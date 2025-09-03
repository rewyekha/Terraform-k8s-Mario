variable "aws_region" {
  description = "The AWS region where resources will be created."
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "The name for the EKS cluster."
  type        = string
  default     = "mario-cluster"
}

variable "mario_replica_count" {
  description = "Number of Mario pods to run."
  type        = number
  default     = 2
}
