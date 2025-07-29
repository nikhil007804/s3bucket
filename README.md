# Terraform S3 Bucket Automation

This repository contains Terraform configuration to **automate the creation of an Amazon S3 bucket**, with deployment triggered via **GitHub Actions**. The Terraform state is securely stored in a dedicated S3 bucket.

---

##  Project Structure

```
terraform-s3-automation/
├── main.tf               # S3 bucket resource definition
├── provider.tf           # AWS provider configuration
├── variables.tf          # Input variable definitions
├── backend.tf            # S3 remote backend configuration
├── terraform.tfvars      # Default values (optional)
├── outputs.tf            # Outputs (e.g., bucket name/ARN)
├── environments/
│   ├── dev.tfvars
│   ├── uat.tfvars
│   └── prod.tfvars
└── .github/workflows/
    └── terraform.yml     # GitHub Actions workflow
```

---

##  What It Does

- Provisions an **Amazon S3 bucket** using Terraform.
- Enables **versioning** and **encryption** on the bucket.
- Stores Terraform state in a **separate remote S3 bucket**.
- Automates deployments via GitHub Actions (`init`, `plan`, `apply`).
- Includes **cost estimation** using [Infracost](https://www.infracost.io).
- Enforces **manual approval** before applying infrastructure changes.

---

##  Prerequisites

- [Terraform](https://www.terraform.io/downloads.html)
- AWS IAM user with S3 permissions
- GitHub repository secrets:
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`
  - `INFRACOST_API_KEY`

---

---

##  `backend.tf` Example

```hcl
terraform {
  backend "s3" {
    bucket = "prathyusha-tfstatefile"
    key    = "s3-bucket-repo/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}
```

---

##  Add Collaborators

1. Go to your **GitHub Repo → Settings → Collaborators**
2. Click **"Invite a collaborator"**
3. Enter your teammate’s GitHub username
4. Choose appropriate access (`Write` or `Admin`)
5. Click **Send Invite**

> Note: You cannot add yourself if you're the owner — you already have full access.

---

##  Add GitHub Environment for Manual Approval

1. Go to **Repo Settings → Environments**
2. Click **"New Environment"** and name it `dev-approval`
3. Under **Deployment protection rules**, click **"Required reviewers"**
4. Add your GitHub username (or teammate)
5. Click **Save**

This ensures **manual approval** is required before applying infrastructure changes.

---

##  Usage

### Step 1: Clone the Repo

```bash
git clone https://github.com/your-username/terraform-s3-automation.git
cd terraform-s3-automation
```

### Step 2: Edit the Variables

Edit `terraform.tfvars` (or `environments/dev.tfvars`):

```hcl
bucket_name = "your-unique-s3-bucket-name"
aws_region  = "us-east-1"
```

### Step 3: Push Code to Main

```bash
git add .
git commit -m "Initial commit"
git push origin main
```

This will trigger the **GitHub Actions workflow** (`terraform.yml`).

---

##  How to Approve the Apply Step

1. Go to your **GitHub Repo → Actions**
2. Click on the latest workflow run
3. Find the **Terraform Apply (Manual Approval)** job
4. Click **"Review deployments"**
5. Hit **"Approve and deploy"**

---

##  (Optional) Run Locally

```bash
terraform init
terraform plan -var-file="environments/dev.tfvars"
terraform apply -auto-approve -var-file="environments/dev.tfvars"
```

---

##  Cost Estimation (via Infracost)

The workflow integrates [Infracost](https://www.infracost.io) to show estimated monthly cloud costs directly in the Actions summary.
