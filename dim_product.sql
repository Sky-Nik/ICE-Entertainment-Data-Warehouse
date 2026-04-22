use dw;
CREATE TABLE dim_product (
    product_key         INT             NOT NULL AUTO_INCREMENT,
    product_code        INT             NOT NULL,
    product_category    VARCHAR(100)    NOT NULL,
    product_type        VARCHAR(100)    NOT NULL,
    name                VARCHAR(255)    NOT NULL,
    description			VARCHAR(255)	NOT NULL,
    title               VARCHAR(255)    NOT NULL,
    artist_code         VARCHAR(100)    NOT NULL,
    product_type_code	CHAR(10)		NOT NULL,
    format              VARCHAR(50)     NOT NULL,
    unit_price          DECIMAL(10,2)   NOT NULL,
    unit_cost           DECIMAL(10,2)   NOT NULL,
    status              VARCHAR(50)     NOT NULL,
    created				DATE			NOT NULL,
    last_updated		DATE			NOT NULL,
    created_timestamp   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_timestamp   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT pk_dim_product 
        PRIMARY KEY (product_key)
);

