locals {
	s3_origin_id = "s3-origin"
}

# 1. Origin Access Control (OAC) for Sigv4-signed S3 fetchs
resource "aws_cloudfront_origin_access_control" "this" {
	name		 													= "${var.name}-oac"
	origin_access_control_origin_type	= "s3"
  	signing_protocol								= "sigv4"
  	signing_behavior  							= "always" 
}

# 2. CloudFront Distribution
resource "aws_cloudfront_distribution" "this" {
	comment 						= "${var.name} CDN"
	enabled 						= true
	is_ipv6_enabled 		= true
	default_root_object = "index.html"

	aliases = var.aliases

	# 2.1 Single S3 origin using OAC
	origin {
  	domain_name = var.alb_dns_name
  	origin_id   = "alb-origin"

  	custom_origin_config {
  	  origin_protocol_policy = "http-only"
  	  http_port              = 80
  	  https_port             = 443
  	  origin_ssl_protocols   = ["TLSv1.2"]
  	}
	}
	# 2.2 Default cache rules
	default_cache_behavior {
  	target_origin_id      	= "alb-origin"
  	viewer_protocol_policy	= "redirect-to-https"
  	allowed_methods  				= ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
  	cached_methods        	= ["GET", "HEAD"]
  	compress              	= true

  	forwarded_values {
  	  query_string = true
  	  headers      = ["Host", "X-Forwarded-Proto"]
  	  cookies {
  	    forward = "all"
  	  }
  	}

  	min_ttl     = 0
  	default_ttl = 3600
  	max_ttl     = 86400
	}

	restrictions {
	  geo_restriction {
		restriction_type = "none"
	  }
	}

	viewer_certificate {
  	acm_certificate_arn            = var.acm_cert_arn
  	ssl_support_method             = "sni-only"
  	minimum_protocol_version       = "TLSv1.2_2019"
	}
}
