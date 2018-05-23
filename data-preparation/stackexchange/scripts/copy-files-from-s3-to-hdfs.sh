EXCHANGE_TYPE=$1

SOURCE_S3_BUCKET_NAME=big-dataset-stackexchange
SOURCE_S3_FOLDER_NAME=uncompressed/$EXCHANGE_TYPE.7z
TARGET_HDFS_DIR=hdfs:/user/pentaho/big-data-files/stackexchange/uncompressed/$EXCHANGE_TYPE

hdfs dfs -mkdir -p $TARGET_HDFS_DIR

time s3-dist-cp --src s3://$SOURCE_S3_BUCKET_NAME/$SOURCE_S3_FOLDER_NAME/ --dest $TARGET_HDFS_DIR