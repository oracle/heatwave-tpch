-- Copyright (c) 2020, Oracle and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

-- Coypright (c) 2020, Transaction Processing Performance Council

-- TPC-H Query 11 - Important Stock Identification
SELECT  
    PS_PARTKEY, SUM(PS_SUPPLYCOST * PS_AVAILQTY) AS VALUE
FROM
    PARTSUPP,
    SUPPLIER,
    NATION
WHERE
    PS_SUPPKEY = S_SUPPKEY
    AND S_NATIONKEY = N_NATIONKEY
    AND N_NAME = 'GERMANY'
GROUP BY PS_PARTKEY
HAVING SUM(PS_SUPPLYCOST * PS_AVAILQTY) > (SELECT 
        SUM(PS_SUPPLYCOST * PS_AVAILQTY) * 0.0001
    FROM
        PARTSUPP,
        SUPPLIER,
        NATION
    WHERE
        PS_SUPPKEY = S_SUPPKEY
        AND S_NATIONKEY = N_NATIONKEY
        AND N_NAME = 'GERMANY')
ORDER BY VALUE DESC;