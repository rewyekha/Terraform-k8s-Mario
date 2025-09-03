output "cluster_endpoint" {
  description = "The endpoint for your EKS Kubernetes API server."
  value       = module.eks.cluster_endpoint
}

output "mario_game_url" {
  description = "The public URL to play the Mario game. It might take a minute to become available."
  value       = "http://${kubernetes_service.mario.status.0.load_balancer.0.ingress.0.hostname}"
}

output "kubeconfig_command" {
  description = "Run this command to configure kubectl to connect to the cluster."
  value       = "aws eks --region ${var.aws_region} update-kubeconfig --name ${var.cluster_name}"
}
