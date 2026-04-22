SELECT
    s.division,
    s.region,
    s.country,
    s.state,
    s.city,
    s.store,
    s.store_type,
    SUM(f.qty) AS total_unit_sales,
    SUM(f.dollar_sales_usd) AS total_dollar_sales_usd,
    SUM(f.margin_usd) AS total_margin_usd
FROM fact_sales f
JOIN dim_store s
    ON f.store_key = s.store_key
GROUP BY
    s.division,
    s.region,
    s.country,
    s.state,
    s.city,
    s.store,
    s.store_type
ORDER BY
    total_margin_usd DESC;