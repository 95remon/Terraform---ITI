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