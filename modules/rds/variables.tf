variable "name" {
  type        = string
  description = "The name used to identify and tag AWS resources (e.g., RDS, EFS, etc.)"
}

variable "db_name" {
  type        = string
  description = "The name of the database schema created within the RDS instance"
}

variable "db_user" {
  type        = string
  description = "The master username used to connect to the RDS database"
}

variable "db_password" {
  type      = string
  description = "The master password used to connect to the RDS database"
  sensitive = true
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of subnet IDs for placing the resources (RDS, EFS), typically private subnets"
}

variable "ec2_security_group_id" {
  type        = string
  description = "The security group ID used to control network access to the RDS resource"
}

variable "vpc_id" {
	description = "VPC ID where RDS and SG live"
	type		= string
}