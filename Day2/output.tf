output "public-ec2-ip" {
    value = aws_instance.iti-public-ec2.public_ip
}

output "private-ec2-ip" {
    value = aws_instance.iti-private-ec2.private_ip
}