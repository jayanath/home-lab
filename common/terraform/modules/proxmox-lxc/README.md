## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.10 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_lxc.lxc](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs/resources/lxc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cores"></a> [cores](#input\_cores) | The number of cores assigned to the container | `number` | `1` | no |
| <a name="input_cpulimit"></a> [cpulimit](#input\_cpulimit) | A number to limit CPU usage by | `number` | `1` | no |
| <a name="input_cpuunits"></a> [cpuunits](#input\_cpuunits) | A number of the CPU weight that the container possesses | `number` | `1024` | no |
| <a name="input_description"></a> [description](#input\_description) | The container description seen in the web interface | `string` | `"lxc-container"` | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | Host name of the container | `string` | n/a | yes |
| <a name="input_label"></a> [label](#input\_label) | A common label for resource identification, such as a project code prefix | `string` | n/a | yes |
| <a name="input_memory"></a> [memory](#input\_memory) | A number containing the amount of RAM to assign to the container (in MB) | `number` | `512` | no |
| <a name="input_network_bridge"></a> [network\_bridge](#input\_network\_bridge) | The bridge to attach the network interface to (e.g. vmbr0) | `string` | `"vmbr0"` | no |
| <a name="input_network_ip"></a> [network\_ip](#input\_network\_ip) | The IPv4 address of the network interface. Can be a static IPv4 address (in CIDR notation), dhcp, or manual | `string` | n/a | yes |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | The name of the network interface as seen from inside the container (e.g. eth0) | `string` | `"eth0"` | no |
| <a name="input_onboot"></a> [onboot](#input\_onboot) | A boolean that determines if the container will start on boot | `bool` | `true` | no |
| <a name="input_ostemplate"></a> [ostemplate](#input\_ostemplate) | The volume identifier of the OS template.(e.g. local:vztmpl/ubuntu-20.04-standard\_20.04-1\_amd64.tar.gz) | `string` | n/a | yes |
| <a name="input_rootfs_size"></a> [rootfs\_size](#input\_rootfs\_size) | Size of the underlying volume | `string` | `"10G"` | no |
| <a name="input_rootfs_storage"></a> [rootfs\_storage](#input\_rootfs\_storage) | A string containing the volume , directory, or device to be mounted into the container | `string` | n/a | yes |
| <a name="input_ssh_public_keys"></a> [ssh\_public\_keys](#input\_ssh\_public\_keys) | Multi-line string of SSH public keys that will be added to the container. Can be defined using heredoc syntax | `string` | `"NONE"` | no |
| <a name="input_target_node"></a> [target\_node](#input\_target\_node) | A cluster node name for the LXC container to live | `string` | n/a | yes |
| <a name="input_unprivileged"></a> [unprivileged](#input\_unprivileged) | Run the container as an unprivileged user | `bool` | `true` | no |
| <a name="input_vmid"></a> [vmid](#input\_vmid) | A number that sets the VMID of the container | `number` | `0` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lxc_hostname"></a> [lxc\_hostname](#output\_lxc\_hostname) | The hostname of the LXC container |
| <a name="output_lxc_ip_address"></a> [lxc\_ip\_address](#output\_lxc\_ip\_address) | The IP address assigned to the LXC container (if configured) |
| <a name="output_lxc_target_node"></a> [lxc\_target\_node](#output\_lxc\_target\_node) | The Proxmox node where the LXC container was created |
| <a name="output_lxc_unprivileged"></a> [lxc\_unprivileged](#output\_lxc\_unprivileged) | Indicates if the container is unprivileged |
| <a name="output_lxc_vmid"></a> [lxc\_vmid](#output\_lxc\_vmid) | The unique Proxmox VMID of the created LXC container |
