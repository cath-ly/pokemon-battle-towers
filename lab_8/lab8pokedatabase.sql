DROP DATABASE IF EXISTS trade_pokemon;

CREATE DATABASE trade_pokemon;
USE trade_pokemon;

CREATE TABLE trainers(
    PRIMARY KEY (trainer_id),
    trainer_id    INT AUTO_INCREMENT NOT NULL,
    trainer_name  VARCHAR(15)
);

CREATE TABLE pokemon_species(
    PRIMARY KEY (species_name),
    species_name  VARCHAR(15)
);

CREATE TABLE pokemon(
    PRIMARY KEY (pokemon_id),
    pokemon_id    INT AUTO_INCREMENT NOT NULL,
    trainer_id    INT(2),
    species_name  VARCHAR(15),
    FOREIGN KEY (trainer_id) REFERENCES trainers(trainer_id) 
    ON DELETE CASCADE
);

CREATE TABLE trainer_party_members(
    PRIMARY KEY (pokemon_id, trainer_id),
    pokemon_id  INT(2),
    trainer_id  INT(2),
    FOREIGN KEY (pokemon_id) REFERENCES pokemon(pokemon_id),
    FOREIGN KEY (trainer_id) REFERENCES trainers(trainer_id) 
    ON DELETE CASCADE
);