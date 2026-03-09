-- =====================================================
-- Scenario 1: Role-Based Privilege Assignment (RBAC)
-- Objective:
-- Assign privileges to users according to their roles
-- while following the Least Privilege Principle.
-- =====================================================


-- ==========================================
-- Super Admin Privileges
-- Full control over all databases and users
-- ==========================================

GRANT ALL PRIVILEGES ON *.*
TO 'Super_Admin'@'%'
WITH GRANT OPTION;



-- ==========================================
-- DBA Privileges
-- DBA can manage databases but cannot grant
-- privileges or create users
-- ==========================================

GRANT ALL PRIVILEGES ON *.*
TO 'DBA'@'%';

-- Remove sensitive privileges

REVOKE CREATE USER ON *.*
FROM 'DBA'@'%';

REVOKE GRANT OPTION ON *.*
FROM 'DBA'@'%';



-- ==========================================
-- Developer Privileges
-- Developers can modify data only in dev_db
-- ==========================================

GRANT SELECT, INSERT, UPDATE, DELETE
ON dev_db.*
TO 'Dev'@'%';



-- ==========================================
-- Analyst Privileges
-- Read-only access for reporting
-- ==========================================

GRANT SELECT
ON analytics_db.*
TO 'Analyst'@'%';



-- ==========================================
-- Intern Privileges
-- Limited access only from localhost
-- ==========================================

GRANT SELECT
ON dev_db.*
TO 'Intern'@'localhost';



-- ==========================================
-- Apply privilege changes
-- ==========================================

FLUSH PRIVILEGES;