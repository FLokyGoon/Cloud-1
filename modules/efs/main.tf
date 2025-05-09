resource "aws_efs_file_system" "this" {
	creation_token = var.efs_name
	
	lifecycle_policy {
		transition_to_ia = var.transition_to_ia
	}
}

resource "aws_efs_mount_target" "this" {
  count				= length(var.subnet_ids)
  file_system_id	= aws_efs_file_system.this.id
  subnet_id			= var.subnet_ids[count.index]
  security_groups	= [var.security_group_id]
}