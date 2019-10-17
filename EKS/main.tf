provider "aws" {
  region = "${var.aws_region}"
}

module "eks-demo-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "1.71.0"

  name                  = "${var.stack_name}"
  cidr                  = "${var.vpc_cidr}"
  secondary_cidr_blocks = "${var.secondary_cidr_blocks}"

  azs             = "${var.azs}"
  private_subnets = "${var.private_subnets}"
  public_subnets  = "${var.public_subnets}"

  private_subnet_tags = {
    "kubernetes.io/cluster/eks-demo" =  "shared"
    "kubernetes.io/role/internal-elb" = 1
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/eks-demo" =  "shared"
    "kubernetes.io/role/elb" = 1
}

  enable_nat_gateway = "true"
  single_nat_gateway = "true"

  tags = {
    Terrafrom   = "true"
    Environment = "dev"
    Project     = "${var.stack_name}"
    "kubernetes.io/cluster/eks-demo" =  "shared"
  }
}

module "eks-demo-cluster" {
  source  = "terraform-aws-modules/eks/aws"
  version = "4.0.2"

  cluster_name = "eks-demo"
  subnets      = "${module.eks-demo-vpc.public_subnets}"
  vpc_id       = "${module.eks-demo-vpc.vpc_id}"

  worker_groups = [
    {
      instance_type = "${var.eks_worker_node_type}"
      asg_min_size  = 1
      asg_max_size  = 2
      key           = "${var.ssh_key_name}"
    },
  ]

  cluster_create_timeout = "30m"
  cluster_delete_timeout = "30m"

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Project     = "${var.stack_name}"
  }
}