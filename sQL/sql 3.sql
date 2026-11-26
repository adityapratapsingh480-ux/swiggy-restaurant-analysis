USE swiggy_db;

LOAD DATA LOCAL INFILE 'C:/Users/adity/Desktop/swiggy-restaurant-analysis/data_raw/swiggy.csv'
INTO TABLE swiggy_raw
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

SHOW WARNINGS;