# Pentaho — ETL Transformations

## Overview
This folder contains all Pentaho Data Integration (PDI) transformation files used to load data for the ICE Entertainment dimensional data warehouse. The ETL pipeline is split into two layers: a **staging layer** that extracts raw data from Excel source files, and a **DW layer** that transforms and loads the dimensional model.

**Tool:** Pentaho Data Integration (Spoon) v11.0.0.0-237  
**Database connection:** `ICE_Entertainment` (MySQL — points to both `stg` and `dw` databases)  
**Source data path:** `D:\...\MIS774-ICE-Entertainment-DW\dataset\`

---

## Folder Contents

| File | Layer | Description |
|---|---|---|
| `Stage_ETL2.ktr` | Staging | Loads all 26 source Excel files into the `stg` database |
| `Data loading.ktr` | DW | Early version — loads dim_product directly from Excel (superseded) |
| `load_dim_currency.ktr` | DW | Loads `dim_currency` — 7 currencies from staging + USD generated |
| `load_dim_customer.ktr` | DW | Loads `dim_customer` with SCD Type 2 fields and age group derivation |
| `load_dim_package.ktr` | DW | Loads `dim_package` — packages joined with subscriptions |
| `load_dim_product.ktr` | DW | Loads `dim_product` — products joined with product type and status |
| `load_dim_store.ktr` | DW | Loads `dim_store` — stores with market derivation and state name lookup |
| `load_dim_subscription.ktr` | DW | Loads `dim_subscription` — subscriptions joined with package details |
| `load_fact_sales.ktr` | DW | Loads `fact_sales` — 50,000 order line items with USD conversion |
| `load_fact_subscription.ktr` | DW | Loads `fact_subscription` — 3,000 subscription records with flags |

---

## Execution Order

> ⚠️ Run in this exact order. Dimension tables must be loaded before fact tables.

| Order | File | Target Table | Expected Rows |
|---|---|---|---|
| 1 | `Stage_ETL2.ktr` | All `stg.*` tables | 76,166 total |
| 2 | `load_dim_currency.ktr` | `dw.dim_currency` | 422 |
| 3 | `load_dim_customer.ktr` | `dw.dim_customer` | 5,000 |
| 4 | `load_dim_product.ktr` | `dw.dim_product` | 1,000 |
| 5 | `load_dim_store.ktr` | `dw.dim_store` | 500 |
| 6 | `load_dim_subscription.ktr` | `dw.dim_subscription` | 3,000 |
| 7 | `load_dim_package.ktr` | `dw.dim_package` | 3,000 |
| 8 | `load_fact_sales.ktr` | `dw.fact_sales` | 50,000 |
| 9 | `load_fact_subscription.ktr` | `dw.fact_subscription` | 3,000 |

> Note: `dim_date` and `dim_market` are populated via SQL scripts, not Pentaho.

---

## Stage ETL — `Stage_ETL2.ktr`

Loads all 26 source Excel files into the `stg` database in parallel. Each pipeline follows the pattern:

```
[Excel Input] ──► [Table Output → stg.*]
```

**Rows loaded per table:**

| Source File | Target Table | Rows |
|---|---|---|
| Order_Details.xlsx | stg_order_details | 50,000 |
| Order_Header.xlsx | stg_order_header | 17,000 |
| Customer.xlsx | stg_customer | 5,000 |
| Store.xlsx | stg_store | 500 |
| Product.xlsx | stg_product | 1,000 |
| Subscription.xlsx | stg_subscription | 3,000 |
| Currency_Rate.xlsx | stg_currency_rate | 369 |
| Currency.xlsx | stg_currency | 175 |
| Occupation.xlsx | stg_occupation | 101 |
| Product_Type.xlsx | stg_product_type | 65 |
| Interest.xlsx | stg_interest | 38 |
| Package.xlsx | stg_package | 24 |
| Region.xlsx | stg_region | 14 |
| House_Hold_Income.xlsx | stg_house_hold_income | 11 |
| State.xlsx | stg_state | 8 |
| Channel.xlsx | stg_channel | 6 |
| Package_Type.xlsx | stg_package_type | 6 |
| Product_Status.xlsx | stg_product_status | 4 |
| Customer_Status.xlsx | stg_customer_status | 4 |
| Division.xlsx | stg_division | 3 |
| Product_Category.xlsx | stg_product_category | 3 |
| Customer_Type.xlsx | stg_customer_type | 3 |
| Address_Type.xlsx | stg_address_type | 2 |
| Email_Address_Type.xlsx | stg_email_address_type | 2 |
| Permission.xlsx | stg_permission | 2 |
| Phone_Number_Type.xlsx | stg_phone_number_type | 2 |
| **Total** | | **76,166** |

**Known fixes applied:**

| Step | Issue | Fix |
|---|---|---|
| Currency_Rate.xlsx | `effective_date` format mismatch — PDI expected `yyyy/MM/dd HH:mm:ss.SSS` | Changed format to `yyyy-MM-dd` in Excel Input Fields tab |
| stg_order_header | `Purchase type` column had a space causing `Unknown column` error | Mapped `Purchase type` → `purchase_type` in Table Output field mapping |

---

## DW ETL Transformation Details

### `load_dim_currency.ktr`
**Pattern:** Two Table Inputs → Append Streams → Table Output

- **Stream 1 (`stg_currency_rate`):** Joins `stg.stg_currency_rate` with `stg.stg_currency` to get currency name — 369 rows across 7 currencies
- **Stream 2 (`usd_base_rate`):** Generates USD rows using `DISTINCT` AUD dates with `rate = 1.0` — 53 rows
- **Output:** 422 rows across 8 currencies (AUD, CNY, EUR, GBP, INR, JPY, ZAR, USD)

**Key SQL (USD stream):**
```sql
SELECT DISTINCT 'USD', 'United States, Dollars',
    STR_TO_DATE(cr.effective_date, '%Y-%m-%d %H:%i:%s'),
    1.000000
FROM stg.stg_currency_rate cr
WHERE cr.currency_code = 'AUD'
```

---

### `load_dim_customer.ktr`
**Pattern:** Single Table Input → Table Output

- Joins `stg.stg_customer` with `stg.stg_house_hold_income` for income band description
- Derives `age_group` using `TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE())`
- Sets SCD Type 2 fields: `effective_date = DATE(NOW())`, `expiry_date = NULL`, `is_current = 1`

**Age group bands:**
- 30 and under
- 31 to 50
- Over 50

---

### `load_dim_product.ktr`
**Pattern:** Single Table Input → Table Output

- Joins `stg.stg_product` with `stg.stg_product_type` and `stg.stg_product_status`
- Converts `created` and `last_updated` to DATE using `DATE()`
- Joins on `p.status = ps.product_status_code` (not product_type_code)

---

### `load_dim_store.ktr`
**Pattern:** Single Table Input → Table Output

- Joins `stg.stg_store` with `stg.stg_division` and `stg.stg_state` (LEFT JOIN for non-AU stores)
- Derives `market` using CASE statement on country and state:
  - `AU + VIC` → Victoria
  - `AU + non-VIC` → Rest of Australia
  - All others → International

---

### `load_dim_subscription.ktr`
**Pattern:** Single Table Input → Table Output

- Joins `stg.stg_subscription` with `stg.stg_package` and `stg.stg_package_type`
- Converts `start_date` and `end_date` from INT (YYYYMMDD) to DATE using `STR_TO_DATE(CAST(x AS CHAR), '%Y%m%d')`

---

### `load_dim_package.ktr`
**Pattern:** Single Table Input → Table Output

- Joins `stg.stg_subscription`, `stg.stg_package`, and `stg.stg_package_type`
- One row per subscription — 3,000 rows
- Includes `customer_number`, `subscription_id`, `start_date`, `end_date`, `status`

---

### `load_fact_sales.ktr`
**Pattern:** Single Table Input → Table Output

Joins across both `stg` and `dw` databases to resolve all surrogate keys:

```
stg.stg_order_details + stg.stg_order_header
    → dw.dim_date       (date_key via sql_date match)
    → dw.dim_customer   (customer_key via customer_number + is_current=1)
    → dw.dim_product    (product_key via product_code)
    → dw.dim_store      (store_key via store_number)
    → dw.dim_market     (market_key via store.market)
    → dw.dim_currency   (currency_key via correlated subquery — most recent rate ≤ order date)
```

**Currency rate lookup (correlated subquery):**
```sql
AND cur.effective_date = (
    SELECT MAX(cr2.effective_date)
    FROM dw.dim_currency cr2
    WHERE cr2.currency_code = oh.currency
    AND cr2.effective_date <= STR_TO_DATE(oh.order_date, '%Y-%m-%d')
)
```

**Calculated measures:**
- `dollar_sales_usd = ROUND(qty × price × exchange_rate, 2)`
- `cost_usd = ROUND(qty × unit_cost × exchange_rate, 2)`
- `margin_usd = dollar_sales_usd − cost_usd`

---

### `load_fact_subscription.ktr`
**Pattern:** Single Table Input → Table Output

Joins `dw.dim_package`, `dw.dim_customer`, `dw.dim_subscription`, and `dw.dim_date`:

```
dw.dim_package
    → dw.dim_customer    (customer_key via customer_number + is_current=1)
    → dw.dim_subscription (subscription_key via subscription_id)
    → dw.dim_date        (date_key via start_date)
```

**Derived measures:**
- `subscription_duration_days = DATEDIFF(IFNULL(end_date, CURRENT_DATE), start_date)`
- `active_flag = 1` if status = Active
- `cancelled_flag = 1` if status = Cancelled

---

## Verification Results

| Table | Expected | Actual | Status |
|---|---|---|---|
| stg (all tables) | 76,166 | 76,166 | ✅ |
| dim_date | 10,592 | 10,592 | ✅ |
| dim_customer | 5,000 | 5,000 | ✅ |
| dim_market | 3 | 3 | ✅ |
| dim_product | 1,000 | 1,000 | ✅ |
| dim_store | 500 | 500 | ✅ |
| dim_subscription | 3,000 | 3,000 | ✅ |
| dim_package | 3,000 | 3,000 | ✅ |
| dim_currency | 422 | 422 | ✅ |
| fact_sales | 50,000 | 50,000 | ✅ |
| fact_subscription | 3,000 | 3,000 | ✅ |

**Revenue summary (fact_sales):**

| Market | Revenue (USD) | Margin (USD) |
|---|---|---|
| International | $318,026.70 | $135,982.36 |
| Rest of Australia | $29,599.07 | $12,607.48 |
| Victoria | $13,420.95 | $5,766.24 |
| **Total** | **$361,046.72** | **$154,356.08** |

---

## How to Run

1. Open **Pentaho Data Integration (Spoon)**
2. Ensure the `ICE_Entertainment` database connection is configured (MySQL, localhost, port 3306)
3. Run `Stage_ETL2.ktr` first — verify 76,166 rows loaded
4. Run DW transformations in the order listed in the execution table above
5. Each transformation has **Truncate table** enabled — safe to re-run

## Dependencies
- MySQL 8.0+ with `stg` and `dw` databases created
- All staging tables must exist before running `Stage_ETL2.ktr`
- All DW dimension tables must exist before running any DW ETL (run `04_dim_database.sql` first)
- `dim_date` must be populated via stored procedure before `load_fact_sales.ktr`
- `dim_market` must be seeded (3 rows) before `load_fact_sales.ktr`
