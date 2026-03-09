-- =========================================================
-- Scenario 3: Password Policy Enforcement
-- Objective:
-- Enforce strong password policy across the organization.
-- Implement password expiry, prevent reuse, and configure
-- automatic account lock after failed login attempts.
-- MySQL Version: 8.0+
-- =========================================================


-- =========================================================
-- Step 1: Install Password Validation Component
-- This enables password strength checking in MySQL.
-- Run only if not already installed.
-- =========================================================

INSTALL COMPONENT 'file://component_validate_password';


-- =========================================================
-- Step 2: Verify Password Validation Settings
-- =========================================================

SHOW VARIABLES LIKE 'validate_password%';


-- =========================================================
-- Step 3: Enforce Strong Password Policy
-- STRONG policy enforces:
-- - Minimum length
-- - Uppercase & lowercase
-- - Numbers
-- - Special characters
-- =========================================================

SET GLOBAL validate_password.policy = STRONG;

-- Set minimum password length to 12 characters
SET GLOBAL validate_password.length = 12;

-- Ensure complexity requirements
SET GLOBAL validate_password.mixed_case_count = 1;
SET GLOBAL validate_password.number_count = 1;
SET GLOBAL validate_password.special_char_count = 1;


-- =========================================================
-- Step 4: Enforce Password Expiry (60 Days)
-- Users must change password every 60 days
-- =========================================================

ALTER USER 'Dev'@'%' 
PASSWORD EXPIRE INTERVAL 60 DAY;

ALTER USER 'Intern'@'localhost' 
PASSWORD EXPIRE INTERVAL 60 DAY;


-- =========================================================
-- Step 5: Prevent Password Reuse
-- Prevent reuse of last 5 passwords
-- Block reuse for 365 days
-- =========================================================

SET GLOBAL password_history = 5;
SET GLOBAL password_reuse_interval = 365;


-- =========================================================
-- Step 6: Configure Automatic Account Lock
-- Lock account after 3 failed login attempts
-- Lock duration: 1 day
-- =========================================================

ALTER USER 'Dev'@'%' 
FAILED_LOGIN_ATTEMPTS 3 
PASSWORD_LOCK_TIME 1;


-- =========================================================
-- Step 7: Verify User Account Security Settings
-- =========================================================

SELECT user, host, password_lifetime, account_locked
FROM mysql.user;


-- =========================================================
-- End of Scenario 3
-- =========================================================