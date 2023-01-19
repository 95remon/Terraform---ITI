resource "aws_subnet" "iti-subnet" {

    vpc_id = aws_vpc.iti-vpc.id

    cidr_block = var.subnet-cidr[count.index]

    count = length(var.subnet-cidr)

    tags = {
        Name = "iti-subnet"
    }
  
}

resource "aws_route_table_association" "iti-public-rta" {

  subnet_id      = aws_subnet.iti-subnet[0].id
  route_table_id = aws_route_table.iti-public-rt.id

}

resource "aws_route_table_association" "iti-private-rta" {

  subnet_id      = aws_subnet.iti-subnet[1].id
  route_table_id = aws_route_table.iti-private-rt.id

}