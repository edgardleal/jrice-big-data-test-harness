export SCRIPTS_DIR="$(cd "$(dirname "$0")" && pwd)"

export BDTH_AWS_KEY_FILE_PATH=$AWS_KEY_FILE_PATH

export BDTH_EMR_PLAYBOOK_DIR=$SCRIPTS_DIR/../ansible
export BDTH_EMR_DOCKER_DIR=$SCRIPTS_DIR/../docker

#export BDTH_GLOBAL_DOCKER_REPO_NAME=joericearchitect
export BDTH_GLOBAL_DOCKER_REPO_NAME=nexus3.pentaho.com
export BDTH_GLOBAL_IMAGE_NAME_PREFIX_EMR=bdth-emr
export BDTH_DOMAIN_NAME=joericearchitect.com
