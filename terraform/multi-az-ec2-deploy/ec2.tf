provider "aws" {
  region = "ap-south-1"
}

data "aws_availability_zones" "az" {
  state = "available"
}

output "az_list" {
    value = toset(data.aws_availability_zones.az.names)
}

resource "aws_instance" "demo" {
  for_each = toset(data.aws_availability_zones.az.names)

  ami           = "ami-0af9569868786b23a"
  instance_type = "t3.micro"
  availability_zone = each.key

  tags = {
    Name = "demo-${each.key}"
  }

}