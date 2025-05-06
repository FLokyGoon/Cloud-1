resource "aws_s3_bucket" "this" {
	bucket = "${var.bucket_name}"
	force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "this" {
	bucket = aws_s3_bucket.this.id

	block_public_acls       = true
	block_public_policy     = false
	ignore_public_acls      = true
	restrict_public_buckets = false
}

# resource "aws_s3_bucket_policy" "this" {
#   bucket = aws_s3_bucket.this.id
#   policy = data.aws_iam_policy_document.s3_policy.json
# }