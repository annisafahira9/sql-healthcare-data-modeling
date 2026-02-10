-- STEP 1 --
-- this step lets SQLITE auto create the staging table from the csv file --
DROP TABLE IF EXISTS stg_patients;
.mode csv
.import patients.csv stg_patients

-- STEP 2 --
-- this is to confirm if the table was created and the data was imported cleanly (no double header) --
.tables
SELECT * FROM stg_patients LIMIT 5;
SELECT COUNT(*) FROM stg_patients;

-- STEP 3 --
-- this is to create the dimension table --
CREATE TABLE dim_patient (
  patient_key INTEGER PRIMARY KEY,
  patient_id_src TEXT,
  first_name TEXT,
  last_name TEXT,
  gender TEXT,
  race TEXT,
  ethnicity TEXT,
  birthdate TEXT,
  city TEXT,
  state TEXT,
  zip TEXT,
  marital_status TEXT
);

-- STEP 4 --
-- this is to populate the dimension table:
-- it's taking the columns from the staging table and insert them to the dimension table, one row for each unique patient --
INSERT INTO dim_patient (
  patient_id_src,
  first_name,
  last_name,
  gender,
  race,
  ethnicity,
  birthdate,
  city,
  state,
  zip,
  marital_status
)
SELECT DISTINCT
  Id,
  FIRST,
  LAST,
  GENDER,
  RACE,
  ETHNICITY,
  BIRTHDATE,
  CITY,
  STATE,
  ZIP,
  MARITAL
FROM stg_patients;
