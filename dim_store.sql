USE dw;
CREATE TABLE dim_store (
    store_key       INT             NOT NULL AUTO_INCREMENT,
    store_number    INT             NOT NULL,
    address1		VARCHAR(100)	NOT NULL,
    address2		VARCHAR(100)	NOT NULL,
    address3		VARCHAR(100)	NOT NULL,
    address4		VARCHAR(100)	NULL,
    division        VARCHAR(100)    NOT NULL,
    region          VARCHAR(50)     NOT NULL,
    country         CHAR(2)         NOT NULL,
    state           VARCHAR(100)    NULL,
    city            VARCHAR(100)    NOT NULL,
    store			VARCHAR(50)		NOT NULL,
    store_type      VARCHAR(50)     NOT NULL,
    zipcode			VARCHAR(10)		NOT NULL,
    phone_number	VARCHAR(10)		NOT NULL,
    web_site		VARCHAR(100)	NOT NULL,
    created			DATE			NOT NULL,
    last_updated	DATE			NOT NULL,
    created_timestamp   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_timestamp   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT pk_dim_store 
        PRIMARY KEY (store_key)
);