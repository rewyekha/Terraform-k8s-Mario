# Terraform on Kubernetes: Deploying Mario on AWS EKS

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)

This project is a professional showcase demonstrating how to provision a production-ready **AWS EKS Kubernetes cluster** and deploy a containerized application onto it, all managed end-to-end with **Terraform**.

The goal is to highlight proficiency in modern DevOps practices, including Infrastructure as Code (IaC), container orchestration, and full-stack deployment automation.

---

### 🏛️ Architecture



The Terraform script automates the following workflow:
1.  **VPC Creation**: Provisions a new, production-grade VPC with public and private subnets using the official `terraform-aws-modules/vpc` module.
2.  **EKS Cluster Provisioning**: Creates a managed EKS cluster with a node group of EC2 instances using the `terraform-aws-modules/eks` module.
3.  **Kubernetes Provider Configuration**: Terraform dynamically configures its own Kubernetes provider to authenticate with the newly created EKS cluster.
4.  **Application Deployment**:
    * Applies a Kubernetes **Deployment** to run the "Super Mario" game container.
    * Applies a Kubernetes **Service** of type `LoadBalancer`, which automatically provisions an AWS Network Load Balancer.
5.  **Output URL**: The public URL of the Load Balancer is provided as an output, giving you direct access to the game.

---

### ✨ Key Skills Demonstrated

* **Multi-Provider Management**: Uses both the `aws` and `kubernetes` Terraform providers in a single project, linking them together dynamically.
* **Infrastructure and Application as Code**: Manages not only the cloud resources but also the application configuration running on Kubernetes.
* **Modular & Reusable Code**: Leverages community-standard Terraform modules for VPC and EKS, a critical best practice for avoiding boilerplate and ensuring maintainability.
* **End-to-End Automation**: A single `terraform apply` command handles everything from network creation to application deployment and exposure.
* **Clean Code Separation**: Infrastructure code (`.tf` files) is kept separate from the application manifests (`.yaml` files).

---

### 🚀 How to Deploy

#### Prerequisites

1.  **Terraform** (`~> 1.5`) installed.
2.  **AWS Account** and **AWS CLI** (`~> 2.0`) configured with your credentials.
3.  **kubectl** installed to interact with the cluster.

#### Deployment Steps

1.  **Clone the repository:**
    ```sh
    git clone <your-repo-url>
    cd terraform-k8s-mario
    ```

2.  **Initialize Terraform:**
    This will download the necessary providers and modules.
    ```sh
    terraform init
    ```

3.  **Plan the deployment:**
    Review the resources that Terraform will create.
    ```sh
    terraform plan
    ```

4.  **Apply the configuration:**
    This will build the entire infrastructure and deploy the game. **This may take 15-20 minutes**, as EKS cluster creation is a lengthy process.
    ```sh
    terraform apply --auto-approve
    ```

5.  **Access the Game!**
    Once the apply is complete, Terraform will display the `mario_game_url`. Copy this URL into your browser to play the game.
    *Note: It may take an additional 1-2 minutes for the AWS Load Balancer to become fully active.*

#### Interacting with the Cluster

To manage the cluster with `kubectl`, run the command provided in the Terraform output `kubeconfig_command`.
```sh
aws eks --region us-east-1 update-kubeconfig --name mario-cluster
kubectl get pods
kubectl get services
```

### 🧹 Cleanup

To destroy all created resources and avoid incurring AWS costs, run:
```sh
terraform destroy --auto-approve
```

### Support 😒🫴🏼
Just hit the ⭐️ 
and hit the FOLLOW 🥲🫶🏼
