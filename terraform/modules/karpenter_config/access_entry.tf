# Create the EKS access entry for the role
resource "aws_eks_access_entry" "nodeclass_access" {
  cluster_name  = var.cluster_name
  principal_arn = aws_iam_role.nodeclass_role.arn
  type          = "EC2"

  depends_on = [
    var.eks_dependency
  ]
}

# Associate the AmazonEKSAutoNodePolicy with the access entry
resource "aws_eks_access_policy_association" "nodeclass_policy" {
  cluster_name  = var.cluster_name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAutoNodePolicy"
  principal_arn = aws_iam_role.nodeclass_role.arn

  access_scope {
    type = "cluster"
  }

  depends_on = [
    aws_eks_access_entry.nodeclass_access
  ]
}
