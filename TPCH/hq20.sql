-- Copyright (c) 2020, Oracle and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

-- Coypright (c) 2020, Transaction Processing Performance Council

-- TPCH Query 20 - Potential Part Promotions Query
SELECT /*+ SET_VAR(use_secondary_engine=forced) */ 
    s_name, s_address
FROM 
    SUPPLIER, 
    NATION  
WHERE 
    s_suppkey IN  (
       SELECT 
           ps_suppkey
       FROM 
           PART STRAIGHT_JOIN PARTSUPP ON ps_partkey = p_partkey  
       WHERE 
           p_name LIKE 'forest%' 
           AND ps_availqty  > (  
               SELECT 
                   0.5 * SUM(l_quantity)  
               FROM 
                   LINEITEM  
               WHERE 
                   l_partkey = ps_partkey   
                   AND l_suppkey = ps_suppkey 
                   AND l_shipdate >= '1994-01-01'  
                   AND l_shipdate < '1995-01-01' )  )
    AND s_nationkey = n_nationkey 
    AND n_name = 'CANADA'  
ORDER BY 
    s_name;
