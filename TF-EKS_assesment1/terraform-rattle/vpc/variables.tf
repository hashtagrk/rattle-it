# Define variables if needed
variable "aws_region" {
  description = "The AWS region in which all resources will be created"
  type        = string
  default = "us-west-2"
}

variable "aws_account_id" {
  description = "The ID of the AWS Account in which to create resources."
  type        = string
  default = "xyz" #this is dummy val for now
}