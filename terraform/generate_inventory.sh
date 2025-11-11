#!/bin/bash
# generate_inventory.sh
# Generates inventory.ini file for Ansible

IP=$(terraform output -raw instance_public_ip)

cat > ../ansible/inventory.ini <<EOF
[cv_server]
${IP} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/cv-challenge01-server-keypair.pem
EOF

echo "✅ Ansible inventory generated at ansible/inventory.ini"
