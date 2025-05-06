# Create a public SSL certificate for a custom domain
resource "aws_acm_certificate" "cloudfront_cert" {
  domain_name               = var.domain_name
  subject_alternative_names = var.san_names
  validation_method         = "DNS"

  tags = {
    Name = "cloudfront-ssl"
  }

  lifecycle {
    create_before_destroy = true
  }
}
