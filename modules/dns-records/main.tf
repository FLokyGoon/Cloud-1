resource "aws_route53_record" "this" {
  for_each = var.dns_records

  zone_id = var.zone_id
  name    = "${each.key}.${var.domain_name}"
  type    = "CNAME"
  ttl     = 300
  records = [var.target]
}
