locals {
	s3_origin_id = "s3-origin"
}

# 1. Origin Access Control (OAC) for Sigv4-signed S3 fetchs
resource "aws_cloudfront_origin_access_control" "this" {
	name		 						= "${var.name}-oac"
	origin_access_control_origin_type	= "s3"
  	signing_protocol					= "sigv4"
  	signing_behavior  					= "always" 
}

# 2. CloudFront Distribution
resource "aws_cloudfront_distribution" "this" {
		comment 			= "${var.name} CDN"
		enabled 			= true
		is_ipv6_enabled 	= true
		default_root_object = "index.html"

	# 2.1 Single S3 origin using OAC
	origin {
		domain_name					= var.bucket_domain
		origin_id 					= local.s3_origin_id
		origin_access_control_id	= aws_cloudfront_origin_access_control.this.id
	}
	# 2.2 Default cache rules
	default_cache_behavior {
		target_origin_id		= local.s3_origin_id
	  	viewer_protocol_policy	= "redirect-to-https"
	  	allowed_methods			= ["GET", "HEAD", "OPTIONS"]
	  	cached_methods			= ["GET", "HEAD"]
	  	compress 				= true
	  
	  	forwarded_values {
			query_string = false
			cookies {
				forward = "none"
			}
		}

		min_ttl 	= 0
		default_ttl = 3600 
		max_ttl 	= 86400
	}

	# 2.3 Imutable-content cache
	ordered_cache_behavior {
		path_pattern 			= "/static/immutable/*"
		target_origin_id 		= local.s3_origin_id
		viewer_protocol_policy	= "redirect-to-https"
		allowed_methods			= ["GET", "HEAD", "OPTIONS"]
		cached_methods 			= ["GET", "HEAD", "OPTIONS"]
		compress				= true
	
		forwarded_values {
			query_string = false
			cookies {
				forward = "none"
			}
		}

		min_ttl 	= 0
		default_ttl =  86400
		max_ttl 	= 31536000
	}

	restrictions {
	  geo_restriction {
		restriction_type = "none"
	  }
	}

	viewer_certificate {
	  cloudfront_default_certificate = true
	}
}
