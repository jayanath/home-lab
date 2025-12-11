## Proxmox upgrade process

```
ceph -s
apt update && apt dist-upgrade

echo 'grub-efi-amd64 grub2/force_efi_extra_removable boolean true' | debconf-set-selections -v -u

apt install --reinstall grub-efi-amd64
pve8to9 --full
apt remove systemd-boot
proxmox-boot-tool status
apt remove systemd-boot
efibootmgr -v
pve8to9 --full

sed -i 's/bookworm/trixie/g' /etc/apt/sources.list
sed -i 's/bookworm/trixie/g' /etc/apt/sources.list.d/pve-enterprise.list
sed -i 's/bookworm/trixie/g' /etc/apt/sources.list.d/ceph.list

apt update
apt dist-upgrade
```

