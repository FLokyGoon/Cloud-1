# ☁️ Cloud-1 — DevOps Infrastructure & Automation

Welcome to the **Cloud-1 Project** documentation. This project, built as part of the 42 School curriculum, aims to **deploy a complete containerized infrastructure on a cloud provider** using **Terraform**, **Ansible**, and **Docker Compose**.

The goal is to **automate the deployment of a WordPress application stack**, including phpMyAdmin and a MySQL database, hosted on secure and scalable AWS infrastructure — with **TLS, persistence, and best practices** in mind.

---

## 📚 Table of Contents

1. [📦 01 — Prerequisites](01-prerequisites.md)  
2. [🏗️ 02 — Infrastructure with Terraform](02-infrastructure-terraform.md)  
3. [🛠️ 03 — Provisioning with Ansible](03-provisioning-ansible.md)  
4. [🐳 04 — Docker Stack Deployment](04-deployment-docker.md)  
5. [🌐 05 — DNS with Route 53](05-dns-route53.md)  
6. [🔐 06 — HTTPS with ACM and CloudFront](06-ssl-cloudfront.md)  
7. [🛡️ 07 — Hardening and Monitoring](07-hardening-and-monitoring.md)  
8. [✅ 08 — Conclusion](conclusion.md)

---

## 🧭 Project Objectives

- Automate the deployment of a WordPress stack on AWS
- Use **Terraform** for infrastructure as code (IaC)
- Use **Ansible** for configuration management
- Orchestrate services with **Docker Compose**
- Secure infrastructure using **SSM**, **TLS**, and **IAM**
- Persist data using **RDS** and **EFS**
- Route traffic via **ALB**, **CloudFront**, and custom DNS
- Apply DevOps best practices for idempotency and automation

---

## 📌 Evaluation Highlights (from subject)

- ✅ 1 container = 1 process (e.g. nginx, php-fpm, MySQL…)
- ✅ Infrastructure must be reproducible & restartable
- ✅ Fully automated deployment (no manual setup)
- ✅ Services reachable via ALB and secure (TLS)
- ✅ Data must persist across reboots (EFS, RDS)
- ✅ No SSH — only AWS SSM for access
- ✅ docker-compose.yml required

---

Ready to get started? 👉 Head to [01 — Prerequisites](01-prerequisites.md)
