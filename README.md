# sql-healthcare-data-modeling
Hospital Operations SQL Data Modeling Project

This project demonstrates end-to-end dimensional data modeling using SQL and SQLite.
The goal is to design a star schema optimized for analytics, reporting, and KPI tracking in a hospital setting.

This project highlights skills in:
- Data modeling (star schema)
- Fact & dimension design
- ERD creation
- SQL querying (joins, CTEs, aggregations)
- Building analysis-ready datasets
- Documentation & analytics engineering fundamentals

📊 Schema Overview

Dimension Tables:
- dim_patient
- dim_department
- dim_provider
- dim_date
  
Fact Table:
- fact_encounter — stores encounter-level metrics such as charges, length of stay, and department/provider relationships.

See erd.png for the visual entity-relationship diagram.

🧱 Files in This Repository

- schema.sql ->	           SQL code for creating all tables in the star schema
- sample_data.sql ->	       Inserts sample values for demonstration and testing
- queries.sql ->	           Analytical SQL queries using joins, CTEs, and aggregations
- erd.png ->	               Exported ERD diagram showing table relationships
- LICENSE ->	               MIT License
- README.md ->	             Project documentation

🗄️ Technologies Used
- SQLite
- SQL (joins, CTEs, aggregations, modeling)
- dbdiagram.io (ERD creation)
- VS Code
- Git / GitHub

✨ Example Analytical Queries
This project includes SQL queries answering common hospital analytics questions:

1. Average Charges by Department
   
SELECT d.department_name, AVG(f.total_charges) AS avg_charges
FROM fact_encounter f
JOIN dim_department d ON f.department_id = d.department_id
GROUP BY d.department_name;

2. Encounters Per Provider
   
SELECT p.provider_name, COUNT(*) AS encounter_count
FROM fact_encounter f
JOIN dim_provider p ON f.provider_id = p.provider_id
GROUP BY p.provider_name;

3. Daily Encounter & Revenue Summary
   
SELECT dd.date_value, COUNT(*) AS total_encounters, SUM(f.total_charges) AS total_revenue
FROM fact_encounter f
JOIN dim_date dd ON f.date_id = dd.date_id
GROUP BY dd.date_value;

🔥 Goals of This Project
- Demonstrate dimensional modeling skills
- Build a clean star schema optimized for BI tools
- Show SQL capability beyond simple queries
- Prepare for analytics engineering and data engineering roles
- Create a professional portfolio project for recruiters

📁 How to Run This Project
- Install SQLite or open a GUI (DB Browser or DBeaver).
- Run schema.sql to create all tables.
- Run sample_data.sql to load test data.
- Run queries.sql to execute analytical queries.

📄 License
This project is open-sourced under the MIT License.
