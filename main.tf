locals {
  user_data = templatefile("${path.module}/templates/user-data.sh.tmpl", {
    admin_username       = var.admin_username
    user_supplied_script = var.user_supplied_script
  })
}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name = var.name

  resource_group_name = var.resource_group_name
  location            = data.azurerm_resource_group.rg.location

  sku          = var.sku
  instances    = var.instance_count
  user_data    = base64encode(local.user_data)
  upgrade_mode = "Manual"

  admin_username                  = var.admin_username
  disable_password_authentication = true

  priority = "Regular"

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.admin_ssh_public_key
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_type
    disk_size_gb         = var.os_disk_size_gb
  }

  network_interface {
    name    = "${var.name}-nic"
    primary = true

    network_security_group_id = var.network_security_group_id

    ip_configuration {
      name      = "${var.name}-ipconf"
      primary   = true
      subnet_id = var.subnet_id
      version   = "IPv4"

      application_gateway_backend_address_pool_ids = var.application_gateway_backend_address_pool_ids

      dynamic "public_ip_address" {
        for_each = var.associate_public_ip_address ? toset([1]) : toset([])

        content {
          name    = "${var.name}-ipaddrconf"
          version = "IPv4"
        }
      }
    }
  }

  tags = var.tags
}
