terraform {
  backend "s3" {
    bucket         = "element84-terraform-state"
    key            = "state/app.tfstate"
    region         = "us-east-1"
    dynamodb_table = "element84-terraform-locks"
    encrypt        = true
  }
}
