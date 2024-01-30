terraform {

    required_version = ">= 1.7.1"

    required_providers {
        proxmox = {
            source = "telmate/proxmox"
            version = "3.0.1-rc1"
        }
        cloudflare = {
            source = "cloudflare/cloudflare"
            version = "~> 4.0"
        }
    }
}
