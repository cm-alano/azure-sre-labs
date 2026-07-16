resource "azurerm_resource_group" "rgdev" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.resource_group_tags
}

resource "azurerm_network_security_group" "nsgdev" {
  name                = var.network_security_group_name
  location            = azurerm_resource_group.rgdev.location
  resource_group_name = azurerm_resource_group.rgdev.name
}

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.rgdev.name
  address_prefixes     = ["10.0.1.0/24"]
  virtual_network_name = azurerm_virtual_network.vnetdev.name

  service_endpoints = [
    "Microsoft.Storage"
  ]
}

resource "azurerm_subnet" "subnet2" {
  name                 = "subnet2"
  resource_group_name  = azurerm_resource_group.rgdev.name
  address_prefixes     = ["10.0.2.0/24"]
  virtual_network_name = azurerm_virtual_network.vnetdev.name

  service_endpoints = [
    "Microsoft.Storage"
  ]
}

resource "azurerm_virtual_network" "vnetdev" {
  name                = var.vnet_name
  location            = azurerm_resource_group.rgdev.location
  resource_group_name = azurerm_resource_group.rgdev.name

  address_space = ["10.0.0.0/16"]
  dns_servers   = ["10.0.0.4", "10.0.0.5"]

  tags = var.resource_group_tags
}

resource "azurerm_subnet_network_security_group_association" "dev" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.nsgdev.id
}

resource "azurerm_storage_account" "sadev" {
  name                = var.storage_account_name
  location            = azurerm_resource_group.rgdev.location
  resource_group_name = azurerm_resource_group.rgdev.name

  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.resource_group_tags

  network_rules {
    default_action = "Deny"
    ip_rules       = var.storage_allowed_ips
    virtual_network_subnet_ids = [
      azurerm_subnet.subnet1.id,
      azurerm_subnet.subnet2.id
    ]
  }
}

resource "azurerm_storage_container" "sadevcontainer" {
  name                  = var.storage_account_container_name
  storage_account_id    = azurerm_storage_account.sadev.id
  container_access_type = "private"
}

resource "azurerm_public_ip" "devpip" {
  name                = "acceptanceTestPublicIp1"
  resource_group_name = azurerm_resource_group.rgdev.name
  location            = azurerm_resource_group.rgdev.location
  allocation_method   = "Static"
  tags                = var.resource_group_tags
}

resource "azurerm_network_interface" "nicdev" {
  name                = var.network_interface_name
  location            = azurerm_resource_group.rgdev.location
  resource_group_name = azurerm_resource_group.rgdev.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.devpip.id
  }
}

resource "azurerm_virtual_machine" "vmdev" {
  name                  = var.virtual_machine_name
  location              = azurerm_resource_group.rgdev.location
  resource_group_name   = azurerm_resource_group.rgdev.name
  network_interface_ids = [azurerm_network_interface.nicdev.id]
  vm_size               = "Standard_D2s_v3"

  delete_os_disk_on_termination = true

  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = var.virtual_machine_name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = var.resource_group_tags
}

resource "azurerm_log_analytics_workspace" "lawdev" {
  name                = var.log_analytics_workspace_name
  location            = azurerm_resource_group.rgdev.location
  resource_group_name = azurerm_resource_group.rgdev.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_virtual_machine_extension" "vmextensiondev" {
  name                 = var.virtual_machine_name
  virtual_machine_id   = azurerm_virtual_machine.vmdev.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
 {
  "commandToExecute": "hostname && uptime"
 }
SETTINGS


  tags = var.resource_group_tags
}

resource "azurerm_monitor_action_group" "actiongroupdev" {
  name                = "CriticalAlertsAction"
  resource_group_name = azurerm_resource_group.rgdev.name
  short_name          = "p0action"

  email_receiver {
    name                    = "sendtodevops"
    email_address           = "cristelalano@gmail.com"
    use_common_alert_schema = true
  }
}

resource "azurerm_monitor_activity_log_alert" "alertvmdev" {
  name                = var.activity_log_alert_name
  resource_group_name = azurerm_resource_group.rgdev.name
  location            = "global"
  scopes              = [azurerm_resource_group.rgdev.id]
  description         = "This alert will monitor a specific virtual machine activity."

  criteria {
    resource_id    = azurerm_virtual_machine.vmdev.id
    category       = "Administrative"
    operation_name = "Microsoft.Compute/virtualMachines/deallocate/action"
    status         = "Succeeded"
  }

  action {
    action_group_id = azurerm_monitor_action_group.actiongroupdev.id

    webhook_properties = {
      from = "terraform"
    }
  }
}