variable "zone_id" {
  description = "The ID of the Route 53 zone"
  type        = string
}

variable "domain_name" {
  description = "The base domain"
  type        = string
}

variable "target" {
  description = "The DNS target (e.g. CloudFront domain name)"
  type        = string
}

variable "dns_records" {
  description = "Map of subdomain -> description (key = subdomain)"
  type        = map(string)
}
