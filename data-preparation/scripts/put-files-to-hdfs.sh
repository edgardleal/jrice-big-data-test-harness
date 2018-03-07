SOURCE_FILE_DIR=/home/vagrant/git/jrice-big-data-test-harness/apps/stack-overflow-spark-app/src/main/resources/sample-xml-files/devops.stackexchange.com
TARGET_HDFS_DIR=hdfs:/user/pentaho/big-data-files/stackexchange/devops

hdfs dfs -put $SOURCE_FILE_DIR/Badges.xml $TARGET_HDFS_DIR/Badges.xml
hdfs dfs -put $SOURCE_FILE_DIR/Comments.xml $TARGET_HDFS_DIR/Comments.xml
hdfs dfs -put $SOURCE_FILE_DIR/PostHistory.xml $TARGET_HDFS_DIR/PostHistory.xml
hdfs dfs -put $SOURCE_FILE_DIR/PostLinks.xml $TARGET_HDFS_DIR/PostLinks.xml
hdfs dfs -put $SOURCE_FILE_DIR/Posts.xml $TARGET_HDFS_DIR/Posts.xml
hdfs dfs -put $SOURCE_FILE_DIR/Tags.xml $TARGET_HDFS_DIR/Tags.xml
hdfs dfs -put $SOURCE_FILE_DIR/Users.xml $TARGET_HDFS_DIR/Users.xml
hdfs dfs -put $SOURCE_FILE_DIR/Votes.xml $TARGET_HDFS_DIR/Votes.xml

