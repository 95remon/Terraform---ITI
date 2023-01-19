resource "aws_route_table" "iti-public-rt" {
  vpc_id = aws_vpc.iti-vpc.id

  route {
    cidr_block = var.all-traffic
    gateway_id = aws_internet_gateway.iti-gw.id
  }

  tags = {
    Name = "iti-public-rt"
  }
}