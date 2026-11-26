
# Swiggy Restaurant Analysis

## Business Problem
A food delivery platform wants to understand its restaurant market: which cities and cuisines dominate, how ratings and pricing differ across them, and where the gaps and opportunities are.

## Dataset
Source: Kaggle, Swiggy Restaurants Dataset (India)
Rows: 148,515 restaurants (26 rows with misaligned columns removed during cleaning)
Columns: restaurant id, name, city, rating, rating count, cost for two, cuisine, address, and more

## Tools Used
- MySQL (data cleaning and analysis)
- Power BI (dashboard and visualization)
- GitHub (project documentation)

## Data Cleaning
- Removed 26 rows where column values were misaligned due to unescaped commas in the source data
- Split the combined "area,city" field into separate area and city columns
- Converted rating ("--" to NULL) and rating count ("500+" to 500, "1K+" to 1000) into usable numbers
- Removed the ₹ symbol and converted cost into a number
- Treated cost values below ₹20 or above ₹5,000 as data entry errors and set them to NULL
- Standardized city names (for example, "Noida-1" to "Noida")
- Final clean table: 148,489 restaurants

## Key Insights
- The dataset covers 148,489 restaurants across 551 cities, with an average rating of 3.89 and an average cost for two of ₹286.
- Only 41.4% of restaurants have a rating; the rest are likely new or low-order listings.
- The top 7 cities (Bangalore, Delhi, Pune, Hyderabad, Chennai, Kolkata, Mumbai) account for about 51% of all restaurants, with Bangalore leading at 14,943.
- Mumbai has both the highest average cost for two (₹368) and the best average rating (4.08) among major cities, while Hyderabad has the lowest average rating (3.82).
- North Indian is the most common cuisine (23,479 restaurants), but South Indian restaurants have a better average rating (3.94) at a lower average cost (₹235).
- [Add 1-2 more from your Page 3 Key Influencers and scatter chart findings]

## Recommendations
- Encourage review collection in cities with a high share of unrated restaurants to improve customer trust.
- Promote cuisines and price bands with the best rating-to-cost ratio, such as South Indian food.
- [Add 1-2 more based on your own findings]

## Dashboard
3-page Power BI dashboard:
1. Market Overview — KPIs, top cities, rating distribution, top cuisines, rating by price category
2. City & Cuisine Analysis — rating and cost by city, city-cuisine breakdown, cost vs rating comparison
3. Restaurant Quality & Pricing — top-rated restaurants, cost vs rating (hidden gems), key influencers on rating

See the /screenshots folder for page images and the dashboard PDF for the full interactive layout.

## Files in this Repository
- /sql — all SQL scripts in order, from table creation through analysis
- /screenshots — dashboard page images
- swiggy_dashboard.pdf — exported dashboard (all 3 pages)

## Limitations
- The dataset appears to be a 2022 snapshot, so findings reflect that period, not current data.
- "Indian" and "North Indian" are separate cuisine labels in the source data, so cuisine totals are split between them.
- rating_count reflects Swiggy's displayed minimum (for example "500+"), not an exact count.
