provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "multi-ec2" {
  ami           = "ami-0af9569868786b23a"
  instance_type = "t2.micro"
  count         = 3

  tags = {
    Name = "multi-ec2-${count.index + 1}"
  }
}

output "instance_name" {
  value = [
    for instance in aws_instance.multi-ec2 :
    instance.tags["Name"]
  ]
}