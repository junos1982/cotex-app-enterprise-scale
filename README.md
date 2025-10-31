# cotex-app-enterprise-scale

This repository contains Terraform configuration to provision a basic Azure resource group. The configuration is located in the [`terraform/`](terraform/) directory.

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) 1.3.0 or later
- An Azure subscription
- Azure CLI authenticated with the subscription (`az login`)

## Usage

1. Initialize Terraform to download the Azure provider:

   ```bash
   cd terraform
   terraform init
   ```

2. Provide the required variables and apply the configuration. You can do this with a `terraform.tfvars` file or by supplying variables on the command line. For example:

   ```bash
   terraform apply \
     -var "resource_group_name=my-resource-group" \
     -var "location=eastus" \
     -var 'tags={ environment = "dev" }'
   ```

3. Confirm the plan to create the resource group in your Azure subscription.

4. To remove the resource group, run:

   ```bash
   terraform destroy
   ```

## Outputs

After applying, Terraform will output the resource group ID and name for reference.

## Automating with GitHub Actions

A reusable workflow is provided at [`.github/workflows/terraform-apply.yml`](.github/workflows/terraform-apply.yml) to provision the
resource group from GitHub Actions using Terraform.

1. [Create an Azure service principal](https://learn.microsoft.com/azure/developer/github/connect-from-azure?tabs=azure-portal%2Clinux#create-a-service-principal)
   and grant it permissions to manage resource groups in your subscription.
2. Store the JSON credentials for the service principal in a repository secret named `AZURE_CREDENTIALS`. The value should match
   the format expected by [`azure/login`](https://github.com/Azure/login#configure-deployment-credentials-on-github-secrets).
3. (Optional) Define repository variables for frequently used Terraform inputs such as the resource group name or location.
4. Trigger the workflow manually from the **Actions** tab using **Run workflow**. Provide the desired `resource_group_name`,
   `location`, and an optional `tags_json` value (e.g. `{"environment":"dev"}`). The workflow will run `terraform init`, `terraform
   validate`, `terraform plan`, and `terraform apply` to create or update the resource group.

> **Note:** The workflow sets `TF_VAR_tags` directly from the `tags_json` input. Provide the tags as a valid JSON object so
> Terraform can automatically parse it into the expected map.
