provider "aws" {
  
}

module "network" {
  source = "./modules/network"
  azs = var.vpc_azs
  cidr = var.vpc_cidr
  name = var.name

  public_subnets = var.vpc_public_subnets
  private_subnets = var.vpc_private_subnets
  database_subnets = var.vpc_database_subnets

  enable_nat_gateway = var.vpc_enable_nat_gateway
  single_nat_gateway = var.vpc_single_nat_gateway
  one_nat_gateway_per_az = var.vpc_one_nat_gateway_per_az

}

module "security" {
    source = "./modules/security"

    name = var.name
    vpc_id = module.network.vpc_id
    web_port = var.web_port
    app_port = var.app_port
    db_port = var.db_port
    private_subnets_cidr_blocks = module.network.private_subnets_cidr_blocks
    public_subnets_cidr_blocks = module.network.public_subnets_cidr_blocks
    database_subnets = module.network.database_subnets
}

module "compute" {
    source = "./modules/compute"

    name = var.name
    public_key = var.public_key
    ami_sha = var.ami_sha
    web_port = var.web_port
    app_port = var.app_port
    web_sec_grp_id = module.security.web_sec_grp_id
    web_elb_sec_grp_id = module.security.web_elb_sec_grp_id
    public_subnets = module.network.public_subnets
}