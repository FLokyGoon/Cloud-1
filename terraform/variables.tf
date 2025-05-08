#########################################################
# Global
#########################################################

variable "project_name" {
  description = "Project name for tagging AWS resources"
  type        = string
}

variable "project_owner" {
  description = "Owner name for resource tagging"
  type        = string
}

variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
}

#########################################################
# EC2 (Amazon Elastic Compute Cloud)
#########################################################

variable "ec2_ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
}

variable "ec2_instance_type" {
  description = "EC2 instance type (e.g., t3.micro)"
  type        = string
}

#########################################################
# VPC (Virtual Private Cloud)
#########################################################

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_public_subnet_cidrs" {
  description = "List of CIDRs for public subnets"
  type        = list(string)
}

variable "vpc_public_subnet_azs" {
  description = "List of availability zones for public subnets"
  type        = list(string)
}

#########################################################
# IAM / SSM (System-Manager)
#########################################################

variable "iam_ec2_role_name" {
  description = "Name of IAM role for EC2"
  type        = string
}

variable "iam_instance_profile_name" {
  description = "Name of IAM instance profile"
  type        = string
}

variable "iam_ssm_policy_arn" {
  description = "Policy ARN for SSM permissions"
  type        = string
}

variable "iam_assume_role_service" {
  description = "Service that can assume IAM role"
  type        = string
}

#########################################################
# EFS (Amazon Elastic File System)
#########################################################

variable "efs_name" {
  description = "Name for EFS"
  type        = string
}

variable "efs_transition_to_ia" {
  description = "Time before files move to infrequent access (e.g. AFTER_7_DAYS)"
  type        = string
}

#########################################################
# RDS (Amazon Relation Database Service)
#########################################################

variable "rds_db_name" {
  description = "Name of the RDS database"
  type        = string
}

variable "rds_db_username" {
  description = "Master username for the database"
  type        = string
}

variable "rds_db_password" {
  description = "Master password for the database"
  type        = string
}

#########################################################
# S3
#########################################################

variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

#########################################################
# ALB (Application Load Balancer)
#########################################################

variable "alb_listener_port" {
  description = "Port to expose in the ALB"
  type        = number
}

#########################################################
# ASG (Auto Scaling groups)
#########################################################

variable "asg_user_data_path" {
  description = "Path to user data script"
  type        = string
}

#########################################################
# ACM (AWS Certificate Manager)
#########################################################

variable "acm_domain_name" {
  description = "Main domain for ACM certificate"
  type        = string
}

variable "acm_san_names" {
  description = "Subject Alternative Names for ACM certificate"
  type        = list(string)
}


#########################################################
# DNS
#########################################################


variable "dns_records" {
  description = "DNS records to create (subdomain => description)"
  type        = map(string)
}

#########################################################
# Remote State DNS
#########################################################

variable "dns_remote_backend" {
  description = "Backend type used to retrieve remote DNS state (e.g. local, s3)"
  type        = string
}

variable "dns_remote_state_path" {
  description = "Path to the DNS remote state file (local path or S3 config key)"
  type        = string
}

#########################################################
# CloudFront
#########################################################

variable "acm_cert_arn" {
  description = "ACM certificate ARN in us-east-1 for HTTPS"
  type        = string
}

variable "cloudfront_aliases" {
  description = "Aliases (domain names) to associate with the distribution"
  type        = list(string)
}