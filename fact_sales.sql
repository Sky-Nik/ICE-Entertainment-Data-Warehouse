DROP TABLE IF EXISTS fact_sales;
CREATE TABLE fact_sales (
    sales_key           INT             NOT NULL AUTO_INCREMENT,
    date_key            INT             NOT NULL,
    customer_key        INT             NOT NULL,
    product_key         INT             NOT NULL,
    store_key           INT             NOT NULL,
    currency_key        INT             NOT NULL,
    order_id            INT             NOT NULL,
    line_no             INT             NOT NULL,
    qty                 INT             NOT NULL,
    price               DECIMAL(10,2)   NOT NULL,
    unit_cost           DECIMAL(10,2)   NOT NULL,
    exchange_rate       DECIMAL(10,6)   NOT NULL,
    dollar_sales_usd    DECIMAL(12,2)   NOT NULL,
    cost_usd            DECIMAL(12,2)   NOT NULL,
    margin_usd          DECIMAL(12,2)   NOT NULL,
    CONSTRAINT pk_fact_sales 
        PRIMARY KEY (sales_key),
    FOREIGN KEY (date_key)          REFERENCES dim_date(date_key),
    FOREIGN KEY (customer_key)      REFERENCES dim_customer(customer_key),
    FOREIGN KEY (product_key)       REFERENCES dim_product(product_key),
    FOREIGN KEY (store_key)         REFERENCES dim_store(store_key),
    FOREIGN KEY (currency_key)      REFERENCES dim_currency(currency_key)
);
