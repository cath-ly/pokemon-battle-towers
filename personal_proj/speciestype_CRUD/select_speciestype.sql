-- selecting table
SELECT species_name, type_id
FROM species_type
        INNER JOIN species
            USING (species_name);
