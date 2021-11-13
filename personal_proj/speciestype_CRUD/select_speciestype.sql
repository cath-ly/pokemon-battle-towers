-- selecting table
SELECT species_name, type_name
FROM species_type
        INNER JOIN typelist
            USING (type_id);