output "zone_id" {
  description = "The ID of the Route 53 hosted zone."
  value       = aws_route53_zone.this.zone_id
}

output "name_servers" {
  description = "List of name servers to set in Namecheap."
  value       = aws_route53_zone.this.name_servers
}

output "domain_name" {
  description = "The base domain name used for DNS."
  value       = var.domain_name
}