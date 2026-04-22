-- ============================================================
-- ICE Entertainment - Staging Database
-- Database: stg
-- Description: Raw copy of all source system data
--              No transformations, no joins
--              Mirrors source files as closely as practical
-- ============================================================

CREATE DATABASE IF NOT EXISTS stg;
USE stg;

-- ============================================================
-- DROP TABLES
-- ============================================================
DROP TABLE IF EXISTS stg_order_details;
DROP TABLE IF EXISTS stg_order_header;
DROP TABLE IF EXISTS stg_customer;
DROP TABLE IF EXISTS stg_store;
DROP TABLE IF EXISTS stg_product;
DROP TABLE IF EXISTS stg_subscription;
DROP TABLE IF EXISTS stg_currency_rate;
DROP TABLE IF EXISTS stg_currency;
DROP TABLE IF EXISTS stg_package;
DROP TABLE IF EXISTS stg_package_type;
DROP TABLE IF EXISTS stg_product_type;
DROP TABLE IF EXISTS stg_product_category;
DROP TABLE IF EXISTS stg_product_status;
DROP TABLE IF EXISTS stg_channel;
DROP TABLE IF EXISTS stg_customer_status;
DROP TABLE IF EXISTS stg_customer_type;
DROP TABLE IF EXISTS stg_division;
DROP TABLE IF EXISTS stg_region;
DROP TABLE IF EXISTS stg_state;
DROP TABLE IF EXISTS stg_interest;
DROP TABLE IF EXISTS stg_occupation;
DROP TABLE IF EXISTS stg_house_hold_income;
DROP TABLE IF EXISTS stg_permission;
DROP TABLE IF EXISTS stg_address_type;
DROP TABLE IF EXISTS stg_email_address_type;
DROP TABLE IF EXISTS stg_phone_number_type;

-- ============================================================
-- ORDER_DETAILS
-- Source: Sales System
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
-- ORDER_HEADER
-- ============================================================
CREATE TABLE stg_order_header (
    order_id         INT,
    order_date       DATE,
    customer_number  INT,
    store_number     INT,
    currency         VARCHAR(10),
    created          DATE,
    last_updated     DATE,
    purchase_type    VARCHAR(20)
);

-- ============================================================
-- CUSTOMER
-- ============================================================
CREATE TABLE stg_customer (
    customer_number      INT,
    account_number       VARCHAR(50),
    customer_type        CHAR(1),
    name                 VARCHAR(255),
    gender               CHAR(1),
    email_address        VARCHAR(255),
    date_of_birth        DATE,
    address1             VARCHAR(255),
    address2             VARCHAR(255),
    address3             VARCHAR(255),
    address4             VARCHAR(255),
    city                 VARCHAR(100),
    state                CHAR(10),
    zipcode              INT,
    country              CHAR(2),
    phone_number         INT,
    occupation           VARCHAR(100),
    household_income     INT,
    date_registered      DATE,
    status               CHAR(2),
    permission           CHAR(1),
    preferred_channel1   VARCHAR(50),
    preferred_channel2   VARCHAR(50),
    interest1            VARCHAR(100),
    interest2            VARCHAR(100),
    interest3            VARCHAR(100),
    created              DATE,
    last_updated         DATE,
    market               VARCHAR(50)
);

-- ============================================================
-- STORE
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
    phone_number    VARCHAR(30),
    web_site        VARCHAR(255),
    region          VARCHAR(100),
    division        VARCHAR(10),
    created         DATE,
    last_updated    DATE
);

-- ============================================================
-- PRODUCT
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
    created             DATETIME,
    last_updated        DATETIME
);

-- ============================================================
-- SUBSCRIPTION
-- ============================================================
CREATE TABLE stg_subscription (
    subscription_id    INT,
    customer_id        INT,
    store_id           INT,
    package_id         INT,
    channel_id         INT,
    start_date         INT,
    end_date           INT,
    status             VARCHAR(20)
);

-- ============================================================
-- CURRENCY_RATE
-- ============================================================
CREATE TABLE stg_currency_rate (
    effective_date    DATE,
    currency_code     CHAR(3),
    currency_rate     DECIMAL(12,6),
    created           DATE,
    last_updated      DATE
);

-- ============================================================
-- CURRENCY
-- ============================================================
CREATE TABLE stg_currency (
    currency_code    CHAR(3),
    currency_name    VARCHAR(100)
);

-- ============================================================
-- PACKAGE
-- ============================================================
CREATE TABLE stg_package (
    package_id      INT,
    name            VARCHAR(100),
    description     VARCHAR(255),
    package_type    CHAR(2),
    package_price   DECIMAL(10,2)
);

-- ============================================================
-- PACKAGE_TYPE
-- ============================================================
CREATE TABLE stg_package_type (
    package_type_code   CHAR(2),
    package_type        VARCHAR(100)
);

-- ============================================================
-- PRODUCT_TYPE
-- ============================================================
CREATE TABLE stg_product_type (
    product_type_code   CHAR(2),
    product_type        VARCHAR(100),
    product_category    VARCHAR(50)
);

-- ============================================================
-- PRODUCT_CATEGORY
-- ============================================================
CREATE TABLE stg_product_category (
    product_category    VARCHAR(50),
    description         VARCHAR(255)
);

-- ============================================================
-- PRODUCT_STATUS
-- ============================================================
CREATE TABLE stg_product_status (
    product_status_code   CHAR(2),
    product_status        VARCHAR(50)
);

-- ============================================================
-- CHANNEL
-- ============================================================
CREATE TABLE stg_channel (
    name          VARCHAR(50),
    description   VARCHAR(255),
    start_date    DATE,
    end_date      DATE,
    status        VARCHAR(20)
);

-- ============================================================
-- CUSTOMER_STATUS
-- ============================================================
CREATE TABLE stg_customer_status (
    customer_status_code   CHAR(2),
    description            VARCHAR(100)
);

-- ============================================================
-- CUSTOMER_TYPE
-- ============================================================
CREATE TABLE stg_customer_type (
    customer_type_code   CHAR(1),
    description          VARCHAR(100)
);

-- ============================================================
-- DIVISION
-- ============================================================
CREATE TABLE stg_division (
    division_code   CHAR(10),
    division_name   VARCHAR(100)
);

-- ============================================================
-- REGION
-- ============================================================
CREATE TABLE stg_region (
    region_code     CHAR(10),
    region_name     VARCHAR(100),
    division_code   CHAR(10)
);

-- ============================================================
-- STATE
-- ============================================================
CREATE TABLE stg_state (
    state_code               CHAR(10),
    state_name               VARCHAR(100),
    formal_name              VARCHAR(100),
    admission_to_statehood   INT,
    population               INT,
    capital                  VARCHAR(100),
    largest_city             VARCHAR(100)
);

-- ============================================================
-- INTEREST
-- ============================================================
CREATE TABLE stg_interest (
    interest                 VARCHAR(100),
    description              VARCHAR(255),
    interest_group           VARCHAR(100),
    associated_product_type  VARCHAR(100),
    related_interest         VARCHAR(100)
);

-- ============================================================
-- OCCUPATION
-- ============================================================
CREATE TABLE stg_occupation (
    occupation_code   INT,
    occupation        VARCHAR(100),
    description       VARCHAR(255),
    category          VARCHAR(100)
);

-- ============================================================
-- HOUSE_HOLD_INCOME
-- ============================================================
CREATE TABLE stg_house_hold_income (
    household_income_code   INT,
    lower_limit             DECIMAL(12,2),
    upper_limit             INT,
    description             VARCHAR(100)
);

-- ============================================================
-- PERMISSION
-- ============================================================
CREATE TABLE stg_permission (
    permission_code   CHAR(1),
    description       VARCHAR(100)
);

-- ============================================================
-- ADDRESS_TYPE
-- ============================================================
CREATE TABLE stg_address_type (
    address_type_code   CHAR(1),
    address_type        VARCHAR(50),
    description         VARCHAR(100)
);

-- ============================================================
-- EMAIL_ADDRESS_TYPE
-- ============================================================
CREATE TABLE stg_email_address_type (
    email_address_type_code   CHAR(1),
    email_address_type        VARCHAR(50),
    description               VARCHAR(100)
);

-- ============================================================
-- PHONE_NUMBER_TYPE
-- ============================================================
CREATE TABLE stg_phone_number_type (
    phone_number_type_code   CHAR(1),
    phone_number_type        VARCHAR(50),
    description              VARCHAR(100)
);

-- ============================================================
-- VERIFY
-- ============================================================
SHOW TABLES;