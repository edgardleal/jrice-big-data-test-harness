# *********************************************************************************
# Description: Deploy 
# Author:      Joe Rice
# Created:     03/07/2018
#
# Notes:
#    Script assumes that the following environment variables are set
#       export AWS_ACCESS_KEY=<Secret>
#       export AWS_SECRET_KEY=<Super_Top_Secret>
# *********************************************************************************

DIR="$(cd "$(dirname "$0")" && pwd)"

source $DIR/setenv.sh

PLAYBOOK_FILE=./deploy-admin-logging-services.yml
EC2_INVENTORY_FILE=./ec2-inventory/ec2.py
PLAYBOOK_VAR_ENV=prod
PLAYBOOK_VAR_DOMAIN_PREFIX=""
PLAYBOOK_VAR_DOMAIN_NAME=$BDTH_DOMAIN_NAME
STACK_FILE_DIR=../docker/logging
STACK_FILE_NAME=docker-compose-local.yml

echo "."
echo "*********************************************************************************"
echo "   Deploy Docker Logging Stack..."
echo "*********************************************************************************"

time ENV_DOMAIN_PREFIX=$PLAYBOOK_VAR_DOMAIN_PREFIX \
  sudo docker stack deploy bdth-admin-logging \
  -c $STACK_FILE_DIR/$STACK_FILE_NAME 