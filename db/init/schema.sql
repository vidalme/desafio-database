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
    used_area DECIMAL(10, 2),
);

CREATE TABLE detalhes (
    listing_id INT,
    details TEXT
);
