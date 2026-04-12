USE dw;

SELECT 'dim_date' AS table_name, COUNT(*) AS row_count FROM dim_date
UNION ALL
SELECT 'dim_customer', COUNT(*) FROM dim_customer
UNION ALL
SELECT 'dim_product', COUNT(*) FROM dim_product
UNION ALL
SELECT 'dim_store', COUNT(*) FROM dim_store
UNION ALL
SELECT 'dim_currency', COUNT(*) FROM dim_currency
UNION ALL
SELECT 'dim_subscription', COUNT(*) FROM dim_subscription
UNION ALL
SELECT 'fact_sales', COUNT(*) FROM fact_sales;