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

- encounters_schema.sql,
  organizations_schema.sql,
  patients_schema.sql,
  payers_schema.sql,
  fact_encounters_schema.sql,
  fact_procedures_schema.sql
 ->	           SQL code for creating all the dimension and fact tables in the star schema
- queries.sql ->	           Analytical SQL queries using joins, CTEs, and aggregations
- erd_diagram.png ->	               Exported ERD diagram showing table relationships
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
1. Encounter byvolume and costs by month

   <img width="356" height="1393" alt="Screenshot 2026-02-11 at 10 40 32 PM" src="https://github.com/user-attachments/assets/1f2c3c39-ff40-47b2-bd40-e756b79180f5" />

2. Top encounter reasons by total cost

<img width="740" height="307" alt="Screenshot 2026-02-11 at 10 42 05 PM" src="https://github.com/user-attachments/assets/4b93cc91-9a41-4f14-876a-f402dc0bf4b8" />

4. Procedure volume and base cost by month
<img width="420" height="684" alt="Screenshot 2026-02-11 at 10 43 08 PM" src="https://github.com/user-attachments/assets/bf4a3453-c5c6-4671-9e99-1c86e8a3615e" />
<img width="430" height="706" alt="Screenshot 2026-02-11 at 10 44 13 PM" src="https://github.com/user-attachments/assets/4c9f9e08-a9bd-468c-ba0a-5cc0c64cfeab" />

5. Most common procedures and total base cost
<img width="829" height="440" alt="Screenshot 2026-02-11 at 10 45 27 PM" src="https://github.com/user-attachments/assets/a7cacc70-5394-4b85-9491-da8db0c2c422" />

🔥 Goals of This Project
- Demonstrate dimensional modeling skills
- Build a clean star schema optimized for BI tools
- Show SQL capability beyond simple queries

📁 How to Run This Project
- Install SQLite.
- Import ALL CSV files into staging tables using SQLite .import
- Run ALL schema.sql files to create all tables.
- Run queries.sql to execute analytical queries.

📄 License
This project is open-sourced under the MIT License.
