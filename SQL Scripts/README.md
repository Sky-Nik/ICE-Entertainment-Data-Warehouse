# SQL Scripts

## Overview
This folder contains all SQL scripts used to build the ICE Entertainment dimensional data warehouse. Scripts are numbered and must be executed in order. The warehouse uses two databases — `stg` for the staging layer and `dw` for the dimensional model.

---

## Folder Structure
```
SQL Scripts/
├── 01_create_database.sql          -- Create the dw database
├── 02_dim_date.sql                 -- Date dimension table + stored procedure
├── 03_dim_customer.sql             -- Customer dimension (SCD Type 2)
├── 04_dim_product.sql              -- Product dimension
├── 05_dim_store.sql                -- Store dimension with geographic hierarchy
├── 06_dim_subscription.sql         -- Subscription dimension
├── 07_dim_currency.sql             -- Currency dimension with exchange rates
├── 08_fact_sales.sql               -- Central fact table with all foreign keys
├── 09_staging_database.sql         -- Staging database + all stg_ tables
└── 10_stg_data_check_count.sql     -- Row count verification for staging layer
```

---

## Execution Order

> ⚠️ Scripts must be executed in the numbered order below. Running out of sequence will cause foreign key constraint errors.

| # | File | Database | Description |
|---|---|---|---|
| 1 | `01_create_database.sql` | `dw` | Creates the `dw` database |
| 2 | `02_dim_date.sql` | `dw` | Creates and populates `dim_date` (10,592 rows) |
| 3 | `03_dim_customer.sql` | `dw` | Creates `dim_customer` |
| 4 | `04_dim_product.sql` | `dw` | Creates `dim_product` |
| 5 | `05_dim_store.sql` | `dw` | Creates `dim_store` |
| 6 | `06_dim_subscription.sql` | `dw` | Creates `dim_subscription` |
| 7 | `07_dim_currency.sql` | `dw` | Creates `dim_currency` |
| 8 | `08_fact_sales.sql` | `dw` | Creates `fact_sales` with all FK constraints |
| 9 | `09_staging_database.sql` | `stg` | Creates `stg` database + all 13 staging tables |
| — | *(Run Stage_ETL in Pentaho)* | `stg` | Loads source Excel data into staging tables |
| 10 | `10_stg_data_check_count.sql` | `stg` | Verifies all staging table row counts |

---

## Script Descriptions

### `01_create_database.sql`
Creates the `dw` database and includes a validation query to confirm `dim_date` has been populated correctly after running script 02.

```sql
CREATE DATABASE dw;
```

---

### `02_dim_date.sql`
Creates the `dim_date` table and a stored procedure `populate_dim_date` that generates one row per calendar day from **1998-01-01 to 2026-12-31** (10,592 rows total).

**Key columns:**

| Column | Description |
|---|---|
| `date_key` | Surrogate key (auto increment) |
| `sql_date` | Standard SQL date |
| `day_name` | Full day name (e.g. Monday) |
| `month_name` | Full month name (e.g. January) |
| `quarter` | Calendar quarter (Q1–Q4) |
| `year` | Calendar year |
| `fiscal_week` | Week number within fiscal year |
| `fiscal_period` | Fiscal period using 4-5-4 pattern (FP01–FP13) |
| `fiscal_quarter` | Fiscal quarter (FQ1–FQ4) |
| `fiscal_year` | Fiscal year label (e.g. FY2025) |
| `week_day` | 1 = weekday (Mon–Fri), 0 = weekend |
| `month_end` | 1 = last day of calendar month |
| `period_end` | 1 = last day of fiscal period |

**Fiscal year definition:** 1 September – 31 August
(e.g. FY2025 = 1 Sep 2024 to 31 Aug 2025)

**Indexes created:**
- `dim_date_sql_date` (unique)
- `dim_date_date` (unique)
- `dim_date_system_date` (unique)
- `dim_date_dow`

---

### `03_dim_customer.sql`
Creates `dim_customer` as a **Slowly Changing Dimension (SCD Type 2)** to track customer address changes over time. Includes `effective_date`, `expiry_date`, and `is_current` columns so the customer's location is preserved at the time of each sale — satisfying the case study requirement that postcode is recorded at time of purchase, not the customer's current address.

**Key columns:**

| Column | Description |
|---|---|
| `customer_key` | Surrogate key |
| `customer_number` | Natural key from source system |
| `age_group` | Derived: ≤30 / 31–50 / >50 |
| `market` | Victoria / Rest of Australia / International |
| `zipcode` | Postcode at time of record |
| `effective_date` | Date this version became active |
| `expiry_date` | Date this version expired (NULL if current) |
| `is_current` | 1 = current record, 0 = historical |

---

### `04_dim_product.sql`
Creates `dim_product` covering all 1,000 products across three categories.

**Hierarchy:** `product_category` → `product_type` → `product_code`

| Column | Description |
|---|---|
| `product_key` | Surrogate key |
| `product_code` | Natural key from ERP system |
| `product_category` | Music / Films / Audio Books |
| `product_type` | e.g. Classical Music, Drama Films, Fiction Books |
| `unit_price` | Retail price in USD |
| `unit_cost` | Cost price for margin calculation |
| `status` | AC / IN / QC / WD |

---

### `05_dim_store.sql`
Creates `dim_store` with the full geographic hierarchy required for store performance reporting.

**Hierarchy:** `division` → `region` → `country` → `state` → `city` → `store`

| Column | Description |
|---|---|
| `store_key` | Surrogate key |
| `store_number` | Natural key from source system |
| `store_type` | Full Outlet / Mini Outlet / Distribution Centre |
| `market` | Victoria / Rest of Australia / International |
| `division` | AAA (America, Asia, Australia) or EMEA |
| `region` | e.g. Australia, United Kingdom, Germany |
| `state` | Australian stores only (NULL for international) |

---

### `06_dim_subscription.sql`
Creates `dim_subscription` to support CRM and loyalty program analysis.

| Column | Description |
|---|---|
| `subscription_key` | Surrogate key |
| `subscription_id` | Natural key |
| `customer_number` | References customer |
| `package_name` | e.g. Basic, Premium, Ultra |
| `package_type` | GM / SM / ST / TG / RT |
| `package_price` | Monthly price in USD |
| `start_date` / `end_date` | Subscription period |
| `status` | Active / Expired / Cancelled |

---

### `07_dim_currency.sql`
Creates `dim_currency` storing monthly exchange rates for all non-USD currencies. Used to convert local transaction amounts to USD in the fact table.

| Column | Description |
|---|---|
| `currency_key` | Surrogate key |
| `currency_code` | ISO code — AUD, EUR, GBP, INR, ZAR, CNY |
| `effective_date` | First day of the month the rate applies |
| `currency_rate` | Multiply local amount by this to get USD |

> Note: USD is the base currency (rate = 1.0) and does not appear in this table. USD transactions require no conversion.

---

### `08_fact_sales.sql`
Creates the central `fact_sales` table. Grain: **one row per order line item**.

**Measures:**

| Column | Description |
|---|---|
| `qty` | Units sold |
| `price` | Selling price per unit in local currency |
| `unit_cost` | Cost per unit in local currency |
| `exchange_rate` | Rate applied for USD conversion |
| `dollar_sales_usd` | `qty × price × exchange_rate` |
| `cost_usd` | `qty × unit_cost × exchange_rate` |
| `margin_usd` | `dollar_sales_usd − cost_usd` |

**Foreign Keys:**

| FK Column | References |
|---|---|
| `date_key` | `dim_date(date_key)` |
| `customer_key` | `dim_customer(customer_key)` |
| `product_key` | `dim_product(product_key)` |
| `store_key` | `dim_store(store_key)` |
| `currency_key` | `dim_currency(currency_key)` |
| `subscription_key` | `dim_subscription(subscription_key)` — nullable |

---

### `09_staging_database.sql`
Creates the `stg` database and all 13 staging tables as a clean mirror of the source Excel files. All tables are dropped and recreated on each run for a clean slate. Ends with `SHOW TABLES` to confirm all 13 tables were created.

**Tables created:**

| Table | Source File | Expected Rows |
|---|---|---|
| `stg_order_header` | Order_Header.xlsx | 17,000 |
| `stg_order_details` | Order_Details.xlsx | 50,000 |
| `stg_customer` | Customer.xlsx | 5,000 |
| `stg_store` | Store.xlsx | 500 |
| `stg_product` | Product.xlsx | 1,000 |
| `stg_subscription` | Subscription.xlsx | 3,000 |
| `stg_currency_rate` | Currency_Rate.xlsx | 369 |
| `stg_currency` | Currency.xlsx | 175 |
| `stg_package` | Package.xlsx | 24 |
| `stg_product_type` | Product_Type.xlsx | 65 |
| `stg_division` | Division.xlsx | 3 |
| `stg_region` | Region.xlsx | 14 |
| `stg_house_hold_income` | House_Hold_Income.xlsx | 11 |

---

### `10_stg_data_check_count.sql`
Quick post-ETL verification — counts rows across all 13 staging tables in a single `UNION ALL` query, sorted alphabetically. Run this immediately after the Stage_ETL Pentaho transformation completes to confirm all data loaded correctly before proceeding to the DW ETL.

---

## Database Summary

| Database | Layer | Contains |
|---|---|---|
| `stg` | Staging | Raw source data — 13 staging tables |
| `dw` | Warehouse | `dim_date`, `dim_customer`, `dim_product`, `dim_store`, `dim_subscription`, `dim_currency`, `fact_sales` |

---

## Dependencies
- MySQL 8.0+
- Scripts `01` through `08` must complete before running the DW ETL in Pentaho
- Script `09` must run before the Stage_ETL Pentaho transformation
- `dim_date` must be fully populated before fact table ETL (date keys are looked up by date value during load)
- All dimension tables must exist before `fact_sales` is created (foreign key constraints)
