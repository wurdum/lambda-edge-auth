terraform {
  backend "s3" {
    bucket = "wu-lambda-edge-auth"
    key    = "lambda-edge-auth-aws.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "artifacts" {
  backend = "s3"
  config = {
    bucket = "wu-lambda-edge-auth"
    key    = "lambda-edge-auth-artifacts.tfstate"
    region = "us-east-1"
  }
}
