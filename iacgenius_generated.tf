```hcl
# Create a new EKS cluster
resource "aws_eks_cluster" "my_cluster" {
  name     = "my-eks-cluster"  # Cluster name
  role_arn = "arn:aws:iam::123456789012:role/eks-role"  # IAM role ARN for EKS cluster
  version  = "1.21"  # Kubernetes version

  vpc_config {
    subnet_ids          = ["subnet-1234567890abcdef0", "subnet-0987654321abcdef0"]  # Subnet IDs for EKS cluster
    security_group_ids  = ["sg-0123456789abcdef0"]  # Security group ID for EKS cluster
  }
}

# Attach the worker nodes to the EKS cluster
resource "aws_eks_node_group" "my_node_group" {
  cluster_name    = aws_eks_cluster.my_cluster.name  # Cluster name to attach the nodes to
  node_group_name = "my-node-group"  # Node group name
  node_role_arn   = "arn:aws:iam::123456789012:role/eks-node-role"  # IAM role ARN for the nodes

  subnet_ids = ["subnet-1234567890abcdef0", "subnet-0987654321abcdef0"]  # Subnet IDs for the nodes
  instance_types = ["t3.medium"]  # EC2 instance types for the nodes
  scaling_config {
    desired_size = 2  # Desired number of nodes
    max_size     = 3  # Maximum number of nodes
    min_size     = 1  # Minimum number of nodes
  }
}
```  