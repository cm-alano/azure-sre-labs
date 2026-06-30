# Azure SRE Terraform Lab

## Project Overview

This project demonstrates how to provision Azure infrastructure using Terraform while following Infrastructure as Code (IaC) best practices.

The repository was built as part of my Azure SRE learning journey to improve my skills in:

- Terraform
- Azure Infrastructure
- Infrastructure as Code
- Azure Monitoring
- Modular Terraform Design
- Remote State Management

---

## Architecture

                    Azure Subscription
                           │
                    Resource Group
                           │
        ┌──────────────────┴──────────────────┐
        │                                     │
 Storage Account                      Virtual Network
        │                                     │
   tfstate Container          ┌─────────┴─────────┐
                              │                   │
                         Web Subnet         App Subnet
                              │                   │
                             NSG                 NSG

                Log Analytics Workspace
                          │
                   Azure Monitor
                          │
                    Action Group

---

## Technologies Used

- Terraform
- Azure Resource Manager (AzureRM Provider)
- Azure CLI
- Git
- Visual Studio Code

---

## Infrastructure Components

- Resource Group
- Virtual Network
- Subnets
- Network Security Groups
- Storage Account
- Storage Container
- Log Analytics Workspace
- Action Group
- Linux Virtual Machine
- Remote State Backend

---

## Repository Structure
