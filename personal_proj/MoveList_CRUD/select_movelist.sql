SELECT move_name, type_name 
    FROM movelist
    INNER JOIN typelist
        USING(type_id);