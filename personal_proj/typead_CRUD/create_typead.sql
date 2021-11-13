CREATE TABLE typead(
    PRIMARY KEY (type_id, type_strength),
    type_id         INT(2),
    type_strength   VARCHAR(15),
    FOREIGN KEY (type_id) REFERENCES typelist(type_id)
);