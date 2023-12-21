# Proxmox Full-Clone
# ---
# Create a new VM from a clone

# enter the the name of the new device
resource "proxmox_vm_qemu" "testing02" {

    # VM General Settings

    # which proxmox server should this be launched on?
    target_node = "pve"
    # make sure this ID is unqiue.  If you reuse ID's you will get errors :)
    vmid = "125"
    # name of the new device again
    name = "testing02"
    desc = "Description"

    # VM Advanced General Settings
    onboot = false

    # VM OS Settings
    clone = "VM 9000"

    # make sure to install qemu-guest-agent on image cloning
    # otherwise terafform will hang creating the vm
    agent = 1

    # VM CPU Settings
    # set cpu cores
    cores = 8
    sockets = 1
    cpu = "host"

    # VM Memory Settings
    # how much ram?
    memory = 2048

    # VM Network Settings
    network {
        bridge = "vmbr0"
        model  = "virtio"
    }

    # how big for the disk image?
    disk {
        storage = "local-lvm"
        type = "virtio"
        size = "8G"
    }

    # VM Cloud-Init Settings
    os_type = "cloud-init"

    # (Optional) IP Address and Gateway
    # set to your network
    # ipconfig0 = "ip=dhcp/24,gw=192.168.50.1"

    # (Optional) Default User
    ciuser = "ubuntu"

    # (Optional) Add your SSH KEY
    sshkeys = <<EOF
    l8NEcdZhQvP88OUzY3zISJEoHkSAV0ESZw9rKJVkFjo
    EOF
}
