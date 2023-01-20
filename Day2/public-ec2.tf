resource "aws_instance" "iti-public-ec2" {

    ami           =  var.aim-id
    
    instance_type = var.ec2-type
    
    subnet_id     = aws_subnet.iti-subnet[0].id
    
    associate_public_ip_address = true

    vpc_security_group_ids = [aws_security_group.iti-public-sg.id]
    
    user_data = file("ec2-userdata.sh")
    
    tags = {
      Name = "iti-public-ec2"
    }
  
}