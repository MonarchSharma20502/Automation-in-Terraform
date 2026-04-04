resource "azurerm_route_table" "route_table" {
  name = var.route_table_name
  resource_group_name = var.resource_group_name
  location = var.location

  dynamic "route" {
    for_each = var.routes != {} ? var.routes : {}
    content {
      name = route.value.route_name
      address_prefix = route.value.address_prefix
      next_hop_type = route.value.next_hop_type
    }
  }
}

resource "azurerm_subnet_route_table_association" "subnet_route_table_association" {
  subnet_id = var.subnet_id
  route_table_id = azurerm_route_table.route_table.id
}

# This will prevent terraform from destroying the route table when we run terraform destroy, but it will also prevent terraform from creating or updating the route table when we run terraform apply.
# removed {
#     from = azurerm_route_table.route_table
#     lifecycle {
#         destroy = false
#     }
# }