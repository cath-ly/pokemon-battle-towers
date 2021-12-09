-- view of typedisad
CREATE VIEW type_dis AS
    SELECT type_weakness 
    FROM typedisad
    INNER JOIN typelist
        USING (type_id);