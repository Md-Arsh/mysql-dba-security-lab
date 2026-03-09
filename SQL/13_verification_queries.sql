-- ==========================================
-- Verification Queries
-- Used to verify users and their privileges
-- ==========================================


-- Show all MySQL users and their allowed hosts
-- This helps verify that users were created correctly

SELECT User, Host 
FROM mysql.user;



-- Check privileges assigned to Super Admin
-- Super Admin should have full access with GRANT OPTION

SHOW GRANTS FOR 'super_admin'@'%';



-- Check privileges assigned to Developer
-- Developer should have read and write access only to dev_db

SHOW GRANTS FOR 'developer'@'%';



-- Check privileges assigned to Analyst
-- Analyst should have read-only access to analytics_db

SHOW GRANTS FOR 'analyst'@'%';



-- Check the currently logged-in user
-- Useful for confirming which account is executing queries

SELECT CURRENT_USER();