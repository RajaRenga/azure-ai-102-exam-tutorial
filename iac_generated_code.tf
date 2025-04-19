provider "azurerm" {
  features {}
}

# Define the address space for the Virtual Network
resource "azurerm_virtual_network" "my_vnet" {
  name                = "my-vnet"
  address_space       = ["10.0.0.0/16"] # Define the desired address space for the VNet
  location            = "eastus" # Define the region where the VNet will be created
  resource_group_name = azurerm_resource_group.my_rg.name

  tags = {
    environment = "production",
    project     = "my-project"
  }
}

# Define the subnet within the Virtual Network
resource "azurerm_subnet" "my_subnet" {
  name                 = "my-subnet"
  resource_group_name  = azurerm_resource_group.my_rg.name
  virtual_network_name = azurerm_virtual_network.my_vnet.name
  address_prefixes     = ["10.0.1.0/24"] # Define the desired subnet address space

  service_endpoints = ["Microsoft.Storage", "Microsoft.Sql"] # Define service endpoints for the subnet

  tags = {
    environment = "production",
    project     = "my-project"
  }
}

# Define a Network Security Group for the subnet
resource "azurerm_network_security_group" "my_nsg" {
  name                = "my-nsg"
  location            = "eastus" # Define the region where the NSG will be created
  resource_group_name = azurerm_resource_group.my_rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*" # Define the allowed source IP range
    destination_address_prefix = "*"
  }

  tags = {
    environment = "production",
    project     = "my-project"
  }
}

# Associate the NSG with the subnet
resource "azurerm_subnet_network_security_group_association" "my_nsg_association" {
  subnet_id                 = azurerm_subnet.my_subnet.id
  network_security_group_id = azurerm_network_security_group.my_nsg.id
}

# Define a Resource Group for the VNet
resource "azurerm_resource_group" "my_rg" {
  name     = "my-resource-group" # Define the name for the resource group
  location = "eastus" # Define the region where the resource group will be created

  tags = {
    environment = "production",
    project     = "my-project"
  }
}