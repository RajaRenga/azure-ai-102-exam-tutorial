# Define variables
variable "region" {
  default = "eastus"
}

variable "vnet_address_space" {
  default = "10.0.0.0/16"  # Suggested value, update as needed
}

variable "subnet1_cidr" {
  default = "10.0.1.0/24"  # Suggested value, update as needed
}

variable "subnet2_cidr" {
  default = "10.0.2.0/24"  # Suggested value, update as needed
}

# Create Azure Resource Group
resource "azurerm_resource_group" "myresourcegroup" {
  name     = "myResourceGroup"
  location = var.region
}

# Create Azure Virtual Network
resource "azurerm_virtual_network" "myvnet" {
  name                = "myVNet"
  resource_group_name = azurerm_resource_group.myresourcegroup.name
  location            = azurerm_resource_group.myresourcegroup.location
  address_space       = [var.vnet_address_space]

  tags = {
    environment = "production"
  }
}

# Create Subnets in the Virtual Network
resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  virtual_network_name = azurerm_virtual_network.myvnet.name
  resource_group_name  = azurerm_resource_group.myresourcegroup.name
  address_prefixes     = [var.subnet1_cidr]
}

resource "azurerm_subnet" "subnet2" {
  name                 = "subnet2"
  virtual_network_name = azurerm_virtual_network.myvnet.name
  resource_group_name  = azurerm_resource_group.myresourcegroup.name
  address_prefixes     = [var.subnet2_cidr]
}

# Create Azure Network Security Group (NSG) for Subnet1
resource "azurerm_network_security_group" "nsg_subnet1" {
  name                = "nsg-subnet1"
  resource_group_name = azurerm_resource_group.myresourcegroup.name

  security_rule {
    name                       = "Allow-HTTP"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Deny-All"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Associate NSG with Subnet1
resource "azurerm_subnet_network_security_group_association" "subnet1_nsg_association" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.nsg_subnet1.id
}