terraform {
  # Conditional backend configuration
  backend "s3" {
    bucket         = var.backend_bucket_name
    key            = "state/app.tfstate"
    region         = var.aws_region
    dynamodb_table = var.dynamodb_table_name
    encrypt        = true
  }

  required_version = ">= 1.5.3"
}



# terraform {
#   backend "s3" {
#     bucket         = "element84-terraform-state"  # S3 bucket for Terraform state
#     key            = "state/app.tfstate"         # Path to the state file
#     region         = "us-east-1"                 # AWS region
#     dynamodb_table = "element84-terraform-locks" # DynamoDB table for state locking
#     encrypt        = true                        # Encrypt the state file
#   }
# }
