-- ============================================================
-- ICE Entertainment - Staging Row Count Verification
-- ============================================================
USE stg;

SELECT 'stg_division'          AS table_name, COUNT(*) AS row_count FROM stg_division
UNION ALL
SELECT 'stg_region',                          COUNT(*) FROM stg_region
UNION ALL
SELECT 'stg_package',                         COUNT(*) FROM stg_package
UNION ALL
SELECT 'stg_product_type',                    COUNT(*) FROM stg_product_type
UNION ALL
SELECT 'stg_store',                           COUNT(*) FROM stg_store
UNION ALL
SELECT 'stg_product',                         COUNT(*) FROM stg_product
UNION ALL
SELECT 'stg_order_details',                   COUNT(*) FROM stg_order_details
UNION ALL
SELECT 'stg_subscription',                    COUNT(*) FROM stg_subscription
UNION ALL
SELECT 'stg_currency_rate',                   COUNT(*) FROM stg_currency_rate
UNION ALL
SELECT 'stg_currency',                        COUNT(*) FROM stg_currency
UNION ALL
SELECT 'stg_customer',                        COUNT(*) FROM stg_customer
UNION ALL
SELECT 'stg_order_header',                    COUNT(*) FROM stg_order_header
UNION ALL
SELECT 'stg_house_hold_income',               COUNT(*) FROM stg_house_hold_income
UNION ALL
SELECT 'stg_channel',                         COUNT(*) FROM stg_channel
UNION ALL
SELECT 'stg_product_status',                  COUNT(*) FROM stg_product_status
UNION ALL
SELECT 'stg_occupation',                      COUNT(*) FROM stg_occupation
UNION ALL
SELECT 'stg_email_address_type',              COUNT(*) FROM stg_email_address_type
UNION ALL
SELECT 'stg_customer_status',                 COUNT(*) FROM stg_customer_status
UNION ALL
SELECT 'stg_address_type',                    COUNT(*) FROM stg_address_type
UNION ALL
SELECT 'stg_phone_number_type',               COUNT(*) FROM stg_phone_number_type
UNION ALL
SELECT 'stg_interest',                        COUNT(*) FROM stg_interest
UNION ALL
SELECT 'stg_permission',                      COUNT(*) FROM stg_permission
UNION ALL
SELECT 'stg_state',                           COUNT(*) FROM stg_state
UNION ALL
SELECT 'stg_package_type',                    COUNT(*) FROM stg_package_type
UNION ALL
SELECT 'stg_product_category',                COUNT(*) FROM stg_product_category
UNION ALL
SELECT 'stg_customer_type',                   COUNT(*) FROM stg_customer_type;