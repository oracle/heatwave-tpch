-- Copyright (c) 2020, Oracle and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

SELECT /*+ set_var(use_secondary_engine=forced) */  
    c_count, COUNT(*) AS custdist
FROM
    (SELECT 
        c_custkey, COUNT(o_orderkey) AS c_count
    FROM
        CUSTOMER
    LEFT OUTER JOIN ORDERS ON (c_custkey = o_custkey
        AND o_comment NOT LIKE '%special%requests%')
    GROUP BY c_custkey) AS c_orders
GROUP BY c_count
ORDER BY custdist DESC , c_count DESC;