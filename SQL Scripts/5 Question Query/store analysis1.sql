SELECT
    d.fiscal_year,
    d.month ,
    d.month_name,
    s.division,
    s.region,
    s.country,
    s.state,
    s.city,
    s.store_type,
    s.store_number,
    SUM(f.qty) AS total_unit_sales,
    SUM(f.dollar_sales_usd) AS total_dollar_sales_usd,
    SUM(f.margin_usd) AS total_margin_usd
FROM fact_sales f
JOIN dim_store s
    ON f.store_key = s.store_key
JOIN dim_date d
    ON f.date_key = d.date_key
GROUP BY
    d.fiscal_year,
    d.month,
    d.month_name,
    s.division,
    s.region,
    s.country,
    s.state,
    s.city,
    s.store_type,
    s.store_number
ORDER BY
    total_margin_usd DESC;