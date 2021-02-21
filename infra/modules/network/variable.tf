variable "name" {
  description = "The name of the deployment"
  default     = ""
}

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
