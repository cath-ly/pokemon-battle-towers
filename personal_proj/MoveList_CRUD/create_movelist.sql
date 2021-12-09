CREATE TABLE movelist(
    PRIMARY KEY (move_name),
    move_name VARCHAR(25),
    type_id   INT(2),
    FOREIGN KEY (type_id) REFERENCES typelist(type_id)
);