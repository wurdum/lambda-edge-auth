terraform {
  backend "s3" {
    bucket = "wu-local-test-container-lambda"
    key    = "test-container-lambda-aws.tfstate"
    region = "us-east-1"
  }
}
