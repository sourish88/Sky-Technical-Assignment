resource "aws_key_pair" "ssh-key" {
  key_name = "${var.name}-ssh-key"
  public_key = file(var.public_key)

}
data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name = "name"

    values = ["demo-app-*"]
  }

  filter {
    name = "image-id"

    values = [var.ami_id]
  }

  owners = ["self"]
}

data "template_file" "web_user_data" {
    template = file("${path.module}/templates/web-user-data.tpl")
}

resource "aws_launch_configuration" "web" {
  image_id        = data.aws_ami.amazon_linux.id
  instance_type   = var.web_instance_type
  security_groups = [var.web_sec_grp_id]
  key_name = aws_key_pair.ssh-key.key_name
  name_prefix = "${var.name}-web-vm-"

  user_data = base64encode(data.template_file.web_user_data.rendered)

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_autoscaling_group" "web" {
  name_prefix = "${var.name}-web-asg-"

  launch_configuration = aws_launch_configuration.web.id

  vpc_zone_identifier = var.public_subnets

  load_balancers    = [module.elb_web.this_elb_name]
  health_check_type = "EC2"
  health_check_grace_period = 10

  min_size = var.web_autoscale_min_size
  max_size = var.web_autoscale_max_size

  tags = concat (
    [
        {
            key = "Name" 
            value = "${var.name}-web-server"
            propagate_at_launch = true
        },
        {
            key = "Buildwith" 
            value = "terraform"
            propagate_at_launch = true
        },
        {
            key = "Environment" 
            value = var.name
            propagate_at_launch = true
        }  
    ])
}

resource "aws_autoscaling_policy" "agents-scale-up" {
    name = "agents-scale-up"
    scaling_adjustment = 1
    adjustment_type = "ChangeInCapacity"
    cooldown = 10
    autoscaling_group_name = aws_autoscaling_group.web.name
}

resource "aws_autoscaling_policy" "agents-scale-down" {
    name = "agents-scale-down"
    scaling_adjustment = -1
    adjustment_type = "ChangeInCapacity"
    cooldown = 10
    autoscaling_group_name = aws_autoscaling_group.web.name
}

resource "aws_cloudwatch_metric_alarm" "memory-high" {
    alarm_name = "${var.name}-cpu-util-high"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "10"
    statistic = "Average"
    threshold = "60"
    alarm_description = "This metric monitors ec2 cpu for high utilization on hosts"
    alarm_actions = [
        aws_autoscaling_policy.agents-scale-up.arn
    ]
    dimensions = {
        AutoScalingGroupName = aws_autoscaling_group.web.name
    }
}

resource "aws_cloudwatch_metric_alarm" "memory-low" {
    alarm_name = "${var.name}-cpu-util-low"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "10"
    statistic = "Average"
    threshold = "40"
    alarm_description = "This metric monitors ec2 cpu for low utilization on hosts"
    alarm_actions = [
        aws_autoscaling_policy.agents-scale-down.arn
    ]
    dimensions = {
        AutoScalingGroupName = aws_autoscaling_group.web.name
    }
}
