# Pentaho Big Data Test Harness
A test harness for testing out Pentaho products across large data sets (>1TB)

This project contains scripts & code to test out Pentaho products at scale.  And monitoring tools to measure performance over time.

# Background

## Problems Addressed

Before diving into the details of this solution, let's look at the problems it addresses & the requirements it fulfils.

* Lack of ability to test Pentaho solutions at scale
  - Customers run our products on Terrabyte size data sets
  - But we test on small datasets (500 MB - 10GB)
  - Currently, we have no means to test our solutions against TB datasets before release.

* Lack of Empirical Data
  - How does AEL on Spark compare with running vanilla spark?  
  - How does it compare with running same on Pentaho Server or Worker Nodes?
  - Currently, we have no way quantifying the difference or measuring performance over time.


* Lack of ability to experiment
  - How do our products perform on 5-node cluster?  -Vs- 100-node cluster? –Vs- 1,000 node cluster?
  - How do they perform against GB of data, TB, PB?  
  - What’s the breaking point?
  - Currently, we have no way of quickly experimenting to answer those questionws without costing an arm and a leg.

## Requirements

Given the problems described earlier, the solution must:

* Allow us to test real-world large data sets (1TB+).
* Allow us to test using real-world large-scale Hadoop clusters (100 – 1,000 node clusters.  16+ GB RAM, tons of CPU cores)
* Allow us to monitor tests, record metrics, gather data that give insights to how our products perform.
* Allow us to compare results of different tests.
* Allow us to quickly experiment with different configurations with little effort.
* Not cost the size of a small government or army.

# Solution - Big Data Test Harness

## High-Level Overview

![alt text](wiki/Big Data Test Harness Architecture.png "Big Data Test Harness - High Level Diagram")

There are 3 major components to the Big Data Test Harness:

1. **Big Data Sets stored in S3** 
   - Real World Data Sets to test against are stored in AWS S3
   - This ensures we have TB+ of repeatable data to test against.
   
2. **AWS EMR Hadooop Ckluster** 
   - This is the cluster which runs workloads to test - Spark jobs, Pentaho / AEL Jobs, workner 
   - This cluster is provisioned dynamically each time a test is run.  And dstroyed each time a test ends.
   - Completely automated.  1 script builds out all infrastructure.
   - Number of VMs, CPU, Mem, Disk Size are all configurable.  Quickly experiment.
   - Spin up, run test, then spin down. Only pay for the few hours the test runs

3. **Logging & Monitoring Cluster**
   - Even though EMR workload clusters are ephemeral and only live for the life of the test, they generate metrics and logs and write them to a central logging / monitoring cluster.
   - Can view test results even after test cluster is terminated.  
   - Can compare and trend test results over time.
   
