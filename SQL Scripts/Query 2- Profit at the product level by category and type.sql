USE dw;

SELECT
    dp.product_category,
    dp.product_type,
    SUM(fs.qty) AS total_unit_sales,
    ROUND(SUM(fs.dollar_sales_usd), 2) AS total_dollar_sales_usd,
    ROUND(SUM(fs.margin_usd), 2) AS total_margin_usd
FROM fact_sales fs
JOIN dim_product dp
    ON fs.product_key = dp.product_key
GROUP BY
    dp.product_category,
    dp.product_type
ORDER BY total_margin_usd DESC;