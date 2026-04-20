USE dw;
DROP TABLE IF EXISTS dim_customer;

CREATE TABLE dim_customer (
    customer_key        INT           NOT NULL AUTO_INCREMENT,
    customer_number     INT           NOT NULL,
    account_number 		VARCHAR(20)   NULL,
    customer_type       VARCHAR(50)   NOT NULL,
    name                VARCHAR(255)  NOT NULL,
    gender              VARCHAR(100)  NOT NULL,
    email_address		VARCHAR(100)  NOT NULL,
    date_of_birth       DATE          NOT NULL,
    address1			VARCHAR(100)  NOT NULL,
    address2			VARCHAR(100)  NOT NULL,
    address3			VARCHAR(100)  NULL,
    address4			VARCHAR(100)  NULL,
    city                VARCHAR(100)  NOT NULL,
    state               VARCHAR(100)  NULL,
    zipcode             INT(20)       NOT NULL,
    country             CHAR(100)     NOT NULL,
    phone_number        INT 		  NOT NULL,
    occupation			VARCHAR(100)  NOT NULL,
    age_group           VARCHAR(20)   NOT NULL,
    household_income    VARCHAR(50)   NOT NULL,
    market              VARCHAR(50)   NOT NULL,
    status              VARCHAR(50)   NOT NULL,
    date_registered     DATE          NOT NULL,
    permission          VARCHAR(50)   NOT NULL,
    preferred_channel1  VARCHAR(100)  NOT NULL,
    preferred_channel2  VARCHAR(50)   NOT NULL,
    interest1           VARCHAR(100)  NOT NULL,
    interest2           VARCHAR(100)  NOT NULL,
    interest3           VARCHAR(100)  NOT NULL,
    created             DATE          NOT NULL,
	last_updated        DATE          NOT NULL,
    is_current          TINYINT       NOT NULL DEFAULT 1,
    
    created_timestamp   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_timestamp   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT pk_dim_customer PRIMARY KEY (customer_key)
);

