variable "vpc-cidr" {
    type = string
}

variable "subnets" {
  type = map(object({
    cidr_block = string
    availability_zone = string
  }))
}

variable "all-traffic" {

}

variable "private-alb-sg-id" {
}