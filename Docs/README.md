# Stage ETL — Pentaho Data Integration Transformation

## Overview
This folder contains the Pentaho Data Integration (PDI) transformation responsible for extracting data from all ICE Entertainment source Excel files and loading them into the staging database (`ICE_Entertainment`).

## Transformation File
| File | Description |
|---|---|
| `Stage_ETL.ktr` | Main PDI transformation — extracts from Excel, loads to staging |

## What It Does
- Reads from 13 source Excel files representing the Sales System (Informix) and ERP System (Oracle)
- Loads data into 13 corresponding staging tables in MySQL
- Runs all table loads in parallel for performance

## Staging Tables Loaded
| Staging Table | Source File | Expected Rows |
|---|---|---|
| stg_order_header | Order_Header.xlsx | 17,000 |
| stg_order_details | Order_Details.xlsx | 50,000 |
| stg_customer | Customer.xlsx | 5,000 |
| stg_store | Store.xlsx | 500 |
| stg_product | Product.xlsx | 1,000 |
| stg_subscription | Subscription.xlsx | 3,000 |
| stg_currency_rate | Currency_Rate.xlsx | 369 |
| stg_currency | Currency.xlsx | 175 |
| stg_package | Package.xlsx | 24 |
| stg_product_type | Product_Type.xlsx | 65 |
| stg_division | Division.xlsx | 3 |
| stg_region | Region.xlsx | 14 |
| stg_house_hold_income | House_Hold_Income.xlsx | 11 |

## Known Fixes Applied
- `Currency_Rate.xlsx` — `effective_date` format changed from `yyyy/MM/dd HH:mm:ss.SSS` to `yyyy-MM-dd` in the Excel Input step
- `Order_Header.xlsx` — `Purchase type` field renamed to `purchase_type` in both the Excel Input and Table Output steps to match the staging table column name

## How to Run
1. Open PDI (Spoon)
2. Open `Stage_ETL.ktr`
3. Verify the `ICE_Entertainment` database connection is active
4. Click **Run** (F9)
5. After completion, run `stg_row_counts.sql` to verify row counts

## Dependencies
- PDI version 11.0.0.0-237 or later
- MySQL 8.0+ with `ICE_Entertainment` database and all `stg_` tables created
- Source Excel files located in the configured dataset directory
