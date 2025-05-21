# 🎮 Pacman on AWS – Cloud-Native Deployment

This repository contains a fully automated deployment of the classic [Pacman Game](https://github.com/font/pacman) using a modern cloud-native stack:
- Kubernetes (EKS)
- MongoDB (StatefulSet)
- Docker (ECR)
- CI/CD with CodePipeline & CodeBuild
- Terraform (for infrastructure as code)

---

## 🧠 Overview

Pacman is a browser-based arcade game implemented in Node.js. This project packages and deploys the application with AWS infrastructure, applying production-level best practices.

---

## ⚙️ Tech Stack

| Component          | Technology                      |
|--------------------|----------------------------------|
| Infrastructure     | Terraform                       |
| Cluster            | Amazon EKS                      |
| CI/CD              | AWS CodePipeline & CodeBuild    |
| App Container      | Docker (Node.js App)            |
| Image Registry     | Amazon ECR                      |
| Database           | MongoDB (K8s StatefulSet + PVC) |
| Storage            | AWS EBS with gp3                |
| Load Balancer      | Kubernetes LoadBalancer Service |

---

## 📁 Project Structure

```bash
pacman-terraform-k8s/
├── terraform/                # Infrastructure as Code for EKS
├── pacman-src/              # Application source
│   ├── Dockerfile
│   └── bin/server.js
├── k8s-manifests/
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── mongodb-statefulset.yaml
│   └── gp3-storageclass.yaml
├── buildspec.yml            # CI/CD configuration
└── README.md                # Project documentation
```

---

## 🚀 How It Works

### CI/CD Pipeline

1. Code is pushed to GitHub.
2. CodePipeline is triggered.
3. CodeBuild builds the Docker image and pushes it to ECR.
4. Kubernetes is updated via `kubectl apply`.

### MongoDB Deployment

- Deployed via StatefulSet.
- Backed by a PersistentVolume (EBS).
- Accessible internally via `mongodb:27017`.

---

## 🌐 Accessing the Application

Find your LoadBalancer URL via:

```bash
kubectl get svc pacman-service
```

Visit `http://<EXTERNAL-IP>` in a browser to play the game.

---

## 🧰 Developer Instructions

### Local Development (Optional)

```bash
cd pacman-src
npm install
node bin/server.js
```

### Build Docker Image Locally

```bash
docker build -t pacman .
```

---

## 🧱 Architecture Diagram

```
          ┌──────────────┐
          │   GitHub     │
          └────┬─────────┘
               │
        ┌──────▼─────┐
        │ CodePipeline│
        └──────┬─────┘
               ▼
        ┌─────────────┐
        │ CodeBuild   │
        └────┬────────┘
             ▼
      ┌─────────────┐
      │   Amazon ECR│
      └────┬────────┘
           ▼
    ┌──────────────┐
    │   Amazon EKS │
    │ ┌──────────┐ │
    │ │ Pacman   │ │
    │ └──────────┘ │
    │ ┌──────────┐ │
    │ │ MongoDB  │ │
    │ └──────────┘ │
    └──────────────┘
```

---

## ✅ Checklist

- [x] EKS & VPC setup with Terraform
- [x] MongoDB with StatefulSet & PVC
- [x] CI/CD via AWS native services
- [x] Docker image in ECR
- [x] App exposed via LoadBalancer
- [x] Code tested, structured, and documented

---

