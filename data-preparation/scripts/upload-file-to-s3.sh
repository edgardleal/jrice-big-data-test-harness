DATA_SOURCE_DIR=/home/ubuntu/big-data-datasets/stack-exchange-uncompressed
S3_BUCKET_NAME=big-dataset-stackexchange
S3_FOLDER_NAME=compressed


time aws s3 cp $DATA_SOURCE_DIR/ s3://$S3_BUCKET_NAME/$S3_FOLDER_NAME/ --recursive