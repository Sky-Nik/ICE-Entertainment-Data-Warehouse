DROP TABLE IF EXISTS dw.fact_sales;
CREATE TABLE dw.fact_sales (
    sales_key           INT             NOT NULL AUTO_INCREMENT PRIMARY KEY,
    order_id            INT             NOT NULL,
    line_no             INT             NOT NULL,
    
    date_key            INT             NOT NULL,
    customer_key        INT             NOT NULL,
    product_key         INT             NOT NULL,
    store_key           INT             NOT NULL,
    currency_key        INT             NOT NULL,
    market_key          INT             NOT NULL,
    
    qty                 INT             NOT NULL,
    sales_amount_local  DECIMAL(14,2)   NOT NULL,
    sales_amount_usd    DECIMAL(14,2)   NOT NULL,
    cost_amount_local   DECIMAL(14,2)   NOT NULL,
    cost_amount_usd     DECIMAL(14,2)   NOT NULL,
    margin_usd          DECIMAL(14,2)   NOT NULL,
    
    CONSTRAINT fk_fact_sales_date
        FOREIGN KEY (date_key) REFERENCES dim_date(date_key),

    CONSTRAINT fk_fact_sales_customer
        FOREIGN KEY (customer_key) REFERENCES dim_customer(customer_key),

    CONSTRAINT fk_fact_sales_product
        FOREIGN KEY (product_key) REFERENCES dim_product(product_key),

    CONSTRAINT fk_fact_sales_store
        FOREIGN KEY (store_key) REFERENCES dim_store(store_key),

    CONSTRAINT fk_fact_sales_market
        FOREIGN KEY (market_key) REFERENCES dim_market(market_key),

    CONSTRAINT fk_fact_sales_currency
        FOREIGN KEY (currency_key) REFERENCES dim_currency(currency_key),

    CONSTRAINT uq_fact_sales_orderline
        UNIQUE (order_id, line_no)
);