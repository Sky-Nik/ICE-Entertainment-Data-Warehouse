-- ============================================================
-- ICE Entertainment - Staging Database
-- Database: stg
-- Description: Raw copy of all source system data
--              No transformations, no joins
--              Mirrors source files exactly
-- ============================================================

CREATE DATABASE IF NOT EXISTS stg;
USE stg;

-- ============================================================
-- DROP TABLES (clean slate each time)
-- ============================================================
DROP TABLE IF EXISTS stg_order_details;
DROP TABLE IF EXISTS stg_order_header;
DROP TABLE IF EXISTS stg_customer;
DROP TABLE IF EXISTS stg_store;
DROP TABLE IF EXISTS stg_product;
DROP TABLE IF EXISTS stg_product_type;
DROP TABLE IF EXISTS stg_subscription;
DROP TABLE IF EXISTS stg_package;
DROP TABLE IF EXISTS stg_region;
DROP TABLE IF EXISTS stg_division;
DROP TABLE IF EXISTS stg_house_hold_income;
DROP TABLE IF EXISTS stg_currency_rate;
DROP TABLE IF EXISTS stg_currency;

-- ============================================================
-- ORDER DETAILS
-- Source: Order_Details.xlsx (50,000 rows)
-- ============================================================
CREATE TABLE stg_order_details (
    order_id        INT,
    line_no         INT,
    product_code    INT,
    qty             INT,
    price           DECIMAL(10,4),
    unit_cost       DECIMAL(10,4)
);

-- ============================================================
-- ORDER HEADER
-- Source: Order_Header.xlsx (17,000 rows)
-- ============================================================
CREATE TABLE stg_order_header (
    order_id            INT,
    order_date          VARCHAR(20),
    customer_number     INT,
    store_number        INT,
    currency            CHAR(3),
    created             VARCHAR(20),
    last_updated        VARCHAR(20),
    purchase_type       VARCHAR(20)
);

-- ============================================================
-- CUSTOMER
-- Source: Customer.xlsx (5,000 rows)
-- ============================================================
CREATE TABLE stg_customer (
    customer_number     INT,
    account_number      VARCHAR(50),
    customer_type       CHAR(1),
    name                VARCHAR(255),
    gender              CHAR(1),
    email_address       VARCHAR(255),
    date_of_birth       VARCHAR(20),
    address1            VARCHAR(255),
    address2            VARCHAR(255),
    address3            VARCHAR(255),
    address4            VARCHAR(255),
    city                VARCHAR(100),
    state               CHAR(10),
    zipcode             VARCHAR(20),
    country             CHAR(2),
    phone_number        VARCHAR(20),
    occupation          VARCHAR(100),
    household_income    INT,
    date_registered     VARCHAR(20),
    status              CHAR(2),
    permission          CHAR(1),
    preferred_channel1  VARCHAR(50),
    preferred_channel2  VARCHAR(50),
    interest1           VARCHAR(100),
    interest2           VARCHAR(100),
    interest3           VARCHAR(100),
    created             VARCHAR(20),
    last_updated        VARCHAR(20),
    market              VARCHAR(50)
);

-- ============================================================
-- STORE
-- Source: Store.xlsx (500 rows)
-- ============================================================
CREATE TABLE stg_store (
    store_number    INT,
    store_name      VARCHAR(100),
    store_type      VARCHAR(50),
    address1        VARCHAR(255),
    address2        VARCHAR(255),
    address3        VARCHAR(255),
    address4        VARCHAR(255),
    city            VARCHAR(100),
    state           CHAR(10),
    zipcode         VARCHAR(20),
    country         CHAR(2),
    phone_number    VARCHAR(20),
    web_site        VARCHAR(255),
    region          VARCHAR(50),
    division        CHAR(10),
    created         VARCHAR(20),
    last_updated    VARCHAR(20)
);

-- ============================================================
-- PRODUCT
-- Source: Product.xlsx (1,000 rows)
-- ============================================================
CREATE TABLE stg_product (
    product_code        INT,
    name                VARCHAR(255),
    description         VARCHAR(255),
    title               VARCHAR(255),
    artist_code         VARCHAR(100),
    product_type_code   CHAR(2),
    format              VARCHAR(50),
    unit_price          DECIMAL(10,4),
    unit_cost           DECIMAL(10,4),
    status              CHAR(2),
    created             VARCHAR(50),
    last_updated        VARCHAR(50)
);

-- ============================================================
-- PRODUCT TYPE
-- Source: Product_Type.xlsx (65 rows)
-- ============================================================
CREATE TABLE stg_product_type (
    product_type_code   CHAR(2),
    product_type        VARCHAR(100),
    product_category    VARCHAR(50)
);

-- ============================================================
-- SUBSCRIPTION
-- Source: Subscription.xlsx (3,000 rows)
-- ============================================================
CREATE TABLE stg_subscription (
    subscription_id     INT,
    customer_id         INT,
    store_id            INT,
    package_id          INT,
    channel_id          INT,
    start_date          INT,
    end_date            INT,
    status              VARCHAR(20)
);

-- ============================================================
-- PACKAGE
-- Source: Package.xlsx (24 rows)
-- ============================================================
CREATE TABLE stg_package (
    package_id      INT,
    name            VARCHAR(100),
    description     VARCHAR(255),
    package_type    CHAR(2),
    package_price   DECIMAL(10,2)
);

-- ============================================================
-- REGION
-- Source: Region.xlsx (14 rows)
-- ============================================================
CREATE TABLE stg_region (
    region_code     CHAR(10),
    region_name     VARCHAR(100),
    division_code   CHAR(10)
);

-- ============================================================
-- DIVISION
-- Source: Division.xlsx (3 rows)
-- ============================================================
CREATE TABLE stg_division (
    division_code   CHAR(10),
    division_name   VARCHAR(100)
);

-- ============================================================
-- HOUSE HOLD INCOME
-- Source: House_Hold_Income.xlsx (11 rows)
-- ============================================================
CREATE TABLE stg_house_hold_income (
    household_income_code   INT,
    lower_limit             DECIMAL(10,2),
    upper_limit             INT,
    description             VARCHAR(100)
);

-- ============================================================
-- CURRENCY RATE
-- Source: Currency_Rate.xlsx (357 rows)
-- ============================================================
CREATE TABLE stg_currency_rate (
    effective_date  VARCHAR(30),
    currency_code   CHAR(3),
    currency_rate   DECIMAL(10,6),
    created         VARCHAR(20),
    last_updated    VARCHAR(20)
);

-- ============================================================
-- CURRENCY
-- Source: Currency.xlsx
-- ============================================================
CREATE TABLE stg_currency (
    currency_code   CHAR(3),
    currency_name   VARCHAR(100)
);

-- ============================================================
-- VERIFY ALL TABLES CREATED
-- ============================================================
SHOW TABLES;