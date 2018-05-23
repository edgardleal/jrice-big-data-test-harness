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
export ENVIRONMENT_SIZE=medium
export EMR_CLUSTER_CORE_INSTANCE_COUNT=2

cd $TERRAFORM_DIR

SCRIPT_START_DATETIME=$(date '+%A %D %I:%M:%S:%N %Z')

echo .
echo .
echo -------------------------------------------------------------
echo " Start - Destroy $ENVIRONMENT Environment ..."
echo "   - environment               = $ENVIRONMENT"
echo "   - environment-domain-prefix = $ENVIRONMENT_DOMAIN_PREFIX"
echo "   - Script Start Time         = $SCRIPT_START_DATETIME"
echo -------------------------------------------------------------

time terraform destroy \
  -var "environment=$ENVIRONMENT" \
  -var "environment-domain-prefix=$ENVIRONMENT_DOMAIN_PREFIX" \
  -var "environment-size=$ENVIRONMENT_SIZE" \
  -var "emr-cluster-core-instance-count=$EMR_CLUSTER_CORE_INSTANCE_COUNT"

SCRIPT_END_DATETIME=$(date '+%A %D %I:%M:%S:%N %Z')
  
echo .
echo .
echo -------------------------------------------------------------
echo " End - $ENVIRONMENT Environment Plan..."
echo "   - Script Start Time = $SCRIPT_START_DATETIME"
echo "   - Script End Time   = $SCRIPT_END_DATETIME"
echo ------------------------------------------------------------
