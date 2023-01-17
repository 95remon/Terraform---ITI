resource "aws_instance" "iti-public-ec2" {
 
    ami           = "ami-06878d265978313ca"
    
    instance_type = "t2.micro"
    
    subnet_id = aws_subnet.iti-public-subnet.id
    
    associate_public_ip_address = true

    vpc_security_group_ids = [aws_security_group.iti-public-sg.id]
    
    user_data = file("ec2-userdata.sh")
    
    tags = {
      Name = "iti-public-ec2"
    }
  
}