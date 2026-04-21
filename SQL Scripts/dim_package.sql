use dw;
CREATE TABLE dim_package (
   package_key                        INT             NOT NULL AUTO_INCREMENT,
   package_id                         INT             NOT NULL,
   subscription_customer              INT             NOT NULL,
   name                               VARCHAR(100)    NOT NULL,
   description                        VARCHAR(100)    NOT NULL,
   package_type                       VARCHAR(100)    NOT NULL,
   package_price                      DECIMAL(10,2)   NOT NULL,
   subscription_channel               VARCHAR(100)    NOT NULL,
   package_subscription_start_date    DATE            NOT NULL,
   package_subscription_end_date      DATE            NOT NULL,
   subscription_status                VARCHAR(50)     NOT NULL,
   created_timestamp   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   updated_timestamp   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT pk_dim_package
        PRIMARY KEY (package_key)
);
