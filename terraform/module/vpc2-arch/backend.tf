terraform {
  backend "s3" {
    bucket = "vpc-monit-test"
    key    = "vpc2/terraform.tfstate"
    region = "ap-south-1"
  }
}