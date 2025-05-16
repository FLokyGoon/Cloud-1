variable "ami_id" {
	description	= "AMI ID for Ubuntu Server 20.04 LTS"
	type				= string
}

variable "instance_type" {
	description	= "EC2 instance type (e.g t3.micro)"
	type				= string
}

variable "subnet_id" {
	description = "Subnet ID where EC2 will be launched"
	type 				= string
}

variable "instance_name" {
	description = "Tag Name for EC2 instance"
	type				= string
}

variable "iam_instance_profile" {
  description	= "is the link between an EC2 instance and an IAM role"
  type 				= string
}

variable "ec2_security_group_ids" {
	description = "Security group id"
	type 				= string
	
}