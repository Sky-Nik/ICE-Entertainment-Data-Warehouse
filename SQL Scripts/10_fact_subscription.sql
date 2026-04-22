DROP TABLE IF EXISTS dw.fact_subscription;
CREATE TABLE dw.fact_subscription (
    subscription_key    INT             NOT NULL AUTO_INCREMENT PRIMARY KEY,
    subscription_id     INT             NOT NULL,
    package_key         INT             NOT NULL,
    customer_key        INT             NOT NULL,
    store_key           INT             NOT NULL,
    channel_id          INT             NOT NULL,
    subscription_duration_days   INT             NOT NULL,
    subscription_status VARCHAR(100)    NOT NULL,
    subscription_price_usd_all DECIMAL(14,2)   NOT NULL,
    
	CONSTRAINT uq_fact_subscription UNIQUE (subscription_id),
    CONSTRAINT fk_fact_subscription_package
        FOREIGN KEY (package_key) REFERENCES dw.dim_package(package_key),
    CONSTRAINT fk_fact_subscription_customer
        FOREIGN KEY (customer_key) REFERENCES dw.dim_customer(customer_key),
    CONSTRAINT fk_fact_subscription_store
        FOREIGN KEY (store_key) REFERENCES dw.dim_store(store_key)
);