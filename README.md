# Azure Palo Alto VM-series FW with Standard Public IPs

## Overview
This Terraform project deploys a Palo Alto VM-series firewall in Azure with Standard SKU Public IP addresses. The configuration sets up a complete network security solution with management, untrust (external), and trust (internal) interfaces.

## First thing first
1. **Execute the following command to accept the terms and conditions for the Palo Alto VM-series Flex image**:

az vm image terms accept \
--urn paloaltonetworks:vmseries-flex:byol:11.2.5

## Key Components

### 1. Resource Group
- **Name**: `HUB-VNET` (default, configurable)
- **Location**: `southeastasia` (default, configurable)

### 2. Virtual Network
- **Name**: `fwVNET` (default, configurable)
- **Address Space**: `10.0.5.0/24` (default, configurable)

### 3. Subnets
- **Management**: `10.0.5.0/27`
  - Used for firewall management interface
- **Untrust (External)**: `10.0.5.32/27`
  - For external/public-facing traffic
- **Trust (Internal)**: `10.0.5.64/27`
  - For internal/private network traffic

### 4. Virtual Machine
- **VM Type**: Palo Alto VM-series Firewall
- **SKU**: `Standard_D3_v2`
- **Image**: Palo Alto networks VM-Series Flex (BYOL)
- **Version**: 11.2.5
- **Admin Credentials**:
  - Username: `paadmin`
  - Password: Set via `admin_password` variable (marked as sensitive)

### 5. Network Interfaces
- **Management NIC**:
  - Connected to `mgmt` subnet
  - Has a Standard SKU Public IP
- **Untrust NIC**:
  - Connected to `untrust` subnet
  - Has two Standard SKU Public IPs
- **Trust NIC**:
  - Connected to `trust` subnet
  - No public IP assigned

### 6. Public IPs
- **Management**: 1 Standard SKU Public IP
- **Untrust**: 2 Standard SKU Public IPs (for HA or different services)

## Configuration Template

A template file `terraform.tfvars.example` is provided to help you configure the deployment. To use it:

1. Copy the example file to create your configuration:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Edit `terraform.tfvars` with your specific values:
   - `subs_id`: Your Azure Subscription ID
   - `resource_group_name`: Name for your resource group
   - `location`: Azure region for deployment (default: southeastasia)
   - `vnet_name` and `vnet_address_space`: Network configuration
   - Subnet prefixes for management, untrust, and trust interfaces
   - `admin_password`: Secure password for the firewall admin user

3. For production environments, consider using environment variables or Azure Key Vault for sensitive values.

## Configuration Notes
1. **Security Consideration**: The admin password is marked as sensitive but is still passed directly. Consider using Azure Key Vault for better security.
2. **VM Size**: The VM size is set to `Standard_D3_v2`, which is recommended for testing. Production environments might require larger instances.
3. **Image**: Uses BYOL (Bring Your Own License) image. Ensure you have the appropriate licenses.
4. **Networking**: The configuration uses a three-tier architecture (management, untrust, trust) which is a standard security practice.

## Required Inputs
- `admin_password`: Password for the admin user
- `subs_id`: Azure subscription ID

