module "vpc" {
  source          = "../../modules/vpc"
  vpc_cidr        = var.vpc.cidr
  public_subnets  = var.vpc.public_subnets
  private_subnets = var.vpc.private_subnets
  sufix           = local.sufix
  natgw           = var.vpc.natgw_enable
}
