variable "backend_bucket_name" {
  default = "my-unique-terraform-state-bucket"
}

variable "dynamodb_table_name" {
  default = "my-unique-terraform-locks"
}
