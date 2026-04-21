DROP TABLE IF EXISTS dw.dim_currency;
CREATE TABLE dw.dim_currency (
    currency_key        INT             NOT NULL AUTO_INCREMENT,
    currency_code       CHAR(3)         NOT NULL,
    currency_name       VARCHAR(100)    NOT NULL,
    CONSTRAINT pk_dim_currency 
        PRIMARY KEY (currency_key)
);