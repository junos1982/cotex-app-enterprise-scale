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
