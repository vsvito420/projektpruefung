# Proxmox Vollständiger Klon
resource "proxmox_vm_qemu" "testing02" {

    # VM General Settings

    # Proxmox Server Name
    target_node = "pve"
    # Bitte Geben sie eine Eindeutige ID an!
    vmid = "126"
    # Proxmox Server Name erneut
    name = "testing02"
    desc = "Description"

    # Starten bei dem Boot von Proxmox?
    onboot = false

    # VM OS Settings
    clone = "VM 9000"

    # stelle sicher qemu-guest-agent wird installiert bei dem image cloning
    # ansonsten bleibt terraform stehen in der konfiguration!
    agent = 1

    # VM CPU Einstellugen
    # set cpu cores
    cores = 8
    sockets = 1
    cpu = "host"

    # VM Memory Einstellugen
    # Wie viel RAM?
    memory = 2048

    # VM Network Einstellugen
    network {
        bridge = "vmbr0"
        model  = "virtio"
    }

    # Wie groß soll das disk Image sein?
    disk {
        storage = "local-lvm"
        type = "virtio"
        size = "8G"
    }

    # VM Cloud-Init Einstellugen
    os_type = "cloud-init"

    # (Optional) IP Address and Gateway
    # Setze deine Netzwerkeinstellungen
    ipconfig0 = "ip=dhcp/24,gw=192.168.50.1"

    # (Optional) Default User
    ciuser = "ubuntu"

    # (Optional) Add your SSH KEY
    sshkeys = <<EOF
    l8NEcdZhQvP88OUzY3zISJEoHkSAV0ESZw9rKJVkFjo
    EOF
}
