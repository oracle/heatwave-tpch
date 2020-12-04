-- Copyright (c) 2020, Oracle and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

-- Coypright (c) 2020, Transaction Processing Performance Council

-- TPC-H Query 8 - National Market Share
SELECT /*+ set_var(use_secondary_engine=forced) */   
    o_year,
    SUM(CASE
        WHEN nation = 'BRAZIL' THEN volume
        ELSE 0
    END) / SUM(volume) AS mkt_share
FROM
    (SELECT 
        EXTRACT(YEAR FROM o_orderdate) AS o_year,
            l_extendedprice * (1 - l_discount) AS volume,
            n2.n_name AS nation
    FROM
        PART
    STRAIGHT_JOIN LINEITEM
    STRAIGHT_JOIN SUPPLIER
    STRAIGHT_JOIN ORDERS
    STRAIGHT_JOIN CUSTOMER
    STRAIGHT_JOIN NATION n1
    STRAIGHT_JOIN NATION n2
    STRAIGHT_JOIN REGION
    WHERE
        p_partkey = l_partkey
            AND s_suppkey = l_suppkey
            AND l_orderkey = o_orderkey
            AND o_custkey = c_custkey
            AND c_nationkey = n1.n_nationkey
            AND n1.n_regionkey = r_regionkey
            AND r_name = 'AMERICA'
            AND s_nationkey = n2.n_nationkey
            AND o_orderdate BETWEEN DATE '1995-01-01' AND DATE '1996-12-31'
            AND p_type = 'ECONOMY ANODIZED STEEL') AS all_nations
GROUP BY o_year
ORDER BY o_year;