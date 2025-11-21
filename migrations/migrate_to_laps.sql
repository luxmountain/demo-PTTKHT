-- Migration: Add laps tracking to F1 race system
-- Date: 2025-11-21
-- Description: Replace position column with laps_completed in tblregister
--              Add total_laps column to tblstage
-- 
-- This migration updates the database schema to track laps completed
-- instead of position, allowing DNF (Did Not Finish) detection when
-- laps_completed < total_laps
--
-- HOW TO USE:
-- Run this migration on an EXISTING database that was created with the old schema

-- Step 1: Add total_laps column to tblstage
ALTER TABLE `tblstage` 
ADD COLUMN `total_laps` SMALLINT UNSIGNED NOT NULL DEFAULT 0 
AFTER `roadmap`;

-- Step 2: Add laps_completed column to tblregister
ALTER TABLE `tblregister` 
ADD COLUMN `laps_completed` SMALLINT UNSIGNED NOT NULL DEFAULT 0 
AFTER `status`;

-- Step 3: Migrate existing position data to laps_completed (OPTIONAL)
-- Uncomment the following line if you want to copy position values to laps_completed
-- UPDATE `tblregister` SET `laps_completed` = COALESCE(`position`, 0);

-- Step 4: Drop old position column
ALTER TABLE `tblregister` 
DROP COLUMN `position`;

-- Notes:
-- - total_laps in tblstage: total number of laps for that race stage
-- - laps_completed in tblregister: number of laps the racer completed
-- - DNF detection: if laps_completed < total_laps, display "DNF" in frontend
-- - SMALLINT UNSIGNED allows values 0-65535, sufficient for lap counts
-- - DEFAULT 0 ensures no NULL values for cleaner logic

-- Rollback (if needed):
-- ALTER TABLE `tblstage` DROP COLUMN `total_laps`;
-- ALTER TABLE `tblregister` ADD COLUMN `position` TINYINT DEFAULT NULL AFTER `status`;
-- ALTER TABLE `tblregister` DROP COLUMN `laps_completed`;
