resource "aws_db_subnet_group" "this" {
	name = "${var.name}-subnet-group"
	subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "this" {
	identifier 				= "${var.name}-db"
	engine					= "mysql"
	engine_version			= "8.0"
	instance_class 			= "db.t3.micro"
	allocated_storage		= 20
	db_name 				= var.db_name
	username 				= var.db_user
	password 				= var.db_password
	parameter_group_name 	= "default.mysql8.0"
	db_subnet_group_name 	= aws_db_subnet_group.this.id
	vpc_security_group_ids 	= [aws_security_group.rds_sg.id]
	publicly_accessible   	= false
	skip_final_snapshot 	= true
}