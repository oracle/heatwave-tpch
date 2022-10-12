# HeatWave TPC-H

MySQL HeatWave is a fully managed and highly scalable in-memory database service which provides a cost-efficient solution for 
OLTP, OLAP and Machine Learning. It is available on both Oracle Cloud Infrastructure (OCI) and Amazon Web Service (AWS).

HeatWave is tightly integrated with MySQL database and is optimized for underlying infrastructure.
You can run analytics on your MySQL data without requiring ETL and without any change to Your applications. Your 
applications connect to the HeatWave cluster through standard MySQL protocols.
The MySQL Database is built on the MySQL Enterprise Edition Server, which allows developers to quickly create and deploy secure 
cloud native applications using the world's most popular open source database. 

MySQL HeatWave Lakehouse extends MySQL HeatWave to enable you to run analytics workloads on data stored in object storage 
at 100s of TB data scale. HeatWave Lakehouse provides the same high query performance as MySQL HeatWave, enables you to run 
queries across data from both MySQL and object storage, providing a great solution for your data warehouse and data lake use cases.

This repository contains SQL scripts derived from [TPC Benchmark&trade;H (TPC-H)][1]. The SQL scripts contain TPC-H schema
generation statements and queries derived from TPC-H benchmark, specific for MySQL HeatWave and MySQL HeatWave Lakehouse.

## Software prerequisites:
1. [TPC-H data generation tool][2] to generate TPC-H dataset for workload sizes of your choice
2. [MySQL Shell][3] to import generated TPC-H dataset to MySQL Database System

## Required services:
1. [Oracle Cloud Infrastructure][9]
2. [MySQL HeatWave for OCI][4] or [MySQL HeatWave on AWS][5]

## Repository
* [TPCH](TPCH) - a collection of scripts for TPC-H schema and queries specific to MySQL Database System
* [HeatWave](HeatWave) - a collection of scripts to configure HeatWave to run TPC-H queries

## Getting started
### To run TPC-H queries in HeatWave
1. Generate TPC-H data using TPC-H data generation tool
2. Provision a MySQL Database System
3. Run [create_tables.sql](TPCH/create_tables.sql) to create TPC-H schema on MySQL Database System
4. Import TPC-H data generated to MySQL Database System. See [MySQL Shell Parallel Table Import Utility documentation][7]
5. Add a HeatWave cluster to MySQL Database System. See [HeatWave][8] documentation
6. Run [secondary_load.sql](HeatWave/secondary_load.sql) to configure and load data to HeatWave cluster
7. You are now ready to run the queries derived from TPC-H


### To run TPC-H queries in MySQL HeatWave Lakehouse
1. Generate TPC-H data using TPC-H data generation tool
2. Keep the generated data in an Object Store bucket in OCI (in the same region where the MySQL Database System will be provisioned. 
   Note down the namespace and bucket information.
3. Provision a MySQL Database System. See [Getting Started with MySQL Database Service][6]
4. Add a HeatWave cluster to MySQL Database System. See [HeatWave][8] documentation
5. Run [create_tables_lakehouse.sql](TPCH/create_tables_lakehouse.sql) to create TPC-H schema for MySQL HeatWave Lakehouse on MySQL Database System. 
   Make sure to fill in the appropriate **\<region\>**, **\<namespace\>**, **\<bucket\>** and **\<name\>** information in the script. 
6. Run [secondary_load_lakehouse.sql](HeatWave/secondary_load_lakehouse.sql) to configure and load data to HeatWave cluster
7. You are now ready to run the queries derived from TPC-H

[1]: http://www.tpc.org/tpch/
[2]: http://www.tpc.org/tpc_documents_current_versions/download_programs/tools-download-request5.asp?bm_type=TPC-H&bm_vers=2.18.0&mode=CURRENT-ONLY
[3]: https://dev.mysql.com/downloads/shell/
[4]: https://docs.oracle.com/en-us/iaas/mysql-database/doc/heatwave.html
[5]: https://dev.mysql.com/doc/heatwave-aws/en/
[6]: https://docs.cloud.oracle.com/en-us/iaas/mysql-database/doc/getting-started.html
[7]: https://dev.mysql.com/doc/mysql-shell/8.0/en/mysql-shell-utilities-parallel-table.html
[8]: https://docs.cloud.oracle.com/en-us/iaas/mysql-database/doc/mysql-analytics-engine.html
[9]: https://docs.cloud.oracle.com/en-us/iaas/Content/home.htm

TPC Benchmark&trade;, TPC-H, QppH, QthH, and QphH are trademarks of the Transaction Processing Performance
Council.

All parties are granted permission to copy and distribute to any party without fee all or part of this material provided
that: 1) copying and distribution is done for the primary purpose of disseminating TPC material; 2) the TPC
copyright notice, the title of the publication, and its date appear, and notice is given that copying is by permission of
the Transaction Processing Performance Council.

Benchmark queries are derived from the TPC-H benchmark, but results are not comparable to published TPC-H benchmark results since they do not comply with the TPC-H specification.
