############################
# AWS COMMON
############################
variable "aws_profile" {
  description = "The AWS profile"
}

variable "aws_region" {
  description = "The AWS region"
}

variable "aws_account_id" {
  description = "AWS account Number for Athena log location"
}

variable "name_prefix" {
  description = "Prefix used for naming resources"
}
