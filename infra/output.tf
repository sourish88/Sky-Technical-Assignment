output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.network.vpc_id
}

output "public_subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value       = module.network.public_subnets_cidr_blocks
}

output "public_subnets" {
  description = "List of of public subnets"
  value       = module.network.public_subnets
}

output "web_sec_grp_id" {
    value = module.security.web_sec_grp_id
}

output "web_elb_sec_grp_id" {
    value = module.security.web_elb_sec_grp_id
}

output "web_asg_id" {
  value = module.compute.web_asg_id
}

output "web_elb_id" {
  value = module.compute.web_elb_id
}