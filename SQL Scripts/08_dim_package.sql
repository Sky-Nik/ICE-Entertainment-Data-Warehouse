DROP TABLE IF EXISTS dw.dim_package;
CREATE TABLE dw.dim_package (
    package_key         INT           NOT NULL AUTO_INCREMENT PRIMARY KEY,
    package_id          INT           NOT NULL,
    package_name        VARCHAR(255)  NOT NULL,
    package_description VARCHAR(200)  NOT NULL,
    package_type_code   VARCHAR(100)  NOT NULL,
    package_type_name   VARCHAR(100)  NOT NULL,
    package_price       DECIMAL(14,2) NOT NULL,
    CONSTRAINT uq_dim_package UNIQUE (package_id)
);