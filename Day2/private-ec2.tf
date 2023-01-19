resource "aws_instance" "iti-private-ec2" {
 
    ami           =  var.aim-id
    
    instance_type = var.ec2-type
    
    subnet_id     = aws_subnet.iti-subnet[1].id
    

    vpc_security_group_ids = [aws_security_group.iti-private-sg.id]
    
    user_data = file("ec2-userdata.sh")
    
    tags = {
      Name = "iti-private-ec2"
    }
  
}