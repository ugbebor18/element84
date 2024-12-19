# provider.tf at the root level
provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  description = "AWS region for resources"
  default     = "us-east-1"
}
