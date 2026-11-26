USE swiggy_db;
SET SQL_SAFE_UPDATES = 0;

CREATE TABLE swiggy_clean AS
SELECT
    CAST(id AS UNSIGNED) AS restaurant_id,
    TRIM(name) AS restaurant_name,
    CASE WHEN city LIKE '%,%' THEN TRIM(SUBSTRING_INDEX(city, ',', 1)) ELSE NULL END AS area,
    TRIM(SUBSTRING_INDEX(city, ',', -1)) AS city,
    CASE WHEN rating REGEXP '^[0-9]+[.]?[0-9]*$' THEN CAST(rating AS DECIMAL(3,1)) ELSE NULL END AS rating,
    CASE
        WHEN rating_count REGEXP '^[0-9.]+K[+]' THEN CAST(CAST(SUBSTRING_INDEX(rating_count, 'K', 1) AS DECIMAL(10,1)) * 1000 AS UNSIGNED)
        WHEN rating_count REGEXP '^[0-9]+[+]' THEN CAST(SUBSTRING_INDEX(rating_count, '+', 1) AS UNSIGNED)
        ELSE NULL
    END AS ratings_count,
    CAST(NULLIF(REGEXP_REPLACE(cost, '[^0-9]', ''), '') AS UNSIGNED) AS cost_inr,
    TRIM(SUBSTRING_INDEX(cuisine, ',', 1)) AS primary_cuisine,
    TRIM(cuisine) AS cuisine,
    TRIM(address) AS address
FROM swiggy_raw;

ALTER TABLE swiggy_clean ADD PRIMARY KEY (restaurant_id);

ALTER TABLE swiggy_clean ADD COLUMN cost_category VARCHAR(30);

UPDATE swiggy_clean
SET cost_category = CASE
    WHEN cost_inr IS NULL THEN 'Unknown'
    WHEN cost_inr < 200 THEN 'Budget (under 200)'
    WHEN cost_inr <= 400 THEN 'Mid-range (200-400)'
    ELSE 'Premium (above 400)'
END;