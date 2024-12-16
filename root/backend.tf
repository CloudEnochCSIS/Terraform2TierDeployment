terraform {
  backend "s3" {
    bucket         = "akpa-terraform-s3"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "remote-backend"
    profile        = "DevOps-Admin"
  }
}
