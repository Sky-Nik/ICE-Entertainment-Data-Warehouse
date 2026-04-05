
CREATE TABLE dim_store (
    store_key       INT             NOT NULL AUTO_INCREMENT,
    store_number    INT             NOT NULL,
    store_name      VARCHAR(100)    NOT NULL,
    store_type      VARCHAR(50)     NOT NULL,
    city            VARCHAR(100)    NOT NULL,
    state           CHAR(10)        NULL,
    country         CHAR(2)         NOT NULL,
    region          VARCHAR(50)     NOT NULL,
    division        CHAR(10)        NOT NULL,
    market          VARCHAR(50)     NOT NULL,
    CONSTRAINT pk_dim_store 
        PRIMARY KEY (store_key)
);