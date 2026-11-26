USE swiggy_db;

SELECT COUNT(*) AS total_rows,
       SUM(rating IS NULL) AS null_rating,
       SUM(ratings_count IS NULL) AS null_ratings_count,
       SUM(cost_inr IS NULL) AS null_cost,
       SUM(area IS NULL) AS null_area
FROM swiggy_clean;

SELECT * FROM swiggy_clean LIMIT 10;

SELECT cost_category, COUNT(*) AS restaurants FROM swiggy_clean GROUP BY cost_category;

SELECT MIN(rating), MAX(rating), MIN(cost_inr), MAX(cost_inr), MAX(ratings_count) FROM swiggy_clean;

SELECT city, COUNT(*) AS restaurants FROM swiggy_clean GROUP BY city ORDER BY restaurants DESC LIMIT 40;