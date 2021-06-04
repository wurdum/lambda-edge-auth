resource "aws_lambda_function" "check_auth" {
  function_name = "${var.project_name}-check-auth"
  role          = aws_iam_role._.arn

  publish = true
  runtime = "nodejs12.x"

  s3_bucket        = aws_s3_bucket.lambda.bucket
  s3_key           = aws_s3_bucket_object.lambda_package.key
  source_code_hash = data.aws_s3_bucket_object.lambda_package_hash_data.body

  handler = "index.checkAuthHandler"
}

resource "aws_lambda_function" "http_headers" {
  function_name = "${var.project_name}-http-headers"
  role          = aws_iam_role._.arn

  publish = true
  runtime = "nodejs12.x"

  s3_bucket        = aws_s3_bucket.lambda.bucket
  s3_key           = aws_s3_bucket_object.lambda_package.key
  source_code_hash = data.aws_s3_bucket_object.lambda_package_hash_data.body

  handler = "index.httpHeadersHandler"
}

resource "aws_lambda_function" "parse_auth" {
  function_name = "${var.project_name}-parse-auth"
  role          = aws_iam_role._.arn

  publish = true
  runtime = "nodejs12.x"

  s3_bucket        = aws_s3_bucket.lambda.bucket
  s3_key           = aws_s3_bucket_object.lambda_package.key
  source_code_hash = data.aws_s3_bucket_object.lambda_package_hash_data.body

  handler = "index.parseAuthHandler"
}

resource "aws_lambda_function" "refresh_auth" {
  function_name = "${var.project_name}-refresh-auth"
  role          = aws_iam_role._.arn

  publish = true
  runtime = "nodejs12.x"

  s3_bucket        = aws_s3_bucket.lambda.bucket
  s3_key           = aws_s3_bucket_object.lambda_package.key
  source_code_hash = data.aws_s3_bucket_object.lambda_package_hash_data.body

  handler = "index.refreshAuthHandler"
}

resource "aws_lambda_function" "sign_out" {
  function_name = "${var.project_name}-sign-out"
  role          = aws_iam_role._.arn

  publish = true
  runtime = "nodejs12.x"

  s3_bucket        = aws_s3_bucket.lambda.bucket
  s3_key           = aws_s3_bucket_object.lambda_package.key
  source_code_hash = data.aws_s3_bucket_object.lambda_package_hash_data.body

  handler = "index.signOutHandler"
}
