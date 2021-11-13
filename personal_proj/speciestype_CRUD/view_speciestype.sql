-- will this be similar to select or implement view?
CREATE VIEW spec_type AS
    SELECT species_name 
    FROM species_type
        INNER JOIN species
            USING (species_name);
