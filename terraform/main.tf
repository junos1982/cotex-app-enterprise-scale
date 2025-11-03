locals {
  default_tags = {
    ManagedBy = "GitHubActions"
  }
}

resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location

  tags = merge(local.default_tags, var.tags)
}
