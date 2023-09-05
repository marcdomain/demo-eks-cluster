data "tls_certificate" "eks" {
  url = aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}

module "cluster_autoscaler_service_account" {
  source             = "./modules/iam/oidc"
  role_name          = "${var.cluster_name}-cluster-autoscaler-oidc"
  iam_policy         = file("./policy-doc/autoscaler-policy.json")
  oidc_provider_url  = aws_iam_openid_connect_provider.eks.url
  oidc_provider_arns = [aws_iam_openid_connect_provider.eks.arn]
  service_account    = ["system:serviceaccount:kube-system:cluster-autoscaler"]
}

module "reverse_ip_service_account" {
  source             = "./modules/iam/oidc"
  role_name          = "${var.cluster_name}-reverse-ip-service-oidc"
  iam_policy         = file("./policy-doc/reverse-ip-service-policy.json")
  oidc_provider_url  = aws_iam_openid_connect_provider.eks.url
  oidc_provider_arns = [aws_iam_openid_connect_provider.eks.arn]
  service_account    = ["system:serviceaccount:${local.namespace}:${var.reverse_ip_service_account}"]
}
