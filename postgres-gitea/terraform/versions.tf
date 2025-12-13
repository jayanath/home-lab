terraform {
  required_version = ">= 1.5.0"
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.89.1"
    }
  }
}

provider "proxmox" {
  # make sure to export PROXMOX_VE_API_TOKEN='<Your Token ID>=<Your Token Secret>'
  insecure = true
  endpoint = "https://192.168.193.11:8006/api2/json"
}
