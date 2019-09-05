variable "aws_region" {
  type = "string"
  default = "us-east-1"
}

variable "azs" {
  type = "list"
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
  description = "List of AZs to use"
}

variable "stack_name" {
  type = "string"
  description = "Stack name, used to form resource names"
  default = "demo"
}

variable "vpc_cidr" {
  type = "string"
  default = "10.0.0.0/16"
}

variable "secondary_cidr_blocks" {
  type = "list"
  default = ["10.2.0.0/16"]
}

variable "private_subnets" {
  type = "list"
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
  type = "list"
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "eks_worker_node_type" {
  type = "string"
  default = "m4.large"
}

variable "eks_worker_node_count" {
  type = "string"
  default = "2"
}

variable "ssh_key_name" {
  type = "string"
}