variable "ami_sha" {
  default = ""
}

variable "name" {
    description = "Environment name"
}

variable "public_key" {
  default = ""
}

# Web ASG
variable "web_instance_type" {
  description = "The EC2 instance type for the web servers"
  default = "t2.micro"
}

variable "web_autoscale_min_size" {
  description = "The fewest amount of EC2 instances to start"
  default = 3
}

variable "web_autoscale_max_size" {
  description = "The largest amount of EC2 instances to start"
  default = 5
}

variable "web_sec_grp_id" {
  description = "Web security group ID"
}

variable "web_elb_sec_grp_id" {
  description = "Web ELB security group ID."
}

variable "public_subnets" {
  description = "Public subnets for web."
}

# Web ELB
variable "web_port" {
  description = "The port on which the web servers listen for connections"
  default = 80
}

variable "web_elb_health_check_interval" {
  description = "Duration between health checks"
  default = 20
}

variable "web_elb_healthy_threshold" {
  description = "Number of checks before an instance is declared healthy"
  default = 2
}

variable "web_elb_unhealthy_threshold" {
  description = "Number of checks before an instance is declared unhealthy"
  default = 2
}

variable "web_elb_health_check_timeout" {
  description = "Interval between checks"
  default = 5
}
