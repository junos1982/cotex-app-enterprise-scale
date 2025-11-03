# cotex-app-enterprise-scale

This repository contains Terraform configuration that provisions a basic Ubuntu Linux virtual machine together with the networking resources it requires.

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) 1.3.0 or later
- An Azure subscription with permissions to create virtual machines, networking, and public IP resources
- The Azure CLI authenticated with the subscription (`az login`)
- An SSH public key for the administrator account on the virtual machine

## Usage

1. Initialize Terraform to download the Azure provider:

   ```bash
   cd terraform
   terraform init
   ```

2. Provide the required variables and apply the configuration. Supply the resource group name and admin SSH key either via a `terraform.tfvars` file or command-line arguments. For example:

   ```bash
   terraform apply \
     -var "resource_group_name=rg-cotex-git" \
     -var "admin_ssh_public_key=$(cat ~/.ssh/id_rsa.pub)"
   ```

   Additional variables are available to customize names, address spaces, VM size, and tags. See [`variables.tf`](terraform/variables.tf) for the full list and defaults.

3. After confirming the plan, Terraform creates the resource group (if needed), networking resources, and an Ubuntu 22.04 LTS VM tagged with `생성자=이동준` by default.

4. To remove the virtual machine and associated infrastructure, run:

   ```bash
   terraform destroy
   ```

## Outputs

After applying, Terraform returns the resource group metadata, VM identifier, and public IP address.

## Automating with GitHub Actions

The workflow at [`.github/workflows/terraform-apply.yml`](.github/workflows/terraform-apply.yml) automates validation and deployment by using Azure OpenID Connect authentication and Terraform.

1. Store the Azure service principal credentials in the repository secrets `AZURE_CLIENT_ID`, `AZURE_TENANT_ID`, and `AZURE_SUBSCRIPTION_ID`.
2. On pull requests to `main`, the workflow checks out the repository, configures Terraform 1.5.7, logs in to Azure, and runs `terraform init`, `fmt -check`, `validate`, and `plan`.
3. When changes are pushed to `main`, the workflow repeats those validation steps and then runs `terraform apply -auto-approve` to ensure the Ubuntu VM defined in this configuration is present.
4. You can also trigger the workflow manually with **Run workflow** in the Actions tab.
