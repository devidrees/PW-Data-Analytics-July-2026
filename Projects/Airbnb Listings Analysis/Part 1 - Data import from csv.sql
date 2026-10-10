SHOW GLOBAL VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = ON;

DROP DATABASE IF EXISTS airbnb_db;
CREATE DATABASE airbnb_db;
USE airbnb_db;

CREATE TABLE airbnb_import_raw (
    import_row_id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `id` VARCHAR(50),
    `NAME` TEXT,
    `host id` VARCHAR(50),
    `host_identity_verified` VARCHAR(30),
    `host name` VARCHAR(255),
    `neighbourhood group` VARCHAR(100),
    `neighbourhood` VARCHAR(255),
    `lat` VARCHAR(50),
    `long` VARCHAR(50),
    `country` VARCHAR(100),
    `country code` VARCHAR(20),
    `instant_bookable` VARCHAR(20),
    `cancellation_policy` VARCHAR(50),
    `room type` VARCHAR(100),
    `Construction year` VARCHAR(30),
    `price` VARCHAR(50),
    `service fee` VARCHAR(50),
    `minimum nights` VARCHAR(30),
    `number of reviews` VARCHAR(30),
    `last review` VARCHAR(50),
    `reviews per month` VARCHAR(30),
    `review rate number` VARCHAR(30),
    `calculated host listings count` VARCHAR(30),
    `availability 365` VARCHAR(30),
    `house_rules` LONGTEXT,
    `license` VARCHAR(255)
);


SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA LOCAL INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/airbnb_data2.csv'
INTO TABLE airbnb_import_raw
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(
    `id`,
    `NAME`,
    `host id`,
    `host_identity_verified`,
    `host name`,
    `neighbourhood group`,
    `neighbourhood`,
    `lat`,
    `long`,
    `country`,
    `country code`,
    `instant_bookable`,
    `cancellation_policy`,
    `room type`,
    `Construction year`,
    `price`,
    `service fee`,
    `minimum nights`,
    `number of reviews`,
    `last review`,
    `reviews per month`,
    `review rate number`,
    `calculated host listings count`,
    `availability 365`,
    `house_rules`,
    `license`
);

SELECT COUNT(*) FROM airbnb_import_raw;

SELECT * FROM airbnb_import_raw
LIMIT 20;

-- Data cleaning and Prepration: SQL file
-- Imuptations are hardcoded









