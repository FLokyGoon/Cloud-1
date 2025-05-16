# 🏗️ 02 --- Infrastructure with Terraform
======================================

This chapter details how we provision **all** AWS resources with Terraform, the infrastructure‑as‑code (IaC) backbone of Cloud‑1. You will learn both **project structure** *and* **daily CLI workflow**, so you can reproduce, destroy, and restore your stack at will.

* * * * *

## 🧱 Summary
----------

Terraform will automatically create and manage:

-   VPC and public subnets

-   EC2 instance (or Auto Scaling Group later)

-   RDS (MySQL)

-   EFS (Elastic File System)

-   ALB (Application Load Balancer)

-   S3 bucket (optional media storage)

-   CloudFront distribution

-   IAM roles & policies for SSM

* * * * *

## 📋 Prerequisites
----------------

-   [01 --- Prerequisites](https://chatgpt.com/g/g-p-6814b7fee73c819196cb074bd2ef952f-cloud-1/c/01-prerequisites.md) completed ✔️

-   AWS credentials configured (`aws configure`)

-   Terraform **installed on Ubuntu 22.04** (`terraform -v`)

* * * * *

## 🪜 Step‑by‑Step Instructions
----------------------------

### 1\. 📁 Project & Module Layout

Create the base tree:

```sh
	mkdir -p terraform modules environments/dev
	cd terraform

	touch main.tf provider.tf variables.tf outputs.tf terraform.tfvars

```

You should now have:

```sh
cloud-1/
├── terraform/
│   ├── main.tf
│   ├── provider.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars
└── modules/
    ├── vpc/
    ├── ec2/
    ├── rds/
    ├── efs/
    ├── alb/
    ├── s3/
    ├── cloudfront/
    └── ssm/

```

Each sub‑folder inside `modules/` will expose its own `main.tf`, `variables.tf`, and `outputs.tf`, keeping responsibilities well‑separated.

* * * * *

### 2\. 🏁 Terraform CLI Workflow (Ubuntu 22.04.5 LTS)

#### 2.2 Standard Commands

Run these **inside** the `terraform/` directory:

```sh
	terraform init       # Download provider plugins & create .terraform.lock.hcl
	terraform validate   # Lint & validate syntax
	terraform plan       # Compare *.tf files with real AWS & show the diff
	terraform apply      # Provision / update resources and write terraform.tfstate

```

*Tips*

-   Add `-out=tfplan` to `plan` to save the plan and apply it later.

-   The first `apply` creates everything; subsequent runs only change what drifted or is new.

#### 2.3 Destroy Everything

```sh
	terraform destroy

```

Terraform reads `terraform.tfstate` to know what exists, deletes those resources, then updates the state to reflect an empty stack.

#### 2.4 Backup & Restore State

```sh
	cp terraform.tfstate.backup terraform.tfstate
	terraform plan        # Inspect differences before re‑applying

```

This lets you roll back to a previous known‑good state file, useful after accidental edits or corruption.

* * * * *

#### ✅ Expected Result
-----------------

By the end of this chapter you should be able to:

-   Bootstrap the project structure for Terraform modules

-   Install & use Terraform CLI on Ubuntu 22.04

-   Create, update, destroy, and restore Cloud‑1 infrastructure confidently

* * * * *

<div align="center">
	<a href="01-prerequisites.md">
		<img src="https://img.shields.io/badge/⬅️%20Previous-Prerequisites-blue" alt="Previous">
	</a>
	<a href="03-provisioning-ansible.md">
		<img src="https://img.shields.io/badge/Next-Provisioning%20with%20Ansible-ff69b4" alt="Next">
	</a>
</div>