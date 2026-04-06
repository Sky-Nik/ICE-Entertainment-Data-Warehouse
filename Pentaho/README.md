# Pentaho — Stage ETL Transformation

## Overview
This folder contains the Pentaho Data Integration (PDI) transformation that loads all ICE Entertainment source data from Excel files into the MySQL staging database (`ICE_Entertainment`). All 13 pipeline steps completed successfully with zero errors.

## Folder Contents
| File | Description |
|---|---|
| `Stage_ETL.ktr` | PDI transformation file — extract from Excel, load to staging |
| `Stage_etl.png` | Screenshot of the completed transformation in Spoon |

## Transformation Canvas Layout

The transformation is organised into 13 parallel pipelines, each following the pattern:
![State_etl](Docs/Stage_etl.png)
```
[Excel Input] ──► [Table Output]
```

| Excel Input Step | Table Output Step | Rows Loaded |
|---|---|---|
| Division.xlsx | stg_division | 3 |
| Region.xlsx | stg_region | 14 |
| Package.xlsx | stg_package | 24 |
| Product_Type.xlsx | stg_product_type | 65 |
| Store.xlsx | stg_store | 500 |
| Product.xlsx | stg_product | 1,000 |
| Subscription.xlsx | stg_subscription | 3,000 |
| Customer.xlsx | stg_customer | 5,000 |
| Currency.xlsx | stg_currency | 175 |
| Currency_Rate.xlsx | stg_currency_rate | 369 |
| House_Hold_Income.xlsx | stg_house_hold_income | 11 |
| Order_Header | stg_order_header | 17,000 |
| Order_Details.xlsx | stg_order_details | 50,000 |

**Total rows loaded: 76,166**

## Execution Results (Successful Run)
Confirmed from PDI execution log — all steps finished with `E=0` (zero errors):

```
Store.xlsx          I=500,   W=500
Product.xlsx        I=1000,  W=1000
Currency.xlsx       I=175,   W=175
stg_currency_rate   R=369,   W=369
stg_store           R=500,   W=500
Customer.xlsx       I=5000,  W=5000
stg_product         R=1000,  W=1000
Subscription.xlsx   I=3000,  W=3000
Order_Header        I=17000, W=17000
stg_customer        R=5000,  W=5000
stg_order_header    R=17000, W=17000
Order_Details.xlsx  I=50000, W=50000
stg_order_details   R=50000, W=50000
```

## Known Fixes Applied
| Step | Issue | Fix Applied |
|---|---|---|
| Currency_Rate.xlsx | `effective_date` format mismatch — PDI expected `yyyy/MM/dd HH:mm:ss.SSS` but Excel stored `yyyy-MM-dd` | Changed format in Excel Input Fields tab to `yyyy-MM-dd` |
| Order_Header | `Purchase type` column name had a space, causing `Unknown column` error on insert | Renamed field to `purchase_type` in both Excel Input and Table Output steps |

## How to Run
1. Open **Pentaho Data Integration (Spoon)**
2. Open `Stage_ETL.ktr`
3. Confirm the `ICE_Entertainment` database connection is configured
4. Press **F9** or click the **Run** button
5. Monitor the **Execution Results → Logging** tab for any errors
6. After completion, run `stg_row_counts.sql` to verify all row counts

## Dependencies
- Pentaho Data Integration version `11.0.0.0-237`
- MySQL 8.0+ with `ICE_Entertainment` database created
- All `stg_` staging tables must exist before running (created via DDL scripts)
- Source Excel files must be accessible at the configured dataset path:
  `D:\...\MIS774-ICE-Entertainment-DW\dataset\`
