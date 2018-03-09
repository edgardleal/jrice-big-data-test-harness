# *********************************************************************************
# Description: Builds a docker image for this node app
# Author:      Joe Rice
# Created:     10/14/2016
#
# Notes:
#    Uses the Dockerfile in this same git repo
# *********************************************************************************

DIR="$(cd "$(dirname "$0")" && pwd)"

source $DIR/setenv.sh

echo .
echo .
echo -------------------------------------------------------------
echo   Building BDTH Prometheus Docker Image...
echo ------------------------------------------------

REPO_NAME=$BDTH_GLOBAL_DOCKER_REPO_NAME
IMAGE_NAME=$BDTH_GLOBAL_IMAGE_NAME_PREFIX_ADMIN-prometheus
IMAGE_VERSION=1.0.0
IMAGE_TAG_VERSION=$IMAGE_VERSION
IMAGE_TAG_LAGEST=latest

cd $BDTH_ADMIN_DOCKER_MONITORING_DIR/prometheus

time sudo docker build \
   -t $REPO_NAME/$IMAGE_NAME:$IMAGE_TAG_VERSION \
   -t $REPO_NAME/$IMAGE_NAME:$IMAGE_TAG_LAGEST \
   .

echo .
echo .
echo -------------------------------------------------------------
echo   Pushing Jarch Prometheus Docker Image to Registry...
echo ------------------------------------------------

time sudo docker push \
    $REPO_NAME/$IMAGE_NAME