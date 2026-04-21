DROP TABLE IF EXISTS dw.dim_store;
CREATE TABLE dw.dim_store (
    store_key       INT             NOT NULL AUTO_INCREMENT PRIMARY KEY,
    store_number    INT             NOT NULL,
    store_name      VARCHAR(100)    NOT NULL,
    store_type      VARCHAR(50)     NOT NULL,
    city            VARCHAR(100)    NOT NULL,
    state           CHAR(10)        NULL,
    country         CHAR(2)         NOT NULL,
    region          VARCHAR(50)     NOT NULL,
    division        CHAR(10)        NOT NULL,
    zipcode         VARCHAR(20)     NOT NULL,
     CONSTRAINT uq_dim_store UNIQUE (store_number)
);