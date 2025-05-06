variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "app_port" {
  type    = number
}