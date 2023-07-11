-- Copyright (c) 2020, Oracle and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

-- Coypright (c) 2020, Transaction Processing Performance Council

-- TPC-H Query 16 - Parts/Suppplier Relationship
SELECT   
    P_BRAND,
    P_TYPE,
    P_SIZE,
    COUNT(DISTINCT PS_SUPPKEY) AS SUPPLIER_CNT
FROM
    PARTSUPP,
    PART
WHERE
    P_PARTKEY = PS_PARTKEY
    AND P_BRAND <> 'Brand#45'
    AND P_TYPE NOT LIKE 'MEDIUM POLISHED%'
    AND P_SIZE IN (49 , 14, 23, 45, 19, 3, 36, 9)
    AND PS_SUPPKEY NOT IN (SELECT 
            S_SUPPKEY
        FROM
            SUPPLIER
        WHERE
            S_COMMENT LIKE '%Customer%Complaints%')
GROUP BY P_BRAND , P_TYPE , P_SIZE
ORDER BY SUPPLIER_CNT DESC , P_BRAND , P_TYPE , P_SIZE;