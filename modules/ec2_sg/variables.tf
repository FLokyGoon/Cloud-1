variable "sg_name" {
	description = "Name for the EC2 Security Group"
	type		= string
}

variable "vpc_id" {
	description = "VPC ID where EC2 and SG live"
	type		= string
}