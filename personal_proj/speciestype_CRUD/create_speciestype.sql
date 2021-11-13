CREATE TABLE species_type(
    PRIMARY KEY (species_name, type_id),
    species_name     VARCHAR(11),
    type_id          INT(2),
    FOREIGN KEY (species_name) REFERENCES species(species_name),
    FOREIGN KEY (type_id) REFERENCES typelist(type_id)
);
-- check if species_name has only two entries