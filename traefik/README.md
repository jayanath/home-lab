# How to deploy traefik as the reverse proxy

### Step 01 - Deploy a new LXC container 
```
Update the tf_backend.hcl with S3 bucket info
Update the versions.tf with proxmox path
Update the public key to be used with ssh connectivity to the container in the traefik.tf

export PM_API_TOKEN_ID = my_proxmox_user_token_id
export PM_API_TOKEN_SECRET = my_proxmox_user_token_value

from the terraform/

terraform init -backend-config=../../tf_backend.hcl
terraform plan
terraform apply

```
### Step 02 - Install and configure traefik 

```
Update the inventory.ini with host information

ansible-vault encrypt files/.aws/credentials to encrypt the AWS credentials

ansible-playbook site.yml -i inventory.ini --ask-vault-pass

```