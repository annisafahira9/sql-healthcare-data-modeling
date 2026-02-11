-- STEP 1 --
-- this step lets SQLITE auto create the staging table from the csv file --
DROP TABLE IF EXISTS stg_encounters;
.mode csv
.import encounters.csv stg_encounters

-- STEP 2 --
-- this is to confirm if the table was created and the data was imported cleanly (no double header) --
.tables
SELECT * FROM stg_encounters LIMIT 5;
SELECT COUNT(*) FROM stg_encounters;

-- STEP 3 --
-- this is to create the dimension table --
CREATE TABLE IF NOT EXISTS dim_encounter_class (
  encounter_class_key INTEGER PRIMARY KEY,
  encounter_class_name TEXT
);

-- STEP 4 --
-- this is to populate the dimension table:
-- it's taking the columns from the staging table and insert them to the dimension table, one row for each unique patient --
INSERT INTO dim_encounter_class (encounter_class_name)
SELECT DISTINCT
  ENCOUNTERCLASS
FROM stg_encounters
WHERE ENCOUNTERCLASS IS NOT NULL;

-- STEP 5 --
-- creating another table and populating from the same staging table --
DROP TABLE IF EXISTS dim_reason
CREATE TABLE IF NOT EXISTS dim_reason (
  reason_key INTEGER PRIMARY KEY,
  reason_code TEXT,
  reason_description TEXT
);

INSERT INTO dim_reason (
  reason_code,
  reason_description
)
SELECT DISTINCT
  REASONCODE,
  REASONDESCRIPTION
FROM stg_encounters
WHERE REASONCODE IS NOT NULL
AND TRIM(REASONCODE) <> ''; -- there was a bad row with empty strings

-- this is the query that shows where the empty row comes from in the staging table --
SELECT
  REASONCODE,
  REASONDESCRIPTION,
  COUNT(*) AS row_count
FROM stg_encounters
GROUP BY REASONCODE, REASONDESCRIPTION
HAVING REASONCODE IS NULL OR TRIM(REASONCODE) = '';

-- STEP 6 -- 
-- checking for the start and stop time
SELECT START, STOP
FROM stg_encounters
LIMIT 5;
-- only care for (YYYY-MM-DD) --
SELECT
  START,
  substr(START, 1, 10) AS start_date_only
FROM stg_encounters
LIMIT 5;

-- This is to create a date dimension from the staging encounter table --
CREATE TABLE dim_date (
  date_key INTEGER PRIMARY KEY,  -- e.g. 20110901
  date_value TEXT,               -- '2011-09-01'
  year INTEGER,
  month INTEGER,
  day INTEGER,
  day_of_week INTEGER,           -- 0=Sunday, 6=Saturday (SQLite default)
  month_name TEXT,
  day_name TEXT
);

-- this takes distinct dates from START and STOP
-- UNION so each date only appears once
-- substr(START,1,10) -> keeps only YYYY-MM-DD
-- strftime extracts year/month/day from each day
-- CAST(... AS INTEGER) turns TEXT into INTEGER

WITH all_dates AS (
  SELECT DISTINCT substr(START, 1, 10) AS date_value
  FROM stg_encounters
  WHERE START IS NOT NULL

  UNION

  SELECT DISTINCT substr(STOP, 1, 10) AS date_value
  FROM stg_encounters
  WHERE STOP IS NOT NULL
)

INSERT INTO dim_date (
  date_key,
  date_value,
  year,
  month,
  day,
  day_of_week,
  month_name,
  day_name
)
SELECT
  CAST(strftime('%Y%m%d', date_value) AS INTEGER)             AS date_key,
  date_value,
  CAST(strftime('%Y', date_value) AS INTEGER)                 AS year,
  CAST(strftime('%m', date_value) AS INTEGER)                 AS month,
  CAST(strftime('%d', date_value) AS INTEGER)                 AS day,
  CAST(strftime('%w', date_value) AS INTEGER)                 AS day_of_week,
  strftime('%m', date_value)                                  AS month_name,   -- '01', '02', ...
  strftime('%w', date_value)                                  AS day_name      -- '0'..'6', you can later map to names
FROM all_dates
WHERE date_value IS NOT NULL;

