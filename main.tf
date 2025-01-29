provider "aws" {
  region  = var.region
  profile = var.profile
}

module "vpc" {
  source           = "./modules/vpc"
  vpc_cidr         = var.vpc_cidr
  vpc_name         = var.vpc_name
  destination_cidr = var.destination_cidr
}

module "sg" {
  source   = "./modules/sg"
  sg_name  = var.sg_name
  vpc_id   = module.vpc.vpc_id
  app_port = var.app_port
  vpc_cidr = var.vpc_cidr
}

module "iam" {
  source               = "./modules/iam"
  iam_instance_profile = module.ec2_instance.iam_instance_profile
  instance_id          = module.ec2_instance.instance_id
}

module "ec2_instance" {
  source               = "./modules/ec2"
  ami_id               = var.ami_id
  instance_type        = var.instance_type
  security_group_id    = module.sg.security_group_id
  subnet_id            = module.vpc.public_subnets[0]
  instance_name        = var.instance_name
  root_volume_type     = var.root_volume_type
  root_volume_size     = var.root_volume_size
  key_pair             = var.key_pair
  iam_instance_profile = module.iam.iam_instance_profile
}
