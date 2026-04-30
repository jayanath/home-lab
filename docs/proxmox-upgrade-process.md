## Proxmox upgrade process 
This is the approach for minor version upgrades. Any major version upgrade should planned with specific instructions.

Since this is a `Ceph-integrated` environment, we should follow this specific order: Proxmox OS patches first, node by node.

1. Pick the first node.
2. Right-click the node in the GUI and select "Bulk Action" -> "Migrate" to move all VMs/LXCs to other nodes
3. On the first node:
```
ceph -s
## results should be health: HEALTH_OK

apt update && apt dist-upgrade

ceph -s
## once we see healthy ceph cluster we can move to the next node.

## after all the nodes are updated:
ceph health detail
## result should be HEALTH_OK
```

