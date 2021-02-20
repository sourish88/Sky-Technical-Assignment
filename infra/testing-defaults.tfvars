name = "build"
region = "us-east-1"
public_key = "~/.ssh/id_rsa.pub"

# VPC
vpc_azs = [ "us-east-1a", "us-east-1b" ]
vpc_cidr = "10.0.0.0/16"
vpc_private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
vpc_public_subnets  = ["10.0.101.0/24", "10.0.201.0/24"]
vpc_database_subnets = ["10.0.102.0/24", "10.0.202.0/24"]
vpc_enable_nat_gateway = true
vpc_single_nat_gateway = false
vpc_one_nat_gateway_per_az = true