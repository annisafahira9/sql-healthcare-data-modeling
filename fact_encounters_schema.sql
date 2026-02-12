CREATE TABLE fact_encounter (
  encounter_key INTEGER PRIMARY KEY,   -- surrogate key
  encounter_id_src TEXT,               -- original Id from stg_encounters

  patient_key INTEGER,
  organization_key INTEGER,
  payer_key INTEGER,
  encounter_class_key INTEGER,
  reason_key INTEGER,
  start_date_key INTEGER,
  stop_date_key INTEGER,

  base_encounter_cost REAL,
  total_claim_cost REAL,
  payer_coverage REAL
);

INSERT INTO fact_encounter (
  encounter_id_src,
  patient_key,
  organization_key,
  payer_key,
  encounter_class_key,
  reason_key,
  start_date_key,
  stop_date_key,
  base_encounter_cost,
  total_claim_cost,
  payer_coverage
)
SELECT
  e.Id AS encounter_id_src,
  dp.patient_key,
  do.organization_key,
  dpa.payer_key,
  dec.encounter_class_key,
  dr.reason_key,
  dstart.date_key AS start_date_key,
  dstop.date_key AS stop_date_key,
  e.BASE_ENCOUNTER_COST,
  e.TOTAL_CLAIM_COST,
  e.PAYER_COVERAGE
FROM stg_encounters e

-- patient
LEFT JOIN dim_patient dp
  ON e.PATIENT = dp.patient_id_src

-- organization (hospital/clinic)
LEFT JOIN dim_organization do
  ON e.ORGANIZATION = do.organization_id_src

-- payer (insurance)
LEFT JOIN dim_payer dpa
  ON e.PAYER = dpa.payer_id_src

-- encounter class (ambulatory, emergency, etc.)
LEFT JOIN dim_encounter_class dec
  ON e.ENCOUNTERCLASS = dec.encounter_class_name

-- reason (diagnosis driving the encounter)
LEFT JOIN dim_reason dr
  ON e.REASONCODE = dr.reason_code

-- start date
LEFT JOIN dim_date dstart
  ON substr(e.START, 1, 10) = dstart.date_value

-- stop date
LEFT JOIN dim_date dstop
  ON substr(e.STOP, 1, 10) = dstop.date_value;
