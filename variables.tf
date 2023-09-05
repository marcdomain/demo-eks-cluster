variable "aws_region" {
  default = "eu-central-1"
}

variable "cluster_name" {
  type    = string
  default = "marcus-eks-cluster"
}

variable "vpc_cidr" {
  type = string
}

# https://aws.amazon.com/ec2/instance-types/
variable "instance_types" {
  type    = list(any)
  default = ["t2.large"]
}

variable "single_nat_gateway" {
  type    = bool
  default = false
}

variable "private_subnet_cidr" {
  type = list(string)
}

variable "public_subnet_cidr" {
  type = list(string)
}

variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "aws_account_number" {
  type = string
}

variable "reverse_ip_service_account" {
  type    = string
  default = "reverse-ip-service"
}
