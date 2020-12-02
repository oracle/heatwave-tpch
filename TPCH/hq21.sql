-- Copyright (c) 2020, Oracle and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

SELECT /*+ set_var(use_secondary_engine=forced) */  
    S_NAME, COUNT(*) AS NUMWAIT
FROM
    NATION
        STRAIGHT_JOIN
    SUPPLIER
        STRAIGHT_JOIN
    LINEITEM L1
        STRAIGHT_JOIN
    ORDERS
WHERE
    S_SUPPKEY = L1.L_SUPPKEY
        AND O_ORDERKEY = L1.L_ORDERKEY
        AND O_ORDERSTATUS = 'F'
        AND L1.L_RECEIPTDATE > L1.L_COMMITDATE
        AND EXISTS( SELECT 
            *
        FROM
            LINEITEM L2
        WHERE
            L2.L_ORDERKEY = L1.L_ORDERKEY
                AND L2.L_SUPPKEY <> L1.L_SUPPKEY)
        AND NOT EXISTS( SELECT 
            *
        FROM
            LINEITEM L3
        WHERE
            L3.L_ORDERKEY = L1.L_ORDERKEY
                AND L3.L_SUPPKEY <> L1.L_SUPPKEY
                AND L3.L_RECEIPTDATE > L3.L_COMMITDATE)
        AND S_NATIONKEY = N_NATIONKEY
        AND N_NAME = 'SAUDI ARABIA'
GROUP BY S_NAME
ORDER BY NUMWAIT DESC , S_NAME
LIMIT 100;