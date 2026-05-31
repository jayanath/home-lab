#!/bin/bash
# Queries NUT server and outputs InfluxDB line protocol for Telegraf inputs.exec
# Managed by Ansible — do not edit manually.

NUT_SERVER="$1"
NUT_UPS="$2"

# Run upsc and parse output
declare -A fields

while IFS=': ' read -r key value; do
    [[ -z "$key" || "$key" == Init* ]] && continue
    fields["$key"]="$value"
done < <(upsc "${NUT_UPS}@${NUT_SERVER}" 2>/dev/null)

# Exit silently if no data (NUT server unreachable)
[[ ${#fields[@]} -eq 0 ]] && exit 0

# Map NUT fields to InfluxDB line protocol
# Format: measurement,tags field1=val1,field2=val2 timestamp
battery_charge="${fields[battery.charge]:-0}"
battery_voltage="${fields[battery.voltage]:-0}"
output_voltage="${fields[output.voltage]:-0}"
ups_load="${fields[ups.load]:-0}"
ups_status="${fields[ups.status]:-unknown}"

# Convert status string to integer for graphing (OL=1, OL LB=2, unknown=0)
case "$ups_status" in
    "OL")    status_code=1 ;;
    "OL LB") status_code=2 ;;
    *)       status_code=0 ;;
esac

# Emit InfluxDB line protocol
# Tag: ups_name for filtering in Grafana
echo "nut,ups=${NUT_UPS},server=${NUT_SERVER} \
battery_charge=${battery_charge},\
battery_voltage=${battery_voltage},\
output_voltage=${output_voltage},\
ups_load=${ups_load},\
status_code=${status_code}i,\
ups_status=\"${ups_status}\""
