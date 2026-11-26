USE swiggy_db;
SET SQL_SAFE_UPDATES = 0;

-- 1. cost values below 20 or above 5000 are treated as data errors
UPDATE swiggy_clean SET cost_inr = NULL WHERE cost_inr < 20 OR cost_inr > 5000;

-- 2. rebuild the cost categories after the fix
UPDATE swiggy_clean
SET cost_category = CASE
    WHEN cost_inr IS NULL THEN 'Unknown'
    WHEN cost_inr < 200 THEN 'Budget (under 200)'
    WHEN cost_inr <= 400 THEN 'Mid-range (200-400)'
    ELSE 'Premium (above 400)'
END;

-- 3. remove zone numbers from city names (Noida-1 becomes Noida)
UPDATE swiggy_clean
SET city = TRIM(REGEXP_REPLACE(city, '-[0-9]+$', ''))
WHERE city REGEXP '-[0-9]+$';

-- 4. check the result
SELECT MIN(cost_inr), MAX(cost_inr), ROUND(AVG(cost_inr)) AS avg_cost FROM swiggy_clean;
SELECT COUNT(DISTINCT city) AS total_cities FROM swiggy_clean;
SELECT cost_category, COUNT(*) AS restaurants FROM swiggy_clean GROUP BY cost_category;