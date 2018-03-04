SPARK_HOME=/opt/spark-2.2.0-bin-hadoop2.7
SPARK_CMD=$SPARK_HOME/bin/spark-submit

SPARK_CLASS="com.pentaho.bigdata.spark.stackoverflow.StackOverflowSparkDriver"
SPARK_DRIVER_JAR=../target/stackoverview-app-8.1.0.0-SNAPSHOT.jar

time $SPARK_CMD --packages com.databricks:spark-xml_2.11:0.4.1 --class $SPARK_CLASS --master local[*] $SPARK_DRIVER_JAR
