data "aws_ami" "ami" {
  most_recent = true
  name_regex  = "^base-ami"
  owners      = ["self"]
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "terraform-b58"
    key    = "terraform-mutable/vpc/${var.env}/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "alb" {
  backend = "s3"
  config = {
    bucket = "terraform-b58"
    key    = "terraform-mutable/alb/${var.env}/terraform.tfstate"
    region = "us-east-1"
  }
}


data "aws_secretsmanager_secret" "secrets" {
  name = var.env
}

data "aws_secretsmanager_secret_version" "secrets" {
  secret_id = data.aws_secretsmanager_secret.secrets.id
}

