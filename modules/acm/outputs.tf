output "certificate_arn" {
  description = "The ARN of the issued ACM certificate to be used with CloudFront."
  value       = aws_acm_certificate.cloudfront_cert.arn
}
