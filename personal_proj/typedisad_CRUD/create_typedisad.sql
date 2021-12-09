CREATE TABLE typedisad(
    PRIMARY KEY (type_id, type_weakness),
    type_id         INT(2),
    type_weakness   VARCHAR(15),
    FOREIGN KEY (type_id) REFERENCES typelist(type_id)
);