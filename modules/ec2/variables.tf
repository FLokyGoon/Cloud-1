variable "ami_id" {
	description	= "AMI ID for Ubuntu Server 20.04 LTS"
	type		= string
}

variable "instance_type" {
	description	= "EC2 instance type (e.g t3.micro)"
	type		= string
}

variable "subnet_id" {
	description = "Subnet ID where EC2 will be launched"
	type 		= string
}

variable "vpc_id" {
	description = "VPC ID where EC2 and SG live"
	type		= string
}

variable "sg_name" {
	description = "Name for the EC2 Security Group"
	default		= "cloud1-web-sg"
	type		= string
}

variable "instance_name" {
	description = "Tag Name for EC2 instance"
	default 	= "cloud1-wordpress-server"
	type		= string
}

variable "iam_instance_profile" {
  description	= "is the link between an EC2 instance and an IAM role"
  type 			= string
}