-- Copyright (c) 2022, Oralce and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

-- data placement
alter table LINEITEM secondary_engine NULL;
alter table LINEITEM change L_ORDERKEY L_ORDERKEY BIGINT NOT NULL COMMENT 'RAPID_COLUMN=DATA_PLACEMENT_KEY=1';
alter table LINEITEM secondary_engine RAPID;

alter table LINEITEM secondary_load;
alter table ORDERS secondary_load;
alter table CUSTOMER secondary_load;
alter table SUPPLIER secondary_load;
alter table NATION secondary_load;
alter table REGION secondary_load;
alter table PART secondary_load;
alter table PARTSUPP secondary_load;
