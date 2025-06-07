resource "aws_route_table" "pub_route" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "priv_route" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table_association" "pub_sub1_route" {
  route_table_id = aws_route_table.pub_route.id
  subnet_id      = aws_subnet.pub_sub1.id
}

resource "aws_route_table_association" "pub_sub2_route" {
  route_table_id = aws_route_table.pub_route.id
  subnet_id      = aws_subnet.pub_sub2.id
}

resource "aws_route_table_association" "priv_sub1_route" {
  route_table_id = aws_route_table.priv_route.id
  subnet_id      = aws_subnet.priv_sub1.id
}

resource "aws_route" "route_pub_route" {
  route_table_id         = aws_route_table.pub_route.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route" "route_prv_route" {
  route_table_id         = aws_route_table.priv_route.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}