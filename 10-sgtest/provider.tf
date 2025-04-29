terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.93.0"
    }
  }

backend "s3" {
    bucket = "terraform-remotestate-file" 
    key    = "expense-infra-dev-app-alb"
    region = "us-east-1"
    dynamodb_table = "state-locking"
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}