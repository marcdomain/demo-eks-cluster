locals {
  environment = terraform.workspace
  namespace   = local.environment

  service_names = [
    "reverse-ip-service"
  ]

  tags = {
    Cluster     = var.cluster_name
    Terraform   = true
    Environment = local.environment
  }

  number_of_azs = {
    dev  = 2
    prod = length(data.aws_availability_zones.available.names)
  }

  cluster_iam_managed_policies = [
    "AmazonEKSClusterPolicy",
    "AmazonEKSVPCResourceController",
  ]

  node_group_iam_managed_policies = [
    "AmazonEKSWorkerNodePolicy",
    "AmazonEKS_CNI_Policy",
    "AmazonEC2ContainerRegistryReadOnly"
  ]

  reverse_ip_service_iam_policies = [
    "ListAllMyBuckets",
    "GetBucketLocation"
  ]
}
