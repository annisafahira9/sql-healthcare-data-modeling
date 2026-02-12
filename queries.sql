-- Encounters over time (volume + cost) --
SELECT
  d.year,
  d.month,
  COUNT(*) AS encounter_count,
  ROUND(SUM(COALESCE(fe.total_claim_cost, 0)), 2) AS total_claim_cost
FROM fact_encounter fe
JOIN dim_date d
  ON fe.start_date_key = d.date_key
GROUP BY d.year, d.month
ORDER BY d.year, d.month;

-- Top 10 encounter reasons by total cost --
SELECT
  dr.reason_description,
  COUNT(*) AS encounter_count,
  ROUND(SUM(COALESCE(fe.total_claim_cost, 0)), 2) AS total_cost
FROM fact_encounter fe
JOIN dim_reason dr
  ON fe.reason_key = dr.reason_key
GROUP BY dr.reason_description
ORDER BY total_cost DESC
LIMIT 10;

-- Procedures over time (volume + base cost) --
SELECT
  d.year,
  d.month,
  COUNT(*) AS procedure_count,
  ROUND(SUM(COALESCE(fp.base_cost, 0)), 2) AS total_procedure_base_cost
FROM fact_procedure fp
JOIN dim_date d
  ON fp.start_date_key = d.date_key
GROUP BY d.year, d.month
ORDER BY d.year, d.month;

-- Top 15 procedures by frequency + base cost --
SELECT
  dp.procedure_description,
  COUNT(*) AS procedure_count,
  ROUND(SUM(COALESCE(fp.base_cost, 0)), 2) AS total_base_cost
FROM fact_procedure fp
JOIN dim_procedure dp
  ON fp.procedure_key = dp.procedure_key
GROUP BY dp.procedure_description
ORDER BY procedure_count DESC
LIMIT 15;
