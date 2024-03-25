terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.42.0"
    }
  }
}

provider "aws" {

}


provider "random" {
  
}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "example" {
  # Bucket names rules
  #https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html
  bucket = random_string.bucket_name.result
}


#https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
resource "random_string" "bucket_name" {
  lower = true
  upper = false
  length  = 32
  special = false
}


output "random_bucket_name_id" {
  value = random_string.bucket_name.id
}


output "random_bucket_name_result" {
  value = random_string.bucket_name.result
}