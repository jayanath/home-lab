# Home-Lab
Home-lab related code and notes

# How to deploy
```
export PM_API_TOKEN_ID = my_proxmox_user_token_id
export PM_API_TOKEN_SECRET = my_proxmox_user_token_value

from the {product}/terraform:
terraform init -backend-config=../../tf_backend.hcl
terraform plan
terraform apply

```