# How to deploy Vault

### Step 01 - Deploy a new LXC container 
```
Update the tf_backend.hcl with S3 bucket info
Update the versions.tf with proxmox path
Update the public key to be used with ssh connectivity to the container in the vault.tf

export PM_API_TOKEN_ID = my_proxmox_user_token_id
export PM_API_TOKEN_SECRET = my_proxmox_user_token_value

from the terraform/

terraform init -backend-config=../../tf_backend.hcl
terraform plan
terraform apply

```
### Step 02 - Install and configure Vault

```
Update the inventory.ini with host information

ansible-vault encrypt secrets.yml to encrypt the secrets file

ansible-playbook site.yml -i inventory.ini --ask-vault-pass

```

### Step 03 - Integrate Vault with Traefik
- Run Traefik playbook to deploy the vault routes.
- Make sure to update DNS records accordingly. In my case I update pfSense and Adguard.

### Step 04 - Integrate Vault with Keycloak
- Run keycloak-vault-integration playbook to add Vault client
```
ansible-playbook keycloak-vault-integration.yml -i inventory.ini --ask-vault-pass
```