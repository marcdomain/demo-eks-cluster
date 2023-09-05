################## CLUSTER IAM ROLE ####################
module "cluster_iam_role" {
  source             = "./modules/iam/role"
  role_name          = var.cluster_name
  assume_role_policy = file("./policy-doc/eks-assume-role.json")
  policy_names       = local.cluster_iam_managed_policies
}

################## NODE GROUP IAM ROLE ####################
module "node_group_iam_role" {
  source             = "./modules/iam/role"
  role_name          = "${var.cluster_name}-node-group"
  assume_role_policy = file("./policy-doc/ec2-assume-role.json")
  policy_names       = local.node_group_iam_managed_policies
}
