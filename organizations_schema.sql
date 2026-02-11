-- STEP 1 --
-- this step lets SQLITE auto create the staging table from the csv file --
DROP TABLE IF EXISTS stg_organizations;
.mode csv
.import organizations.csv stg_organizations

-- STEP 2 --
-- this is to confirm if the table was created and the data was imported cleanly (no double header) --
.tables
SELECT * FROM stg_organizations LIMIT 5;
SELECT COUNT(*) FROM stg_organizations;

-- STEP 3 --
-- this is to create the dimension table --
CREATE TABLE IF NOT EXISTS dim_organization (
  organization_key INTEGER PRIMARY KEY,   -- warehouse key
  organization_id_src TEXT,               -- original Id from source data
  name TEXT,
  city TEXT,
  state TEXT,
  zip TEXT
);

-- STEP 4 --
-- this is to populate the dimension table:
-- it's taking the columns from the staging table and insert them to the dimension table, one row for each unique patient --
INSERT INTO dim_organization (
  organization_id_src,
  name,
  city,
  state,
  zip
)
SELECT DISTINCT
  Id,
  Name,
  City,
  State,
  Zip
FROM stg_organizations;
