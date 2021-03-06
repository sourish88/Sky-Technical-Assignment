provider "aws" {}

module "network" {
  source = "./modules/network"
  vpc_azs    = var.vpc_azs
  vpc_cidr   = var.vpc_cidr
  name   = var.name

  vpc_public_subnets   = var.vpc_public_subnets

}

module "security" {
  source = "./modules/security"

  name                        = var.name
  vpc_id                      = module.network.vpc_id
  web_port                    = var.web_port
  app_port                    = var.app_port
  public_subnets_cidr_blocks  = module.network.public_subnets_cidr_blocks
}

module "compute" {
  source = "./modules/compute"

  name               = var.name
  public_key         = var.public_key
  ami_id            = var.ami_id
  web_port           = var.web_port
  app_port           = var.app_port
  web_sec_grp_id     = module.security.web_sec_grp_id
  web_elb_sec_grp_id = module.security.web_elb_sec_grp_id
  public_subnets     = module.network.public_subnets
}
