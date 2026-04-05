CREATE TABLE dim_product (
    -- Surrogate Key
    product_key         INT             NOT NULL AUTO_INCREMENT,
    -- Natural Key
    product_code        INT             NOT NULL,
    -- Hierarchy
    product_category    VARCHAR(100)    NOT NULL,
    product_type        VARCHAR(100)    NOT NULL,
    -- Product Details
    name                VARCHAR(255)    NOT NULL,
    title               VARCHAR(255)    NOT NULL,
    artist_code         VARCHAR(100)    NULL,
    format              VARCHAR(50)     NOT NULL,
    -- Pricing
    unit_price          DECIMAL(10,2)   NOT NULL,
    unit_cost           DECIMAL(10,2)   NOT NULL,
    -- Status
    status              CHAR(2)         NOT NULL,
    -- Primary Key
    CONSTRAINT pk_dim_product 
        PRIMARY KEY (product_key)
);