resource "aws_subnet" "iti-public-subnet" {

    vpc_id = aws_vpc.iti-vpc.id
    cidr_block = "10.0.0.0/24"

    tags = {
        Name = "iti-public-subnet"
    }
  
}

resource "aws_route_table_association" "iti-rta" {

  subnet_id      = aws_subnet.iti-public-subnet.id
  route_table_id = aws_route_table.iti-public-rt.id

}