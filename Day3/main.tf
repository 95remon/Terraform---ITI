module "network" {
    source = "./network"
    vpc-cidr = var.vpc-cidr
    subnets = var.subnets
    all-traffic = var.all-traffic
    private-alb-sg-id = module.loadbalancer.private-alb-sg-id
}

module "loadbalancer" {
    source = "./loadbalancer"
    public-subnet-ids= {
        public-1 = module.network.subnet-ids["public-1"],
        public-2 = module.network.subnet-ids["public-2"],
    }
    private-subnet-ids= {
        private-1 = module.network.subnet-ids["private-1"],
        private-2 = module.network.subnet-ids["private-2"],
    }
    vpc-id = module.network.iti-vpc-id
    all-traffic = var.all-traffic
    public-ec2-sg-id = module.network.iti-public-sg-id
}

module "ec2" {

    source = "./ec2"
    public-subnet-ids= {
        public-1 = module.network.subnet-ids["public-1"],
        public-2 = module.network.subnet-ids["public-2"],
    }
    private-subnet-ids= {
        private-1 = module.network.subnet-ids["private-1"],
        private-2 = module.network.subnet-ids["private-2"],
    }
    ec2-type = var.ec2-type
    public-ec2-sg-id = module.network.iti-public-sg-id
    private-ec2-sg-id = module.network.iti-private-sg-id
    private-load-balancer-dns = module.loadbalancer.private-load-balancer-dns
    public-tg-arn = module.loadbalancer.public-tg-arn
    private-tg-arn = module.loadbalancer.private-tg-arn
    vpc-id = module.network.iti-vpc-id
    all-traffic = var.all-traffic
    private-alb-sg-id = module.loadbalancer.private-alb-sg-id

}