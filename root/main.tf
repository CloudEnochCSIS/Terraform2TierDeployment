
module "vpc" {
  source                = "../modules/vpc"
  project_name          = var.project_name
  vpc_cidr              = var.vpc_cidr
  public_subnet_1_cidr  = var.public_subnet_1_cidr
  public_subnet_2_cidr  = var.public_subnet_2_cidr
  private_subnet_3_cidr = var.private_subnet_3_cidr
  private_subnet_4_cidr = var.private_subnet_4_cidr
  private_subnet_5_cidr = var.private_subnet_5_cidr
  private_subnet_6_cidr = var.private_subnet_6_cidr
  region_name           = var.region_name

}

module "nat" {
  source           = "../modules/Nat"
  public_subnet_1  = module.vpc.public_subnet_1
  internet_gateway = module.vpc.internet_gateway
  public_subnet_2  = module.vpc.public_subnet_2
  vpc_id           = module.vpc.vpc_id
  private_subnet_3 = module.vpc.private_subnet_3
  private_subnet_4 = module.vpc.private_subnet_4
  private_subnet_5 = module.vpc.private_subnet_5
  private_subnet_6 = module.vpc.private_subnet_6

}

module "security_group" {
  source = "../modules/SG"
  vpc_id = module.vpc.vpc_id
}

module "Key" {
  source = "../modules/key-pair"


}
module "bastion-host" {
  source                      = "../modules/bastion-host"
  public_subnet_1             = module.vpc.public_subnet_1
  bastion_host_security_group = module.security_group.bastion_host_security_group
  key_name                    = module.Key.key_name
}

module "alb" {
  source                       = "../modules/alb"
  project_name                 = module.vpc.project_name
  application_load_balancer_sg = module.security_group.application_load_balancer_sg
  public_subnet_1              = module.vpc.public_subnet_1
  public_subnet_2              = module.vpc.public_subnet_2
  vpc_id                       = module.vpc.vpc_id

}

module "asg" {
  source = "../modules/asg"
  project_name = module.vpc.project_name
  key_name = module.Key.key_name
  private_subnet_3 =  module.vpc.private_subnet_3
  private_subnet_4 =  module.vpc.private_subnet_4
  alb_target_group_arn = module.alb.alb_target_group_arn
  client_security_group =  module.security_group.client_security_group
}

module "rds" {
  source = "../modules/rds"
  private_subnet_5 = module.vpc.private_subnet_5
  private_subnet_6 = module.vpc.private_subnet_6
  database_username = var.database_username
  database_password = var.database_password
  database_security_group = module.security_group.database_security_group
  
}
module "cloudfront" {
  source = "../modules/cloudfront"
  project_name = module.vpc.project_name
  certificate_domain_name = var.additional_domain_name
  additional_domain_name =  var.additional_domain_name
  alb_domain_name = module.alb.alb_dns_name
   
}

module "route53" {
  source = "../modules/route_53"
  cdf_domain_name = module.cloudfront.cloudfront_domain_name
  cdf_hosted_zone_id = module.cloudfront.cloudfront_hosted_zone_id
  
}

