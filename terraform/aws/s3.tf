resource "aws_s3_bucket" "spa" {
  bucket_prefix = "wu-spa-${var.project_name}"
  acl           = "private"

  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket_policy" "spa_policy" {
  bucket = aws_s3_bucket.spa.id
  policy = data.aws_iam_policy_document.spa_cloudfront.json
}

resource "aws_s3_bucket_object" "index_html" {
  bucket        = aws_s3_bucket.spa.bucket
  key           = "index.html"
  source        = "../../index.html"
  etag          = filemd5("../../index.html")
  content_type  = "text/html; charset=utf-8"
  cache_control = "no-cache"
}

data "aws_iam_policy_document" "spa_cloudfront" {
  statement {
    effect  = "Allow"
    actions = ["s3:GetObject"]
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.spa_distribution_s3_origin_identity.iam_arn]
    }
    resources = ["${aws_s3_bucket.spa.arn}/*"]
  }

  statement {
    effect  = "Allow"
    actions = ["s3:ListBucket"]
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.spa_distribution_s3_origin_identity.iam_arn]
    }
    resources = ["${aws_s3_bucket.spa.arn}"]
  }
}

resource "aws_s3_bucket" "lambda" {
  bucket_prefix = "wu-lambda-${var.project_name}"
  acl           = "private"
}

resource "aws_s3_bucket_object" "lambda_package" {
  bucket = aws_s3_bucket.lambda.bucket
  key    = "package.zip"
  source = "../../dist/package.zip"

  content_type  = "application/zip"
  cache_control = "no-cache"

  etag = filemd5("../../dist/package.zip")
}

resource "aws_s3_bucket_object" "lambda_package_hash" {
  bucket  = aws_s3_bucket.lambda.bucket
  key     = "package-hash.txt"
  content = filebase64sha256("../../dist/package.zip")

  content_type  = "plain/text"
  cache_control = "no-cache"
}

data "aws_s3_bucket_object" "lambda_package_hash_data" {
  bucket = aws_s3_bucket.lambda.bucket
  key    = aws_s3_bucket_object.lambda_package_hash.key
}
