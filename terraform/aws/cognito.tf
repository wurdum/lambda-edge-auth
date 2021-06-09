resource "aws_cognito_user_pool" "pool" {
  name = "wu-${var.project_name}"
}

resource "aws_cognito_user_pool_client" "client" {
  name         = "${var.project_name}-client"
  user_pool_id = aws_cognito_user_pool.pool.id

  supported_identity_providers = ["COGNITO"]

  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code"]
  allowed_oauth_scopes                 = ["phone", "email", "openid", "profile", "aws.cognito.signin.user.admin"]

  callback_urls = ["https://${aws_cloudfront_distribution.spa_distribution.domain_name}/parseauth"]
  logout_urls   = ["https://${aws_cloudfront_distribution.spa_distribution.domain_name}/"]
}

resource "random_uuid" "domain_uuid" {
}

resource "aws_cognito_user_pool_domain" "domain" {
  domain       = "auth-${random_uuid.domain_uuid.result}"
  user_pool_id = aws_cognito_user_pool.pool.id
}
