output "ec2_public_ip" {
	description = "Public IP of th EC2 instance"
	value		= module.ec2.public_ip
}

output "ec2_instance_id" {
	description	= "ID for the EC2 instance"
	value 		= module.ec2.instance_id
}

output "rds_endpoint" {
	description = "the endpoint adress of the RDS database"
	value = module.rds.endpoint
}

output "alb_dns" {
  description = "The DNS name of the Application Load Balancer"
  value = module.alb.alb_dns
}

output "bucket_name" {
  value = module.s3.bucket_name
}