module "vpc" {
  source              = "../modules/vpc"
  name                = var.project_name
  cidr_block          = var.vpc_cidr_block
  public_subnet_cidrs = var.vpc_public_subnet_cidrs
  public_azs          = var.vpc_public_subnet_azs
}

module "iam_ssm" {
  source                     = "../modules/iam-ssm"
  ssm_ec2_profile_name       = var.iam_instance_profile_name
  ssm_ec2_role_name          = var.iam_ec2_role_name
  policy_arn                 = var.iam_ssm_policy_arn
  assume_role_policy_service = var.iam_assume_role_service
}

module "acm" {
  source    = "../modules/acm"
  providers = { aws = aws.us_east_1 }
  domain_name = var.acm_domain_name
  san_names   = var.acm_san_names
}

module "ec2" {
  source               = "../modules/ec2"
  depends_on           = [module.iam_ssm, module.vpc]
  ami_id               = var.ec2_ami_id
  instance_type        = var.ec2_instance_type
  subnet_id            = module.vpc.public_subnet[0]
  vpc_id               = module.vpc.vpc_id
  iam_instance_profile = module.iam_ssm.instance_profile_name
}

module "efs" {
  source            = "../modules/efs"
  depends_on        = [module.vpc]
  efs_name          = var.efs_name
  subnet_ids        = module.vpc.public_subnet
  security_group_id = module.ec2.security_group_id
  transition_to_ia  = var.efs_transition_to_ia
}

module "rds" {
  source                = "../modules/rds"
  depends_on            = [module.vpc, module.iam_ssm]
  name                  = var.project_name
  db_name               = var.rds_db_name
  db_user               = var.rds_db_username
  db_password           = var.rds_db_password
  subnet_ids            = module.vpc.public_subnet
  ec2_security_group_id = module.ec2.security_group_id
  vpc_id                = module.vpc.vpc_id
}

module "s3" {
  source      = "../modules/s3"
  name        = var.project_name
  bucket_name = var.s3_bucket_name
}

module "cloudfront" {
  source        = "../modules/cloudfront"
  depends_on    = [module.s3]
  name          = var.project_name
  bucket_domain = module.s3.bucket_domain
}

module "alb" {
  source            = "../modules/alb"
  depends_on        = [module.vpc]
  name              = var.project_name
  vpc_id            = module.vpc.vpc_id
  subnet_ids        = module.vpc.public_subnet
  security_group_id = module.ec2.security_group_id
  app_port          = var.alb_listener_port
}

module "dns_records" {
  source      = "../modules/dns-records"
  zone_id     = data.terraform_remote_state.dns.outputs.zone_id
  domain_name = data.terraform_remote_state.dns.outputs.domain_name
  target      = module.cloudfront.distribution_domain
  dns_records = var.dns_records
}

resource "aws_lb_target_group_attachment" "ec2_manual" {
  target_group_arn = module.alb.target_group_arn
  target_id        = module.ec2.instance_id
  port             = var.alb_listener_port
}

# module "asg" {
#   source                = "../modules/asg"
#   depends_on            = [module.vpc, module.iam_ssm]
#   name                  = var.project_name
#   ami_id                = var.ec2_ami_id
#   instance_type         = var.ec2_instance_type
#   instance_profile_name = module.iam_ssm.instance_profile_name
#   security_group_id     = module.ec2.security_group_id
#   subnet_ids            = module.vpc.public_subnet
#   target_group_arn      = module.alb.target_group_arn
#   user_data_path        = var.asg_user_data_path
# }
