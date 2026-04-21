DROP TABLE IF EXISTS dw.dim_product;
CREATE TABLE dw.dim_product (
    -- Surrogate Key
    product_key         INT             NOT NULL AUTO_INCREMENT PRIMARY KEY,
    -- Natural Key
    product_code        INT             NOT NULL,
    -- Hierarchy
    product_category    VARCHAR(100)    NOT NULL,
    product_type        VARCHAR(100)    NOT NULL,
    -- Product Details
    product_name        VARCHAR(255)    NOT NULL,
    title               VARCHAR(255)    NOT NULL,
    artist_code         VARCHAR(100)    NULL,
    format              VARCHAR(50)     NOT NULL,
    product_status              CHAR(2)         NOT NULL,

       CONSTRAINT uq_dim_product UNIQUE (product_code)
);