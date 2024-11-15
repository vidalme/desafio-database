CREATE TABLE price_changes (
    listing_id INT,
    old_price DECIMAL(10, 2),
    new_price DECIMAL(10, 2),
    change_date DATE,
    details TEXT
);

CREATE TABLE build_area_used_area (
    listing_id INT,
    built_area DECIMAL(10, 2),
    used_area DECIMAL(10, 2)
);

CREATE TABLE detalhes (
    listing_id INT,
    details TEXT
);

COPY price_changes (listing_id, old_price, new_price, change_date, details) FROM '/csv/Price_changes.csv' DELIMITER ',' CSV HEADER NULL AS 'NULL';
COPY build_area_used_area (listing_id, built_area, used_area) FROM '/csv/Built_used_area.csv' DELIMITER ',' CSV HEADER NULL AS 'NULL';
COPY detalhes (listing_id, details) FROM '/csv/Details.csv' DELIMITER ',' CSV HEADER NULL AS 'NULL';