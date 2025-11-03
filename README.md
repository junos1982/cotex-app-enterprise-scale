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

A workflow is provided at [`.github/workflows/terraform-apply.yml`](.github/workflows/terraform-apply.yml) to log in to Azure with OpenID Connect and tag the existing `rg-cotex-test1` resource group using the Azure CLI.

1. [Create an Azure service principal](https://learn.microsoft.com/azure/developer/github/connect-from-azure?tabs=azure-portal%2Clinux#create-a-service-principal) and grant it permissions to manage resource groups in your subscription.
2. Store the service principal identifiers in the repository secrets `AZURE_CLIENT_ID`, `AZURE_TENANT_ID`, and `AZURE_SUBSCRIPTION_ID`.
3. Push changes to the repository. On each push, the workflow logs in to Azure using the existing Azure CLI login step and runs `az group update --name rg-cotex-test1 --set tags.생성자="이동준"` to apply the tag.
