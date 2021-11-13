--viewing the movelist
CREATE VIEW move_n AS
    SELECT move_name 
        FROM movelist
        INNER JOIN typelist
            USING(type_id);