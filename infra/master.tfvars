name       = "dev"
region     = "us-east-1"
public_key = "~/.ssh/id_rsa.pub"

# VPC
vpc_azs                    = ["us-east-1a", "us-east-1b"]
vpc_cidr                   = "10.1.0.0/16"
vpc_public_subnets        = ["10.1.1.0/24", "10.1.2.0/24"]
