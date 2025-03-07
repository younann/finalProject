output "load_balancer_dns" {
  value = aws_lb.app_alb.dns_name
}

output "eks_cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
}

output "alb_dns_name" {
  value = aws_lb.app_alb.dns_name
}

output "s3_bucket_name" {
  value = aws_s3_bucket.app_bucket.bucket
}
