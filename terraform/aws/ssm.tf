resource "aws_ssm_parameter" "configuration" {
  name      = var.project_name
  type      = "String"
  overwrite = true

  value = jsonencode({
    userPoolArn             = aws_cognito_user_pool.pool.arn
    clientId                = aws_cognito_user_pool_client.client.id
    clientSecret            = aws_cognito_user_pool_client.client.client_secret
    oauthScopes             = ["phone", "email", "profile", "openid", "aws.cognito.signin.user.admin"]
    cognitoAuthDomain       = "${aws_cognito_user_pool_domain.domain.domain}.auth.${var.region}.amazoncognito.com"
    redirectPathSignIn      = "/parseauth"
    redirectPathSignOut     = "/"
    redirectPathAuthRefresh = "/refreshauth"
    cookieSettings = {
      idToken      = null
      accessToken  = null
      refreshToken = null
      nonce        = null
    }
    mode = "spaMode"
    httpHeaders = {
      "Content-Security-Policy"   = "default-src 'none'; img-src 'self'; script-src 'self' https://code.jquery.com https://stackpath.bootstrapcdn.com; style-src 'self' 'unsafe-inline' https://stackpath.bootstrapcdn.com; object-src 'none'; connect-src 'self' https://*.amazonaws.com https://*.amazoncognito.com"
      "Strict-Transport-Security" = "max-age=31536000; includeSubdomains; preload"
      "Referrer-Policy"           = "same-origin"
      "X-XSS-Protection"          = "1; mode=block"
      "X-Frame-Options"           = "DENY"
      "X-Content-Type-Options"    = "nosniff"
    }
    logLevel            = "none"
    nonceSigningSecret  = "vb9Bn~GlK6~_PhFM"
    cookieCompatibility = "amplify"
    additionalCookies   = {}
    requiredGroup       = ""
  })
}
