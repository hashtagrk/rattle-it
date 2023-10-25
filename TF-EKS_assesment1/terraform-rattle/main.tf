module "vpc" {
  source = "./vpc"
}

module "eks" {
  source = "./eks"
  subnet = module.vpc.private_subnet_ids
}