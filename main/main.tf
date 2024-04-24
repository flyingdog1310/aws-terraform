terraform {
  required_version = ">= 1.5.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.35.0"
    }
  }

  backend "s3" {
    bucket               = "flyingdog-terraform-states"
    region               = "ap-northeast-1"
    workspace_key_prefix = "terraform-state"
    key                  = "terraform.tfstate"
    dynamodb_table       = "flyingdog-terraform-locks"
  }
}

provider "aws" {
  region = "ap-northeast-1"
}
provider "aws" {
  alias  = "us-east"
  region = "us-east-1"
}