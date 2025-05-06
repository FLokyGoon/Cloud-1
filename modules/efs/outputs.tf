output "file_system_id" {
  description	= "EFS ID"
  value 		= aws_efs_file_system.this.id
}