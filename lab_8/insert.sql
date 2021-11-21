-- You man need to change the names of the tables and fields here to match your design.
INSERT INTO trainers (trainer_name)
VALUES ('Will'), -- Elite Four from Pokémon Gold/Silver/Crystal era.
       ('Koga'),
       ('Bruno'),
       ('Lance');

INSERT INTO pokemon_species (species_name)
VALUES ('Pikachu'),
       ('Charmander'),
       ('Bulbasuar'),
       ('Squirtle'),
       ('Geodude'),
       ('Magikarp'),
       ('Weedle'),
       ('Butterfree');

INSERT INTO pokemon (trainer_id, species_name) 
VALUES (1, 'Pikachu'),
       (1, 'Charmander'),
       (1, 'Bulbasuar'),
       (1, 'Squirtle'),
       (1, 'Geodude'),
       (1, 'Magikarp'),
       (1, 'Weedle'),
       (2, 'Pikachu'),
       (2, 'Charmander'),
       (2, 'Bulbasuar'),
       (2, 'Squirtle'),
       (2, 'Geodude'),
       (2, 'Magikarp'),
       (2, 'Weedle');

INSERT INTO trainer_party_members (pokemon_id, trainer_id)
VALUES (1, 1), -- Trade this one (Will's Pikachu)
       (2, 1),
       (3, 1),
       (4, 1),
       (5, 1),
       (6, 1),
       (11, 2); -- for this one. (Koga's Squirtle)