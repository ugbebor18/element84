provider "aws" {
  region = "us-east-1" # Explicitly set the correct region
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = var.backend_bucket_name

  tags = {
    Name = "Terraform State Bucket"
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "Terraform Lock Table"
  }
}
