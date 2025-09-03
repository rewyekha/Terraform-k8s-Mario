# 1. NETWORKING FOR EKS
# EKS requires a VPC with specific tags. This module sets it up correctly.
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.5.2"

  name = "mario-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    "Terraform" = "true"
  }
}


# 2. EKS CLUSTER PROVISIONING
# This module abstracts away the complexity of setting up a production-ready EKS cluster.
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"

  cluster_name    = var.cluster_name
  cluster_version = "1.29"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    main = {
      min_size     = 1
      max_size     = 3
      desired_size = 2
      instance_types = ["t3.medium"]
    }
  }

  tags = {
    Project = "Mario-Showcase"
  }
}


# 3. KUBERNETES APPLICATION DEPLOYMENT
# This section uses the Kubernetes provider to apply our manifests.
# This demonstrates managing the application layer with Terraform.

resource "kubernetes_deployment" "mario" {
  metadata {
    name = "mario-deployment"
    labels = {
      app = "mario"
    }
  }

  spec {
    replicas = var.mario_replica_count

    selector {
      match_labels = {
        app = "mario"
      }
    }

    template {
      metadata {
        labels = {
          app = "mario"
        }
      }

      spec {
        container {
          image = "pengbai/docker-mario"
          name  = "mario"
          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "mario" {
  metadata {
    name = "mario-service"
  }
  spec {
    selector = {
      app = kubernetes_deployment.mario.spec.0.template.0.metadata.0.labels.app
    }
    port {
      port        = 80
      target_port = 8080
    }
    type = "LoadBalancer"
  }
}
