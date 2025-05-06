variable "cidr_block" {
  description = "VPC CIDR block"
  type        = string
}

variable "name" {
  description = "VPC name"
  type        = string
}

variable "public_subnet_cidrs" {
  description	= "List subnet IP in the VPC"
  type			= list(string)
}

variable "public_azs" {
	description = "List on location for the subnet"
	type 		= list(string)
  
}