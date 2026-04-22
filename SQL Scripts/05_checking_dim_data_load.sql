-- ============================================================
-- ICE Entertainment - DW Dimension Verification
-- ============================================================
USE dw;

-- 1. Row counts across all dimensions
SELECT 'dim_date'         AS table_name, COUNT(*) AS row_count FROM dim_date
UNION ALL
SELECT 'dim_customer',                   COUNT(*) FROM dim_customer
UNION ALL
SELECT 'dim_market',                     COUNT(*) FROM dim_market
UNION ALL
SELECT 'dim_package',                    COUNT(*) FROM dim_package
UNION ALL
SELECT 'dim_product',                    COUNT(*) FROM dim_product
UNION ALL
SELECT 'dim_store',                      COUNT(*) FROM dim_store
UNION ALL
SELECT 'dim_subscription',               COUNT(*) FROM dim_subscription
UNION ALL
SELECT 'dim_currency',                   COUNT(*) FROM dim_currency;

-- 2. dim_customer checks
SELECT 'dim_customer' AS dimension, age_group, COUNT(*) AS count FROM dim_customer GROUP BY age_group
UNION ALL
SELECT 'dim_customer', market, COUNT(*) FROM dim_customer GROUP BY market;

-- 3. dim_product checks
SELECT product_category, COUNT(*) AS count FROM dim_product GROUP BY product_category;

-- 4. dim_store checks
SELECT market, COUNT(*) AS count FROM dim_store GROUP BY market;

-- 5. dim_package checks
SELECT status, COUNT(*) AS count FROM dim_package GROUP BY status;

-- 6. dim_subscription checks
SELECT status, COUNT(*) AS count FROM dim_subscription GROUP BY status;

-- 7. dim_currency checks
SELECT currency_code, COUNT(*) AS count FROM dim_currency GROUP BY currency_code;

-- 8. NULL checks across all dimensions
SELECT
    'dim_customer'  AS table_name,
    SUM(CASE WHEN customer_number IS NULL THEN 1 ELSE 0 END) AS null_pk,
    SUM(CASE WHEN market IS NULL THEN 1 ELSE 0 END)          AS null_market,
    SUM(CASE WHEN age_group IS NULL THEN 1 ELSE 0 END)       AS null_key_field
FROM dim_customer
UNION ALL
SELECT
    'dim_product',
    SUM(CASE WHEN product_code IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN product_category IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN product_type IS NULL THEN 1 ELSE 0 END)
FROM dim_product
UNION ALL
SELECT
    'dim_store',
    SUM(CASE WHEN store_number IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN market IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN region IS NULL THEN 1 ELSE 0 END)
FROM dim_store
UNION ALL
SELECT
    'dim_currency',
    SUM(CASE WHEN currency_code IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN currency_rate IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN effective_date IS NULL THEN 1 ELSE 0 END)
FROM dim_currency
UNION ALL
SELECT
    'dim_package',
    SUM(CASE WHEN package_id IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN package_type IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN status IS NULL THEN 1 ELSE 0 END)
FROM dim_package
UNION ALL
SELECT
    'dim_subscription',
    SUM(CASE WHEN subscription_id IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN package_name IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN status IS NULL THEN 1 ELSE 0 END)
FROM dim_subscription;