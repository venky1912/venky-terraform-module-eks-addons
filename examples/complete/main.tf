module "eks_addons" {
  source = "../../"

  cluster_name = "platform-dev"

  addons = {
    coredns                = {}
    kube-proxy             = {}
    vpc-cni                = {}
    aws-ebs-csi-driver     = {}
    eks-pod-identity-agent = {}
  }

  tags = {
    Environment = "dev"
    Project     = "eks-platform"
    ManagedBy   = "terraform"
  }
}
