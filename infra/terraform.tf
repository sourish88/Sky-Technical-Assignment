provider "aws" {
  
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
    web_port = var.web_port
    app_port = var.app_port
    web_sec_grp_id = module.security.web_sec_grp_id
    web_elb_sec_grp_id = module.security.web_elb_sec_grp_id
    public_subnets = module.network.public_subnets
}