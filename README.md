# home-lab
Home-lab related code and notes

# How to deploy
```
export PM_API_TOKEN_ID = my_proxmox_user_token_id
export PM_API_TOKEN_SECRET = my_proxmox_user_token_value

terraform init -backend-config=/path/to/backend.hcl
terraform plan --var-file=my_vars.tfvars
terraform apply --var-file=my_vars.tfvars

```