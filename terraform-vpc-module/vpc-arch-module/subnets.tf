resource "aws_subnet" "pub_sub1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.pub_sub1_cidr_range
  availability_zone = var.pub_sub1_region
}

resource "aws_subnet" "pub_sub2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.pub_sub2_cidr_range
  availability_zone = var.pub_sub2_region
}

resource "aws_subnet" "priv_sub1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.priv_sub1_cidr_range
  availability_zone = var.priv_sub1_region
}