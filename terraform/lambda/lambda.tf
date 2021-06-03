resource "aws_lambda_function" "check_auth" {
  function_name = "${var.project_name}-check-auth"
  role          = aws_iam_role._.arn

  publish      = true
  package_type = "Image"
  image_uri    = "${data.terraform_remote_state.aws.outputs.ecr_repository_url}@${data.aws_ecr_image.latest.image_digest}"
  image_config {
    command = ["index.checkAuthHandler"]
  }
}

resource "aws_lambda_function" "http_headers" {
  function_name = "${var.project_name}-http-headers"
  role          = aws_iam_role._.arn

  publish      = true
  package_type = "Image"
  image_uri    = "${data.terraform_remote_state.aws.outputs.ecr_repository_url}@${data.aws_ecr_image.latest.image_digest}"
  image_config {
    command = ["index.httpHeadersHandler"]
  }
}

resource "aws_lambda_function" "parse_auth" {
  function_name = "${var.project_name}-parse-auth"
  role          = aws_iam_role._.arn

  publish      = true
  package_type = "Image"
  image_uri    = "${data.terraform_remote_state.aws.outputs.ecr_repository_url}@${data.aws_ecr_image.latest.image_digest}"
  image_config {
    command = ["index.parseAuthHandler"]
  }
}

resource "aws_lambda_function" "refresh_auth" {
  function_name = "${var.project_name}-refresh-auth"
  role          = aws_iam_role._.arn

  publish      = true
  package_type = "Image"
  image_uri    = "${data.terraform_remote_state.aws.outputs.ecr_repository_url}@${data.aws_ecr_image.latest.image_digest}"
  image_config {
    command = ["index.refreshAuthHandler"]
  }
}

resource "aws_lambda_function" "sign_out" {
  function_name = "${var.project_name}-sign-out"
  role          = aws_iam_role._.arn

  publish      = true
  package_type = "Image"
  image_uri    = "${data.terraform_remote_state.aws.outputs.ecr_repository_url}@${data.aws_ecr_image.latest.image_digest}"
  image_config {
    command = ["index.signOutHandler"]
  }
}

data "aws_ecr_image" "latest" {
  repository_name = data.terraform_remote_state.aws.outputs.ecr_repository_name
  image_tag       = "latest"
}
