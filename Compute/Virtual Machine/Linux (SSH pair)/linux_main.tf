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
      private_ip_address_version = var.private_ip_address_version
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
  allocation_method   = var.vmConfig.publicIPAllocationMethod
  sku                 = var.public_ip_sku
  tags                = var.tags
  lifecycle {
    ignore_changes = [
      ip_tags,
      zones
     ]
  }
}

resource "azurerm_linux_virtual_machine" "linux_virtual_machine" {
  name                            = var.linux_vm_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.vmConfig.vmSize
  zone                            = var.vmConfig.availabilityZone
  
  # admin_username                  = var.vmConfig.vmAdminUsername
  # admin_password                  = var.vmConfig.vmAdminPassword
  disable_password_authentication = var.vmConfig.vmDisablePasswordAuthentication
  vtpm_enabled                    = var.vtpm_enabled
  tags                            = var.tags
  secure_boot_enabled             = var.secure_boot_enabled
  network_interface_ids           = [azurerm_network_interface.nic.id]

  # Generate a pair of SSH keys at the path (~/.ssh/authorized_keys/id_rsa.pub).
  admin_ssh_key {
    # paste the public key here and keep the private key in the local machine at ~/.ssh/authorized_keys and save the private key in the local machine
    public_key = file("~/.ssh/authorized_keys/id_rsa.pub") # or var.ssh_public_key\
    username = var.vmConfig.vmAdminUsername
  }
# The naming of the OS Disk is strict here, CHANGE IT IF FLEXIBILITY is required.
  os_disk {
    name                 = lookup(var.os_disk_name, var.linux_vm_name+"-osdisk", var.linux_vm_name+"-osdisk")
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
