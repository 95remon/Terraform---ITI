# ---------------------------------------------------------------------------------
# Public Application Load Balancer -----------------------------------------------
#---------------------------------------------------------------------------------


resource "aws_security_group" "public-alb-sg" {

    vpc_id = var.vpc-id

    description = "security group for public ALB"

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = [var.all-traffic]
    }


    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [var.all-traffic]
    }



    tags = {
        name = "public-lb-sg"
    }
}




resource "aws_alb" "public-alb" {
    
    name            = "public-alb"
    internal        = false
    security_groups = [aws_security_group.public-alb-sg.id]
    subnets = [var.public-subnet-ids["public-1"],var.public-subnet-ids["public-2"]]
    tags = {
        name = "public-alb"
    }
}




resource "aws_alb_target_group" "public-tg" {
    
    name = "public-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc-id
    tags = {
        name = "public-tg"
    }
}




resource "aws_alb_listener" "public-alb-listener" {
    load_balancer_arn = aws_alb.public-alb.arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
        target_group_arn = aws_alb_target_group.public-tg.arn
        type             = "forward"
    }
}



# ---------------------------------------------------------------------------------
# Private Application Load Balancer -----------------------------------------------
# ---------------------------------------------------------------------------------



resource "aws_security_group" "private-alb-sg" {

    vpc_id = var.vpc-id

    description = "security group for private ALB"

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        security_groups = [var.public-ec2-sg-id]
    }


    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [var.all-traffic]
    }



    tags = {
        name = "private-alb-sg"
    }
}



resource "aws_alb" "private-alb" {
    
    name            = "private-alb"
    internal        = true
    security_groups = [aws_security_group.private-alb-sg.id]
    subnets = [var.private-subnet-ids["private-1"],var.private-subnet-ids["private-2"]]
    tags = {
        name = "private-alb"
    }
}




resource "aws_alb_target_group" "private-tg" {
    
    name = "private-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc-id
    tags = {
        name = "private-tg"
    }
}




resource "aws_alb_listener" "private-alb-listener" {
    load_balancer_arn = aws_alb.private-alb.arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
        target_group_arn = aws_alb_target_group.private-tg.arn
        type             = "forward"
    }
}





