output "bucket_id" {
  value = aws_s3_bucket.this.id
}

output "bucket_domain" {
  value = aws_s3_bucket.this.bucket_regional_domain_name
}

output "bucket_arn" {
  value = aws_s3_bucket.this.arn
}

output "bucket_name" {
  value = aws_s3_bucket.this.bucket
}