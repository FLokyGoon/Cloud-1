variable "name" {
  type        = string
  description = "A name prefix used to tag and identify ASG resources (e.g., instances, launch template)"
}

variable "ami_id" {
  type        = string
  description = "The AMI ID to use for EC2 instances in the ASG (e.g., Ubuntu, Amazon Linux)"
}

variable "instance_type" {
  type        = string
  description = "The type of EC2 instances to launch (e.g., t3.micro)"
}

variable "instance_profile_name" {
  type        = string
  description = "IAM instance profile name attached to EC2 instances (for SSM access, logging, etc.)"
}

variable "security_group_id" {
  type        = string
  description = "Security group ID controlling network access to the EC2 instances"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs across availability zones to deploy ASG instances in (should be private or public depending on architecture)"
}

variable "target_group_arn" {
  type        = string
  description = "ARN of the target group that instances should be registered to (for load balancing with ALB)"
}

variable "user_data_path" {
  type        = string
  description = "Path to the user-data script (cloud-init shell script) used to bootstrap EC2 instances"
}

variable "min_size" {
  type        = number
  default     = 1
  description = "Minimum number of instances that the ASG should maintain"
}

variable "max_size" {
  type        = number
  default     = 2
  description = "Maximum number of instances that the ASG can scale up to"
}

variable "desired_capacity" {
  type        = number
  default     = 1
  description = "Initial number of instances to run in the ASG at deployment time"
}
