resource "aws_eip" "iti-eip" {
    vpc              = true
}

resource "aws_nat_gateway" "iti-nat-gw" {
    allocation_id = aws_eip.iti-eip.id
    subnet_id     = aws_subnet.iti-subnet[0].id

    tags = {
        Name = "gw NAT"
    }
}

resource "aws_route_table" "iti-private-rt" {
  vpc_id = aws_vpc.iti-vpc.id

  route {
    cidr_block = var.all-traffic
    gateway_id = aws_nat_gateway.iti-nat-gw.id
  }

  tags = {
    Name = "iti-private-rt"
  }
}