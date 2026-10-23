resource "azurerm_network_interface" "nic" {
  name                          = var.nic_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  tags                          = var.tags
  # enable_accelerated_networking = var.enable_accelerated_networking

  # We can have tags in multiple ways as shown below, either we can have a variable for tags and pass it to the resource or we can have a map of tags and merge it with the existing tags. Here, we are using the variable for tags and passing it to the resource.
  # tags = merge(var.tags, { "Name" = var.nic_name })
  # tags = var.tags != null ? merge(var.tags, { "Name" = var.nic_name }) : { "Name" = var.nic_name }
  # tags = {
  #   cloud = var.cloud
  #   environment = var.environment
  #   author = var.author
  # }
  dynamic "ip_configuration" {
    for_each = var.ipconfig
    content {
      name = ip_configuration.key
      subnet_id = ip_configuration.value.subnet_id
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
      private_ip_address_version = ip_configuration.value.private_ip_address_version
      primary = ip_configuration.value.primary
      # This VM is along with a PUBLIC IP ADDRESS, for private deployment, remove this line in the module.
      public_ip_address_id = azurerm_public_ip.public_ip.id
    }
  }
}


resource "azurerm_public_ip" "public_ip" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku
  tags                = var.tags
  lifecycle {
    ignore_changes = [
      ip_tags,
      zones
     ]
  }
}

resource "azurerm_windows_virtual_machine" "windows_virtual_machine" {
  name                = var.windows_vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vmConfig.vmSize
  zone                = var.vmConfig.availabilityZone
  admin_username      = var.vmConfig.adminUsername
  # admin_password      = var.admin_password
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

  lifecycle {
    ignore_changes = [
      admin_password,
      private_ip_address,
      public_ip_address,
      patch_assessment_mode,
      secure_boot_enabled,
      vtpm_enabled,
      encryption_at_host_enabled,
      virtual_machine_id,
      identity,
      additional_capabilities
    ]
  }
}
