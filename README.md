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

## Automate deployments with GitHub Actions

This repository includes a reusable workflow in `.github/workflows/terraform.yml` that plans every pull request and applies the configuration to Azure when changes are pushed to the `main` branch. The workflow operates directly against the `terraform/environments/dev` folder so you can keep adding new environments without changing the automation.

### Required repository secrets

Configure the following secrets in your GitHub repository to allow the workflow to authenticate with Azure and connect to the remote state storage. Federated credentials with GitHub Actions are recommended so that no long-lived client secrets are required.

- `AZURE_CLIENT_ID` – Application (client) ID for the federated identity service principal.
- `AZURE_TENANT_ID` – Azure AD tenant ID.
- `AZURE_SUBSCRIPTION_ID` – Subscription that will host the sample infrastructure.
- `TF_BACKEND_RESOURCE_GROUP` – Resource group that contains the Terraform state storage account.
- `TF_BACKEND_STORAGE_ACCOUNT` – Name of the storage account created for Terraform state.
- `TF_BACKEND_CONTAINER` – Blob container inside the storage account that stores the state file.
- `TF_BACKEND_KEY` – Name of the blob that should hold the state file (for example `dev.terraform.tfstate`).
- `TF_VAR_RESOURCE_GROUP_NAME` – Name of the resource group to create (matches the `resource_group_name` variable).

You can optionally define additional `TF_VAR_...` secrets (such as `TF_VAR_LOCATION`) to override variable defaults for the automated runs. Secrets are exposed to Terraform through environment variables, so no sensitive data is committed to the repository.

The workflow writes a temporary `backend.hcl` file at runtime using the values above. The new `terraform/.gitignore` file ensures backend configuration and variable files remain untracked in Git.

## Extending the architecture

- Create additional modules under `terraform/modules` to encapsulate reusable building blocks (e.g., networks, databases).
- Add new environment folders (such as `test` or `prod`) under `terraform/environments` that consume the shared modules with
environment-specific settings.
- Configure CI/CD pipelines (GitHub Actions, Azure DevOps, etc.) to run `terraform fmt`, `terraform validate`, `terraform plan`,
and `terraform apply` against each environment folder as part of your deployment workflow.
