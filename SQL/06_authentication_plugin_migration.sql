-- ==========================================================
-- Scenario 4: Migration from MySQL 5.7 to MySQL 8.0
-- Topic: Authentication Plugin Migration
-- Goal:
--   • Convert mysql_native_password → caching_sha2_password
--   • Ensure users can still login
--   • Verify authentication plugin for all users
--   • Maintain password security
-- ==========================================================


-- ----------------------------------------------------------
-- Step 1: Check current authentication plugin for all users
-- This shows which plugin each MySQL user account is using
-- ----------------------------------------------------------

SELECT user, host, plugin
FROM mysql.user;



-- ----------------------------------------------------------
-- Step 2: Simulate an old MySQL 5.7 user
-- mysql_native_password was the default plugin in MySQL 5.7
-- We convert the Dev user to simulate an old environment
-- ----------------------------------------------------------

ALTER USER 'Dev'@'%'
IDENTIFIED WITH mysql_native_password
BY 'Raza#786';



-- ----------------------------------------------------------
-- Step 3: Verify the plugin change
-- This confirms that Dev is now using mysql_native_password
-- ----------------------------------------------------------

SELECT user, host, plugin
FROM mysql.user
WHERE user = 'Dev';



-- ----------------------------------------------------------
-- Step 4: Perform migration to MySQL 8 authentication plugin
-- caching_sha2_password is the default and more secure plugin
-- ----------------------------------------------------------

ALTER USER 'Dev'@'%'
IDENTIFIED WITH caching_sha2_password
BY 'Raza#786';



-- ----------------------------------------------------------
-- Step 5: Verify plugin migration
-- This confirms Dev user is now using the MySQL 8 plugin
-- ----------------------------------------------------------

SELECT user, host, plugin
FROM mysql.user
WHERE user = 'Dev';



-- ----------------------------------------------------------
-- Step 6: Verify authentication plugin for all users
-- Ensures all application users use caching_sha2_password
-- ----------------------------------------------------------

SELECT user, host, plugin
FROM mysql.user;



-- ----------------------------------------------------------
-- Step 7: Verify password security policy
-- Confirms password validation rules remain active
-- ----------------------------------------------------------

SHOW VARIABLES LIKE 'validate_password%';


-- ==========================================================
-- End of Scenario 4
-- ==========================================================