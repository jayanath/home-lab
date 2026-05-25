## Workload Shutdown

Shutdown all the LXC containers, keep the proxy to the last

Set maintenance flags on CEPH
```
ceph osd set noout
ceph osd set nobackfill
ceph osd set norecover
ceph -s

cluster should report a 'HEALTH_WARN' status
```

3. Power down all the nodes. Keep the PBS for the last.
4. When powered up, unset the CEPH flags and check the status.
```
ceph osd unset noout
ceph osd unset nobackfill
ceph osd unset norecover
```