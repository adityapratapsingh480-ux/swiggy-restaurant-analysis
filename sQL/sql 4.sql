USE swiggy_db;
SELECT COUNT(*) AS total_rows FROM swiggy_raw;
SELECT COUNT(DISTINCT city) AS total_cities FROM swiggy_raw;
SELECT * FROM swiggy_raw LIMIT 10;
SELECT cost FROM swiggy_raw LIMIT 5;