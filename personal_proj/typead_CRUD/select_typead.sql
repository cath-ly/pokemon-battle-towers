SELECT type_name, type_strength 
    FROM typead
    INNER JOIN typelist
        USING (type_id);