# resource group

resource "azurerm_resource_group" "di_rg" {
  name     = var.resource_group_name
  location = var.location
}

# virtual network

resource "azurerm_virtual_network" "di_vnet" {
  name                = "vnet-${var.deployment_name}"
  location            = var.location
  resource_group_name = azurerm_resource_group.di_rg.name
  address_space       = ["10.0.0.0/24"]
}

# subnet applications with half the address space

resource "azurerm_subnet" "di_subnet_applications" {
  name                 = "applications"
  resource_group_name  = azurerm_resource_group.di_rg.name
  virtual_network_name = azurerm_virtual_network.di_vnet.name
  address_prefixes     = ["10.0.0.0/25"]
}

# subnet services with half the address space

resource "azurerm_subnet" "di_subnet_services" {
  name                 = "services"
  resource_group_name  = azurerm_resource_group.di_rg.name
  virtual_network_name = azurerm_virtual_network.di_vnet.name
  address_prefixes     = ["10.0.0.128/25"]
}

# user managed identity

resource "azurerm_user_assigned_identity" "di_umi" {
  name                = "umi-${var.deployment_name}"
  location            = var.location
  resource_group_name = azurerm_resource_group.di_rg.name
}

# private dns zone for document intelligence cognitive service account

resource "azurerm_private_dns_zone" "di_private_dns_zone" {
  name                = "privatelink.cognitiveservices.azure.com"
  resource_group_name = azurerm_resource_group.di_rg.name
}

# link private dns zone to virtual network

resource "azurerm_private_dns_zone_virtual_network_link" "di_private_dns_zone_vnet_link" {
  name                  = "link-to-${azurerm_virtual_network.di_vnet.name}"
  resource_group_name   = azurerm_resource_group.di_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.di_private_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.di_vnet.id
}

# private dns zone for storage account

resource "azurerm_private_dns_zone" "di_storage_private_dns_zone" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.di_rg.name
}

# link private dns zone to virtual network

resource "azurerm_private_dns_zone_virtual_network_link" "di_storage_private_dns_zone_vnet_link" {
  name                  = "link-to-vnet-${azurerm_virtual_network.di_vnet.name}"
  resource_group_name   = azurerm_resource_group.di_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.di_storage_private_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.di_vnet.id
}

# storage account

resource "azurerm_storage_account" "di_storage_account" {
  name                      = var.storage_account_name
  resource_group_name       = azurerm_resource_group.di_rg.name
  location                  = var.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  min_tls_version           = "TLS1_2"
  shared_access_key_enabled = false
  local_user_enabled        = false

  # disable public network access
  public_network_access_enabled = false

  # allow trusted services
  network_rules {
    default_action = "Deny"
    bypass         = ["AzureServices"]
  }

}

# create container in storage account

resource "azurerm_storage_container" "di_storage_container" {
  name                  = "data"
  storage_account_id    = azurerm_storage_account.di_storage_account.id
  container_access_type = "private"
}

# private endpoint for storage account

resource "azurerm_private_endpoint" "di_storage_private_endpoint" {
  name                = "pe-${azurerm_storage_account.di_storage_account.name}"
  location            = var.location
  resource_group_name = azurerm_resource_group.di_rg.name

  subnet_id = azurerm_subnet.di_subnet_applications.id

  private_service_connection {
    name                           = "psc-${azurerm_storage_account.di_storage_account.name}"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_storage_account.di_storage_account.id
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name                 = "pe-dnsgroup-${azurerm_storage_account.di_storage_account.name}"
    private_dns_zone_ids = [azurerm_private_dns_zone.di_storage_private_dns_zone.id]
  }

}

# provide di-mi with Storage Blob Data Contributor role on storage account

resource "azurerm_role_assignment" "di_storage_blob_data_contributor" {
  principal_id         = azurerm_user_assigned_identity.di_umi.principal_id
  role_definition_name = "Storage Blob Data Contributor"
  scope                = azurerm_storage_account.di_storage_account.id
}

# document intelligence cognitive service account
resource "azurerm_cognitive_account" "di_cognitive_service_account" {
  name                = var.deployment_name
  location            = var.location
  resource_group_name = azurerm_resource_group.di_rg.name
  sku_name            = "S0"
  kind                = "FormRecognizer"

  local_auth_enabled                 = false
  public_network_access_enabled      = false
  outbound_network_access_restricted = true

  //allow outbound connections to microsoft.com 

  fqdns = [
    "microsoft.com"
  ]

  custom_subdomain_name = var.deployment_name
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.di_umi.id]
  }

}

# private endpoint for document intelligence cognitive service account

resource "azurerm_private_endpoint" "di_cognitive_service_private_endpoint" {
  name                = "pe-${var.deployment_name}"
  location            = var.location
  resource_group_name = azurerm_resource_group.di_rg.name

  subnet_id = azurerm_subnet.di_subnet_applications.id

  private_service_connection {
    name                           = "psc-${var.deployment_name}"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_cognitive_account.di_cognitive_service_account.id
    subresource_names              = ["account"]
  }

  private_dns_zone_group {
    name                 = "pe-dnsgroup-${var.deployment_name}"
    private_dns_zone_ids = [azurerm_private_dns_zone.di_private_dns_zone.id]
  }

}

# Document Intelligence workspace users entraID group

resource "azuread_group" "di_workspace_users" {
  display_name     = var.di_workspace_users_group_name
  mail_enabled     = false
  security_enabled = true
}

resource "azurerm_role_assignment" "di_workspace_users" {
  principal_id         = azuread_group.di_workspace_users.object_id
  role_definition_name = "Cognitive Services User"
  scope                = azurerm_cognitive_account.di_cognitive_service_account.id

}

resource "azurerm_role_assignment" "di_workspace_users_storage" {
  principal_id         = azuread_group.di_workspace_users.object_id
  role_definition_name = "Storage Blob Data Contributor"
  scope                = azurerm_storage_account.di_storage_account.id
}

# add members to Document Intelligence workspace users group

data "azuread_user" "users" {
  for_each            = toset(var.di_workspace_users_principals) # Ensure unique values
  user_principal_name = each.value
}

resource "azuread_group_member" "di_workspace_users_members" {
  for_each         = data.azuread_user.users
  group_object_id  = azuread_group.di_workspace_users.object_id
  member_object_id = each.value.object_id
}

# get local ip address

data "http" "local_ip" {
  url = "http://api.ipify.org?format=json"
}

# network security group that allows connections from local_ip address to port 3389

resource "azurerm_network_security_group" "di_nsg" {
  name                = "nsg-wks-${var.deployment_name}"
  location            = var.location
  resource_group_name = azurerm_resource_group.di_rg.name

  security_rule {
    name                       = "allow-rdp-from-local-ip"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = jsondecode(data.http.local_ip.response_body).ip
    destination_address_prefix = "*"
  }
}

# create static public ip address

resource "azurerm_public_ip" "di_public_ip" {
  name                = "pip-vm${replace(var.deployment_name, "-", "")}"
  location            = var.location
  resource_group_name = azurerm_resource_group.di_rg.name
  allocation_method   = "Static"
}

# network interface for windows vm

resource "azurerm_network_interface" "di_nic" {
  name                = "nic-wks-${var.deployment_name}"
  location            = var.location
  resource_group_name = azurerm_resource_group.di_rg.name

  ip_configuration {
    name                          = "ipconfig-${var.deployment_name}"
    subnet_id                     = azurerm_subnet.di_subnet_applications.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.di_public_ip.id
  }

}

# add network interface to network security group

resource "azurerm_network_interface_security_group_association" "di_nic_nsg" {
  network_interface_id      = azurerm_network_interface.di_nic.id
  network_security_group_id = azurerm_network_security_group.di_nsg.id
}

# data science windows vm

resource "azurerm_windows_virtual_machine" "di_vm" {
  name                = "vm${replace(var.deployment_name, "-", "")}"
  location            = var.location
  resource_group_name = azurerm_resource_group.di_rg.name
  size                = "Standard_E4ads_v5"
  admin_username      = var.windows_admin_username
  admin_password      = var.windows_admin_password
  network_interface_ids = [
    azurerm_network_interface.di_nic.id,
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }
  source_image_reference {
    publisher = "microsoft-dsvm"
    offer     = "dsvm-win-2022"
    sku       = "winserver-2022"
    version   = "latest"
  }
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.di_umi.id]
  }
}