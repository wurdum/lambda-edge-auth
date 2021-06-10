resource "aws_iam_role" "_" {
  name               = "${var.project_name}-role"
  assume_role_policy = data.aws_iam_policy_document.assume-role-policy.json
}

data "aws_iam_policy_document" "assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com",
        "edgelambda.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role_policy" "logs_role_policy" {
  name   = "${var.project_name}-logs-policy"
  role   = aws_iam_role._.id
  policy = data.aws_iam_policy_document.lambda_logs_policy_doc.json
}

data "aws_iam_policy_document" "lambda_logs_policy_doc" {
  statement {
    effect    = "Allow"
    resources = ["*"]
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",

      # Lambda@Edge logs are logged into Log Groups in the region of the edge location
      # that executes the code. Because of this, we need to allow the lambda role to create
      # Log Groups in other regions
      "logs:CreateLogGroup"
    ]
  }
}

resource "aws_iam_role_policy" "ssm_parameter_role_policy" {
  name   = "${var.project_name}-ssm-parameter-policy"
  role   = aws_iam_role._.id
  policy = data.aws_iam_policy_document.lambda_ssm_parameter_policy_doc.json
}

data "aws_iam_policy_document" "lambda_ssm_parameter_policy_doc" {
  statement {
    effect    = "Allow"
    resources = [aws_ssm_parameter.configuration.arn]
    actions   = ["ssm:GetParameter"]
  }
}

resource "aws_s3_bucket_policy" "spa_policy" {
  bucket = data.terraform_remote_state.artifacts.outputs.spa_bucket
  policy = data.aws_iam_policy_document.spa_cloudfront.json
}

data "aws_iam_policy_document" "spa_cloudfront" {
  statement {
    effect  = "Allow"
    actions = ["s3:GetObject"]
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.spa_distribution_s3_origin_identity.iam_arn]
    }
    resources = ["${data.terraform_remote_state.artifacts.outputs.spa_arn}/*"]
  }

  statement {
    effect  = "Allow"
    actions = ["s3:ListBucket"]
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.spa_distribution_s3_origin_identity.iam_arn]
    }
    resources = ["${data.terraform_remote_state.artifacts.outputs.spa_arn}"]
  }
}
