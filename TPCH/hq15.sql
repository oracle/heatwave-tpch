-- Copyright (c) 2020, Oracle and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

-- Coypright (c) 2020, Transaction Processing Performance Council

-- TPC-H Query 15 - Top Supplier Query
WITH REVENUE0 AS (
	SELECT 
		L_SUPPKEY AS SUPPLIER_NO,
		SUM(L_EXTENDEDPRICE * (1 - L_DISCOUNT)) AS TOTAL_REVENUE
	FROM
		LINEITEM
	WHERE
		L_SHIPDATE >= DATE '1996-01-01'
			AND L_SHIPDATE < DATE_ADD(DATE '1996-01-01',
			INTERVAL 3 MONTH)
	GROUP BY L_SUPPKEY
) 
SELECT  /*+ set_var(use_secondary_engine=forced) */  
    S_SUPPKEY, S_NAME, S_ADDRESS, S_PHONE, TOTAL_REVENUE
FROM
    SUPPLIER,
    REVENUE0
WHERE
    S_SUPPKEY = SUPPLIER_NO
        AND TOTAL_REVENUE = (SELECT 
            MAX(TOTAL_REVENUE)
        FROM
            REVENUE0)
ORDER BY S_SUPPKEY;