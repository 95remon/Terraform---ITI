output "subnet-ids" {
    value = {
        public-1 = aws_subnet.iti-subnet["public-1"].id,
        private-1 = aws_subnet.iti-subnet["private-1"].id,
        public-2 = aws_subnet.iti-subnet["public-2"].id,
        private-2 = aws_subnet.iti-subnet["private-2"].id,
    }
}


output "iti-public-sg-id" {
    value = aws_security_group.iti-public-sg.id
}

output "iti-private-sg-id" {
    value = aws_security_group.iti-private-sg.id
}

output "iti-vpc-id" {
    value = aws_vpc.iti-vpc.id
}
