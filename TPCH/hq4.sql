-- Copyright (c) 2020, Oracle and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

-- Coypright (c) 2020, Transaction Processing Performance Council

-- TPC-H Query 4 - Order Priority Checking
SELECT  
    O_ORDERPRIORITY, COUNT(*) AS ORDER_COUNT
FROM
    ORDERS
WHERE
    O_ORDERDATE >= DATE '1994-03-01'
    AND O_ORDERDATE < DATE '1994-03-01' + INTERVAL '3' MONTH
    AND EXISTS( SELECT 
          *
        FROM
           LINEITEM
        WHERE
            L_ORDERKEY = O_ORDERKEY
            AND L_COMMITDATE < L_RECEIPTDATE)
GROUP BY O_ORDERPRIORITY
ORDER BY O_ORDERPRIORITY;