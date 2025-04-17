resource "aws_iam_role" "nodeclass_role" {
  name = "${var.nodeclass_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name = "${var.nodeclass_name}-role"
  }
}

resource "aws_iam_role_policy_attachment" "nodeclass_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodeMinimalPolicy"
  role       = aws_iam_role.nodeclass_role.name
}

resource "aws_iam_role_policy_attachment" "nodeclass_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPullOnly"
  role       = aws_iam_role.nodeclass_role.name
}

resource "aws_iam_instance_profile" "nodeclass_profile" {
  name = "${var.nodeclass_name}-profile"
  role = aws_iam_role.nodeclass_role.name
}
