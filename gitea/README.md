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
### Step 03 - Run Keycloak integration with Gitea
```
From keycloak/ansible 
Run ansible-playbook keycloak-gitea-integration.yml -i inventory.ini --ask-vault-pass
```

### Step 04 - Integrate Gitea with Traefik
```
Run Traefik playbook to deploy the Gitea routes.
Make sure to update DNS records accordingly. In my case I update Unifi Cloud Gateway and Adguard.
```

### Step 05 - Install and Configure Gitea
```
Update the inventory.ini with host information

ansible-vault encrypt secrets.yml to encrypt the secrets file

ansible-playbook site.yml -i inventory.ini --ask-vault-pass
```

### Step 06 - Test Gitea
```
# Check if the service is running
systemctl status gitea

# Check if service is listening on port 3000
ss -tlnp | grep 3000

# Hit HTTP endpoint from the container iteslf
curl -I http://localhost:3000

```