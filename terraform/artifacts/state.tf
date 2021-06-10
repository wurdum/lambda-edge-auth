terraform {
  backend "s3" {
    bucket = "wu-lambda-edge-auth"
    key    = "lambda-edge-auth-artifacts.tfstate"
    region = "us-east-1"
  }
}
