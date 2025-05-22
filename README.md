# Home-Lab
This repository contains my home-lab related code and notes.
The code is reusable with minimal changes. Give it a try.

# How to deploy
```
export PM_API_TOKEN_ID = my_proxmox_user_token_id
export PM_API_TOKEN_SECRET = my_proxmox_user_token_value

from the {product}/terraform:
terraform init -backend-config=../../tf_backend.hcl
terraform plan
terraform apply


Once the base infra (LXC container or a VM) is deployed, run the relavent Ansible playbook to install and configure the application.
The playbooks can be found at {product}/ansible

```
Refer to the README.md under each product for more detailed steps.


# AWS IAM policy, if S3 bucket is used for remote state management.
```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:ListBucket",
      "Resource": "arn:aws:s3:::jay-home-lab-tf-state",
      "Condition": {
        "StringLike": {
          "s3:prefix": "proxmox/*/terraform.tfstate"
        }
      }
    },
    {
      "Effect": "Allow",
      "Action": ["s3:GetObject", "s3:PutObject"],
      "Resource": [
        "arn:aws:s3:::jay-home-lab-tf-state/proxmox/*/terraform.tfstate"
      ]
    },
    {
      "Effect": "Allow",
      "Action": ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"],
      "Resource": [
        "arn:aws:s3:::jay-home-lab-tf-state/proxmox/*/terraform.tfstate.tflock"
      ]
    }
  ]
}
```
