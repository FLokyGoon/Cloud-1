# data "aws_iam_policy_document" "s3_policy" {
# 	statement {
# 		actions 	= ["s3.GetObject"]
# 		resources 	= ["${aws_s3_bucket.this.arn}/*"]
# 		principals {
# 			type 		= "AWS"
# 			identifiers = ["???"]
# 		}
# 	}
# }