variable "efs_name" {
	description = "Name of the Elastic File System"
	type 		= string
}

variable "subnet_ids" {
	description = "List of subnets to create EFS mount targets"
	type 		= list(string)
}

variable "security_group_id" {
	description = "Security group that allows NFS access from EC2"
	type 		= string
}

variable "transition_to_ia" {
	description = "Define how many days before move the file to infrequent access"
	type 		= string
}