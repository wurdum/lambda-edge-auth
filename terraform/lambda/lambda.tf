resource "aws_lambda_function" "_" {
  function_name = var.project_name
  role          = aws_iam_role._.arn

  package_type = "Image"
  image_uri    = "${data.terraform_remote_state.aws.outputs.ecr_repository_url}@${data.aws_ecr_image.latest.image_digest}"
  image_config {
    command = ["app.lambdaHandler2"]
  }
}

data "aws_ecr_image" "latest" {
  repository_name = data.terraform_remote_state.aws.outputs.ecr_repository_name
  image_tag       = "latest"
}
