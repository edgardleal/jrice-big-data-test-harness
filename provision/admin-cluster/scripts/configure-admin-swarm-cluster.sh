# *********************************************************************************
# Description: provision a new docker host machine in AWS to be used for the wordpress blog
# Author:      Joe Rice
# Created:     03/08/2018
#
# Notes:
#    Script assumes that the following environment variables are set
#       export AWS_ACCESS_KEY=<Secret>
#       export AWS_SECRET_KEY=<Super_Top_Secret>
# *********************************************************************************

DIR="$(cd "$(dirname "$0")" && pwd)"

source $DIR/setenv.sh

PLAYBOOK_FILE=./configure-admin-cluster.yml
EC2_INVENTORY_FILE=./ec2-inventory/ec2.py
PLAYBOOK_VAR_ENV=prod
PLAYBOOK_VAR_DOMAIN_PREFIX=""

cd $BDTH_ADMIN_PLAYBOOK_DIR

time ansible-playbook \
  -i $EC2_INVENTORY_FILE \
  -v \
  -u ubuntu \
  -e env=$PLAYBOOK_VAR_ENV \
  -e env_domain_prefix=$PLAYBOOK_VAR_DOMAIN_PREFIX \
  --private-key $BDTH_AWS_KEY_FILE_PATH \
  $PLAYBOOK_FILE
