SPARK_HOME=/usr/lib/spark
SPARK_CMD=$SPARK_HOME/bin/spark-submit

SPARK_CLASS="com.pentaho.bigdata.spark.stackoverflow.StackOverflowSparkDriver"
SPARK_DRIVER_JAR=stackoverview-app-8.1.0.0-SNAPSHOT.jar
SPARK_EXECUTOR_CORES=5
SPARK_NUM_EXECUTORS=12
SPARK_EXECUTOR_MEMORY=6g
SPARK_METRICS_PROPERTIES_FILE=metrics.properties

time $SPARK_CMD --packages com.databricks:spark-xml_2.11:0.4.1,com.databricks:spark-avro_2.11:4.0.0 --class $SPARK_CLASS --master yarn --executor-cores $SPARK_EXECUTOR_CORES --num-executors $SPARK_NUM_EXECUTORS --driver-memory 3g --executor-memory $SPARK_EXECUTOR_MEMORY --files=./$SPARK_METRICS_PROPERTIES_FILE --conf spark.metrics.conf=$SPARK_METRICS_PROPERTIES_FILE $SPARK_DRIVER_JAR
