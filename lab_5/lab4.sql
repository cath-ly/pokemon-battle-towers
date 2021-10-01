-- deletes any existing database named carpet_store
DROP DATABASE IF EXISTS carpet_store;
 
 -- creates database and goes into carpet_store database
CREATE DATABASE carpet_store;

USE carpet_store;

-- creates the table rugs and the fields that go into it
-- might have origin_country, rug_material, rug_style be a validation table so have it as foreign key later on
CREATE TABLE country(
    PRIMARY KEY (origin_country),
    origin_country      VARCHAR(15)
);
INSERT INTO country (origin_country)
VALUES ('Turkey'),
       ('Iran'),
       ('India'),
       ('Afghanistan');
SELECT * FROM country;

CREATE TABLE material(
    PRIMARY KEY (rug_material),
    rug_material        VARCHAR(15)
);
INSERT INTO material (rug_material)
VALUES ('Wool'),
       ('Silk'),
       ('Cotton');
SELECT * FROM material;

CREATE TABLE style(
    PRIMARY KEY (rug_style),
    rug_style           VARCHAR(15)
);
INSERT INTO style(rug_style)
VALUES ('Ushak'),
       ('Tabriz'),
       ('Agra');
SELECT * FROM style;

-- lots of information joining together; in other words look hehe
-- validation tables are referenced here, 3 to make fixed values!
CREATE TABLE rugs (
    PRIMARY KEY (inventory_id),
    inventory_id        INT AUTO_INCREMENT,
    origin_country      VARCHAR(15),
    rug_material        VARCHAR(15),
    rug_style           VARCHAR(15),
    rug_length          INT(4),
    rug_width           INT(4), 
    original_cost       INT(9),
    date_acquired       DATE,
    year_made           INT(4),
    markup_price        FLOAT(4),
    FOREIGN KEY (origin_country) REFERENCES country(origin_country)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT,
    FOREIGN KEY (rug_material) REFERENCES material(rug_material)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT,
    FOREIGN KEY (rug_style) REFERENCES style(rug_style)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
);
INSERT INTO rugs (origin_country, rug_material, rug_style, rug_length, rug_width, original_cost, date_acquired, year_made, markup_price)
VALUES ('Turkey', 'Wool', 'Ushak', '5', '7', '625', '2017-04-06', '1925', '1'),
       ('Iran', 'Silk', 'Tabriz', '10', '14', '28000', '2017-04-06', '1910', '.75'),
       ('India', 'Wool', 'Agra', '8', '10', '1200', '2017-06-15', '2017', '1'),
       ('India', 'Wool', 'Agra', '4', '6', '450', '2017-06-15', '2017', '1.2');
SELECT * FROM rugs;

--creates validation for states to prevent error and allow fixed values to determine
CREATE TABLE states(
    PRIMARY KEY (cust_state),
    cust_state          CHAR(2)
);
INSERT INTO states (cust_state)
VALUES ('MI'),
       ('OH'),
       ('GA'),
       ('PA'),
       ('CA');
SELECT * FROM states;

-- creates customers table
CREATE TABLE customers(
    PRIMARY KEY (customer_id),
    customer_id         INT AUTO_INCREMENT,
    cust_first          VARCHAR(20),
    cust_last           VARCHAR(20),
    cust_address        VARCHAR(50),
    city                VARCHAR(20),
    cust_state          CHAR(2),
    zip                 CHAR(5),
    cust_phone          VARCHAR(13),
    FOREIGN KEY (cust_state) REFERENCES states(cust_state)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
);
INSERT INTO customers(cust_first, cust_last, cust_address, city, cust_state, zip, cust_phone)
VALUES('Akira', 'Ingram', '68 Country Drive', 'Roseville', 'MI', '48066', '(926)252-6716'),
      ('Meredith', 'Spencer', '9044 Piper Lane', 'North Royalton', 'OH', '44133', '(817)530-5994'),
      ('Marco', 'Page', '747 East Harrison Lane', 'Atlanta', 'GA', '30303', '(588)799-6535'),
      ('Sandra', 'Page', '747 East Harrison Lane', 'Atlanta', 'GA', '30303', '(997)697-2666'),
      ('Bria', 'Le', '386 Silver Spear Court', 'Coraopolis', 'PA', '15108', '(999)494-3316'),
      ('Gloria', 'Gomez', '78 Corona Rd.', 'Fullerton', 'CA', '92831', '(867)926-2585');
SELECT * FROM customers;

-- verify the return_date is past date of sale!!!
CREATE TABLE sales(
    PRIMARY KEY (customer_id, inventory_id),
    inventory_id        INT,
    customer_id         INT,
    sales_price         INT(9),
    date_of_sale        DATE,
    return_date         DATE DEFAULT NULL CHECK (return_date >= date_of_sale),
    FOREIGN KEY (inventory_id) REFERENCES rugs(inventory_id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
);
--verify the values to see if default can be NULL for return date
INSERT INTO sales(inventory_id, customer_id, sales_price, date_of_sale, return_date)
VALUES ('1', '6', '990', '2017-12-14', NULL),
       ('3', '5', '2400', '2017-12-24', NULL),
       ('2', '2', '40000', '2017-12-14', '2017-12-26');
SELECT * FROM sales;

-- as well as trial start has to be b4 trial end and return as well, and return date cannot be > current date
CREATE TABLE trials(
    PRIMARY KEY (customer_id, inventory_id),
    inventory_id        INT,
    customer_id         INT,
    trial_start         DATE,
    trial_end           DATE DEFAULT DATE_ADD(trial_start, INTERVAL 14 DAY) CHECK (trial_end > trial_start), 
    return_date         DATE DEFAULT NULL CHECK (return_date >= trial_start),
    FOREIGN KEY (inventory_id) REFERENCES rugs(inventory_id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
);

--inserted values for trials to verify if it works!
INSERT INTO trials(inventory_id, customer_id, trial_start, return_date)
VALUES ('1', '2', '2017-12-14', NULL),
       ('2', '1', '2016-12-18', '2016-12-30'),
       ('4', '6', '2010-08-27', '2010-08-27');
SELECT * FROM trials;