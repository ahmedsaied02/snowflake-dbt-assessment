# Snowflake dbt Assessment

This repository contains my solution to the **Data Engineer Assessment (dbt with Snowflake)**.  
It demonstrates the use of dbt to build a modern analytics pipeline on top of Snowflake using the TPCH sample dataset.

---

## Project Setup

### 1. Prerequisites
- **Snowflake account** (trial or enterprise) with access to `SNOWFLAKE_SAMPLE_DATA.TPCH_SF1`.
- **Warehouse**: `DEV_WH` (X-Small, auto-suspend 60 seconds).  
- **Database**: `DEV`  
- **Schema**: `ANALYTICS`  

### 2. Running the project

#### Option A: dbt Cloud (recommended)
1. Connect dbt Cloud to Snowflake with the following settings:
   - Warehouse: `DEV_WH`
   - Database: `DEV`
   - Schema: `ANALYTICS`
   - Role: `ACCOUNTADMIN` or `SYSADMIN`
2. Connect dbt Cloud project to this GitHub repo.
3. In dbt Cloud IDE, run:
   ```bash
   dbt run
   dbt test
   dbt docs generate
4. Click View Documentation to explore the catalog and lineage.
-------------------------
#### Option B: dbt CLI

1. Clone the repo:
    ```bash
    git clone https://github.com/<your-username>/snowflake-dbt-assessment.git
    cd snowflake-dbt-assessment
2. Install dbt:
   ```bash
   pip install dbt-snowflake
3. Configure your profiles.yml with your Snowflake account details.
4. Run the models and tests:
   ```bash
    dbt run
    dbt test
    dbt docs generate
    dbt docs serve
------------------------
## Project Structure
  ```bash
      models/
        ├── sources.yml              
        ├── staging/
        │   └── stg_orders.sql      
        └── marts/
            ├── customer_revenue.sql           
            ├── customer_revenue_by_year.sql    
            └── customer_revenue_by_nation.sql
```
-----------------------
## Tests

  1. stg_orders.order_key: unique, not_null
  
  2. customer_revenue.cust_key: not_null
  
  3. customer_revenue_by_year: cust_key, order_year → not_null
  
  4. customer_revenue_by_nation: cust_key, nation_name → not_null

---------------------
## Documentation

Run dbt docs generate and dbt docs serve to open an interactive documentation site.

Includes:

  Source documentation for TPCH tables.

  Column-level documentation for all staging and mart models.

  Lineage graph from raw sources → staging → marts.

--------------------
## Assumptions

The TPCH sample data is available in SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.

Staging models are materialized as views (always up-to-date, lightweight).

Mart models are materialized as tables (for performance and analytics).

Revenue is calculated as:
  ```bash
  l_extendedprice * (1 - l_discount)
  ```
Only core tables (CUSTOMER, ORDERS, LINEITEM, NATION) are required for the scope of this project.







