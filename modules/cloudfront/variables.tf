variable "name" {
  type = string
}

variable "alb_dns_name" {
  type = string
}

variable "acm_cert_arn" {
  description = "ACM certificate ARN in us-east-1 for HTTPS"
  type        = string
}

variable "aliases" {
  description = "Aliases (domain names) to associate with the distribution"
  type        = list(string)
}