resource "aws_security_group" "iti-private-sg" {
    
    vpc_id      = aws_vpc.iti-vpc.id

    ingress {
        from_port        = 22
        to_port          = 22
        protocol         = "tcp"
        cidr_blocks      = [aws_subnet.iti-subnet[0].cidr_block]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [var.all-traffic]
    }

    tags = {
        Name = "iti-private-sg"
        description = "iti-private-sg1"
    }
}