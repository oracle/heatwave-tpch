-- Copyright (c) 2020, Oracle and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

-- Coypright (c) 2020, Transaction Processing Performance Council

-- TPC-H Query 18 - Large Volume Customer
SELECT /*+ JOIN_SUFFIX(l, o, c) set_var(use_secondary_engine=forced) */  
    C_NAME,
    C_CUSTKEY,
    O_ORDERKEY,
    O_ORDERDATE,
    O_TOTALPRICE,
    SUM(L_QUANTITY)
FROM
    CUSTOMER c,
    ORDERS o,
    LINEITEM l
WHERE
    O_ORDERKEY IN (SELECT 
            L_ORDERKEY
        FROM
            LINEITEM
        GROUP BY L_ORDERKEY
        HAVING SUM(L_QUANTITY) > 300)
        AND C_CUSTKEY = O_CUSTKEY
        AND O_ORDERKEY = L_ORDERKEY
GROUP BY C_NAME , C_CUSTKEY , O_ORDERKEY , O_ORDERDATE , O_TOTALPRICE
ORDER BY O_TOTALPRICE DESC , O_ORDERDATE
LIMIT 100;
