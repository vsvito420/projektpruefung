terraform {
  required_version = ">= 0.14"
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc1"
    }
  }
}

provider "proxmox" {
    pm_tls_insecure = true
    pm_api_url = "https://192.168.50.87:8006/api2/json"
    pm_api_token_secret = "a776ff4f-940d-4219-bc58-16b04ec0e873"
    pm_api_token_id = "terraform-prov@pve!terraform2idk"
}