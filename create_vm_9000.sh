#!/bin/bash

echo "create_vm_9000.sh gestartet..."

# Überprüft, ob das Skript als Root ausgeführt wird
if [ "$EUID" -ne 0 ]
  then echo "Bitte als Root ausführen"
  exit
fi

# Beispiel, wenn Sie einen Schlüssel in das Image injizieren müssen
# FILE1=/root/ansible_ssh_key.txt
# if test -f "$FILE1"; then
#    echo "ansible ssh-Schlüsseldatei gefunden..."
#  else
#    echo "Konnte die Datei /root/anible_ssh_key.txt nicht finden. Bitte erstellen Sie diese Datei. Beenden."
#    exit
# fi

FILE2=/root/jammy-server-cloudimg-amd64.img.original
# Überprüft, ob die Image-Datei vorhanden ist. Wenn ja, wird sie kopiert. Wenn nein, wird sie heruntergeladen.
if test -f "$FILE2"; then
     echo "Image-Datei gefunden, Überspringen des Downloads..."
     cp /root/jammy-server-cloudimg-amd64.img.original /root/jammy-server-cloudimg-amd64.img
else
     echo "Image-Datei wird heruntergeladen..."
     cd /root/
     wget https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img
fi

# Installiert den QEMU-Gast-Agenten im Image
virt-customize -a jammy-server-cloudimg-amd64.img --install qemu-guest-agent
# Erstellt einen neuen Benutzer mit dem Namen "ubuntu" im Image
virt-customize -a jammy-server-cloudimg-amd64.img --run-command "useradd -m -s /bin/bash ubuntu"
# Legt das Root-Passwort im Image fest
virt-customize -a jammy-server-cloudimg-amd64.img --root-password password:ubuntu

# Injiziert den SSH-Schlüssel in das Image (auskommentiert)
# virt-customize -a jammy-server-cloudimg-amd64.img --ssh-inject ubuntu:file:/root/ansible_ssh_key.txt

# Erstellt eine neue VM mit dem Namen "9000"
qm create 9000 --memory 2048 --net0 virtio,bridge=vmbr0 --scsihw virtio-scsi-pci
# Importiert das Image in die VM
qm set 9000 --scsi0 local-lvm:0,import-from=/root/jammy-server-cloudimg-amd64.img
# Fügt das cloudinit-Image hinzu
qm set 9000 --ide2 local-lvm:cloudinit
# Legt die Bootreihenfolge fest
qm set 9000 --boot order=scsi0
# Legt die serielle Schnittstelle und VGA fest
qm set 9000 --serial0 socket --vga serial0
# Aktiviert den QEMU-Gast-Agenten in der VM
qm set 9000 -agent 1
# Erstellt eine Vorlage aus der VM
qm template 9000

echo "create_vm_9000 abgeschlossen."
