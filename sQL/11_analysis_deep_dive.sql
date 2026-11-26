USE swiggy_db;

-- 7. Top 3 cuisines inside each of the 5 biggest cities (CTE + RANK window function)
WITH top_cities AS (
    SELECT city FROM swiggy_clean GROUP BY city ORDER BY COUNT(*) DESC LIMIT 5
),
ranked AS (
    SELECT c.city, c.primary_cuisine, COUNT(*) AS restaurants,
           RANK() OVER (PARTITION BY c.city ORDER BY COUNT(*) DESC) AS rnk
    FROM swiggy_clean c
    JOIN top_cities t ON c.city = t.city
    GROUP BY c.city, c.primary_cuisine
)
SELECT city, primary_cuisine, restaurants, rnk
FROM ranked
WHERE rnk <= 3
ORDER BY city, rnk;

-- 8. Premium restaurant share by city (cities with 1000+ restaurants)
SELECT city, COUNT(*) AS restaurants,
       ROUND(100 * SUM(cost_category = 'Premium (above 400)') / COUNT(*), 1) AS pct_premium,
       ROUND(100 * SUM(cost_category = 'Budget (under 200)') / COUNT(*), 1) AS pct_budget
FROM swiggy_clean
GROUP BY city
HAVING COUNT(*) >= 1000
ORDER BY pct_premium DESC;

-- 9. Share of unrated restaurants by city (cities with 1000+ restaurants)
SELECT city, COUNT(*) AS restaurants,
       ROUND(100 * SUM(rating IS NULL) / COUNT(*), 1) AS pct_unrated
FROM swiggy_clean
GROUP BY city
HAVING COUNT(*) >= 1000
ORDER BY pct_unrated DESC
LIMIT 10;

-- 10. Hidden gems: cheap but highly rated
SELECT restaurant_name, area, city, primary_cuisine, rating, ratings_count, cost_inr
FROM swiggy_clean
WHERE cost_inr < 200 AND rating >= 4.3 AND ratings_count >= 100
ORDER BY rating DESC, ratings_count DESC
LIMIT 20;

-- 11. Cities ranked by average rating (cities with 500+ rated restaurants)
SELECT city, COUNT(rating) AS rated_restaurants,
       ROUND(AVG(rating), 2) AS avg_rating,
       RANK() OVER (ORDER BY AVG(rating) DESC) AS rating_rank
FROM swiggy_clean
GROUP BY city
HAVING COUNT(rating) >= 500
ORDER BY rating_rank
LIMIT 15;

-- 12. Top 10 areas in Bangalore by restaurant count
SELECT area, COUNT(*) AS restaurants,
       ROUND(AVG(rating), 2) AS avg_rating,
       ROUND(AVG(cost_inr)) AS avg_cost
FROM swiggy_clean
WHERE city = 'Bangalore' AND area IS NOT NULL
GROUP BY area
ORDER BY restaurants DESC
LIMIT 10;