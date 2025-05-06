output "distribution_domain" {
  value = aws_cloudfront_distribution.this.domain_name
}


output "distribution_arn" {
  value = aws_cloudfront_origin_access_control.this.arn
}