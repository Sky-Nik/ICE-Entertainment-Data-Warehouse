USE dw;

DROP TABLE IF EXISTS dim_market;

CREATE TABLE dim_market (
    market_key          INT             NOT NULL AUTO_INCREMENT,
    market              VARCHAR(100)    NOT NULL,
    is_current          TINYINT(1)      NOT NULL DEFAULT 1,
    CONSTRAINT pk_dim_market
        PRIMARY KEY (market_key)
);