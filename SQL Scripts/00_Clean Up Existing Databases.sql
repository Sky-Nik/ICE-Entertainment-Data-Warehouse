-- Check what databases exist
SHOW DATABASES;
 
-- Drop only the ones you created (NEVER drop system databases)
-- Safe to drop:
SET FOREIGN_KEY_CHECKS = 0;
DROP DATABASE IF EXISTS dw;
DROP DATABASE IF EXISTS stg;
SET FOREIGN_KEY_CHECKS = 1;
 
-- NEVER drop these system databases:
-- information_schema, mysql, performance_schema, sys

-- Check what databases exist
SHOW DATABASES;