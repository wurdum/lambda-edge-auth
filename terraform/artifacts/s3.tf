locals {
  spa_index_path        = "../../index.html"
  lambda_package_path   = "../../dist/package.zip"
  lambda_package_suffix = formatdate("YYYYMMDDhhmmss", timestamp())
}

resource "aws_s3_bucket" "spa" {
  bucket_prefix = "wu-spa-${var.project_name}"
  acl           = "private"

  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket_object" "index_html" {
  bucket        = aws_s3_bucket.spa.bucket
  key           = "index.html"
  source        = local.spa_index_path
  etag          = filemd5(local.spa_index_path)
  content_type  = "text/html; charset=utf-8"
  cache_control = "no-cache"
}

resource "aws_s3_bucket" "lambda" {
  bucket_prefix = "wu-lambda-${var.project_name}"
  acl           = "private"
}

resource "aws_s3_bucket_object" "lambda_package" {
  bucket = aws_s3_bucket.lambda.bucket
  key    = "package-${local.lambda_package_suffix}.zip"
  source = local.lambda_package_path

  content_type  = "application/zip"
  cache_control = "no-cache"

  etag = filemd5(local.lambda_package_path)
}

resource "aws_s3_bucket_object" "lambda_package_hash" {
  bucket  = aws_s3_bucket.lambda.bucket
  key     = "package-hash-${local.lambda_package_suffix}.txt"
  content = filebase64sha256(local.lambda_package_path)

  content_type  = "plain/text"
  cache_control = "no-cache"
}
