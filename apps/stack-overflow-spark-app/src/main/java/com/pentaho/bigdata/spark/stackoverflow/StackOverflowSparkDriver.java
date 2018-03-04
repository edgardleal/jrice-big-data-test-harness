package com.pentaho.bigdata.spark.stackoverflow;

import org.apache.spark.SparkContext;
import org.apache.spark.api.java.JavaSparkContext;
import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.SparkSession;

/**
 * Prototype class to demonstrate the use of Spark SQL DataFrames and Select Group By queries to do Group By
 * aggregations against data.
 * <p>
 * This class will read in sales data from csv file, transforms it to JavaRDDs, then transoforms it into Spark SQL
 * Dataframes, then run Select Group By SQL queries against the data and shows results.
 * <p>
 * Joe Rice 2/3/2018
 */
public class StackOverflowSparkDriver {
  private final static String BADGES_XML_FILE = "file:/home/vagrant/git/jrice-big-data-test-harness/apps/stack-overflow-spark-app/src/main/resources/sample-xml-files/devops.stackexchange.com/Badges.xml";
  private final static String COMMENTS_XML_FILE = "file:/home/vagrant/git/jrice-big-data-test-harness/apps/stack-overflow-spark-app/src/main/resources/sample-xml-files/devops.stackexchange.com/Comments.xml";
  private final static String POST_HISTORY_XML_FILE = "file:/home/vagrant/git/jrice-big-data-test-harness/apps/stack-overflow-spark-app/src/main/resources/sample-xml-files/devops.stackexchange.com/PostHistory.xml";
  private final static String POST_LINKS_XML_FILE = "file:/home/vagrant/git/jrice-big-data-test-harness/apps/stack-overflow-spark-app/src/main/resources/sample-xml-files/devops.stackexchange.com/PostLinks.xml";
  private final static String POSTS_XML_FILE = "file:/home/vagrant/git/jrice-big-data-test-harness/apps/stack-overflow-spark-app/src/main/resources/sample-xml-files/devops.stackexchange.com/Posts.xml";
  private final static String TAGS_XML_FILE = "file:/home/vagrant/git/jrice-big-data-test-harness/apps/stack-overflow-spark-app/src/main/resources/sample-xml-files/devops.stackexchange.com/Tags.xml";
  private final static String USERS_XML_FILE = "file:/home/vagrant/git/jrice-big-data-test-harness/apps/stack-overflow-spark-app/src/main/resources/sample-xml-files/devops.stackexchange.com/Users.xml";
  private final static String VOTES_XML_FILE = "file:/home/vagrant/git/jrice-big-data-test-harness/apps/stack-overflow-spark-app/src/main/resources/sample-xml-files/devops.stackexchange.com/Votes.xml";

  private final static String BADGES_TABLE_NAME = "badges";
  private final static String COMMENTS_TABLE_NAME = "comments";
  private final static String POST_HISTORY_TABLE_NAME = "posthistory";
  private final static String POST_LINKS_TABLE_NAME = "postlinks";
  private final static String POSTS_TABLE_NAME = "posts";
  private final static String TAGS_TABLE_NAME = "tags";
  private final static String USERS_TABLE_NAME = "users";
  private final static String VOTES_TABLE_NAME = "votes";

  public static void main( String[] args ) {
    // Get a Spark Session - Spark Session is the main entrypoint for all Spark SQL Operations
    SparkSession spark = SparkSession
      .builder()
      .appName( "StackOverflowSparkDriver" )
      .getOrCreate();

    // Get the SparkContext object from the Spark Session and convert it into a JavaSparkContext object.
    SparkContext sc = spark.sparkContext();
    JavaSparkContext jsc = JavaSparkContext.fromSparkContext( sc );

    Dataset<Row> badgesDataFrame = loadXmlSource( spark, BADGES_XML_FILE, BADGES_TABLE_NAME, "badges" );
    Dataset<Row> commentsDataFrame = loadXmlSource( spark, COMMENTS_XML_FILE, COMMENTS_TABLE_NAME, "comments" );
    Dataset<Row> postHistoryDataFrame = loadXmlSource( spark, POST_HISTORY_XML_FILE, POST_HISTORY_TABLE_NAME );
    Dataset<Row> postLinksDataFrame = loadXmlSource( spark, POST_LINKS_XML_FILE, POST_LINKS_TABLE_NAME );
    Dataset<Row> PostsDataFrame = loadXmlSource( spark, POSTS_XML_FILE, POSTS_TABLE_NAME );
    Dataset<Row> tagsDataFrame = loadXmlSource( spark, TAGS_XML_FILE, TAGS_TABLE_NAME );
    Dataset<Row> usersDataFrame = loadXmlSource( spark, USERS_XML_FILE, USERS_TABLE_NAME );
    Dataset<Row> votesDataFrame = loadXmlSource( spark, VOTES_XML_FILE, VOTES_TABLE_NAME );

    String sqlQuery =
      "SELECT  _Location as Location, "
        + "  count(_Id) as numOfUsers, "
        + "  min(_Age) as minAge, "
        + "  max(_Age) as maxAge, "
        + "  max(_Reputation) as maxRep "
        + " FROM  " + USERS_TABLE_NAME
        + " GROUP BY Location "
        + " ORDER BY numOfUsers DESC, Location";

    Dataset<Row>  topLocationsDf = spark.sql( sqlQuery );

    topLocationsDf.show();
  }

  protected static Dataset<Row> loadXmlSource(SparkSession spark, String XmlFileName, String tableName) {
    return loadXmlSource( spark, XmlFileName, tableName, null );
  }
  protected static Dataset<Row> loadXmlSource(SparkSession spark, String XmlFileName, String tableName, String rootElement) {
    String sourceTableName = tableName + "_src";

    Dataset<Row> dataFrame = spark
      .read()
      .format( "com.databricks.spark.xml" )
      .option("rowTag", tableName)
      .load( XmlFileName );

    System.out.println( "\n\n\nPrinting Schema and Table for " + sourceTableName );
    // Print the sales data schema to the console.
//    dataFrame.printSchema();
//
//    // Print 100 rows of sales data Dataframe to the console.
//    dataFrame.show( 100 );

    // register the table
    dataFrame.registerTempTable( sourceTableName );

    Dataset<Row> df = null;

    df = spark.sql( "Select explode(row) as row from " + sourceTableName);

//    df.show();

    df = df.select( "row.*" );

    df.printSchema();
    df.show(200);

    // register the table
    df.registerTempTable( tableName );

    return df;
  }
}