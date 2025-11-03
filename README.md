# cotex-app-enterprise-scale

This repository provides a minimal, opinionated Terraform layout for deploying Azure resources. The structure follows the
recommended approach of separating reusable modules from environment-specific configuration. A single sample environment (`dev`)
creates a tagged resource group so you can extend the pattern with additional Azure services.

```
terraform/
├── environments/
│   └── dev/
│       ├── backend.hcl.example
│       ├── main.tf
│       ├── outputs.tf
│       ├── providers.tf
│       ├── terraform.tfvars.example
│       ├── variables.tf
│       └── versions.tf
└── modules/
    └── resource-group/
        ├── main.tf
        ├── outputs.tf
        └── variables.tf
```

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) 1.3.0 or later
- An Azure subscription
- Azure CLI authenticated with the subscription (`az login`)
- An Azure Storage Account and container to host the Terraform state file (see below)

## Configure remote state storage

1. Create (or reuse) a resource group, storage account, and blob container dedicated to Terraform state. For example:

   ```bash
   az group create --name tfstate-rg --location eastus
   az storage account create \
     --resource-group tfstate-rg \
     --name tfstateACCOUNT \
     --sku Standard_LRS \
     --encryption-services blob
   az storage container create \
     --name tfstate \
     --account-name tfstateACCOUNT \
     --auth-mode login
   ```

2. Copy `terraform/environments/dev/backend.hcl.example` to `backend.hcl` in the same directory and update the values to match
your storage resources.

## Deploy the sample environment

1. Navigate to the dev environment folder and review the example variables file:

   ```bash
   cd terraform/environments/dev
   cp terraform.tfvars.example terraform.tfvars
   ```

   Update `terraform.tfvars` with the desired resource group name, location, and any additional tags.

2. Initialize Terraform with the remote backend configuration:

   ```bash
   terraform init -backend-config=backend.hcl
   ```

3. Review the execution plan and apply the changes:

   ```bash
   terraform plan
   terraform apply
   ```

4. When you no longer need the sample infrastructure, destroy it:

   ```bash
   terraform destroy
   ```

## Extending the architecture

- Create additional modules under `terraform/modules` to encapsulate reusable building blocks (e.g., networks, databases).
- Add new environment folders (such as `test` or `prod`) under `terraform/environments` that consume the shared modules with
environment-specific settings.
- Configure CI/CD pipelines (GitHub Actions, Azure DevOps, etc.) to run `terraform fmt`, `terraform validate`, `terraform plan`,
and `terraform apply` against each environment folder as part of your deployment workflow.
