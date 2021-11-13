SELECT type_strength, type_name 
    FROM typead
    INNER JOIN typelist
        USING (type_id);