USE swiggy_db;

CREATE TABLE swiggy_backup AS SELECT * FROM swiggy_raw;
SELECT COUNT(*) AS backup_rows FROM swiggy_backup;