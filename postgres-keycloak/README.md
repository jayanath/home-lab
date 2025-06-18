# How to deploy PostgreSQL as the DB for Keycloak

### Step 01 - Deploy a new LXC container 
```
Update the tf_backend.hcl with S3 bucket info
Update the versions.tf with proxmox path
Update the public key to be used with ssh connectivity to the container in the postgresql.tf

export PM_API_TOKEN_ID = my_proxmox_user_token_id
export PM_API_TOKEN_SECRET = my_proxmox_user_token_value

from the terraform/

terraform init -backend-config=../../tf_backend.hcl
terraform plan
terraform apply

```
### Step 02 - Install and configure PostgreSQL

```
Update the inventory.ini with host information

ansible-vault encrypt_string 'this-is-my-super-secret-db-password' --name 'keycloak_db_password'

Use the generated password in the postgres-keycloak/ansible/roles/pg-keycloak/defaults/main.yml

ansible-playbook site.yml -i inventory.ini --ask-vault-pass

```

### Step 03 - Verify the DB installation

SSH into the PostgreSQL LXC container and run a few tests.


Check the DB service status with `systemctl status postgresql`

Check if the DB service is listening in the expected `5432` port using `ss -nutpl | grep postgres`

Try loging into the DB using `sudo -u postgres psql -d keycloak -U keycloakuser -h localhost` and providing the password at the prompt
