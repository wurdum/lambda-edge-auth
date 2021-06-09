terraform {
  backend "s3" {
    bucket = "wu-local-test-container-lambda"
    key    = "test-container-lambda-lambda.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "aws" {
  backend = "s3"
  config = {
    bucket = "wu-local-test-container-lambda"
    key    = "test-container-lambda-aws.tfstate"
    region = "us-east-1"
  }
}
