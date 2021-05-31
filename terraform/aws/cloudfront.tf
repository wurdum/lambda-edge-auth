locals {
  s3_origin_id      = "protected-bucket"
  dummy_origin_id   = "dummy-origin"
  dummy_domain_name = "will-never-be-reached.org"
}

resource "aws_cloudfront_origin_access_identity" "spa_distribution_s3_origin_identity" {
  comment = "S3 origin identity for ${aws_s3_bucket.spa.bucket_domain_name}."
}

resource "aws_cloudfront_distribution" "spa_distribution" {
  origin {
    domain_name = local.dummy_domain_name
    origin_id   = local.dummy_origin_id

    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols   = ["TLSv1.1", "TLSv1.2", "SSLv3"]
    }
  }

  origin {
    domain_name = aws_s3_bucket.spa.bucket_regional_domain_name
    origin_id   = local.s3_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.spa_distribution_s3_origin_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Serve ${aws_s3_bucket.spa.bucket_domain_name} via CloudFront."
  default_root_object = "index.html"

  default_cache_behavior {
    target_origin_id       = local.s3_origin_id
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]

    compress = true
    forwarded_values {
      query_string = true
      cookies {
        forward = "none"
      }
    }
  }

  ordered_cache_behavior {
    path_pattern           = "/parseauth"
    target_origin_id       = local.dummy_origin_id
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]

    compress = true
    forwarded_values {
      query_string = true
      cookies {
        forward = "none"
      }
    }
  }

  ordered_cache_behavior {
    path_pattern           = "/refreshauth"
    target_origin_id       = local.dummy_origin_id
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]

    compress = true
    forwarded_values {
      query_string = true
      cookies {
        forward = "none"
      }
    }
  }

  ordered_cache_behavior {
    path_pattern           = "/signout"
    target_origin_id       = local.dummy_origin_id
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]

    compress = true
    forwarded_values {
      query_string = true
      cookies {
        forward = "none"
      }
    }
  }

  custom_error_response {
    error_caching_min_ttl = 0
    response_code         = 404
    response_page_path    = "/index.html"
    error_code            = 404
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
