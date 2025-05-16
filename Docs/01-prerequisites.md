# 📦 01 — Prerequisites

This chapter explains what you need to install, configure, or understand before starting the Cloud-1 project. Having the right tools and accounts set up will save you time and confusion later.

---

## 🧰 Requirements (Tested on Ubuntu 22.04 LTS)

---

### ✅ 1. A Cloud Provider Account (AWS)

You'll need an active AWS account to host your infrastructure:

- AWS account with **free-tier eligibility**
- Region used: `eu-north-1` (Stockholm)
- IAM user with **AdministratorAccess** or equivalent rights for Terraform

#### 🔍 AWS IAM Setup

1. Log in with your AWS **root account**

2. Create an **IAM group** (e.g., `cloud1-admins`) and attach policies:
   - `AmazonVPCFullAccess`
   - `AmazonEC2FullAccess`
   - `AmazonRDSFullAccess`
   - `AmazonS3FullAccess`
   - `AmazonEFSFullAccess`
   - `CloudFrontFullAccess`
   - `AmazonSSMFullAccess`
   - `AdministratorAccess`

3. Create an **IAM user**:
   - Assign to the group
   - Enable **programmatic access** (generate Access Key & Secret)
   - Save credentials securely

---

### ✅ 2. Install CLI Tools (on Ubuntu 22.04)

#### 🛠️ Terraform

```bash
  sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
  wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

  sudo apt update && sudo apt install terraform
  terraform -v
  terraform -install-autocomplete
```

#### 🔧 Ansible

```bash
  sudo apt install -y ansible
  ansible --version
```

#### 🐳 Docker & Docker Compose

```bash
  sudo apt install -y docker.io docker-compose
  sudo systemctl enable docker
  sudo usermod -aG docker $USER
```

Log out and back in, or run newgrp docker.

#### 📡 AWS CLI

```bash
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
  aws --version
  rm -rf aws awscliv2.zip
```

#### 🧩 Session Manager Plugin (for SSM)

```bash
  curl "https://s3.amazonaws.com/session-manager-downloads/linux/latest/session-manager-plugin.deb" -o "ssm-plugin.deb"
  sudo dpkg -i ssm-plugin.deb
  session-manager-plugin
```

### ✅ 3. Git Project Setup

```bash
  git init cloud-1
  cd cloud-1
```

#### Recommended structure:

```bash
  cloud-1/
  ├── terraform/
  ├── modules/
  ├── environments/
  ├── ansible/
  ├── docker/
  ├── .env
  ├── README.md
```

### ✅ 4. AWS CLI Configuration

After creating your IAM user and getting credentials:

```bash
  aws configure
  # Fill in:
  # AWS Access Key ID
  # AWS Secret Access Key
  # Region: eu-north-1
  # Output format: json
```

####  Validate configuration:

```bash
  aws sts get-caller-identity
```

### ✅ 5. SSH-less Setup with SSM

Cloud-1 forbids SSH. You must use AWS Systems Manager (SSM) to connect to EC2.

Your EC2 instances must:

- Have the SSM agent installed

- Use an IAM role with AmazonSSMManagedInstanceCore policy

- Be launched in a public subnet with outbound internet access (via NAT or IGW)

We’ll configure this in a later chapter.

### ✅ Expected Result

By the end of this chapter, you should have:

- ✅ An AWS account with IAM and credentials configured

- ✅ Terraform, Docker, Ansible, and AWS CLI installed on Ubuntu 22.04

- ✅ A structured Git repo ready to hold your project

- ✅ SSM plugin installed and verified

You're now ready to start building your infrastructure!

<div align="center">
  <a href="../README.md">
    <img src="https://img.shields.io/badge/⬅️%20Previous-Home-blue" alt="Previous">
  </a>
  <a href="02-infrastructure-terraform.md">
    <img src="https://img.shields.io/badge/Next-Infrastructure%20Terraform-ff69b4" alt="Next">
  </a>
</div>
