module "resource_group" {
  source = "../../modules/resource-group"

  name     = var.resource_group_name
  location = var.location
  tags     = merge(
    {
      "environment" = var.environment
    },
    var.tags
  )
}
