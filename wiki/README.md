#Pentaho Big Data Test Harness - Wiki

##Unstructured Notes

###Queries to Perform

###Prometheus Queries

**Tasks**
sum(executor_tasks{application="$application_ID", qty!~"maxPool_size"}) by (qty)