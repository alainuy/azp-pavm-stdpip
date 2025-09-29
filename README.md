# Azure Palo Alto VM-series Firewall with Standard Public IPs

## Overview
This Terraform project deploys a Palo Alto VM-series firewall in Azure with Standard SKU Public IP addresses. The configuration sets up a complete network security solution with management, untrust (external), and trust (internal) interfaces.

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

## Configuration Notes
1. **Security Consideration**: The admin password is marked as sensitive but is still passed directly. Consider using Azure Key Vault for better security.
2. **VM Size**: The VM size is set to `Standard_D3_v2`, which is recommended for testing. Production environments might require larger instances.
3. **Image**: Uses BYOL (Bring Your Own License) image. Ensure you have the appropriate licenses.
4. **Networking**: The configuration uses a three-tier architecture (management, untrust, trust) which is a standard security practice.

## Required Inputs
- `admin_password`: Password for the admin user
- `subs_id`: Azure subscription ID

## Recommendations
1. **Security**:
   - Implement Network Security Groups (NSGs) for each subnet
   - Restrict management access to specific IP ranges
   - Enable Azure Monitor and logging
2. **High Availability**: Consider adding a second VM in a different Availability Zone
3. **Backup**: Implement backup for the firewall configuration
4. **Tags**: Add tags to resources for better organization and cost tracking
