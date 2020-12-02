# MySQL Analytics Engine TPC-H

MySQL Database Service Analytics Engine (MySQL Analytics Engine) is a fully
managed and highly scalable in-memory database service which provides a
cost-efficient solution for SQL analytic processing. It is tightly integrated
with MySQL database and is optimized for Oracle Cloud Infrastructure.

You can run analytics on Your MySQL data without requiring ETL and without any
change to Your applications. Your applications connect to MySQL Analytics cluster
through standard MySQL protocols, and You can manage MySQL Analytics Engine via
Oracle Cloud REST APIs, SDKs, and the Console.

This repository contains SQL scripts derived from [TPC Benchmark&trade;H (TPC-H)][1].
The SQL scripts contain TPC-H schema generation statements and queries derived
from TPC-H benchmark, specific for MySQL Database Service and MySQL Analytics Engine.

## Software prerequisites:
1. [TPC-H data generation tool][2] to generate TPC-H dataset for workload sizes of your choice
2. [MySQL Shell][3] to import generated TPC-H dataset to MySQL Database Service

## Required services:
1. [Oracle Cloud Infrastructure][8]
2. [MySQL Database Service][4] and [MySQL Analytics Engine][5]

## Repository

* [`TPCH`](./TPCH) - a collection of scripts for TPC-H schema and queries specific to MySQL Database Service
* [`MySQLAnalyticsEngine`](./MySQLAnalyticsEngine) - a collection of scripts to configure MySQL Analytics Engine to run TPC-H queries

## Getting started

To run TPC-H queries in MySQL Analytics:

1. Generate TPC-H data using TPC-H data generation tool
2. Provision MySQL Database Service instance. See [Getting Started with MySQL Database Service][6]
3. Run [`create_tables.sql`](TPCH/create_tables.sql) to create TPC-H schema on MySQL Database Service instance
4. Import TPC-H data generated to MySQL Database Service instance. See [MySQL Shell Parallel Table Import Utility documentation][7]
5. Add a MySQL Analytics cluster to MySQL Database Service instance. See [MySQL Analytics Engine][5] documentation
6. Run [`secondary_load.sql`](MySQLAnalyticsEngine/secondary_load.sql) to configure and load data to MySQL Analytics cluster
7. You are now ready to run the queries derived from TPC-H


[1]: http://www.tpc.org/tpch/
[2]: http://www.tpc.org/tpc_documents_current_versions/download_programs/tools-download-request5.asp?bm_type=TPC-H&bm_vers=2.18.0&mode=CURRENT-ONLY
[3]: https://dev.mysql.com/downloads/shell/
[4]: https://docs.cloud.oracle.com/en-us/iaas/mysql-database/index.html
[5]: https://docs.cloud.oracle.com/en-us/iaas/mysql-database/doc/mysql-analytics-engine.html
[6]: https://docs.cloud.oracle.com/en-us/iaas/mysql-database/doc/getting-started.html
[7]: https://dev.mysql.com/doc/mysql-shell/8.0/en/mysql-shell-utilities-parallel-table.html
[8]: https://docs.cloud.oracle.com/en-us/iaas/Content/home.htm

TPC Benchmark&trade;, TPC-H, QppH, QthH, and QphH are trademarks of the Transaction Processing Performance
Council.

All parties are granted permission to copy and distribute to any party without fee all or part of this material provided
that: 1) copying and distribution is done for the primary purpose of disseminating TPC material; 2) the TPC
copyright notice, the title of the publication, and its date appear, and notice is given that copying is by permission of
the Transaction Processing Performance Council.

Benchmark queries are derived from the TPC-H benchmark, but results are not
comparable to published TPC-H benchmark results since they do not comply with
the TPC-H specification.
