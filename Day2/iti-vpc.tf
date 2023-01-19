resource "aws_vpc" "iti-vpc" {
  cidr_block       = var.vpc-cidr
  tags = {
    Name = "iti-vpc"
  }
}