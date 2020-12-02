-- Copyright (c) 2020, Oracle and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

SELECT /*+ set_var(use_secondary_engine=forced) */  
    PS_PARTKEY, SUM(PS_SUPPLYCOST * PS_AVAILQTY) AS VALUE
FROM
    NATION
        STRAIGHT_JOIN
    SUPPLIER
        STRAIGHT_JOIN
    PARTSUPP
WHERE
    PS_SUPPKEY = S_SUPPKEY
        AND S_NATIONKEY = N_NATIONKEY
        AND N_NAME = 'GERMANY'
GROUP BY PS_PARTKEY
HAVING SUM(PS_SUPPLYCOST * PS_AVAILQTY) > (SELECT 
        SUM(PS_SUPPLYCOST * PS_AVAILQTY) * 0.0001
    FROM
        NATION
            STRAIGHT_JOIN
        SUPPLIER
            STRAIGHT_JOIN
        PARTSUPP
    WHERE
        PS_SUPPKEY = S_SUPPKEY
            AND S_NATIONKEY = N_NATIONKEY
            AND N_NAME = 'GERMANY')
ORDER BY VALUE DESC;