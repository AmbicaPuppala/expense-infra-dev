#!/bin/bash
ENVIRONMENT=$1
dnf install ansible -y
#push architecture
#ansible-playbook -i inventory.ini mysql.yaml

#pull architecture
ansible-pull -i localhost, -U https://github.com/AmbicaPuppala/expense-ansible-roles-tf.git main.yaml -e COMPONENT=frontend -e ENVIRONMENT=$1