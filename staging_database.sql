-- ************************************************
-- ICE Entertainment - Staging Database
-- Database: stg
-- Description: Raw copy of all source system data
-- *************************************************

CREATE DATABASE IF NOT EXISTS stg;
USE stg;

-- ============================================================
-- CREATE STAGING TABLE FOR ORDER DETAILS
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
-- CREATE STAGING TABLE FOR ORDER HEADER
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
--  CREATE STAGING TABLE FOR CUSTOMER
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
    country             CHAR(10),
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
-- CREATE STAGING TABLE FOR STORE
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
-- CREATE STAGING TABLE FOR PRODUCT
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
-- CREATE TABLE FOR STAGING TABLE FOR PRODUCT TYPE
-- ============================================================
CREATE TABLE stg_product_type (
    product_type_code   CHAR(2),
    product_type        VARCHAR(100),
    product_category    VARCHAR(50)
);

-- ============================================================
-- CREATE TABLE FOR PACKAGE
-- ============================================================
CREATE TABLE stg_package (
    package_id      INT,
    name            VARCHAR(100),
    description     VARCHAR(255),
    package_type    CHAR(2),
    package_price   DECIMAL(10,2)
);

-- ============================================================
-- CREATE TABLE FOR SUBSCRIPTION
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
-- CREATE TABLE FOR REGION
-- ============================================================
CREATE TABLE stg_region (
    region_code     CHAR(10),
    region_name     VARCHAR(100),
    division_code   CHAR(10)
);

-- ============================================================
-- CREATE STAGING TABLE FOR DIVISION
-- ============================================================
CREATE TABLE stg_division (
    division_code   CHAR(10),
    division_name   VARCHAR(100)
);

-- ============================================================
-- CREATE STAGING TABLE FOR HOUSE HOLD INCOME
-- ============================================================
CREATE TABLE stg_house_hold_income (
    household_income_code   INT,
    lower_limit             DECIMAL(10,2),
    upper_limit             INT,
    description             VARCHAR(100)
);

-- ============================================================
-- CREATE STAGING TABLE FOR CURRENCY RATE
-- ============================================================
CREATE TABLE stg_currency_rate (
    effective_date  VARCHAR(30),
    currency_code   CHAR(3),
    currency_rate   DECIMAL(10,6),
    created         VARCHAR(20),
    last_updated    VARCHAR(20)
);

-- ============================================================
-- CREATE STAGING TABLE FOR CURRENCY
-- ============================================================
CREATE TABLE stg_currency (
    currency_code   CHAR(3),
    currency_name   VARCHAR(100)
);

-- ============================================================
-- CREATE STAGING TABLE FOR CHANNEL
-- ============================================================
CREATE TABLE stg_channel (
    name            VARCHAR(50),
    description     VARCHAR(50),
    start_date      VARCHAR(100),
    end_date        VARCHAR(100),
    status          VARCHAR(100)
);

-- ============================================================
-- CREATE STAGING TABLE FOR CUSTOMER_STATUS
-- ============================================================
CREATE TABLE stg_customer_status (
    customer_status_code        CHAR(10),
    description     			VARCHAR(50)
);

-- ============================================================
-- CREATE STAGING TABLE FOR CUSTOMER_TYPE
-- ============================================================
CREATE TABLE stg_customer_status (
    customer_status_code        CHAR(10),
    description     			VARCHAR(50)
);

-- ============================================================
-- CREATE STAGING TABLE FOR PRODUCT_STATUS
-- ============================================================
CREATE TABLE stg_product_status (
    product_status_code  CHAR(10),
    product_status       VARCHAR(50)
);

-- ============================================================
-- CREATE STAGING TABLE FOR INTEREST
-- ============================================================
CREATE TABLE  stg_interest (
    interest 					VARCHAR(100),
    description 				VARCHAR(255),
    interest_group 				VARCHAR(100),
    associated_product_type 	VARCHAR(100),
    related_interest 			VARCHAR(100)
);

-- ============================================================
-- CREATE STAGING TABLE FOR OCCUPATION
-- ============================================================
CREATE TABLE  stg_occupation (
    occupation_code 			INT,
    occupation 					VARCHAR(100),
    description 				VARCHAR(255),
    category 					VARCHAR(100)
);

-- ============================================================
-- CREATE STAGING TABLE FOR Email_Address_Type
-- ============================================================
CREATE TABLE stg_email_address_type (
    email_address_type_code 	CHAR(10),
    email_address_type 			VARCHAR(50),
    description 				VARCHAR(255)
);


-- ============================================================
-- CREATE STAGING TABLE FOR Address_Type
-- ============================================================
CREATE TABLE IF NOT EXISTS stg_address_type (
    address_type_code  		CHAR(10),
    address_type 			VARCHAR(50),
    description 			VARCHAR(255)
);

-- ============================================================
-- CREATE STAGING TABLE FOR Permission
-- ============================================================
CREATE TABLE  stg_permission (
    permission_code 		CHAR(10),
    description 			VARCHAR(255)
);

-- ============================================================
-- CREATE STAGING TABLE FOR Phone_Number_Type
-- ============================================================
CREATE TABLE stg_phone_number_type (
    phone_number_type_code 		CHAR(10),
    phone_number_type 			VARCHAR(50),
    description 				VARCHAR(255)
);

-- ============================================================
-- CREATE STAGING TABLE FOR State
-- ============================================================
CREATE TABLE stg_state (
    state_code 				CHAR(30),
    state_name 				VARCHAR(100),
    formal_name 			VARCHAR(150),
    admission_to_statehood 	INT,
    population 				INT,
    capital 				VARCHAR(100),
    largest_city 			VARCHAR(100)
);

-- ============================================================
-- CREATE STAGING TABLE FOR Customer_Type
-- ============================================================
CREATE TABLE stg_customer_type (
    customer_type_code 	CHAR(10),
    description 		VARCHAR(100)
);

-- ============================================================
-- CREATE STAGING TABLE FOR Package_Type
-- ============================================================
CREATE TABLE stg_package_type (
    package_type_code 	CHAR(20),
    package_type 		VARCHAR(100)
);

-- ============================================================
-- CREATE STAGING TABLE FOR Product_Category
-- ============================================================
CREATE TABLE stg_product_category (
    product_category 		VARCHAR(100),
    description 			VARCHAR(255)
);








