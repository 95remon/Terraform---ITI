variable "vpc-cidr" {
    type = string
    
}

variable "aim-id" {
    description = "Ubuntu"
    type = string
    
}

variable "ec2-type" {
    description = "micro-free"
    type = string
    
}

variable "subnet-cidr" {
    type = list
}

variable "all-traffic" {
    type = string
  
}