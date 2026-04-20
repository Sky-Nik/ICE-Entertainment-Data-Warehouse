CREATE TABLE fact_subscription (
    subscription_package_key            INT             NOT NULL AUTO_INCREMENT,
    date_key            				INT             NOT NULL,
    customer_key        				INT             NOT NULL,
    subscription_key    				INT             NOT NULL,
    package_key 					    INT             NOT NULL,
    channel                             VARCHAR(100)    NOT NULL,
    subscription_duration_days  		INT         	NULL,
    active_flag 						INT             NULL,
    cancelled_flag						INT 			NULL,
    CONSTRAINT pk_fact_subscription 
          PRIMARY KEY (subscription_package_key),
    FOREIGN KEY (date_key)          REFERENCES dim_date(date_key),
    FOREIGN KEY (customer_key)      REFERENCES dim_customer(customer_key),
    FOREIGN KEY (subscription_key)  REFERENCES dim_subscription(subscription_key)
);

