USE swiggy_db;

SELECT COUNT(*) AS cost_below_20 FROM swiggy_clean WHERE cost_inr < 20;

SELECT COUNT(*) AS cost_above_5000 FROM swiggy_clean WHERE cost_inr > 5000;

SELECT restaurant_name, city, cost_inr FROM swiggy_clean
WHERE cost_inr < 20 OR cost_inr > 5000
ORDER BY cost_inr DESC LIMIT 30;

SELECT COUNT(DISTINCT city) AS total_cities FROM swiggy_clean;

SELECT city, COUNT(*) AS restaurants FROM swiggy_clean
WHERE city REGEXP '[0-9]'
GROUP BY city ORDER BY restaurants DESC LIMIT 20;