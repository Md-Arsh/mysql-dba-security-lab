-- =====================================================
-- Scenario 10: High Security Banking Database
-- Objective:
-- Design a bank-grade MySQL security model
-- =====================================================


-- =====================================================
-- STEP 1: Verify SSL Support
-- =====================================================

SHOW VARIABLES LIKE '%ssl%';



-- =====================================================
-- STEP 2: Enforce Encrypted SSL Login
-- =====================================================

ALTER USER 'DBA'@'%'
REQUIRE SSL;

ALTER USER 'Dev'@'%'
REQUIRE SSL;



-- Verify SSL requirement
SELECT user, host, ssl_type
FROM mysql.user;



-- =====================================================
-- STEP 3: Disable Remote Root Login
-- =====================================================

SELECT user, host
FROM mysql.user
WHERE user='root';


-- If root@% exists, remove it
-- (In many systems it does not exist)

-- DROP USER 'root'@'%';



-- =====================================================
-- STEP 4: Create Limited DBA Role
-- =====================================================

CREATE ROLE limited_dba;



-- Grant safe administrative privileges
GRANT SELECT, INSERT, UPDATE, DELETE,
CREATE, ALTER, INDEX,
CREATE VIEW, SHOW VIEW,
CREATE ROUTINE, ALTER ROUTINE,
EVENT, TRIGGER
ON *.*
TO limited_dba;



-- =====================================================
-- STEP 5: Create Secure DBA User
-- =====================================================

CREATE USER 'bank_dba'@'%'
IDENTIFIED BY 'SecureDBA@123';



-- Assign role to DBA
GRANT limited_dba TO 'bank_dba'@'%';

SET DEFAULT ROLE limited_dba
FOR 'bank_dba'@'%';



-- Verify privileges
SHOW GRANTS FOR 'bank_dba'@'%';



-- =====================================================
-- STEP 6: Install Strong Password Policy
-- =====================================================

INSTALL COMPONENT 'file://component_validate_password';



-- Configure strict password rules
SET GLOBAL validate_password.policy = STRONG;

SET GLOBAL validate_password.length = 14;

SET GLOBAL validate_password.mixed_case_count = 1;

SET GLOBAL validate_password.number_count = 2;

SET GLOBAL validate_password.special_char_count = 2;



-- Prevent password reuse
SET GLOBAL password_history = 10;

SET GLOBAL password_reuse_interval = 365;



-- Protect against brute force login
ALTER USER 'bank_dba'@'%'
FAILED_LOGIN_ATTEMPTS 3
PASSWORD_LOCK_TIME 2;



-- =====================================================
-- STEP 7: Enable Monitoring and Auditing
-- =====================================================

-- Enable general query logging
SET GLOBAL general_log = 'ON';

SET GLOBAL log_output = 'TABLE';



-- Check logged queries
SELECT *
FROM mysql.general_log
ORDER BY event_time DESC
LIMIT 10;



-- Enable slow query monitoring
SET GLOBAL slow_query_log = 'ON';

SET GLOBAL long_query_time = 2;



-- Verify slow query log
SHOW VARIABLES LIKE 'slow_query_log';



-- =====================================================
-- STEP 8: Security Verification
-- =====================================================

-- Check authentication plugin
SELECT user, host, plugin
FROM mysql.user;



-- Check account lock status
SELECT user, host, account_locked
FROM mysql.user;



-- Monitor active sessions
SHOW PROCESSLIST;



-- =====================================================
-- END OF SCENARIO 10
-- Bank-grade MySQL security model implemented
-- =====================================================