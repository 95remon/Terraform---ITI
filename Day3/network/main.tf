# create Main VPC ----------------------------------------------------

resource "aws_vpc" "iti-vpc" {
  cidr_block       = var.vpc-cidr
  tags = {
    Name = var.vpc-cidr
  }
}


# create 4 subnets  ----------------------------------------------------

resource "aws_subnet" "iti-subnet" {
  for_each = var.subnets
  vpc_id = aws_vpc.iti-vpc.id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
        Name = each.key
  }

}

# create gw -----------------------------------------------------------

resource "aws_internet_gateway" "iti-gw" {
  vpc_id = aws_vpc.iti-vpc.id

  tags = {
    Name = "main-gw"
  }
}

# create public route table ----------------------------------------------

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

# create private route table  -----------------------------------------

resource "aws_eip" "iti-eip" {
    vpc              = true
}

resource "aws_nat_gateway" "iti-nat-gw" {
    allocation_id = aws_eip.iti-eip.id
    subnet_id     = aws_subnet.iti-subnet["public-1"].id

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

# route table association -----------------------------------------------

resource "aws_route_table_association" "iti-public1-rta" {

  subnet_id      = aws_subnet.iti-subnet["public-1"].id
  route_table_id = aws_route_table.iti-public-rt.id

}

resource "aws_route_table_association" "iti-public2-rta" {

  subnet_id      = aws_subnet.iti-subnet["public-2"].id
  route_table_id = aws_route_table.iti-public-rt.id

}

resource "aws_route_table_association" "iti-private1-rta" {

  subnet_id      = aws_subnet.iti-subnet["private-1"].id
  route_table_id = aws_route_table.iti-private-rt.id

}

resource "aws_route_table_association" "iti-private2-rta" {

  subnet_id      = aws_subnet.iti-subnet["private-2"].id
  route_table_id = aws_route_table.iti-private-rt.id

}


# security groups ------------------------------------------------------

resource "aws_security_group" "iti-private-sg" {
    
    vpc_id      = aws_vpc.iti-vpc.id


    ingress {
        from_port        = 80
        to_port          = 80
        protocol         = "tcp"
        security_groups = [var.private-alb-sg-id]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [var.all-traffic]
    }

    tags = {
        Name = "iti-private-sg"
    }
}

resource "aws_security_group" "iti-public-sg" {
    
    vpc_id      = aws_vpc.iti-vpc.id

    ingress {
        from_port        = 80
        to_port          = 80
        protocol         = "tcp"
        cidr_blocks      = [var.all-traffic]
    }

    ingress {
        from_port        = 22
        to_port          = 22
        protocol         = "tcp"
        cidr_blocks      = [var.all-traffic]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [var.all-traffic]
    }

    tags = {
        Name = "iti-public-sg"
        description = "iti-public-sg1"
    }
}
