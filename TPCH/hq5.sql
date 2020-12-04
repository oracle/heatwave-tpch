-- Copyright (c) 2020, Oracle and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

-- Coypright (c) 2020, Transaction Processing Performance Council

-- TPC-H Query 5 - Local Supplier Volume
SELECT /*+ set_var(use_secondary_engine=forced) */  
    n_name, SUM(l_extendedprice * (1 - l_discount)) AS revenue
FROM
    ORDERS
        STRAIGHT_JOIN
    LINEITEM
        STRAIGHT_JOIN
    CUSTOMER
        STRAIGHT_JOIN
    SUPPLIER
        STRAIGHT_JOIN
    NATION
        STRAIGHT_JOIN
    REGION
WHERE
    c_custkey = o_custkey
        AND l_orderkey = o_orderkey
        AND l_suppkey = s_suppkey
        AND c_nationkey = s_nationkey
        AND s_nationkey = n_nationkey
        AND n_regionkey = r_regionkey
        AND r_name = 'ASIA'
        AND o_orderdate >= DATE '1994-01-01'
        AND o_orderdate < DATE '1994-01-01' + INTERVAL '1' YEAR
GROUP BY n_name
ORDER BY revenue DESC;