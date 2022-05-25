
###################################
###################################
#     Active Directory Domain     #
###################################
###################################

resource "azurerm_resource_group" "adds" {
    name        = "adds-${var.environment}"
    location    = var.location
}


###################################
#     Azure AD Domain Services    #
###################################

#register the Azure AD Domain Services resource provider
resource "azurerm_resource_provider_registration" "adds" {
  name = "Microsoft.AAD"
}

# Create an Azure AD service principal
# id: 6ba9a5d4-8456-4118-b521-9c5ca10cdf84 (default)
resource "azuread_service_principal" "adds" {
  application_id = "6ba9a5d4-8456-4118-b521-9c5ca10cdf84"
}

resource "azurerm_active_directory_domain_service" "adds" {
  name                = var.domain_name
  location            = azurerm_resource_group.adds.location
  resource_group_name = azurerm_resource_group.adds.name

  domain_name = var.domain_name
  sku         = "Standard"

  initial_replica_set {
    subnet_id = azurerm_subnet.adds.id
  }

  security {
    sync_kerberos_passwords = true
    sync_ntlm_passwords     = true
    sync_on_prem_passwords  = true
  }

  depends_on = [
    azuread_service_principal.adds,
    azurerm_resource_provider_registration.adds,
    azurerm_subnet_network_security_group_association.adds,
  ]
}

###################################
#            Network              #
###################################


resource "azurerm_virtual_network" "adds" {
  name                = "adds-vnet"
  location            = azurerm_resource_group.adds.location
  resource_group_name = azurerm_resource_group.adds.name
  address_space       = ["10.6.0.0/16"]
}

resource "azurerm_subnet" "adds" {
  name                 = "adds-snet"
  resource_group_name  = azurerm_resource_group.adds.name
  virtual_network_name = azurerm_virtual_network.adds.name
  address_prefixes     = ["10.6.1.0/24"]
}

resource "azurerm_network_security_group" "adds" {
  name                = "adds-nsgg"
  location            = azurerm_resource_group.adds.location
  resource_group_name = azurerm_resource_group.adds.name

 security_rule {
    name                       = "AllowRD"
    priority                   = 201
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "CorpNetSaw"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowPSRemoting"
    priority                   = 301
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5986"
    source_address_prefix      = "AzureActiveDirectoryDomainServices"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTPS"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

    security_rule {
    name                       = "AllowLDAPS"
    priority                   = 401
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "636"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }


}

resource "azurerm_subnet_network_security_group_association" "adds" {
  subnet_id                 = azurerm_subnet.adds.id
  network_security_group_id = azurerm_network_security_group.adds.id
}


# Create AD DS admin user
resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "azuread_user" "dc_admin" {
  user_principal_name = "${var.active_directory_admin}@${var.domain_name}"
  display_name        = "adds DC Administrator"
  password            = var.active_directory_admin_password
}

# Create an Azure AD group named AAD DC Administrators
resource "azuread_group" "dc_admins" {
  display_name     = "AAD DC Administrators"
  description      = "adds Administrators"
  members          = [azuread_user.dc_admin.object_id]
  security_enabled = true
}

data "azurerm_role_definition" "admin_role" { 
  name = "Domain Services Contributor"
}

data "azurerm_subscription" "current" {
}

resource "azurerm_role_assignment" "admin_role" {
  scope              = data.azurerm_subscription.current.id
  role_definition_id = data.azurerm_role_definition.admin_role.id
  principal_id       = azuread_group.dc_admins.id
}








############################
############################
#     Virtual Desktops     #
############################
############################

resource "azurerm_resource_group" "dv" {
    name        = "${var.resource_group_name}-${var.environment}"
    location    = var.location
}

###################################
#            Network              #
###################################

resource "azurerm_virtual_network" "vms" {
  name                = "vms-net"
  address_space       = ["10.5.0.0/16"]
  location            = azurerm_resource_group.dv.location
  resource_group_name = azurerm_resource_group.dv.name
}

resource "azurerm_subnet" "vms" {
  name                 = "vms-subnet"
  resource_group_name  = azurerm_resource_group.dv.name
  virtual_network_name = azurerm_virtual_network.vms.name
  address_prefixes     = ["10.5.1.0/24"]
}

resource "azurerm_network_security_group" "nsg" {
  name                = "${var.name_prefix}-NSG"
  location            = azurerm_resource_group.dv.location
  resource_group_name = azurerm_resource_group.dv.name

  security_rule {
    name                       = "AllowRD"
    priority                   = 201
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "CorpNetSaw"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowPSRemoting"
    priority                   = 301
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5986"
    source_address_prefix      = "AzureActiveDirectoryDomainServices"
    destination_address_prefix = "*"
  }

  depends_on = [azurerm_resource_group.dv]
}

resource "azurerm_subnet_network_security_group_association" "nsg_ass" {
  subnet_id                 = azurerm_subnet.vms.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}


# Peering the Azure AD Network and Virtual Machine Network together 
resource "azurerm_virtual_network_peering" "adds_to_dv" {
  name                      = "adds-to-dv-peer"
  resource_group_name       = azurerm_resource_group.adds.name
  virtual_network_name      = azurerm_virtual_network.adds.name
  remote_virtual_network_id = azurerm_virtual_network.vms.id
}

resource "azurerm_virtual_network_peering" "dv_to_adds" {
  name                      = "dv-to-adds-peer"
  resource_group_name       = azurerm_resource_group.dv.name
  virtual_network_name      = azurerm_virtual_network.vms.name
  remote_virtual_network_id = azurerm_virtual_network.adds.id
}

#####################
# Desktop Workspace #
#####################

resource "azurerm_virtual_desktop_workspace" "workspace" {
  name                = "${var.name_prefix}-workspace"
  resource_group_name = azurerm_resource_group.dv.name
  location            = azurerm_resource_group.dv.location
  friendly_name       = "${var.name_prefix} Workspace"
  description         = "${var.name_prefix} Workspace"
}


#####################
#     Host Pool     #
#####################

resource "time_rotating" "avd_token" {
  rotation_days = 20
}

resource "azurerm_virtual_desktop_host_pool" "hostpool" {
  resource_group_name      = azurerm_resource_group.dv.name
  location                 = azurerm_resource_group.dv.location
  name                     = "${var.name_prefix}-hostpool"
  friendly_name            = "${var.name_prefix}-hostpool"
  validate_environment     = true
  custom_rdp_properties    = "audiocapturemode:i:1;audiomode:i:0;targetisaadjoined:i:1;"
  type                     = "Pooled"
  maximum_sessions_allowed = 3
  load_balancer_type       = "DepthFirst" #[BreadthFirst DepthFirst]

}

resource "azurerm_virtual_desktop_host_pool_registration_info" "registration" {
  hostpool_id     = azurerm_virtual_desktop_host_pool.hostpool.id
  expiration_date = "2022-06-10T23:40:52Z"
}

#####################################
#     Desktop Applicaiton Group     #
#####################################

# Azure Virtual Desktop - Desktop Applicaiton group
resource "azurerm_virtual_desktop_application_group" "dag" {
  resource_group_name = azurerm_resource_group.dv.name
  host_pool_id        = azurerm_virtual_desktop_host_pool.hostpool.id
  location            = azurerm_resource_group.dv.location
  type                = "Desktop"
  name                = "${var.name_prefix}-desktop-app-group"
  friendly_name       = "Desktop AppGroup"
  description         = "AVD application group"
  depends_on          = [azurerm_virtual_desktop_host_pool.hostpool, azurerm_virtual_desktop_workspace.workspace]
}

# Associate Workspace and DAG
resource "azurerm_virtual_desktop_workspace_application_group_association" "ws-dag" {
  application_group_id = azurerm_virtual_desktop_application_group.dag.id
  workspace_id         = azurerm_virtual_desktop_workspace.workspace.id
}

############################################
#     Users - Role Based Access Control    #
############################################

data "azurerm_role_definition" "role" { 
  name = "Desktop Virtualization User"
}

resource "azuread_group" "aad_group" {
  display_name = "${var.name_prefix}-rdp-users"
  security_enabled = true
}

resource "azurerm_role_assignment" "role" {
  scope              = azurerm_virtual_desktop_application_group.dag.id
  role_definition_id = data.azurerm_role_definition.role.id
  principal_id       = azuread_group.aad_group.id
}


##########################
#     Virtual Machine    #
##########################

resource "azurerm_network_interface" "dv_vm_nic" {
  count               = var.vm_count
  name                = "${var.name_prefix}-${count.index + 1}-nic"
  resource_group_name = azurerm_resource_group.dv.name
  location            = azurerm_resource_group.dv.location

  ip_configuration {
    name                          = "nic${count.index + 1}_config"
    subnet_id                     = azurerm_subnet.vms.id
    private_ip_address_allocation = "dynamic"
  }

  depends_on = [
    azurerm_resource_group.dv
  ]
}

# Generate random password for local admin user on VMs
resource "random_password" "dv_vm" {
  length           = 16
  special          = true
  number           = true
  lower            = true
  min_special      = 3
  min_numeric     = 3
  override_special = "_%@"
}

resource "azurerm_windows_virtual_machine" "dv_vm" {
  count                 = var.vm_count
  name                  = "${var.name_prefix}-${count.index + 1}"
  computer_name         = "${var.name_prefix}-${count.index + 1}"
  resource_group_name   = azurerm_resource_group.dv.name
  location              = azurerm_resource_group.dv.location
  size                  = var.vm_size
  network_interface_ids = ["${azurerm_network_interface.dv_vm_nic.*.id[count.index]}"]
  provision_vm_agent    = true
  allow_extension_operations   = true
  admin_username        = var.local_admin_username
  admin_password        = random_password.dv_vm.result

  os_disk {
    name                 = "${lower(var.name_prefix)}-${count.index + 1}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "20h2-evd"
    version   = "latest"
  }

  depends_on = [
    azurerm_resource_group.dv,
    azurerm_network_interface.dv_vm_nic
  ]
}


resource "azurerm_virtual_desktop_host_pool_registration_info" "dv" {
  hostpool_id     = azurerm_virtual_desktop_host_pool.hostpool.id
  expiration_date = "2022-05-20T23:40:52Z"
}


# This resource forces the provisioning to wait for domain to be provisioned and available before moving forward 
resource "azurerm_virtual_machine_extension" "wait-for-domain-to-provision" {
  count                 = var.vm_count
  name                 = "TestConnectionDomain"
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"
  virtual_machine_id   = azurerm_windows_virtual_machine.dv_vm[count.index].id
  settings             = <<SETTINGS
  {
    "commandToExecute": "powershell.exe -Command \"while (!(Test-Connection -ComputerName ${var.domain_name} -Count 1 -Quiet) -and ($retryCount++ -le 360)) { Start-Sleep 10 } \""
  }
SETTINGS
}


# Join virtual machines to the Azure Active Directory Domain
resource "azurerm_virtual_machine_extension" "domainjoin" {
  count                = var.vm_count
  name                 = "${var.name_prefix}${count.index + 1}-joindomain"
  virtual_machine_id   = azurerm_windows_virtual_machine.dv_vm[count.index].id
  publisher            = "Microsoft.Compute"
  type                 = "JsonADDomainExtension"
  type_handler_version = "1.3"


  settings = <<SETTINGS
    {
      "Name": "${var.domain_name}",
      "OUPath": "",
      "User": "${var.active_directory_admin}@${var.domain_name}",
      "Restart": "true",
      "Options": "3"
    }
    SETTINGS

protected_settings = <<SETTINGS
    {
      "Password": "${var.active_directory_admin_password}"
    }
    SETTINGS

   depends_on = [
    azurerm_virtual_network_peering.adds_to_dv,
    azurerm_virtual_network_peering.dv_to_adds,
    azurerm_windows_virtual_machine.dv_vm,
    azuread_user.dc_admin,
    azurerm_virtual_machine_extension.wait-for-domain-to-provision
  ]
}



# Configure Azuer Virtual Desktop Agent
# Configures a PowerShell DSC extension that downloads and sets up everything 
# for the VM to join the host pool.
resource "azurerm_virtual_machine_extension" "vmext_dsc" {
  count                      = var.vm_count
  name                       = "${var.name_prefix}${count.index + 1}-avd_dsc"
  virtual_machine_id         = azurerm_windows_virtual_machine.dv_vm[count.index].id
  publisher                  = "Microsoft.Powershell"
  type                       = "DSC"
  type_handler_version       = "2.73"
  auto_upgrade_minor_version = true

  settings = <<-SETTINGS
    {
      "modulesUrl": "https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration_3-10-2021.zip",
      "configurationFunction": "Configuration.ps1\\AddSessionHost",
      "properties": {
        "HostPoolName":"${azurerm_virtual_desktop_host_pool.hostpool.name}"
      }
    }
SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
  {
    "properties": {
      "registrationInfoToken": "${azurerm_virtual_desktop_host_pool_registration_info.dv.token}"
    }
  }
PROTECTED_SETTINGS

  depends_on = [
    azurerm_virtual_machine_extension.domainjoin,
    azurerm_virtual_desktop_host_pool.hostpool
  ]
}

