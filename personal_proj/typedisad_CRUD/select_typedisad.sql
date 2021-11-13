SELECT type_name, type_weakness
    FROM typedisad
    INNER JOIN typelist
        USING (type_id);
