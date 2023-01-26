vpc-cidr = "10.0.0.0/16"
aim-id = "ami-06878d265978313ca"
ec2-type = "t2.micro"
subnets = {
    public-1 = {cidr_block = "10.0.0.0/24" , availability_zone = "us-east-1d"},
    private-1 = {cidr_block = "10.0.1.0/24" , availability_zone = "us-east-1d"},
    public-2 = {cidr_block = "10.0.2.0/24" , availability_zone = "us-east-1b"},
    private-2 = {cidr_block = "10.0.3.0/24" , availability_zone = "us-east-1b"},
}
all-traffic = "0.0.0.0/0"

public-subnet-ids = {
    public-1 = "",
    public-2 = "",
}

# private-subnet-ids = {
#     private-1 = "",
#     private-2 = "",
# }
