provider "aws" {
  region = "ap-south-1"
}

data "aws_availability_zones" "az" {
  state = "available"
}

# Number of EC2s per AZ
variable "instance_count" {
  default = 2
}

# Generate a combined map of { "az|index" => az }
locals {
  # Generate a list of all combinations of AZ and index
  az_index_list = flatten([
    for az in data.aws_availability_zones.az.names : [
      for i in range(var.instance_count) : {
        key   = "${az}-${i}"
        value = az
      }
    ]
  ])

  # Convert the list of maps into a single map
  instance_matrix = {
    for pair in local.az_index_list :
    pair.key => pair.value
  }
}

output "az_index_list" {
  value = local.az_index_list
}

resource "aws_instance" "multi-instance" {
  for_each = local.instance_matrix

  ami               = "ami-0af9569868786b23a"
  instance_type     = "t3.micro"
  availability_zone = each.value

  tags = {
    Name = "ec2-${each.key}"
  }

}

output "az_output" {
  value = (local.instance_matrix)
}



