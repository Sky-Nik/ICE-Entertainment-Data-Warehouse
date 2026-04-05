
CREATE TABLE dim_subscription (
    subscription_key    INT             NOT NULL AUTO_INCREMENT,
    subscription_id     INT             NOT NULL,
    customer_number     INT             NOT NULL,
    package_name        VARCHAR(100)    NOT NULL,
    package_type        VARCHAR(50)     NOT NULL,
    package_price       DECIMAL(10,2)   NOT NULL,
    start_date          DATE            NOT NULL,
    end_date            DATE            NULL,
    status              VARCHAR(20)     NOT NULL,
    CONSTRAINT pk_dim_subscription 
        PRIMARY KEY (subscription_key)
);