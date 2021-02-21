variable "name" {
    description = "Environment name"
}

variable "vpc_id" {
    description = "Target VPC ID"
}

variable "web_port" {
  description = "The port on which the web servers listen for connections"
  default = 80
}

variable "app_port" {
  description = "The port on which the app servers listen for connections"
  default = 8080
}

variable "public_subnets_cidr_blocks" {
  description = "CIDR block for public subnets"
}
