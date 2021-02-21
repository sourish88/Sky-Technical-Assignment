# Define mandatory parameterized variables

variable "region" {
  description = "The AWS region to deploy to"
  default     = "us-east-1"
}

variable "name" {
  description = "The name of the deployment"
  default     = ""
}

variable "public_key" {
  default = ""
}

variable "ami_id" {
  default = ""
}

variable "web_port" {
  description = "The port on which the web servers listen for connections"
  default     = 80
}

variable "app_port" {
  description = "The port on which the web servers listen for connections"
  default     = 80
}

# Borrowed from VPC Module from Terraform Module Repository:
variable "vpc_cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overriden"
  default     = "0.0.0.0/0"
}

variable "vpc_public_subnets" {
  description = "A list of public subnets inside the VPC"
  default     = []
}

variable "vpc_azs" {
  description = "A list of availability zones in the region"
  default     = []
}
