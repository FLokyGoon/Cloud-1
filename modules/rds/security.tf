resource "aws_security_group" "rds_sg" {
	name 		= "${var.name}-rds-sg"
	description = "Allow Msql from ec2 only"
	vpc_id 		= var.vpc_id
}

resource "aws_security_group_rule" "allow_http" {
	type = "ingress"
	from_port = 3306
	to_port = 3306
	protocol = "tcp"
	description = "Allow Mysql from Ec2"
	security_group_id = aws_security_group.rds_sg.id
	source_security_group_id = var.ec2_security_group_id
}