-- Copyright (c) 2020, Oracle and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

SELECT  /*+ set_var(use_secondary_engine=forced) */  
    100.00 * SUM(CASE
        WHEN p_type LIKE 'PROMO%' THEN l_extendedprice * (1 - l_discount)
        ELSE 0
    END) / SUM(l_extendedprice * (1 - l_discount)) AS promo_revenue
FROM
    LINEITEM,
    PART
WHERE
    l_partkey = p_partkey
        AND l_shipdate >= DATE '1995-09-01'
        AND l_shipdate < DATE '1995-09-01' + INTERVAL '1' MONTH;