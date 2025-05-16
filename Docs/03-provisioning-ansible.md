# 🛠️ 03 --- Provisioning with Ansible
==================================

Cloud‑1 uses **Ansible** only to *configure* the EC2 instance that Terraform has already created. Everything runs **agent‑less** through AWS Systems Manager (SSM); no SSH ports, no key pairs.

* * * * *

## 🗺️ High‑Level Workflow
-----------------------

1.  **Dynamic inventory** (`inventory.aws_ec2.yml`) asks AWS for every EC2 instance that carries the tag `Project=cloud1`.

2.  The playbook opens an **SSM session** to each instance (`community.aws.aws_ssm` connection plugin).

3.  Three **roles** run sequentially:

    -   **`docker`** -- installs Docker engine and adds the `ubuntu` user to the `docker` group.

    -   **`docker_compose`** -- drops the full `docker‑compose.yml` bundle (NGINX + PHP‑FPM WordPress + phpMyAdmin) onto the server and pulls images.

    -   **`systemd_docker`** -- creates a systemd unit so that `docker compose up` starts automatically after every reboot.

4.  Variable values such as the RDS endpoint, EFS ID, and ALB DNS are injected at runtime from the file **`terraform_outputs.yml`** (exported by Terraform once the apply is finished).

The result is an idempotent configuration: you can re‑run the playbook at any time and Ansible will report **"ok"** (no changes) unless drift is detected.

* * * * *

## 📂 Repository Layout
--------------------

```sh
	ansible/
	├── ansible.cfg                  # Points to dynamic inventory & SSM plugin
	├── inventory.aws_ec2.yml        # amazon.aws.aws_ec2 inventory plugin
	├── playbook.yml                 # Single source of truth (see below)
	├── terraform_outputs.yml        # Variables exported from Terraform
	└── roles/
	    ├── docker/
	    │   ├── defaults/main.yml    # Version pin & daemon options
	    │   ├── tasks/main.yml       # Install, enable, add user
	    │   └── handlers/main.yml    # Restart Docker if config changes
	    ├── docker_compose/
	    │   ├── files/docker-compose.yml
	    │   ├── files/nginx/default.conf
	    │   ├── files/phpmyadmin/*
	    │   ├── files/wordpress/wp-config.php
	    │   ├── tasks/main.yml       # Copy files & `docker compose pull/up`
	    │   └── handlers/main.yml    # Reload stack if compose file updates
	    └── systemd_docker/
	        └── tasks/main.yml       # Create & enable systemd unit

```

> **Why a single compose file?** It guarantees that all containers share the same network, volumes, and restart policies, while still respecting the *one‑process‑per‑container* rule.

* * * * *

## 📑 The Playbook (Conceptual)
----------------------------

```sh
- hosts: all                     # Provided by dynamic inventory
  gather_facts: true             # Needed for some conditionals
  become: true                   # Run as root via sudo
  connection: community.aws.aws_ssm

  vars_files:
    - terraform_outputs.yml      # Inject RDS, EFS, ALB, secrets

  roles:
    - docker
    - docker_compose
    - systemd_docker

```

### Key Points

-   **SSM bucket & region** are set as host vars (`ansible_aws_ssm_bucket_name`, `ansible_aws_ssm_region`) so that the plugin can stream session data to S3.

-   The playbook is intentionally short; all logic lives inside roles.

-   Handlers ensure that services restart *only* when configuration actually changes.

* * * * *

### 🔍 Running & Re‑Running
-----------------------

1.  Export Terraform outputs to `terraform_outputs.yml` (one‑time).

2.  Execute `ansible-playbook playbook.yml` from the `ansible/` directory.

3.  Re‑run the same command any time you modify Docker images, NGINX config, or WordPress settings. Ansible will apply only what changed.

No manual SSH, no hidden commands.

* * * * *

### ✅ Expected State After Success
------------------------------

-   Docker engine present and enabled.

-   `docker compose ps` shows **nginx**, **wordpress**, **phpmyadmin** containers healthy.

-   Uploads persist to **EFS**; database lives in **RDS**.

-   System survives reboots thanks to the systemd unit.

-   Security: only ports 80/443 exposed via ALB; SSH remains closed.

* * * * *

<div align="center">
	<a href="02-infrastructure-terraform.md">
		<img src="https://img.shields.io/badge/⬅️%20Previous-Infrastrucutre%20Terraform-blue" alt="Previous">
	</a>
	<a href="../README.md">
		<img src="https://img.shields.io/badge/Next-Home-ff69b4" alt="Next">
	</a>
</div>