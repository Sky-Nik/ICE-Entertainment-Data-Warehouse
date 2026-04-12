USE dw;

SELECT
    dd.year,
    CASE
        WHEN dd.month IN (12, 1, 2) THEN 'Summer'
        WHEN dd.month IN (3, 4, 5) THEN 'Autumn'
        WHEN dd.month IN (6, 7, 8) THEN 'Winter'
        WHEN dd.month IN (9, 10, 11) THEN 'Spring'
    END AS season,
    dd.month_name,
    dp.product_category,
    dp.product_type,
    SUM(fs.qty) AS total_unit_sales,
    ROUND(SUM(fs.dollar_sales_usd), 2) AS total_dollar_sales_usd,
    ROUND(SUM(fs.margin_usd), 2) AS total_margin_usd
FROM fact_sales fs
JOIN dim_product dp
    ON fs.product_key = dp.product_key
JOIN dim_date dd
    ON fs.date_key = dd.date_key
GROUP BY
    dd.year,
    CASE
        WHEN dd.month IN (12, 1, 2) THEN 'Summer'
        WHEN dd.month IN (3, 4, 5) THEN 'Autumn'
        WHEN dd.month IN (6, 7, 8) THEN 'Winter'
        WHEN dd.month IN (9, 10, 11) THEN 'Spring'
    END,
    dd.month_name,
    dp.product_category,
    dp.product_type
ORDER BY
    dd.year,
    total_margin_usd DESC;