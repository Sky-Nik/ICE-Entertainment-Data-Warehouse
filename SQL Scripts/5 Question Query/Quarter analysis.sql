SELECT
    d.year,
    d.quarter,
    SUM(f.qty) AS total_unit_sales,
    SUM(f.dollar_sales_usd) AS total_dollar_sales_usd,
    SUM(f.margin_usd) AS total_margin_usd
FROM fact_sales f
JOIN dim_date d
    ON f.date_key = d.date_key
GROUP BY
    d.year,
    d.quarter
ORDER BY
    d.year,
    d.quarter;
