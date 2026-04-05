
CREATE TABLE dim_currency (
    currency_key        INT             NOT NULL AUTO_INCREMENT,
    currency_code       CHAR(3)         NOT NULL,
    currency_name       VARCHAR(100)    NOT NULL,
    effective_date      DATE            NOT NULL,
    currency_rate       DECIMAL(10,6)   NOT NULL,
    CONSTRAINT pk_dim_currency 
        PRIMARY KEY (currency_key)
);