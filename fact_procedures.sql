DROP TABLE IF EXISTS stg_procedures;
.mode csv
.import procedures.csv stg_procedures


DROP TABLE IF EXISTS dim_procedure;

CREATE TABLE dim_procedure (
  procedure_key INTEGER PRIMARY KEY,
  procedure_code TEXT,
  procedure_description TEXT
);

INSERT INTO dim_procedure (procedure_code, procedure_description)
SELECT DISTINCT
  CODE,
  DESCRIPTION
FROM stg_procedures
WHERE CODE IS NOT NULL
  AND TRIM(CODE) <> '';

CREATE INDEX IF NOT EXISTS idx_dim_procedure_code
  ON dim_procedure (procedure_code);

DROP TABLE IF EXISTS fact_procedure;

CREATE TABLE fact_procedure (
  procedure_event_key INTEGER PRIMARY KEY,
  encounter_id_src TEXT,
  patient_key INTEGER,
  procedure_key INTEGER,
  reason_key INTEGER,
  start_date_key INTEGER,
  stop_date_key INTEGER,
  base_cost REAL
);

INSERT INTO fact_procedure (
  encounter_id_src,
  patient_key,
  procedure_key,
  reason_key,
  start_date_key,
  stop_date_key,
  base_cost
)
SELECT
  p.ENCOUNTER,
  dp.patient_key,
  dproc.procedure_key,
  dr.reason_key,
  dstart.date_key,
  dstop.date_key,
  p.BASE_COST
FROM stg_procedures p

LEFT JOIN dim_patient dp
  ON p.PATIENT = dp.patient_id_src

LEFT JOIN dim_procedure dproc
  ON p.CODE = dproc.procedure_code

LEFT JOIN dim_reason dr
  ON p.REASONCODE = dr.reason_code

LEFT JOIN dim_date dstart
  ON substr(p.START, 1, 10) = dstart.date_value

LEFT JOIN dim_date dstop
  ON substr(p.STOP, 1, 10) = dstop.date_value;
