resource "azurerm_network_interface" "nic" {
  name                = var.nicName
  location            = var.location
  resource_group_name = var.rgName
  tags                = var.tags


  ip_configuration {
    name                          = var.vmConfig.nicIpConfiguration
    subnet_id                     = var.subnetId
    private_ip_address_allocation = var.vmConfig.nicPrivateIpAddressAllocation
    public_ip_address_id          = var.publicIpName != null ? azurerm_public_ip.public_ip[0].id : null
  }
}

resource "azurerm_public_ip" "public_ip" {
  count               = var.publicIpName != null ? 1 : 0
  name                = var.publicIpName
  location            = var.location
  resource_group_name = var.rgName
  allocation_method   = var.publicIpAllocationMethod
  sku                 = var.publicIpSku
  tags                = var.tags
  # lifecycle {
  #   ignore_changes = [ 
  #     ip_tags,
  #     zones
  #    ]
  # }
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                = var.vmName
  resource_group_name = var.rgName
  location            = var.location
  size                = var.vmConfig.vmSize
  zone                = var.vmConfig.availabilityZone
  admin_username      = var.vmConfig.adminUsername
  admin_password      = var.admin_password
  computer_name       = var.computerName
  tags                = var.tags
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    name                 = var.osdiskName
    caching              = var.vmConfig.caching
    storage_account_type = var.vmConfig.storageAccountType
  }

  source_image_reference {
    publisher = var.vmConfig.publisher
    offer     = var.vmConfig.offer
    sku       = var.vmConfig.sku
    version   = var.vmConfig.version
  }

  identity {
    type = "SystemAssigned"
  }

  # lifecycle {
  #   ignore_changes = [
  #     # admin_password,
  #     # private_ip_address,
  #     # public_ip_address,
  #     # patch_assessment_mode,
  #     # secure_boot_enabled,
  #     # vtpm_enabled,
  #     # encryption_at_host_enabled,
  #     # virtual_machine_id
  #     identity 
  #   ]
  # }
}
