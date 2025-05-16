resource "aws_security_group" "ec2_sg" {
	name				= var.sg_name
	description	= "Allow HTTP, and HTTPS, EFS"
	vpc_id			= var.vpc_id
}

resource "aws_security_group_rule" "allow_http" {
	type 							= "ingress"
	description 			= "HTTP"
	from_port 				= 80
	to_port						= 80
	protocol 					= "tcp"
	cidr_blocks 			= ["0.0.0.0/0"]
	security_group_id = aws_security_group.ec2_sg.id
}

resource "aws_security_group_rule" "allow_https" {
	type 							= "ingress"
	description 			= "HTTPS"
	from_port 				= 443
	to_port 					= 443
	protocol 					= "tcp"
	cidr_blocks 			= ["0.0.0.0/0"]
	security_group_id = aws_security_group.ec2_sg.id
}

resource "aws_security_group_rule" "allow_efs" {
	type 							= "ingress"
	description 			= "EFS from VPC"
	from_port 				= 2049
	to_port 					= 2049
	protocol 					= "tcp"
	cidr_blocks 			= ["10.0.0.0/16"]
	security_group_id = aws_security_group.ec2_sg.id
}

resource "aws_security_group_rule" "allow_all_egress" {
	type 							= "egress"
	description 			= "Allow all outbound"
	from_port 				= 0
	to_port 					= 0
	protocol 					= "-1"
	cidr_blocks 			= ["0.0.0.0/0"]
	security_group_id = aws_security_group.ec2_sg.id
}