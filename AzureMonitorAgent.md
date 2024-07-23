# Azure Monitor Agent 

## Table of Contents
- [Overview](#overview)
- [Use Case](#use-case)
- [Installing Azure Monitor Agent](#installing-azure-monitor-agent)
    - [Data Collection Rule Install Method](#data-collection-rule-install-method)
    - [CLI Install Method](#cli-install-method)
- [Updating Azure Monitor Agent](#updating-azure-monitor-agent)
- [Addressing the vulnerability issue](#addressing-the-vulnerability-issue)

## Overview
Azure Monitor Agent (AMA) is designed to collect telemetry data from various sources in your cloud and on-premises environments. It provides a unified way to collect, monitor, and analyze data from multiple sources, including virtual machines, containers, and other Azure services. AMA replaces the Microsoft Monitoring Agent (MMA) and the Log Analytics agent for Windows and Linux.

## Use Case

A vulnerability (CVE-2024-2511) was identified in Azure Monitor Agent, which was detected during our weekly vulnerability scans. This document discusses how to mitigate this vulnerability by updating the Azure Monitor Agent to the latest version. Several methods to update the agent are provided, including installation instructions.

## Installing Azure Monitor Agent
### Data Collection Rule Install Method
+ Navigate to the Azure Monitor service in the Azure portal.
+ Click on "Data Collection Rules" in the left-hand menu.
+ If an enterprise-wide rule is already enabled, click on it. If not, click on "Add data collection rule."
    + Note the Configuration section in the left-hand menu, where Data Sources and Resources are listed.

![image](https://github.com/user-attachments/assets/7c9d8e81-d72d-4356-b7c3-eca0e991b917)


  
   + **Data Sources**: Select the data sources you want to collect data from. Common sources include:
        + Windows Event Logs
        + Linux Performance Counters
        + Syslog
        + Custom Logs
   + **Resources**: Select the resources you want to collect data from (e.g., virtual machines, containers).
+ **To add rule to an exhisting virtual machine**:
    + Click on "Resources" under **Configuration**.
    + Click on "Add resource" and select the virtual machine you want to add the rule to.
    + Click on "Save".

## CLI Install Method
+ Open the Azure CLI.
+ Run the following command in Azure CLI:
### User-assigned managed identity
Set-AzVMExtension -Name AzureMonitorWindowsAgent -ExtensionType AzureMonitorWindowsAgent -Publisher Microsoft.Azure.Monitor -ResourceGroupName <resource-group-name> -VMName <virtual-machine-name> -Location <location> -TypeHandlerVersion <version-number> -EnableAutomaticUpgrade $true -SettingString '{"authentication":{"managedIdentity":{"identifier-name":"mi_res_id","identifier-value":"/subscriptions/<my-subscription-id>/resourceGroups/<my-resource-group>/providers/Microsoft.ManagedIdentity/userAssignedIdentities/<my-user-assigned-identity>"}}}'

### System-assigned managed identity
Set-AzVMExtension -Name AzureMonitorWindowsAgent -ExtensionType AzureMonitorWindowsAgent -Publisher Microsoft.Azure.Monitor -ResourceGroupName <resource-group-name> -VMName <virtual-machine-name> -Location <location> -TypeHandlerVersion <version-number> -EnableAutomaticUpgrade $true

Replace the placeholders with your actual values (resource group name, virtual machine name, location, version number, subscription ID, resource group, user-assigned identity).

## Updating Azure Monitor Agent
There are a few ways to update the Azure Monitor Agent:
+ **Automatic**: The agent will automatically update itself if you have the "EnableAutomaticUpgrade" set to true.
+ **Manual**: You can manually update the agent by going to the virtual machine in the Azure portal and clicking on "Extensions + applications". Click on the agent and then click on "Update".
    + Clicking on resources, selecting the machine or resource and deleting the rule, then adding it back will also update the agent. 

![image](https://github.com/user-attachments/assets/0f3d8239-39f9-4c04-a0cd-a7158906f2f2)


+ **CLI**: Use the following command to update the agent via Azure CLI:
```
Set-AzVMExtension -ExtensionName AzureMonitorWindowsAgent -ResourceGroupName <resource-group-name> -VMName <virtual-machine-name> -Publisher Microsoft.Azure.Monitor -ExtensionType AzureMonitorWindowsAgent -TypeHandlerVersion 1.28.2 -Location <location> -EnableAutomaticUpgrade $true
```
You may need to adjust the version number and ensure you are in the correct subscription and resource group.

## Addressing the vulnerability issue
The identified vulnerability was related to the version of the Azure Monitor Agent installed on the virtual machines. This issue was resolved by updating the agent to the latest version. Although Microsoft indicated that it could take up to five weeks for the agent to update itself, internal organizational policies required a manual update. The vulnerability was detected during our weekly scans and was causing significant noise, necessitating prompt action.

For more documentaiton on Azure Monitor Agent, visit the [official Microsoft documentation](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/azure-monitor-agent-manage?tabs=azure-powershell).
