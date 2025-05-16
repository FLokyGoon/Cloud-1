output "security_group_id" {
  description = "Security group id"
  value = aws_security_group.ec2_sg.id
}