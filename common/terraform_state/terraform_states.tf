# Terraform Configuration for AWS S3 Bucket and DynamoDB Lock
# This Terraform file is used to create an Amazon S3 bucket and an Amazon DynamoDB table to store Terraform state files.
# Please use this file as the initial configuration for managing Terraform state.
locals {
  project = "flyingdog"
}

terraform {
  required_version = ">= 1.5.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.40.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_s3_bucket" "terraform_states" {
  bucket              = "${local.project}-terraform-states"
  object_lock_enabled = true
  tags = {
    Name = "S3 Remote Terraform State Store"
  }
}

resource "aws_s3_bucket_versioning" "terraform_states" {
  bucket = aws_s3_bucket.terraform_states.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_states" {
  bucket = aws_s3_bucket.terraform_states.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_object_lock_configuration" "terraform_states" {
  bucket              = aws_s3_bucket.terraform_states.id
  object_lock_enabled = "Enabled"
}

resource "aws_dynamodb_table" "terraform_lock" {
  name           = "${local.project}-terraform-locks"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    Name        = "${local.project}-terraform-locks"
    Environment = "${local.project}"
  }
}
