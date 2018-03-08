# *********************************************************************************
# Description: provision a new docker host machine in AWS to be used for the wordpress blog
# Author:      Joe Rice
# Created:     3/07/2018
#
# Notes:
#    Script assumes that the following environment variables are set
#       export AWS_ACCESS_KEY=<Secret>
#       export AWS_SECRET_KEY=<Super_Top_Secret>
# *********************************************************************************

DIR="$(cd "$(dirname "$0")" && pwd)"

source $DIR/setenv.sh

PLAYBOOK_DIR=$DIR/../ansible
PLAYBOOK_FILE=./provision-swarm-cluster.yml
EC2_INVENTORY_FILE=./ec2-inventory/ec2.py
PLAYBOOK_VAR_ENV=prod
PLAYBOOK_VAR_DOMAIN_PREFIX="prod."
DOCKER_INSTALL_VERSION=17.12.0~ce-0~ubuntu

cd $PLAYBOOK_DIR

time ansible-playbook \
   -i $EC2_INVENTORY_FILE \
   -v \
   -u ubuntu \
   -e env=$PLAYBOOK_VAR_ENV \
   -e env_domain_prefix=$PLAYBOOK_VAR_DOMAIN_PREFIX \
   -e docker_install_version=$DOCKER_INSTALL_VERSION \
   --private-key $BDTH_AWS_KEY_FILE_PATH $PLAYBOOK_FILE
