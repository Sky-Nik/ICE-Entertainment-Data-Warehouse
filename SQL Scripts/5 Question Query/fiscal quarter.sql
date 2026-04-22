SELECT
    d.fiscal_year,
    d.fiscal_quarter,
    SUM(f.qty) AS total_unit_sales,
    SUM(f.dollar_sales_usd) AS total_dollar_sales_usd,
    SUM(f.margin_usd) AS total_margin_usd
FROM fact_sales f
JOIN dim_date d
    ON f.date_key = d.date_key
GROUP BY
    d.fiscal_year,
    d.fiscal_quarter
ORDER BY
    d.fiscal_year,
    d.fiscal_quarter;




