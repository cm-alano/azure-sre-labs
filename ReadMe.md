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

[#architecture](#architecture)

```mermaid
graph TD
    A[Azure Subscription] --> B[Resource Group]
    B --> C[Storage Account]
    B --> D[Virtual Network]
    B --> G[Log Analytics Workspace]

    C --> C1[tfstate Container]

    D --> D1[Web Subnet]
    D --> D2[App Subnet]
    D1 --> N1[NSG]
    D2 --> N2[NSG]
    D2 --> VM[Linux Virtual Machine]

    G --> H[Azure Monitor]
    H --> I[Action Group]
```
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
a## Repository Structure

[#repository-structure](#repository-structure)

```mermaid
graph TD
    Root[azure-sre-labs] --> Bootstrap[bootstrap/]
    Root --> Docs[docs/]
    Docs --> Img[img/]
    Root --> Env[environment/]
    Env --> Dev[dev/]
    Root --> Modules[modules/]
    Root --> Gitignore[.gitignore]
    Root --> Readme[ReadMe.md]
```

## Progress

- [x] Day 1 - Resource Group
- [x] Day 2 - Networking
- [x] Day 3 - Storage
- [x] Day 4 - Remote State
- [x] Day 5 - VM
- [ ] Day 6 - Monitoring
- [ ] Day 7 - Modules
- [ ] Day 8 - Final Project