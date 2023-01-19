resource "aws_internet_gateway" "iti-gw" {
  vpc_id = aws_vpc.iti-vpc.id

  tags = {
    Name = "main-gw"
  }
}