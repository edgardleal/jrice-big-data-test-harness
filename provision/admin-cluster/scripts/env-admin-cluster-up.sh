# *********************************************************************************
# Description: provision a new docker host machine in AWS to be used for the wordpress blog
# Author:      Joe Rice
# Created:     10/14/2016
#
# Notes:
#    Script assumes that the following environment variables are set
#       export AWS_ACCESS_KEY=<Secret>
#       export AWS_SECRET_KEY=<Super_Top_Secret>
# *********************************************************************************

DIR="$(cd "$(dirname "$0")" && pwd)"

source $DIR/setenv.sh

export TERRAFORM_DIR=$DIR/../terraform
export ENVIRONMENT=prod
export ENVIRONMENT_DOMAIN_PREFIX=

export POST_ENV_CREATE_SLEEP_TIME=10s
export POST_PROVISION_DOCKER_SWARM_SLEEP_TIME=10s
export POST_LOGGING_DEPLOY_SLEEP_TIME=10s
export POST_ENV_CONFIGURE_SLEEP_TIME=10s

SCRIPT_START_DATETIME=$(date '+%A %D %I:%M:%S:%N %Z')

echo .
echo .
echo -------------------------------------------------------------
echo " Start - $ENVIRONMENT Admin Environment Up ..."
echo "   - environment               = $ENVIRONMENT"
echo "   - environment-domain-prefix = $ENVIRONMENT_DOMAIN_PREFIX"
echo "   - Script Start Time         = $SCRIPT_START_DATETIME"
echo -------------------------------------------------------------

echo .
echo .
echo -------------------------------------------------------------
echo " Creating Admin Environment - Spinning up AWS Resources"
echo -------------------------------------------------------------

time $DIR/env-admin-cluster-create.sh

echo .
echo .
echo -------------------------------------------------------------
echo " AWS Resources Created.  Sleeping for $POST_ENV_CREATE_SLEEP_TIME before continuing..."
echo -------------------------------------------------------------

sleep $POST_ENV_CREATE_SLEEP_TIME

echo .
echo .
echo -------------------------------------------------------------
echo " Provisioning Admin Docker Swarm..."
echo -------------------------------------------------------------

time $DIR/provision-admin-swarm-cluster.sh

echo .
echo .
echo -------------------------------------------------------------
echo " Docker Swarm Provisioned.  Sleeping for $POST_PROVISION_DOCKER_SWARM_SLEEP_TIME before continuing..."
echo -------------------------------------------------------------

sleep $POST_PROVISION_DOCKER_SWARM_SLEEP_TIME

echo .
echo .
echo -------------------------------------------------------------
echo " Deploying Admin Logging Services..."
echo -------------------------------------------------------------

time $DIR/deploy-admin-logging-services.sh

echo .
echo .
echo -------------------------------------------------------------
echo " Logging Services Deployed.  Sleeping for $POST_LOGGING_DEPLOY_SLEEP_TIME before continuing..."
echo -------------------------------------------------------------

sleep $POST_LOGGING_DEPLOY_SLEEP_TIME

echo .
echo .
echo -------------------------------------------------------------
echo " Configuring Docker Swarm..."
echo -------------------------------------------------------------

time $DIR/configure-admin-swarm-cluster.sh

echo .
echo .
echo -------------------------------------------------------------
echo " Docker Swarm Configured.  Sleeping for $POST_ENV_CONFIGURE_SLEEP_TIME before continuing..."
echo -------------------------------------------------------------

sleep $POST_ENV_CONFIGURE_SLEEP_TIME

echo .
echo .
echo -------------------------------------------------------------
echo " Deploying Admin Monitoring Services..."
echo -------------------------------------------------------------

time $DIR/deploy-admin-monitoring-services.sh

echo .
echo .
echo -------------------------------------------------------------
echo " Monitoring Services Deployed..."
echo -------------------------------------------------------------

SCRIPT_END_DATETIME=$(date '+%A %D %I:%M:%S:%N %Z')
  
echo .
echo .
echo -------------------------------------------------------------
echo " End - $ENVIRONMENT Admin Environment Up..."
echo "   - Script Start Time = $SCRIPT_START_DATETIME"
echo "   - Script End Time   = $SCRIPT_END_DATETIME"
echo ------------------------------------------------------------
