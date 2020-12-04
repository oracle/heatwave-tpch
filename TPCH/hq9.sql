-- Copyright (c) 2020, Oracle and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

-- Coypright (c) 2020, Transaction Processing Performance Council

-- TPC-H Query 9 - Product Type Profit Measure
SELECT /*+ set_var(use_secondary_engine=forced) */  
    nation, o_year, SUM(amount) AS sum_profit
FROM
    (SELECT 
        n_name AS nation,
            YEAR(o_ORDERdate) AS o_year,
            l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity AS amount
    FROM
        PART
    STRAIGHT_JOIN PARTSUPP
    STRAIGHT_JOIN LINEITEM
    STRAIGHT_JOIN SUPPLIER
    STRAIGHT_JOIN ORDERS
    STRAIGHT_JOIN NATION
    WHERE
        s_suppkey = l_suppkey
            AND ps_suppkey = l_suppkey
            AND ps_partkey = l_partkey
            AND p_partkey = l_partkey
            AND o_ORDERkey = l_ORDERkey
            AND s_nationkey = n_nationkey
            AND p_name LIKE '%green%') AS profit
GROUP BY nation , o_year
ORDER BY nation , o_year DESC;