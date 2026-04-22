-- ============================================================
-- ICE Entertainment - Complete DW Schema
-- Database: dw
-- Compatible: MySQL 8.0+
-- Includes: All dimensions + fact_sales + fact_subscription
-- ============================================================

USE dw;

-- ============================================================
-- STEP 1: Drop fact tables first (FK dependencies)
-- ============================================================
DROP TABLE IF EXISTS fact_sales;
DROP TABLE IF EXISTS fact_subscription;

-- ============================================================
-- STEP 2: Drop dimension tables
-- ============================================================
DROP TABLE IF EXISTS dim_customer;
DROP TABLE IF EXISTS dim_market;
DROP TABLE IF EXISTS dim_package;
DROP TABLE IF EXISTS dim_product;
DROP TABLE IF EXISTS dim_store;
DROP TABLE IF EXISTS dim_subscription;
DROP TABLE IF EXISTS dim_currency;
DROP TABLE IF EXISTS dim_date;

-- ============================================================
-- STEP 3: Recreate dim_date (no dependencies)
-- ============================================================
CREATE TABLE dim_date (
    date_key            INT             NOT NULL AUTO_INCREMENT,
    date                CHAR(10)        NOT NULL,
    system_date         CHAR(10)        NOT NULL,
    sql_date            DATE            NOT NULL,
    julian_date         INT             NOT NULL,
    day                 TINYINT         NOT NULL,
    day_of_the_week     TINYINT         NOT NULL,
    day_name            VARCHAR(9)      NOT NULL,
    day_of_the_year     SMALLINT        NOT NULL,
    week_number         TINYINT         NOT NULL,
    month               TINYINT         NOT NULL,
    month_name          VARCHAR(9)      NOT NULL,
    short_month_name    CHAR(3)         NOT NULL,
    quarter             CHAR(2)         NOT NULL,
    year                SMALLINT        NOT NULL,
    fiscal_week         TINYINT         NULL,
    fiscal_period       CHAR(4)         NULL,
    fiscal_quarter      CHAR(3)         NULL,
    fiscal_year         CHAR(6)         NULL,
    week_day            TINYINT         NOT NULL,
    us_holiday          TINYINT         NULL,
    uk_holiday          TINYINT         NULL,
    month_end           TINYINT         NOT NULL,
    period_end          TINYINT         NULL,
    short_day           TINYINT         NULL,
    source_system_code  TINYINT         NOT NULL,
    create_timestamp    DATETIME        NOT NULL,
    update_timestamp    DATETIME        NOT NULL,
    CONSTRAINT pk_dim_date PRIMARY KEY (date_key)
);

-- ============================================================
-- STEP 4: dim_customer (SCD Type 2)
-- ============================================================
CREATE TABLE dim_customer (
    customer_key        INT             NOT NULL AUTO_INCREMENT,
    customer_number     INT             NOT NULL,
    customer_type       CHAR(1)         NOT NULL,
    name                VARCHAR(255)    NOT NULL,
    gender              VARCHAR(100)    NOT NULL,
    date_of_birth       DATE            NOT NULL,
    age_group           VARCHAR(20)     NOT NULL,
    city                VARCHAR(100)    NOT NULL,
    state               CHAR(10)        NULL,
    zipcode             VARCHAR(20)     NOT NULL,
    country             VARCHAR(100)    NOT NULL,
    market              VARCHAR(50)     NOT NULL,
    status              CHAR(2)         NOT NULL,
    occupation          VARCHAR(100)    NULL,
    household_income    VARCHAR(50)     NULL,
    permission          CHAR(1)         NULL,
    preferred_channel1  VARCHAR(100)    NULL,
    preferred_channel2  VARCHAR(50)     NULL,
    interest1           VARCHAR(100)    NULL,
    interest2           VARCHAR(100)    NULL,
    interest3           VARCHAR(100)    NULL,
    effective_date      DATE            NOT NULL,
    expiry_date         DATE            NULL,
    is_current          TINYINT(1)      NOT NULL DEFAULT 1,
    created_timestamp   TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
    updated_timestamp   TIMESTAMP       DEFAULT CURRENT_TIMESTAMP
                        ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT pk_dim_customer PRIMARY KEY (customer_key)
);

-- ============================================================
-- STEP 5: dim_market (SCD Type 2)
-- ============================================================
CREATE TABLE dim_market (
    market_key          INT             NOT NULL AUTO_INCREMENT,
    market              VARCHAR(100)    NOT NULL,
    is_current          TINYINT(1)      NOT NULL DEFAULT 1,
    created_timestamp   TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
    updated_timestamp   TIMESTAMP       DEFAULT CURRENT_TIMESTAMP
                        ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT pk_dim_market PRIMARY KEY (market_key)
);

INSERT INTO dim_market (market, is_current) VALUES
    ('Victoria', 1),
    ('Rest of Australia', 1),
    ('International', 1);

-- ============================================================
-- STEP 6: dim_package
-- ============================================================
CREATE TABLE dim_package (
    package_key         INT             NOT NULL AUTO_INCREMENT,
    package_id          INT             NOT NULL,
    name                VARCHAR(100)    NOT NULL,
    description         VARCHAR(100)    NOT NULL,
    package_type        VARCHAR(100)    NOT NULL,
    package_price       DECIMAL(10,2)   NOT NULL,
    created_timestamp   TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
    updated_timestamp   TIMESTAMP       DEFAULT CURRENT_TIMESTAMP
                        ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT pk_dim_package PRIMARY KEY (package_key)
);

-- ============================================================
-- STEP 7: dim_product
-- ============================================================
CREATE TABLE dim_product (
    product_key         INT             NOT NULL AUTO_INCREMENT,
    product_code        INT             NOT NULL,
    product_category    VARCHAR(100)    NOT NULL,
    product_type        VARCHAR(100)    NOT NULL,
    name                VARCHAR(255)    NOT NULL,
    description         VARCHAR(255)    NOT NULL,
    title               VARCHAR(255)    NOT NULL,
    artist_code         VARCHAR(100)    NOT NULL,
    product_type_code   CHAR(10)        NOT NULL,
    format              VARCHAR(50)     NOT NULL,
    unit_price          DECIMAL(10,2)   NOT NULL,
    unit_cost           DECIMAL(10,2)   NOT NULL,
    status              VARCHAR(50)     NOT NULL,
    created             DATE            NOT NULL,
    last_updated        DATE            NOT NULL,
    created_timestamp   TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
    updated_timestamp   TIMESTAMP       DEFAULT CURRENT_TIMESTAMP
                        ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT pk_dim_product PRIMARY KEY (product_key)
);

-- ============================================================
-- STEP 8: dim_store
-- ============================================================
CREATE TABLE dim_store (
    store_key           INT             NOT NULL AUTO_INCREMENT,
    store_number        INT             NOT NULL,
    store_name          VARCHAR(100)    NOT NULL,
    store_type          VARCHAR(50)     NOT NULL,
    address1            VARCHAR(100)    NOT NULL,
    address2            VARCHAR(100)    NOT NULL,
    address3            VARCHAR(100)    NOT NULL,
    address4            VARCHAR(100)    NULL,
    city                VARCHAR(100)    NOT NULL,
    state               VARCHAR(100)    NULL,
    zipcode             VARCHAR(10)     NOT NULL,
    country             CHAR(2)         NOT NULL,
    region              VARCHAR(50)     NOT NULL,
    division            VARCHAR(100)    NOT NULL,
    market              VARCHAR(50)     NOT NULL,
    phone_number        VARCHAR(20)     NOT NULL,
    web_site            VARCHAR(100)    NOT NULL,
    created             DATE            NOT NULL,
    last_updated        DATE            NOT NULL,
    created_timestamp   TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
    updated_timestamp   TIMESTAMP       DEFAULT CURRENT_TIMESTAMP
                        ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT pk_dim_store PRIMARY KEY (store_key)
);

-- ============================================================
-- STEP 9: dim_subscription
-- ============================================================
CREATE TABLE dim_subscription (
    subscription_key    INT             NOT NULL AUTO_INCREMENT,
    subscription_id     INT             NOT NULL,
    customer_id         INT             NOT NULL,
    store_id            INT             NOT NULL,
    package_id          INT             NOT NULL,
    channel_id          INT             NOT NULL,
    package_name        VARCHAR(100)    NOT NULL,
    package_type        VARCHAR(50)     NOT NULL,
    package_price       DECIMAL(10,2)   NOT NULL,
    start_date          DATE            NOT NULL,
    end_date            DATE            NULL,
    status              VARCHAR(20)     NOT NULL,
    created_timestamp   TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
    updated_timestamp   TIMESTAMP       DEFAULT CURRENT_TIMESTAMP
                        ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT pk_dim_subscription PRIMARY KEY (subscription_key)
);

-- ============================================================
-- STEP 10: dim_currency
-- ============================================================
CREATE TABLE dim_currency (
    currency_key        INT             NOT NULL AUTO_INCREMENT,
    currency_code       CHAR(3)         NOT NULL,
    currency_name       VARCHAR(100)    NOT NULL,
    effective_date      DATE            NOT NULL,
    currency_rate       DECIMAL(10,6)   NOT NULL,
    created_timestamp   TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
    updated_timestamp   TIMESTAMP       DEFAULT CURRENT_TIMESTAMP
                        ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT pk_dim_currency PRIMARY KEY (currency_key)
);

-- ============================================================
-- STEP 11: fact_sales
-- ============================================================
CREATE TABLE fact_sales (
    sales_key           INT             NOT NULL AUTO_INCREMENT,
    date_key            INT             NOT NULL,
    customer_key        INT             NOT NULL,
    product_key         INT             NOT NULL,
    store_key           INT             NOT NULL,
    currency_key        INT             NOT NULL,
    subscription_key    INT             NULL,
    market_key          INT             NOT NULL,
    order_id            INT             NOT NULL,
    line_no             INT             NOT NULL,
    qty                 INT             NOT NULL,
    price               DECIMAL(10,2)   NOT NULL,
    unit_cost           DECIMAL(10,2)   NOT NULL,
    exchange_rate       DECIMAL(10,6)   NOT NULL,
    dollar_sales_usd    DECIMAL(12,2)   NOT NULL,
    cost_usd            DECIMAL(12,2)   NOT NULL,
    margin_usd          DECIMAL(12,2)   NOT NULL,
    CONSTRAINT pk_fact_sales PRIMARY KEY (sales_key),
    FOREIGN KEY (date_key)          REFERENCES dim_date(date_key),
    FOREIGN KEY (customer_key)      REFERENCES dim_customer(customer_key),
    FOREIGN KEY (product_key)       REFERENCES dim_product(product_key),
    FOREIGN KEY (store_key)         REFERENCES dim_store(store_key),
    FOREIGN KEY (currency_key)      REFERENCES dim_currency(currency_key),
    FOREIGN KEY (subscription_key)  REFERENCES dim_subscription(subscription_key),
    FOREIGN KEY (market_key)        REFERENCES dim_market(market_key)
);

-- ============================================================
-- STEP 12: fact_subscription
-- ============================================================
CREATE TABLE fact_subscription (
    subscription_package_key    INT             NOT NULL AUTO_INCREMENT,
    date_key                    INT             NOT NULL,
    customer_key                INT             NOT NULL,
    subscription_key            INT             NOT NULL,
    package_key                 INT             NOT NULL,
    channel                     VARCHAR(100)    NOT NULL,
    subscription_duration_days  INT             NULL,
    active_flag                 INT             NULL,
    cancelled_flag              INT             NULL,
    CONSTRAINT pk_fact_subscription PRIMARY KEY (subscription_package_key),
    FOREIGN KEY (date_key)          REFERENCES dim_date(date_key),
    FOREIGN KEY (customer_key)      REFERENCES dim_customer(customer_key),
    FOREIGN KEY (subscription_key)  REFERENCES dim_subscription(subscription_key),
    FOREIGN KEY (package_key)       REFERENCES dim_package(package_key)
);

-- ============================================================
-- Verification
-- ============================================================
SELECT table_name, table_rows
FROM information_schema.tables
WHERE table_schema = 'dw'
ORDER BY table_name;