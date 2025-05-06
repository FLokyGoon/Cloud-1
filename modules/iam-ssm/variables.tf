variable "ssm_ec2_role_name" {
	description = "Role Name IAM who get the persmission to interact with the ec2"
	type 		= string
}

variable "ssm_ec2_profile_name" {
	description = "Profile name"
	type 		= string
}

variable "policy_arn" {
	description = "ARN (Amazon Resource Name) is a unique identifier for a policy"
	type 		= string
}

variable "assume_role_policy_service" {
  description	= "The AWS service authorized to assume the role of IAM"
  type 			= string
}