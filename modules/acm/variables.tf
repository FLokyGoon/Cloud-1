variable "domain_name" {
  type        = string
  description = "The main domain name to be included in the ACM certificate (e.g. example.me)."
}

variable "san_names" {
  type        = list(string)
  description = "List of Subject Alternative Names (SANs) to include in the ACM certificate (e.g. www.example.me, *.example.me)."
}
