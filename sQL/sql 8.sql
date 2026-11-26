USE swiggy_db;

-- 1. duplicate ids
SELECT COUNT(*) - COUNT(DISTINCT id) AS duplicate_rows FROM swiggy_raw;

-- 2. blank values
SELECT
    SUM(name IS NULL OR name = '') AS blank_name,
    SUM(city IS NULL OR city = '') AS blank_city,
    SUM(cuisine IS NULL OR cuisine = '') AS blank_cuisine
FROM swiggy_raw;

-- 3. rating values
SELECT rating, COUNT(*) AS cnt FROM swiggy_raw GROUP BY rating ORDER BY cnt DESC LIMIT 15;

-- 4. rating_count formats
SELECT rating_count, COUNT(*) AS cnt FROM swiggy_raw GROUP BY rating_count ORDER BY cnt DESC LIMIT 20;

-- 5. cost formats
SELECT cost, COUNT(*) AS cnt FROM swiggy_raw GROUP BY cost ORDER BY cnt DESC LIMIT 20;

-- 6. restaurants per city
SELECT city, COUNT(*) AS restaurants FROM swiggy_raw GROUP BY city ORDER BY restaurants DESC LIMIT 15;