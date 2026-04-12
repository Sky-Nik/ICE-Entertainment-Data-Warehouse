USE stg;

SELECT 'stg_order_details' AS table_name, COUNT(*) AS row_count FROM stg_order_details
UNION ALL
SELECT 'stg_order_header', COUNT(*) FROM stg_order_header
UNION ALL
SELECT 'stg_customer', COUNT(*) FROM stg_customer
UNION ALL
SELECT 'stg_store', COUNT(*) FROM stg_store
UNION ALL
SELECT 'stg_product', COUNT(*) FROM stg_product
UNION ALL
SELECT 'stg_product_type', COUNT(*) FROM stg_product_type
UNION ALL
SELECT 'stg_subscription', COUNT(*) FROM stg_subscription
UNION ALL
SELECT 'stg_package', COUNT(*) FROM stg_package
UNION ALL
SELECT 'stg_currency_rate', COUNT(*) FROM stg_currency_rate
UNION ALL
SELECT 'stg_currency', COUNT(*) FROM stg_currency;