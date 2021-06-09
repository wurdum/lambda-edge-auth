variable "account_id" {
  description = "AWS account id to run this code"
  type        = string
  default     = "590320146706"
}

variable "account_user" {
  description = "AWS account user name to run this code"
  type        = string
  default     = "wurdum-working-mac-cli"
}

variable "environment" {
  description = "The environment being targeted"
  type        = string
  default     = "local"
}

variable "region" {
  description = "The AWS region being targeted"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "test-container-lambda"
}
