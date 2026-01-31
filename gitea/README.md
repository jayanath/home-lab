# How to deploy gitea

### Step 01 - Deploy PostgreSQL

Use `../postgres-gitea` to deploy and configure `postgreSQL` for `gitea`   

### Step 02 - Deploy a new LXC container 
```
Update the tf_backend.hcl with S3 bucket info
Update the versions.tf with proxmox path
Update the public key to be used with ssh connectivity to the container in the postgresql.tf

export PROXMOX_VE_API_TOKEN='<Your Token ID>=<Your Token Secret>'

from the terraform/

terraform init -backend-config=../../tf_backend.hcl
terraform plan
terraform apply

```