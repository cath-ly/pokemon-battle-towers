-- view of typead
CREATE VIEW type_ad AS
    SELECT type_strength 
    FROM typead
    INNER JOIN typelist
        USING (type_id);