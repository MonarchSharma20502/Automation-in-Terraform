resource "azurerm_network_interface" "nic" {
  name                          = var.nicName
  location                      = var.location
  resource_group_name           = var.rgName
  # enable_accelerated_networking = var.enable_accelerated_networking
  tags                          = var.tags

  ip_configuration {
    name                          = var.vmConfig.nicIpConfiguration
    subnet_id                     = var.subnetId
    private_ip_address_allocation = var.vmConfig.nicPrivateIpAddressAllocation
    private_ip_address_version    = var.private_ip_address_version
    # public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}


# resource "azurerm_public_ip" "public_ip" {
#   name                = var.publicIpName
#   location            = var.location
#   resource_group_name = var.rgname
#   allocation_method   = var.vmConfig.publicIPAllocationMethod
#   sku                 = var.publicIpSku
#   tags                = var.tags
#   lifecycle {
#     ignore_changes = [
#       ip_tags,
#       zones
#      ]
#   }
# }

resource "azurerm_linux_virtual_machine" "VM" {
  name                            = var.vmName
  resource_group_name             = var.rgName
  location                        = var.location
  size                            = var.vmConfig.vmSize
  zone                            = var.vmConfig.availabilityZone
  admin_username                  = var.vmConfig.vmAdminUsername
  admin_password                  = var.vmConfig.vmAdminPassword
  disable_password_authentication = var.vmConfig.vmDisablePasswordAuthentication
  vtpm_enabled                    = var.vtpm_enabled
  tags                            = var.tags
  secure_boot_enabled             = var.secure_boot_enabled
  network_interface_ids           = [azurerm_network_interface.nic.id]

  os_disk {
    name                 = var.vmStorageOsDiskName
    caching              = var.vmConfig.vmCaching
    storage_account_type = var.vmConfig.vmManagedDiskType
    disk_size_gb         = var.vmConfig.vmDiskSizeGB
  }

  source_image_reference {
    publisher = var.vmConfig.vmPublisher
    offer     = var.vmConfig.vmOffer
    sku       = var.vmConfig.vmSku
    version   = var.vmConfig.vmSkuVersion
  }


  lifecycle {
    ignore_changes = [
      boot_diagnostics,
      admin_password,
      patch_assessment_mode,
      encryption_at_host_enabled,
      secure_boot_enabled,
      vtpm_enabled,
      public_ip_address,
      public_ip_addresses,
      identity,
      additional_capabilities
    ]
  }
}
