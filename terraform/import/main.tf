provider "aws" {
  region = "ap-south-1"

}

import {
  id = "i-038bbda2347c4afc2"
  to = aws_instance.example
}