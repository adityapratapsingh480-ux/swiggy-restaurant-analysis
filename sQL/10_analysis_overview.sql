USE swiggy_db;

-- 1. Overall KPIs
SELECT
    COUNT(*) AS total_restaurants,
    COUNT(DISTINCT city) AS total_cities,
    ROUND(AVG(rating), 2) AS avg_rating,
    ROUND(AVG(cost_inr)) AS avg_cost_for_two,
    ROUND(100 * SUM(rating IS NOT NULL) / COUNT(*), 1) AS pct_rated
FROM swiggy_clean;

-- 2. Top 10 cities by number of restaurants
SELECT city, COUNT(*) AS restaurants,
       ROUND(AVG(rating), 2) AS avg_rating,
       ROUND(AVG(cost_inr)) AS avg_cost
FROM swiggy_clean
GROUP BY city
ORDER BY restaurants DESC
LIMIT 10;

-- 3. Top 10 cuisines by number of restaurants
SELECT primary_cuisine, COUNT(*) AS restaurants,
       ROUND(AVG(rating), 2) AS avg_rating,
       ROUND(AVG(cost_inr)) AS avg_cost
FROM swiggy_clean
GROUP BY primary_cuisine
ORDER BY restaurants DESC
LIMIT 10;

-- 4. Rating distribution
SELECT
    CASE
        WHEN rating IS NULL THEN 'Not rated'
        WHEN rating < 3 THEN 'Below 3.0'
        WHEN rating < 4 THEN '3.0 - 3.9'
        WHEN rating < 4.5 THEN '4.0 - 4.4'
        ELSE '4.5 and above'
    END AS rating_band,
    COUNT(*) AS restaurants,
    ROUND(100 * COUNT(*) / (SELECT COUNT(*) FROM swiggy_clean), 1) AS pct_of_total
FROM swiggy_clean
GROUP BY rating_band
ORDER BY restaurants DESC;

-- 5. Average rating by price category
SELECT cost_category, COUNT(*) AS restaurants,
       ROUND(AVG(rating), 2) AS avg_rating
FROM swiggy_clean
GROUP BY cost_category
ORDER BY avg_rating DESC;

-- 6. Best restaurants: high rating with enough ratings to trust it
SELECT restaurant_name, area, city, primary_cuisine, rating, ratings_count, cost_inr
FROM swiggy_clean
WHERE rating >= 4.5 AND ratings_count >= 500
ORDER BY rating DESC, ratings_count DESC
LIMIT 20;