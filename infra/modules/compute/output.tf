output "web_asg_id" {
  value = aws_autoscaling_group.web.id
}

output "web_elb_id" {
  value = module.elb_web.this_elb_id
}