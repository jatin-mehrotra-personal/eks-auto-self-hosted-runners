module "vpc" {
  source = "../modules/vpc"


  vpc_name = local.vpc.name
  vpc_cidr = local.vpc.cidr

  azs             = local.vpc.azs
  private_subnets = local.vpc.private_subnets
  public_subnets  = local.vpc.public_subnets

  enable_nat_gateway     = local.vpc.enable_nat_gateway
  single_nat_gateway     = local.vpc.single_nat_gateway
  one_nat_gateway_per_az = local.vpc.one_nat_gateway_per_az

  enable_dns_hostnames = local.vpc.enable_dns_hostnames
  enable_dns_support   = local.vpc.enable_dns_support

  public_subnet_tags  = local.vpc.public_subnet_tags
  private_subnet_tags = local.vpc.private_subnet_tags

  tags = local.tags
}
