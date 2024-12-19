terraform {
  backend "s3" {
    bucket         = "element84-terraform-state"  # S3 bucket for Terraform state
    key            = "state/app.tfstate"         # Path to the state file
    region         = "us-east-1"                 # AWS region
    dynamodb_table = "element84-terraform-locks" # DynamoDB table for state locking
    encrypt        = true                        # Encrypt the state file
  }
}
