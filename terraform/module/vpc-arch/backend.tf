terraform {
  backend "s3" {
    bucket = "vpc-monit-test"
    key    = "vpc/terraform.tfstate"
    region = "ap-south-1"
  }
}