DROP TABLE IF EXISTS dw.dim_market;
CREATE TABLE dw.dim_market (
    market_key                    INT AUTO_INCREMENT PRIMARY KEY,
    market_name                   VARCHAR(100) NOT NULL,
    country_scope                 VARCHAR(100),
    state_scope                   VARCHAR(100),
    market_description            VARCHAR(255),
    market_effective_start_date   DATE NOT NULL,
    market_effective_end_date     DATE,
    market_current_flag           CHAR(1) NOT NULL DEFAULT 'Y',
    CONSTRAINT uq_dim_market_version
        UNIQUE (market_name, market_effective_start_date)
);