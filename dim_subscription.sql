Use dw;
CREATE TABLE dim_subscription (
    subscription_key    INT             NOT NULL AUTO_INCREMENT,
    subscription_id     INT             NOT NULL,
    customer_id			INT 			NOT NULL,
    store_id			INT 			NOT NULL,
    package_id 			INT      		NOT NULL,
    channel_id 			INT 			NOT NULL,
    package_name        VARCHAR(100)    NOT NULL,
    package_type        VARCHAR(50)     NOT NULL,
    package_price       DECIMAL(10,2)   NOT NULL,
    start_date          DATE            NOT NULL,
    end_date            DATE            NULL,
    status              VARCHAR(20)     NOT NULL,
    
    created_timestamp   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_timestamp   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP,
    
    CONSTRAINT pk_dim_subscription 
        PRIMARY KEY (subscription_key)
);