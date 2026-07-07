subscription_id = "acdc4024-9d81-4435-908b-f343e832958f"

resource_group_name = "rg-demo-dev"

location = "eastus"

resource_group_tags = {
  "Environment" = "Dev"
  "Owner"       = "DevOps Team"
}

network_security_group_name = "nsg-dev-01"

vnet_name = "vnet-dev-01"

storage_account_name = "sa0pdevenv"

storage_account_container_name = "dev-state-container"

storage_allowed_ips = ["112.201.191.215"]