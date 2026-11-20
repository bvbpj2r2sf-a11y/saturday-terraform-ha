# 1. Define required providers and minimum Terraform version
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Allows minor updates within version 5.x
    }
  }
  backend "s3" {
    bucket = "saturday-terraform-state"
    key = "saturday-terraform-ha/terraform.tfstate"
    region = "eu-west-2"
    
  }
}

# 2. Configure the AWS Provider
provider "aws" {
  region = "eu-west-2" # Set your target AWS region
}
