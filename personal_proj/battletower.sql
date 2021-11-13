DROP DATABASE IF EXISTS battle_towers_pers;

CREATE DATABASE battle_towers_pers;
USE battle_towers_pers;

SOURCE TypeList_CRUD/crud_typelist.sql;
SOURCE MoveList_CRUD/crud_movelist.sql;
SOURCE Species_CRUD/crud_species.sql;
SOURCE speciestype_CRUD/crud_speciestype.sql;
SOURCE typead_CRUD/crud_typead.sql;
SOURCE typedisad_CRUD/crud_typedisad.sql;