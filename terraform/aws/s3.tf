resource "aws_s3_bucket" "spa" {
  bucket_prefix = "wu-spa-${var.project_name}"
  acl           = "private"
}

resource "aws_s3_bucket_object" "index_html" {
  bucket = aws_s3_bucket.spa.bucket
  key    = "index.html"
  source = "../../index.html"
  etag   = filemd5("../../index.html")
}
