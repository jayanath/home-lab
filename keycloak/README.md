# How to deploy Keycloak

### Step 01 - Deploy PostgreSQL

Use `../postgres-keycloak` to deploy and configure `postgreSQL` for `Keycloak`   

### Step 02 - Deploy a new LXC container 
```
Update the tf_backend.hcl with S3 bucket info
Update the versions.tf with proxmox path
Update the public key to be used with ssh connectivity to the container in the keycloak.tf

export PM_API_TOKEN_ID = my_proxmox_user_token_id
export PM_API_TOKEN_SECRET = my_proxmox_user_token_value

from the terraform/

terraform init -backend-config=../../tf_backend.hcl
terraform plan
terraform apply

```
### Step 03 - Install and configure Keycloak

```
Update the inventory.ini with host information

ansible-vault encrypt secrets.yml to encrypt the secrets file

ansible-playbook site.yml -i inventory.ini --ask-vault-pass

```

## Integrate Applications with Keycloak

### Create a new Keycloak Realm
The `keycloak-realm-mgmt.yml` playbook is used to configure a new realm for the homelab apps to leave the `master` realm alone. 

```
ansible-playbook keycloak-realm-mgmt.yml -i inventory.ini --ask-vault-pass

```

### Integrate Apps with Keycloak.
A separate playbook for each application integration to keep things manageable.

#### Proxmox
```
ansible-playbook keycloak-pmox-integration.yml -i inventory.ini --ask-vault-pass
```
#### Vault
```
ansible-playbook keycloak-vault-integration.yml -i inventory.ini --ask-vault-pass
```