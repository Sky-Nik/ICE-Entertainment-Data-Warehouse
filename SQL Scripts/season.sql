USE dw;

WITH product_profitability AS (
    SELECT
        dp.product_category,
        dp.product_type,
        dp.title AS product_title,
        dd.year,
        dd.month,
        dd.month_name,
        CASE
            WHEN dd.month IN (12, 1, 2) THEN 'Summer'
            WHEN dd.month IN (3, 4, 5) THEN 'Autumn'
            WHEN dd.month IN (6, 7, 8) THEN 'Winter'
            WHEN dd.month IN (9, 10, 11) THEN 'Spring'
        END AS season,
        fs.qty,
        fs.dollar_sales_usd,
        fs.margin_usd
    FROM fact_sales fs
    JOIN dim_product dp
        ON fs.product_key = dp.product_key
    JOIN dim_date dd
        ON fs.date_key = dd.date_key
)
SELECT
    product_category,
    product_type,
    product_title,
    year,
    season,
    month_name,
    SUM(qty) AS total_unit_sales,
    ROUND(SUM(dollar_sales_usd), 2) AS total_dollar_sales_usd,
    ROUND(SUM(margin_usd), 2) AS total_margin_usd
FROM product_profitability
GROUP BY
    product_category,
    product_type,
    product_title,
    year,
    season,
    month_name
ORDER BY total_margin_usd DESC;