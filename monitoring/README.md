# Monitoring Stack

Egress traffic monitoring and log aggregation.

## Components

| Service    | Role                                    | Port  |
|------------|-----------------------------------------|-------|
| Telegraf   | IPFIX/NetFlow receiver → InfluxDB       | 2055/udp |
| InfluxDB v2| Time-series storage (NetFlow data)      | 8086  |
| rsyslog    | Syslog receiver (UCG Max logs)          | 514/udp+tcp |
| Loki       | Log aggregation                         | 3100  |
| Promtail   | Ships rsyslog → Loki                    | 9080  |
| Grafana    | Dashboards (NetFlow + syslog)           | 3000  |

## LXC

- **Node**: pmox01
- **VM ID**: 175
- **IP**: 192.168.193.30
- **Resources**: 2 vCPU / 4 GB RAM / 32 GB disk (ceph)

## Deploy

### 1. Provision the LXC (Terraform)

```bash
cd monitoring/terraform
terraform init -backend-config=../../tf_backend.hcl
terraform plan
terraform apply
```

### 2. Prepare secrets

```bash
cp ansible/secrets-sample.yml ansible/secrets.yml
# Edit secrets.yml with your values:
#   monitoring_influxdb_admin_password  — strong password
#   monitoring_influxdb_operator_token  — run: openssl rand -base64 48 | tr -d '\n'
ansible-vault encrypt ansible/secrets.yml
```

### 3. Configure UCG Max

In UniFi → **CyberSecure → Traffic Logging**:
- Select NetFlow (IPFIX) → collector IP `192.168.193.30`, port `2055`
- Flow Logging → **All Traffic**
- Activity Logging (Syslog) → **SIEM Server** → `192.168.193.30`, port `514`, UDP

### 4. Run the Ansible playbook

```bash
cd monitoring/ansible
ansible-playbook -i inventory.ini site.yml --ask-vault-pass
```

### 5. Add Traefik dynamic config

Copy `traefik-dynamic/grafana.yml` into traefik role's `files/dynamic/` directory
and add `grafana.yml` to the `traefik_dynamic_config_files` list in
`traefik/ansible/site.yml`, then re-run the traefik playbook.

Make sure to add a DNS record for `grafana.{yourdomain}` points to traefik

### 6. Import Grafana dashboards

In Grafana → **Dashboards → Import**, use these community dashboard IDs:

| ID    | Description                                |
|-------|--------------------------------------------|
| 13139 | NetFlow/IPFIX overview (top talkers, geo)  |
| 12006 | Per-host egress breakdown                  |

Or drop any dashboard JSON file into `/var/lib/grafana/dashboards/` — Grafana
auto-loads from that directory every 30 seconds.

## Verify

```bash
# NetFlow arriving
journalctl -u telegraf -f

# Syslog arriving from UCG Max
tail -f /var/log/ucg-max.log

# InfluxDB health
curl http://192.168.193.30:8086/health

# Loki ready
curl http://192.168.193.30:3100/ready
```

## Querying in Grafana

**Explore → InfluxDB (Flux)** — NetFlow:
```flux
from(bucket: "netflow")
  |> range(start: -1h)
  |> filter(fn: (r) => r._measurement == "netflow")
  |> group(columns: ["dst_addr"])
  |> sum(column: "_value")
  |> sort(columns: ["_value"], desc: true)
  |> limit(n: 20)
```

**Explore → Loki** — UCG Max security events:
```logql
{job="ucg-max"} |= "BLOCK"     // IPS blocks
{job="ucg-max"} |= "threat"    // threat detections
{job="ucg-max"} |= "WAN_OUT"   // egress firewall hits
```
