USE swiggy_db;

SET SQL_SAFE_UPDATES = 0;

DELETE FROM swiggy_raw
WHERE menu IS NULL OR menu NOT LIKE 'Menu/%' OR link NOT LIKE 'https://%';

SELECT COUNT(*) AS rows_after_delete FROM swiggy_raw;