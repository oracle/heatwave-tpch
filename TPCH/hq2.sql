-- Copyright (c) 2020, Oracle and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

-- Coypright (c) 2020, Transaction Processing Performance Council

-- TPC-H Query 2 - Minimum Cost Supplier Query
SELECT /*+ SET_VAR(use_secondary_engine=forced) */ 
   s_acctbal, s_name, n_name, p_partkey, p_mfgr, 
       s_address, s_phone, s_comment
FROM 
     PART STRAIGHT_JOIN PARTSUPP ON p_partkey = ps_partkey 
     STRAIGHT_JOIN SUPPLIER ON s_suppkey = ps_suppkey 
     STRAIGHT_JOIN NATION ON s_nationkey = n_nationkey
     STRAIGHT_JOIN REGION ON n_regionkey = r_regionkey 
WHERE 
     p_size = 15  
     AND p_type LIKE '%BRASS'  
     AND r_name = 'EUROPE'  
     AND ps_supplycost = ( 
             SELECT 
                 MIN(ps_supplycost)  
             FROM 
                 PARTSUPP STRAIGHT_JOIN SUPPLIER 
                              ON s_suppkey = ps_suppkey
                 STRAIGHT_JOIN NATION 
                          ON  s_nationkey = n_nationkey 
                 STRAIGHT_JOIN REGION 
                          ON n_regionkey = r_regionkey 
             WHERE 
                 p_partkey = ps_partkey 
                 AND r_name = 'EUROPE'  
    ) 
 ORDER BY 
    s_acctbal desc, n_name, s_name, p_partkey LIMIT 100;
