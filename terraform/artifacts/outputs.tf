output "spa_arn" {
  value = aws_s3_bucket.spa.arn
}

output "spa_bucket" {
  value = aws_s3_bucket.spa.bucket
}

output "spa_bucket_domain_name" {
  value = aws_s3_bucket.spa.bucket_domain_name
}

output "spa_bucket_regional_domain_name" {
  value = aws_s3_bucket.spa.bucket_regional_domain_name
}

output "spa_index_key" {
  value = aws_s3_bucket_object.index_html.key
}

output "lambda_bucket" {
  value = aws_s3_bucket.lambda.bucket
}

output "lambda_package_key" {
  value = aws_s3_bucket_object.lambda_package.key
}

output "lambda_package_hash_key" {
  value = aws_s3_bucket_object.lambda_package_hash.key
}
