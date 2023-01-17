resource "aws_vpc" "iti-vpc" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "iti-vpc"
  }
}