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
- dim date
- dim_encounter
- dim_organization
- dim_payer
- dim_procedure
- dim_reason
- dim_patient
  
Fact Table:
- fact_encounter — stores encounter-level metrics such as charges, length of stay, and department/provider relationships.
- fact_procedure - stores base cost as its only metrics 

See erd.png for the visual entity-relationship diagram.

🧱 Files in This Repository

- encounters_schema.sql
  organizations_schema.sql
  patients_schema.sql
  payers_schema.sql
  fact_encounters_schema.sql
  fact_procedures_schema.sql
 ->	           SQL code for creating all the dimension and fact tables in the star schema
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
1. Encounter volume and costs by month

2. Top encounter reasons by total cost

3. Procedure volume and base cost by month

4. Most common procedures and total base cost

🔥 Goals of This Project
- Demonstrate dimensional modeling skills
- Build a clean star schema optimized for BI tools
- Show SQL capability beyond simple queries

📁 How to Run This Project
- Install SQLite.
- Import ALL CSV files into staging tables using SQLite .import.
- Run ALL schema.sql files to create all tables.
- Run queries.sql to execute analytical queries.

📄 License
This project is open-sourced under the MIT License.
