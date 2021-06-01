-- Copyright (c) 2020, Oracle and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

-- Coypright (c) 2020, Transaction Processing Performance Council

-- TPCH Query 17 - Small-Quantity-Order-Revenue Query
SELECT /*+ SET_VAR(use_secondary_engine=forced) */
    SUM(l_extendedprice) / 7.0 AS avg_yearly
FROM 
    PART STRAIGHT_JOIN LINEITEM ON p_partkey = l_partkey 
WHERE 
    p_brand = 'Brand#23'  
    AND p_container = 'MED BOX'  
    AND l_quantity < (  
              SELECT 
                  0.2 * AVG(l_quantity)  
              FROM 
                  LINEITEM  
              WHERE 
                  l_partkey = p_partkey
              );