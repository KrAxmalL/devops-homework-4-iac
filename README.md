# Homework 4 (IaC) - Configuration Automation

## Creating the infrastructure
- To create the infrastructure - run the `terraform apply` command inside the `/terraform` folder. Terraform will also generate the `/ansible/inventory/hosts.ini` and `/ansible/vars/main.yml` files which are used by Ansible and required to configure the servers.

## Configuring the servers
- To configure servers - run the `ansible-playbook -i inventory/hosts.ini pssql.yml --private-key='../keys/private/devops-homework-4-root-keypair.pem'` command inside the `/ansible` folder (or you can use private key file which contains the private key for the public keys in `/keys/public` folder).

## Notes
- During the infrastructure creation the private key file will be generated inside the `/keys/private` folder. It is used by Ansible to log in into the servers. Destroying the infrastructure with `terraform destroy` command will delete the private key as well.