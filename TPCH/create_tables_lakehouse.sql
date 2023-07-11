-- Copyright (c) 2022, Oracle and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0 as shown as https://oss.oracle.com/licences/upl

-- Copyright (c) 2022, Transaction Processing Performance Council

-- using database tpch_1024 as an example
-- ascii_bin character set and collation used for benchmarking performance

create database tpch_1024;
alter database tpch_1024 CHARACTER SET ascii COLLATE ascii_bin;
use tpch_1024;


-- Create lakehouse tables - source data in OCI object store

CREATE TABLE LINEITEM ( L_ORDERKEY    BIGINT NOT NULL, 
                        L_PARTKEY     INTEGER NOT NULL, 
                        L_SUPPKEY     INTEGER NOT NULL,
                        L_LINENUMBER  INTEGER NOT NULL, 
                        L_QUANTITY    DECIMAL(15,2) NOT NULL, 
                        L_EXTENDEDPRICE  DECIMAL(15,2) NOT NULL,
                        L_DISCOUNT    DECIMAL(15,2) NOT NULL, 
                        L_TAX         DECIMAL(15,2) NOT NULL,
                        L_RETURNFLAG  CHAR(1) NOT NULL,
                        L_LINESTATUS  CHAR(1) NOT NULL,
                        L_SHIPDATE    DATE NOT NULL, 
                        L_COMMITDATE  DATE NOT NULL,
                        L_RECEIPTDATE DATE NOT NULL, 
                        L_SHIPINSTRUCT CHAR(25) NOT NULL, 
                        L_SHIPMODE    CHAR(10) NOT NULL,
                        L_COMMENT     VARCHAR(44) NOT NULL, 
                        PRIMARY KEY (L_ORDERKEY, L_LINENUMBER))
ENGINE=datalake 
secondary_engine=rapid 
ENGINE_ATTRIBUTE='{"file": 
    [{"region":"<region>", 
       "namespace":"<namespace>", 
       "bucket":"<bucket_name>", 
       "name":"<lineitem_file_location>"}]}';


CREATE TABLE ORDERS  ( O_ORDERKEY       BIGINT NOT NULL, 
                       O_CUSTKEY        INTEGER NOT NULL, 
                       O_ORDERSTATUS    CHAR(1) NOT NULL,
                       O_TOTALPRICE     DECIMAL(15,2) NOT NULL,
                       O_ORDERDATE      DATE NOT NULL, 
                       O_ORDERPRIORITY  CHAR(15) NOT NULL,
                       O_CLERK          CHAR(15) NOT NULL,
                       O_SHIPPRIORITY   INTEGER NOT NULL,
                       O_COMMENT  VARCHAR(79) NOT NULL,
                       PRIMARY KEY (O_ORDERKEY))
ENGINE=datalake 
secondary_engine=rapid 
ENGINE_ATTRIBUTE='{"file": 
    [{"region":"<region>", 
      "namespace":"<namespace>", 
      "bucket":"<bucket_name>", 
      "name":"<orders_file_location>"}]}';


create table CUSTOMER ( C_CUSTKEY     INTEGER NOT NULL, 
                        C_NAME        VARCHAR(25) NOT NULL, 
                        C_ADDRESS     VARCHAR(40) NOT NULL, 
                        C_NATIONKEY   INTEGER NOT NULL,
                        C_PHONE       CHAR(15) NOT NULL, 
                        C_ACCTBAL     DECIMAL(15,2) NOT NULL, 
                        C_MKTSEGMENT  CHAR(10) NOT NULL, 
                        C_COMMENT     VARCHAR(117) NOT NULL, 
                        PRIMARY KEY (C_CUSTKEY)) 
ENGINE=datalake 
secondary_engine=rapid 
ENGINE_ATTRIBUTE='{"file": 
    [{"region":"<region>", 
      "namespace":"<namespace>", 
      "bucket":"<bucket_name>", 
      "name":"<customer_file_location>"}]}';


CREATE TABLE SUPPLIER ( S_SUPPKEY     INTEGER NOT NULL, 
                        S_NAME        CHAR(25) NOT NULL, 
                        S_ADDRESS     VARCHAR(40) NOT NULL,
                        S_NATIONKEY   INTEGER NOT NULL, 
                        S_PHONE       CHAR(15) NOT NULL, 
                        S_ACCTBAL     DECIMAL(15,2) NOT NULL,
                        S_COMMENT     VARCHAR(101) NOT NULL, 
                        PRIMARY KEY (S_SUPPKEY))
ENGINE=datalake 
secondary_engine=rapid 
ENGINE_ATTRIBUTE='{"file": 
    [{"region":"<region>", 
      "namespace":"<namespace>", 
      "bucket":"<bucket_name>", 
      "name":"<supplier_file_location>"}]}';


CREATE TABLE NATION ( N_NATIONKEY      INTEGER NOT NULL, 
                      N_NAME           CHAR(25) NOT NULL, 
                      N_REGIONKEY      INTEGER NOT NULL, 
                      N_COMMENT        VARCHAR(152) NOT NULL, 
                      PRIMARY KEY (N_NATIONKEY)) 
ENGINE=datalake 
secondary_engine=rapid 
ENGINE_ATTRIBUTE='{"file": 
    [{"region":"<region>", 
      "namespace":"<namespace>", 
      "bucket":"<bucket_name>", 
      "name":"<nation_file_location>"}]}';

CREATE TABLE REGION ( R_REGIONKEY       INTEGER NOT NULL, 
                      R_NAME            CHAR(25) NOT NULL, 
                      R_COMMENT         VARCHAR(152) NOT NULL, 
                      PRIMARY KEY (R_REGIONKEY)) 
ENGINE=datalake 
secondary_engine=rapid 
ENGINE_ATTRIBUTE='{"file": 
    [{"region":"<region>", 
      "namespace":"<namespace>", 
       "bucket":"<bucket_name>", 
       "name":"<region_file_location>"}]}';


CREATE TABLE PART  ( P_PARTKEY          INTEGER NOT NULL, 
                     P_NAME             VARCHAR(55) NOT NULL, 
                     P_MFGR             CHAR(25) NOT NULL,
                     P_BRAND            CHAR(10) NOT NULL, 
                     P_TYPE             VARCHAR(25) NOT NULL, 
                     P_SIZE             INTEGER NOT NULL,
                     P_CONTAINER        CHAR(10) NOT NULL,  
                     P_RETAILPRICE      DECIMAL(15,2) NOT NULL,
                     P_COMMENT          VARCHAR(23) NOT NULL, 
                     PRIMARY KEY (P_PARTKEY))
ENGINE=datalake 
secondary_engine=rapid 
ENGINE_ATTRIBUTE='{"file": 
    [{"region":"<region>", 
      "namespace":"<namespace>", 
      "bucket":"<bucket_name>", 
      "name":"<part_file_location>"}]}';


CREATE TABLE PARTSUPP ( PS_PARTKEY      INTEGER NOT NULL, 
                        PS_SUPPKEY      INTEGER NOT NULL, 
                        PS_AVAILQTY     INTEGER NOT NULL,
                        PS_SUPPLYCOST   DECIMAL(15,2)  NOT NULL, 
                        PS_COMMENT      VARCHAR(199) NOT NULL,
                        PRIMARY KEY (PS_PARTKEY, PS_SUPPKEY))
ENGINE=datalake 
secondary_engine=rapid 
ENGINE_ATTRIBUTE='{"file": 
    [{"region":"<region>",
      "namespace":"<namespace>", 
      "bucket":"<bucket_name>", 
      "name":"<partsupp_file_location>"}]}';







