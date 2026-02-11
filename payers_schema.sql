-- STEP 1 --
-- this step lets SQLITE auto create the staging table from the csv file --
DROP TABLE IF EXISTS stg_payers;
.mode csv
.import payers.csv stg_payers

-- STEP 2 --
-- this is to confirm if the table was created and the data was imported cleanly (no double header) --
.tables
SELECT * FROM stg_payers LIMIT 5;
SELECT COUNT(*) FROM stg_payers;

-- STEP 3 --
-- this is to check the columns in the staging table
.schema stg_payers
SELECT * FROM stg_payers LIMIT 3;

-- this is to create the dimension table --
CREATE TABLE IF NOT EXISTS dim_payer (
  payer_key INTEGER PRIMARY KEY,
  payer_id_src TEXT,
  name TEXT,
  city TEXT,
  state_headquartered TEXT,
  zip TEXT
);


-- STEP 4 --
-- this is to populate the dimension table:
-- it's taking the columns from the staging table and insert them to the dimension table, one row for each unique patient --
INSERT INTO dim_payer (
  payer_id_src,
  name,
  city,
  state_headquartered,
  zip
)
SELECT DISTINCT
  Id,
  NAME,
  CITY,
  STATE_HEADQUARTERED,
  ZIP
FROM stg_payers;


