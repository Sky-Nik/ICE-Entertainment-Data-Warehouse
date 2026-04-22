-- ============================================================
-- ICE Entertainment - Analytical SQL Queries
-- Deliverable 3 - MIS774 Assessment 1
-- Database: dw
-- ============================================================

USE dw;

-- ============================================================
-- QUERY 1: CUSTOMER ANALYSIS (Business Question 1)
-- Who are the key customers?
-- Unit sales, dollar sales and margin by customer,
-- segmented by age group and market, with postcode at time of sale
-- ============================================================

SELECT
    dc.customer_number,
    dc.name,
    dc.age_group,
    dc.market,
    dc.zipcode,
    dc.country,
    d.year,
    d.quarter,
    d.month_name,
    SUM(f.qty)              AS total_unit_sales,
    SUM(f.dollar_sales_usd) AS total_dollar_sales_usd,
    SUM(f.margin_usd)       AS total_margin_usd
FROM fact_sales f
JOIN dim_customer dc ON f.customer_key = dc.customer_key
JOIN dim_date d      ON f.date_key = d.date_key
GROUP BY
    dc.customer_number,
    dc.name,
    dc.age_group,
    dc.market,
    dc.zipcode,
    dc.country,
    d.year,
    d.quarter,
    d.month_name
ORDER BY
    total_margin_usd DESC;


-- ============================================================
-- QUERY 2: PRODUCT PROFITABILITY (Business Question 2)
-- Which products are the most profitable?
-- Unit sales, dollar sales and margin by product,
-- navigable by category, type and title, with seasonal analysis
-- ============================================================

SELECT
    dp.product_category,
    dp.product_type,
    dp.name                 AS product_name,
    dp.format,
    d.year,
    d.month_name,
    CASE
        WHEN d.month IN (12, 1, 2)  THEN 'Summer'
        WHEN d.month IN (3, 4, 5)   THEN 'Autumn'
        WHEN d.month IN (6, 7, 8)   THEN 'Winter'
        WHEN d.month IN (9, 10, 11) THEN 'Spring'
    END                     AS season,
    SUM(f.qty)              AS total_unit_sales,
    SUM(f.dollar_sales_usd) AS total_dollar_sales_usd,
    SUM(f.margin_usd)       AS total_margin_usd
FROM fact_sales f
JOIN dim_product dp ON f.product_key = dp.product_key
JOIN dim_date d     ON f.date_key = d.date_key
GROUP BY
    dp.product_category,
    dp.product_type,
    dp.name,
    dp.format,
    d.year,
    d.month_name,
    season
ORDER BY
    total_margin_usd DESC;


-- ============================================================
-- QUERY 3: STORE PERFORMANCE (Business Question 3)
-- Which store locations are the most profitable?
-- Unit sales, dollar sales and margin by store per month,
-- navigable through full geographic hierarchy
-- ============================================================

SELECT
    ds.division,
    ds.region,
    ds.country,
    ds.state,
    ds.city,
    ds.store_name,
    ds.store_type,
    d.year,
    d.month,
    d.month_name,
    SUM(f.qty)              AS total_unit_sales,
    SUM(f.dollar_sales_usd) AS total_dollar_sales_usd,
    SUM(f.margin_usd)       AS total_margin_usd
FROM fact_sales f
JOIN dim_store ds ON f.store_key = ds.store_key
JOIN dim_date d   ON f.date_key = d.date_key
GROUP BY
    ds.division,
    ds.region,
    ds.country,
    ds.state,
    ds.city,
    ds.store_name,
    ds.store_type,
    d.year,
    d.month,
    d.month_name
ORDER BY
    total_margin_usd DESC;


-- ============================================================
-- QUERY 4: TIME PERIOD ANALYSIS (Business Question 4)
-- Which time periods are the most profitable?
-- Covers daily, weekly, monthly, quarterly, yearly,
-- fiscal year, fiscal quarter and fiscal period
-- ============================================================

-- 4a. Daily (with day name for Sunday/holiday analysis)
SELECT
    d.sql_date,
    d.day_name,
    d.week_day,
    SUM(f.qty)              AS total_unit_sales,
    SUM(f.dollar_sales_usd) AS total_dollar_sales_usd,
    SUM(f.margin_usd)       AS total_margin_usd
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.sql_date, d.day_name, d.week_day
ORDER BY total_margin_usd DESC;

-- 4b. Weekly
SELECT
    d.year,
    d.week_number,
    SUM(f.qty)              AS total_unit_sales,
    SUM(f.dollar_sales_usd) AS total_dollar_sales_usd,
    SUM(f.margin_usd)       AS total_margin_usd
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.year, d.week_number
ORDER BY d.year, d.week_number;

-- 4c. Monthly
SELECT
    d.year,
    d.month,
    d.month_name,
    SUM(f.qty)              AS total_unit_sales,
    SUM(f.dollar_sales_usd) AS total_dollar_sales_usd,
    SUM(f.margin_usd)       AS total_margin_usd
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.year, d.month, d.month_name
ORDER BY d.year, d.month;

-- 4d. Quarterly (calendar)
SELECT
    d.year,
    d.quarter,
    SUM(f.qty)              AS total_unit_sales,
    SUM(f.dollar_sales_usd) AS total_dollar_sales_usd,
    SUM(f.margin_usd)       AS total_margin_usd
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.year, d.quarter
ORDER BY d.year, d.quarter;

-- 4e. Yearly (calendar)
SELECT
    d.year,
    SUM(f.qty)              AS total_unit_sales,
    SUM(f.dollar_sales_usd) AS total_dollar_sales_usd,
    SUM(f.margin_usd)       AS total_margin_usd
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.year
ORDER BY d.year;

-- 4f. Fiscal Year
SELECT
    d.fiscal_year,
    SUM(f.qty)              AS total_unit_sales,
    SUM(f.dollar_sales_usd) AS total_dollar_sales_usd,
    SUM(f.margin_usd)       AS total_margin_usd
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.fiscal_year
ORDER BY d.fiscal_year;

-- 4g. Fiscal Quarter
SELECT
    d.fiscal_year,
    d.fiscal_quarter,
    SUM(f.qty)              AS total_unit_sales,
    SUM(f.dollar_sales_usd) AS total_dollar_sales_usd,
    SUM(f.margin_usd)       AS total_margin_usd
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.fiscal_year, d.fiscal_quarter
ORDER BY d.fiscal_year, d.fiscal_quarter;

-- 4h. Fiscal Period
SELECT
    d.fiscal_year,
    d.fiscal_period,
    SUM(f.qty)              AS total_unit_sales,
    SUM(f.dollar_sales_usd) AS total_dollar_sales_usd,
    SUM(f.margin_usd)       AS total_margin_usd
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.fiscal_year, d.fiscal_period
ORDER BY d.fiscal_year, d.fiscal_period;


-- ============================================================
-- QUERY 5: MARKET ANALYSIS (Business Question 5)
-- Which market is the most profitable?
-- Unit sales and dollar sales by market per month
-- ============================================================

SELECT
    dm.market,
    d.year,
    d.month,
    d.month_name,
    SUM(f.qty)              AS total_unit_sales,
    SUM(f.dollar_sales_usd) AS total_dollar_sales_usd,
    SUM(f.margin_usd)       AS total_margin_usd,
    ROUND(SUM(f.margin_usd) / SUM(f.dollar_sales_usd) * 100, 2) AS margin_pct
FROM fact_sales f
JOIN dim_market dm ON f.market_key = dm.market_key
JOIN dim_date d    ON f.date_key = d.date_key
GROUP BY
    dm.market,
    d.year,
    d.month,
    d.month_name
ORDER BY
    d.year,
    d.month,
    total_margin_usd DESC;


-- ============================================================
-- BONUS: SUBSCRIPTION ANALYSIS
-- Customer subscription behaviour for loyalty program design
-- ============================================================

SELECT
    dc.name                         AS customer_name,
    dc.market,
    dc.age_group,
    dc.preferred_channel1,
    ds.package_name,
    ds.package_type,
    ds.package_price,
    ds.status                       AS subscription_status,
    fs.subscription_duration_days,
    fs.active_flag,
    fs.cancelled_flag,
    d.year,
    d.month_name
FROM fact_subscription fs
JOIN dim_customer dc     ON fs.customer_key = dc.customer_key
JOIN dim_subscription ds ON fs.subscription_key = ds.subscription_key
JOIN dim_date d          ON fs.date_key = d.date_key
ORDER BY
    fs.subscription_duration_days DESC;