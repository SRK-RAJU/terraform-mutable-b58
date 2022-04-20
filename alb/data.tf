data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "terraform-b58"
    key    = "terraform-mutable/vpc/${var.env}/terraform.tfstate"
    region = "us-east-1"
  }
}

