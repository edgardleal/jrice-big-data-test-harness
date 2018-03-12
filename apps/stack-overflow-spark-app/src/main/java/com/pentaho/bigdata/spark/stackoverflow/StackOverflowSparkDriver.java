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
  private final static String BADGES_XML_FILE = "Badges.xml";
  private final static String COMMENTS_XML_FILE = "Comments.xml";
  private final static String POST_HISTORY_XML_FILE =
    "PostHistory.xml";
  private final static String POST_LINKS_XML_FILE =
    "PostLinks.xml";
  private final static String POSTS_XML_FILE = "Posts.xml";
  private final static String TAGS_XML_FILE = "Tags.xml";
  private final static String USERS_XML_FILE = "Users.xml";
  private final static String VOTES_XML_FILE = "Votes.xml";

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

    String inDir = "s3://big-dataset-stackexchange/uncompressed/serverfault.com.7z";
    String outDir = "s3://big-dataset-stackexchange/avro/serverfault.com";

    Dataset<Row> badgesDataFrame = loadXmlSource( spark, inDir, outDir, BADGES_XML_FILE, BADGES_TABLE_NAME );
    Dataset<Row> commentsDataFrame = loadXmlSource( spark, inDir, outDir, COMMENTS_XML_FILE, COMMENTS_TABLE_NAME );
    Dataset<Row> postHistoryDataFrame = loadXmlSource( spark, inDir, outDir, POST_HISTORY_XML_FILE, POST_HISTORY_TABLE_NAME );
    Dataset<Row> postLinksDataFrame = loadXmlSource( spark, inDir, outDir, POST_LINKS_XML_FILE, POST_LINKS_TABLE_NAME );
    Dataset<Row> PostsDataFrame = loadXmlSource( spark, inDir, outDir, POSTS_XML_FILE, POSTS_TABLE_NAME );
    Dataset<Row> tagsDataFrame = loadXmlSource( spark, inDir, outDir, TAGS_XML_FILE, TAGS_TABLE_NAME );
    Dataset<Row> usersDataFrame = loadXmlSource( spark, inDir, outDir, USERS_XML_FILE, USERS_TABLE_NAME );
    Dataset<Row> votesDataFrame = loadXmlSource( spark, inDir, outDir, VOTES_XML_FILE, VOTES_TABLE_NAME );

//    executeUserLocationQuery( spark );

//    executeTopPostsByUserQuery( spark );
  }

  protected static void executeUserLocationQuery( SparkSession spark ) {
    String sqlQuery =
      "SELECT  _Location as Location, "
        + "  count(_Id) as numOfUsers, "
        + "  min(_Age) as minAge, "
        + "  max(_Age) as maxAge, "
        + "  max(_Reputation) as maxRep "
        + " FROM  " + USERS_TABLE_NAME
        + " GROUP BY Location "
        + " ORDER BY numOfUsers DESC, Location";

    Dataset<Row> topLocationsDf = spark.sql( sqlQuery );

    System.out.println( "\n\n\n\n\nexecuteUserLocationQuery\n\n");

    //    topLocationsDf.show( 200 );
  }

  protected static void executeTopPostsByUserQuery( SparkSession spark ) {
    String sqlQuery =
      "SELECT  users._Id as userId, "
        + "    users._DisplayName as displayName, "
        + "    users._Location as location, "
        + "    users._Reputation as reputation, "
        + "    count(distinct posts._Id) as numOfPosts, "
        + "    count(distinct comments._Id) as numOfComments, "
        + "    max(posts._ViewCount) as maxPostViews, "
        + "    max(comments._Score) as maxCommentsScore "
        + " FROM  " + USERS_TABLE_NAME + " AS users,"
        + "       " + POSTS_TABLE_NAME + " AS posts,"
        + "       " + COMMENTS_TABLE_NAME + " AS comments"
        + " WHERE users._Id = posts._OwnerUserId "
        + "   AND users._Id = comments._UserId"
        + " GROUP BY users._Id, "
        + "          users._DisplayName, "
        + "          users._Location, "
        + "          users._Reputation "
        + " ORDER BY numOfPosts DESC, "
        + "          users._Id  ";

    Dataset<Row> topLocationsDf = spark.sql( sqlQuery );

    System.out.println( "\n\n\n\n\nexecuteTopPostsByUserQuery\n\n");

    topLocationsDf.show( 200 );
  }

  protected static Dataset<Row> loadXmlSource( SparkSession spark, String inDir, String outDir, String XmlFileName, String tableName ) {
    String sourceTableName = tableName + "_src";

    System.out.println( "\n\n\n\n\nLoading XML File: " + inDir + "/" + XmlFileName + "\n\n");

    Dataset<Row> df = null;

    try {
      Dataset<Row> dataFrame = spark
        .read()
        .format( "com.databricks.spark.xml" )
        .option( "rowTag", tableName )
        .load( inDir + "/" + XmlFileName );

      // register the table
      dataFrame.registerTempTable( sourceTableName );
      dataFrame.cache();

      df = spark.sql( "Select explode(row) as row from " + sourceTableName );

      //    df.show();

      df = df.select( "row.*" );

      //    df.printSchema();
      //    df.show( 200 );

      // register the table
      df.registerTempTable( tableName );
      df.cache();

      System.out.println( "\n\nWriting Avro File: " + outDir + "/" + XmlFileName + "\n\n\n\n\n" );

      df.write()
        .format( "com.databricks.spark.avro" )
        .save( outDir + "/" + XmlFileName + ".avro" );
    } catch ( Exception e ) {
      System.out.println( "\n\n\n\n\nError trying to process XML:  " + e.getMessage());
      e.printStackTrace();
    }

    return df;
  }
}