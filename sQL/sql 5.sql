USE swiggy_db;

SELECT COUNT(*) AS bad_rows
FROM swiggy_raw
WHERE menu IS NULL OR menu NOT LIKE 'Menu/%' OR link NOT LIKE 'https://%';

SELECT id, name, city, rating, rating_count, cost, cuisine, link, menu
FROM swiggy_raw
WHERE menu IS NULL OR menu NOT LIKE 'Menu/%' OR link NOT LIKE 'https://%'
LIMIT 50;