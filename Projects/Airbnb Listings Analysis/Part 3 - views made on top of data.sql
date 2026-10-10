-- Views 
-- small tables that you save in your data model derived from your table

USE airbnb_db;

CREATE VIEW vw_airbnb_basic AS
SELECT
    `id`,
    `neighbourhood`,
    `room type`,
    `price`,
    `host_identity_verified`,
    `country`
FROM airbnb_import_raw;

-- Average neighbourhood price
CREATE VIEW vw_avg_price_per_neighbourhood AS
SELECT 
    neighbourhood,
    ROUND(AVG(price), 2) AS avg_price
FROM airbnb_import_raw
GROUP BY neighbourhood
ORDER BY avg_price DESC;

-- Room type preferences
CREATE  VIEW vw_room_type_preference AS
SELECT 
    `room type`,
    COUNT(*) AS total_listings
FROM airbnb_import_raw
GROUP BY `room type`
ORDER BY total_listings DESC;
