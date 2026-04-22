# SQL Scripts — ICE Entertainment Data Warehouse

## Overview
This folder contains all SQL scripts used to build the ICE Entertainment dimensional data warehouse. Scripts are numbered and must be executed in the order listed below. The warehouse uses two databases — `stg` for the staging layer and `dw` for the dimensional model.

---

## Folder Structure

```
SQL Scripts/
├── 01_create_database.sql          — Create the dw database
├── 02_Staging_database.sql         — Staging database + all 26 staging tables
├── 03_checking_stg_data_load.sql   — Row count verification for staging layer
├── 04_dim_database.sql             — Complete DW schema (all dimensions + fact tables)
├── 05_checking_dim_data_load.sql   — DW dimension verification queries
├── 5_question_query.sql            — Five analytical queries (Deliverable 3)
└── 5 Question Query/               — Individual query files (one per business question)
    ├── Profit by Day.sql
    ├── Quarter analysis.sql
    ├── fiscal period analyse.sql
    ├── fiscal quarter.sql
    ├── fiscal year analysis.sql
    ├── monthly profit.sql
    ├── store analysis1.sql
    ├── store analysis2.sql
    ├── weekly profit.sql
    └── year analysis.sql
```

---

## Execution Order

> ⚠️ Scripts must be executed in the numbered order below. Running out of sequence will cause foreign key constraint errors.

| # | File | Database | Description |
|---|---|---|---|
| 1 | `01_create_database.sql` | `dw` | Creates the `dw` database |
| 2 | `02_Staging_database.sql` | `stg` | Creates `stg` database + all 26 staging tables |
| — | *(Run Stage_ETL in Pentaho)* | `stg` | Loads source Excel data into staging tables |
| 3 | `03_checking_stg_data_load.sql` | `stg` | Verifies all staging table row counts |
| 4 | `04_dim_database.sql` | `dw` | Creates all dimension tables + fact tables |
| — | *(Run dim_date stored procedure)* | `dw` | `CALL dw.populate_dim_date('1998-01-01', '2026-12-31')` |
| — | *(Run DW ETL in Pentaho)* | `dw` | Loads all dimension and fact tables |
| 5 | `05_checking_dim_data_load.sql` | `dw` | Verifies all DW table row counts and null checks |
| 6 | `5_question_query.sql` | `dw` | Runs all five analytical queries (Deliverable 3) |

---

## Script Descriptions

### `01_create_database.sql`
Creates the `dw` database.

```sql
CREATE DATABASE dw;
```

---

### `02_Staging_database.sql`
Creates the `stg` database and all 26 staging tables as a clean mirror of the source Excel files. All tables are dropped and recreated on each run.

**Staging tables created:**

| Table | Source File | Rows |
|---|---|---|
| `stg_order_details` | Order_Details.xlsx | 50,000 |
| `stg_order_header` | Order_Header.xlsx | 17,000 |
| `stg_customer` | Customer.xlsx | 5,000 |
| `stg_store` | Store.xlsx | 500 |
| `stg_product` | Product.xlsx | 1,000 |
| `stg_subscription` | Subscription.xlsx | 3,000 |
| `stg_currency_rate` | Currency_Rate.xlsx | 369 |
| `stg_currency` | Currency.xlsx | 175 |
| `stg_occupation` | Occupation.xlsx | 101 |
| `stg_product_type` | Product_Type.xlsx | 65 |
| `stg_interest` | Interest.xlsx | 38 |
| `stg_package` | Package.xlsx | 24 |
| `stg_region` | Region.xlsx | 14 |
| `stg_house_hold_income` | House_Hold_Income.xlsx | 11 |
| `stg_state` | State.xlsx | 8 |
| `stg_channel` | Channel.xlsx | 6 |
| `stg_package_type` | Package_Type.xlsx | 6 |
| `stg_product_status` | Product_Status.xlsx | 4 |
| `stg_customer_status` | Customer_Status.xlsx | 4 |
| `stg_division` | Division.xlsx | 3 |
| `stg_product_category` | Product_Category.xlsx | 3 |
| `stg_customer_type` | Customer_Type.xlsx | 3 |
| `stg_address_type` | Address_Type.xlsx | 2 |
| `stg_email_address_type` | Email_Address_Type.xlsx | 2 |
| `stg_permission` | Permission.xlsx | 2 |
| `stg_phone_number_type` | Phone_Number_Type.xlsx | 2 |
| **Total** | | **76,166** |

---

### `03_checking_stg_data_load.sql`
Post-ETL verification — counts rows across all 26 staging tables in a single `UNION ALL` query. Run immediately after the Stage_ETL Pentaho transformation to confirm all data loaded correctly.

---

### `04_dim_database.sql`
Creates the complete DW schema. Drops all existing tables in the correct order (fact tables first, then dimensions) before recreating them. Includes all foreign key constraints.

**DW tables created:**

| Table | Type | Rows | Description |
|---|---|---|---|
| `dim_date` | Dimension | 10,592 | Calendar + fiscal date attributes (1998–2026) |
| `dim_customer` | Dimension (SCD Type 2) | 5,000 | Customer demographics with address at time of sale |
| `dim_market` | Dimension (SCD Type 2) | 3 | Victoria / Rest of Australia / International |
| `dim_product` | Dimension | 1,000 | Product catalogue across Music, Films, Audio Books |
| `dim_store` | Dimension | 500 | Store locations with full geographic hierarchy |
| `dim_subscription` | Dimension | 3,000 | Customer subscription records |
| `dim_package` | Dimension | 3,000 | Subscription package details |
| `dim_currency` | Dimension | 422 | Monthly FX rates to USD (8 currencies) |
| `fact_sales` | Fact | 50,000 | One row per order line item |
| `fact_subscription` | Fact | 3,000 | One row per subscription |

**Dimensional Model — Star Schema:**

```
                    dim_date
                       |
dim_customer ─── fact_sales ─── dim_product
                       |
dim_store ─────────────┤
                       |
dim_currency ──────────┤
                       |
dim_subscription ──────┤
                       |
dim_market ────────────┘

dim_customer ─── fact_subscription ─── dim_subscription
                       |
dim_date ──────────────┤
                       |
dim_package ───────────┘
```

**fact_sales measures:**

| Column | Formula | Description |
|---|---|---|
| `qty` | — | Units sold |
| `price` | — | Selling price per unit in local currency |
| `unit_cost` | — | Cost per unit in local currency |
| `exchange_rate` | — | FX rate applied for USD conversion |
| `dollar_sales_usd` | `qty × price × exchange_rate` | Revenue in USD |
| `cost_usd` | `qty × unit_cost × exchange_rate` | Cost in USD |
| `margin_usd` | `dollar_sales_usd − cost_usd` | Gross margin in USD |

---

### `05_checking_dim_data_load.sql`
Post-ETL DW verification — checks row counts, distributions and null values across all dimension tables. Run after all Pentaho DW ETL transformations complete.

**Expected results:**

| Check | Expected |
|---|---|
| dim_date rows | 10,592 |
| dim_customer rows | 5,000 |
| dim_market rows | 3 |
| dim_product rows | 1,000 |
| dim_store rows | 500 |
| dim_subscription rows | 3,000 |
| dim_package rows | 3,000 |
| dim_currency rows | 422 |
| fact_sales rows | 50,000 |
| fact_subscription rows | 3,000 |
| All null key checks | 0 |

---

### `5_question_query.sql`
Five analytical SQL queries addressing the five business questions from the case study (Deliverable 3). All queries run against the `dw` database and join fact tables to dimension tables using surrogate keys.

| Query | Business Question | Key Dimensions |
|---|---|---|
| 1 | Who are the key customers? | dim_customer, dim_date |
| 2 | Which products are most profitable? | dim_product, dim_date (with seasons) |
| 3 | Which stores are most profitable? | dim_store, dim_date |
| 4 | Which time periods are most profitable? | dim_date (daily/weekly/monthly/quarterly/yearly/fiscal) |
| 5 | Which market is most profitable? | dim_market, dim_date |

---

## Database Summary

| Database | Layer | Tables | Total Rows |
|---|---|---|---|
| `stg` | Staging | 26 staging tables | 76,166 |
| `dw` | Warehouse | 8 dimensions + 2 fact tables | ~73,000 |

---

## Dependencies
- MySQL 8.0+
- Pentaho Data Integration (PDI/Spoon) v11.0.0.0-237
- Scripts must run in numbered order — FK constraints will fail otherwise
- `dim_date` stored procedure must be called after `04_dim_database.sql`
- All dimension ETL transformations must complete before `load_fact_sales` runs
- `dim_currency` must have exactly 422 rows (53 per currency × 8 currencies) before fact load
