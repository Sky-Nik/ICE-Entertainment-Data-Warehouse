
CREATE TABLE dim_currency (
    currency_key        INT             NOT NULL AUTO_INCREMENT,
    currency_code       CHAR(3)         NOT NULL,
    currency_name       VARCHAR(100)    NOT NULL,
    effective_date      DATE            NOT NULL,
    currency_rate       DECIMAL(10,6)   NOT NULL,
    
    created_timestamp   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_timestamp   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT pk_dim_currency 
        PRIMARY KEY (currency_key)
);

