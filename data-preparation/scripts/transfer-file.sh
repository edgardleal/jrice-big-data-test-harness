KEY_FILE_PATH=/home/devuser/sandbox/jrice/jra-build.pem
REMOTE_HOST=54.157.198.161
REMOTE_DATA_DIR=/home/ubuntu/big-data-datasets/stack-exchange
LOCAL_DATA_DIR=/home/devuser/sandbox/jrice/big-data-data-sets/stack-exchange


scp -i $KEY_FILE_PATH -r $LOCAL_DATA_DIR/$1 ubuntu@$REMOTE_HOST:$REMOTE_DATA_DIR/$1
