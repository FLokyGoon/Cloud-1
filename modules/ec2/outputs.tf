output "public_ip" {
  description = "Public IP of the created EC2 instance"
  value       = aws_instance.this.public_ip
}

output "instance_id" {
  description = "ID of the created EC2 instance"
  value       = aws_instance.this.id
}

output "security_group_id" {
  description = "Security group id"
  value = aws_security_group.ec2_sg.id
}
