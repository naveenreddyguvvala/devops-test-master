# DevOps Project – Scalable Key-Value Application on AWS

---

##  Overview

This project demonstrates a production-style DevOps implementation of a key-value application using AWS services, Docker, and Terraform.

---

##  Architecture

```id="7p3c4t"
User (Browser)
      ↓
S3 (Frontend - React)
      ↓
Application Load Balancer (ALB)
      ↓
ECS Fargate (Backend API)
      ↓
ElastiCache Redis
```

---

##  Project Structure

###  Application Code Structure

```id="k2z6w1"
devops-test-master/
│
├── api/                  # Backend (Rust - Actix Web)
│   ├── src/
│   │   └── main.rs       # API logic (GET/POST endpoints)
│   ├── Cargo.toml        # Rust dependencies
│   └── Dockerfile        # Container build instructions
│
├── app/                  # Frontend (React)
│   ├── src/
│   │   ├── App.tsx       # UI logic
│   │   └── config.json   # API endpoint configuration
│   ├── public/
│   └── package.json      # Node dependencies
│
└── README.md
```

---

###  Infrastructure (Terraform) Structure

```id="1y9o9n"
devops-project/
│
├── main.tf               # Root module (orchestration)
├── variables.tf
├── outputs.tf
│
├── modules/
│   ├── vpc/              # Networking layer
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│
│   ├── alb/              # Load balancer
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│
│   ├── ecs/              # Compute layer
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│
│   └── redis/            # Data layer
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
```

---

##  Tech Stack

* Frontend: React
* Backend: Rust (Actix Web)
* Containerization: Docker
* Orchestration: AWS ECS Fargate
* Load Balancer: AWS ALB
* Database: AWS ElastiCache Redis
* Infrastructure: Terraform
* Storage: AWS S3
* Registry: AWS ECR

---

##  Deployment Steps

### 1. Clone Repository

```id="r6f8hc"
git clone <repo-url>
cd devops-test-master
```

---

### 2. Build Frontend

```id="v4z2xq"
cd app
npm install
npm run build
```

---

### 3. Upload Frontend to S3

```id="0dy9d4"
aws s3 sync build/ s3://<your-bucket-name>
```

---

### 4. Build & Push Backend Image

```id="2g9l5v"
cd api
docker build -t api .

docker tag api:latest <account-id>.dkr.ecr.<region>.amazonaws.com/api:latest
docker push <account-id>.dkr.ecr.<region>.amazonaws.com/api:latest
```

---

### 5. Deploy Infrastructure

```id="o7l8vx"
cd devops-project
terraform init
terraform apply
```

---

##  Access Application

### Frontend

```id="6a8bvl"
http://<s3-website-url>/index.html
```

### Backend

```id="m4k8gl"
http://<alb-dns>
```

---

##  API Usage

### Store value

```id="6x6xdr"
POST /
{
  "key": "name",
  "value": "naveen"
}
```

### Fetch value

```id="2c5ylt"
GET /name
```

---

##  Key Learnings

* Infrastructure as Code (Terraform modules)
* Containerized deployments with ECS Fargate
* Networking & security (VPC, SG, ALB)
* Debugging real-world distributed system issues
* End-to-end DevOps lifecycle

---

##  Cleanup

```id="iq6v9y"
terraform destroy --auto-approve
```

##  Challenges & Solutions

### 1. Redis Connection Issue

* **Problem:** ECS could not connect to Redis
* **Solution:** Updated security group to allow VPC CIDR and used correct endpoint format

---

### 2. ECS Configuration Not Updating

* **Problem:** Environment variables not applied
* **Solution:** Forced ECS redeployment using Terraform

---

### 3. ALB 503 Errors

* **Problem:** Targets marked unhealthy
* **Solution:** Fixed health check path and matcher

---

### 4. Docker Networking (Local Testing)

* **Problem:** API could not reach Redis
* **Solution:** Used Docker network for container communication

---

##  Cleanup

To delete all resources:

```
terraform destroy --auto-approve
```

---

##  Outcome

* Fully automated infrastructure deployment
* Scalable and secure architecture
* Real-world debugging experience
* Production-ready DevOps workflow

---
Built and deployed a containerized application using Terraform, ECS Fargate, ALB, and Redis, while solving real-world issues related to networking, security, and application configuration.
