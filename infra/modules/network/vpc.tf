module "network" {
  source = "terraform-aws-modules/vpc/aws"

  name = format("%s-vpc", var.name)
  azs = var.vpc_azs
  cidr = var.vpc_cidr

  public_subnets = var.vpc_public_subnets

  tags = {
    Name      = "${var.name}-vpc"
    BuildWith = "terraform"
    Environment = var.name
  } 
}
