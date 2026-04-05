CREATE DATABASE dw;
USE dw;
SELECT
    COUNT(*)                    AS total_rows,
    MIN(sql_date)               AS first_date,
    MAX(sql_date)               AS last_date,
    COUNT(DISTINCT fiscal_year) AS fiscal_years
FROM dw.dim_date;