/*
    Chantakrak Ath-Ly
    09/17/2021
    Lab 03
    Prof. William Bailey
*/
-- needed to delete duplicates of the database movie_ratings
DROP DATABASE IF EXISTS movie_ratings;
 
 -- creates database and goes into movie_ratings database
CREATE DATABASE movie_ratings;

USE movie_ratings;

/*
-- establishing movies and providing the info from table
CREATE TABLE movies (
    PRIMARY KEY (movie_id),
    movie_id        INT AUTO_INCREMENT, 
    movie_title     VARCHAR(220),
    release_date    VARCHAR(10),
    genre           VARCHAR(30)
);

INSERT INTO movies (movie_title, release_date, genre)
VALUES ('The Hunt for Red October', '1990-03-02',   'Action, Adventure, Thriller'),
       ('Lady Bird',                '2017-12-01',   'Comedy, Drama'),
       ('Inception',                '2010-08-16',   'Action, Adventure, Sci-Fi');

-- creating consumers table to provide info about the consumer of the movie
CREATE TABLE consumers (
    PRIMARY KEY (consumer_id),
    consumer_id INT AUTO_INCREMENT, 
    first_name  VARCHAR(20),
    last_name   VARCHAR(10),
    con_address VARCHAR(50),
    city        VARCHAR(20),
    con_state   CHAR(2),
    zip         CHAR(5)
);

INSERT INTO consumers (first_name, last_name, con_address, city, con_state, zip)
VALUES ('Toru',   'Okada',    '800 Glenridge Ave', 'Hobart',     'IN', '46342'),
       ('Kumiko', 'Okada',    '864 NW Bohemia St', 'Vincentown', 'NJ', '08088'),
       ('Noboru', 'Wataya',   '342 Joy Ridge St',  'Hermitage',  'TN', '37076'),
       ('May',    'Kasahara', '5 Kent Rd',         'East Haven', 'CT', '06512');

-- ratings table created to give input values
CREATE TABLE ratings(
    PRIMARY KEY (consumer_id, movie_id),
    movie_id        INT,
    consumer_id     INT,
    when_rated      TIMESTAMP,
    number_stars    VARCHAR(1),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (consumer_id) REFERENCES consumers(consumer_id)
);

INSERT INTO ratings (movie_id, consumer_id, when_rated, number_stars)
VALUES ('1', '1', '2010-09-02 10:54:19', '4'),
       ('1', '3', '2012-08-05 15:00:01', '3'),
       ('1', '4', '2016-10-02 23:58:12', '1'),
       ('2', '3', '2017-03-27 00:12:48', '2'),
       ('2', '4', '2018-08-02 00:54:42', '4');

SELECT * FROM movies;
SELECT * FROM consumers;
SELECT * FROM ratings;

SELECT first_name, last_name, movie_title, number_stars
    FROM movies
    NATURAL JOIN ratings
    NATURAL JOIN consumers; */
CREATE TABLE movies (
    PRIMARY KEY (movie_id),
    movie_id        INT AUTO_INCREMENT, 
    movie_title     VARCHAR(220),
    release_date    VARCHAR(10)
);

INSERT INTO movies (movie_title, release_date)
VALUES ('The Hunt for Red October', '1990-03-02'),
       ('Lady Bird',                '2017-12-01'),
       ('Inception',                '2010-08-16');

-- creating validation table to separate the genre category in movies
CREATE TABLE genre (
    PRIMARY KEY (genre_name),
    genre_name  VARCHAR (30)
);

INSERT INTO genre (genre_name)
VALUES ('Action'), 
       ('Adventure'),
       ('Comedy'),
       ('Drama'),
       ('Sci-Fi'),
       ('Thriller');

-- creating linking table
CREATE TABLE movie_genre (
    PRIMARY KEY (movie_id, genre_name),
    movie_id        INT,
    genre_name      VARCHAR (30),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (genre_name) REFERENCES genre(genre_name)
);

INSERT INTO movie_genre (movie_id, genre_name)
VALUES ('1', 'Action'),
       ('1', 'Adventure'),
       ('1', 'Thriller'),
       ('2', 'Comedy'),
       ('2', 'Drama'),
       ('3', 'Action'),
       ('3', 'Drama'),
       ('3', 'Sci-Fi');

SELECT * FROM movies;
SELECT * FROM genre;
SELECT * FROM movie_genre;

/* The major flaw was that the genre was a multi-valued field and needed to be broken down. Using a validation table
allows for the genre to be in their individual table and then allow for a linking table to help show which movie has the genre.
Making the field that was once multi-valued to now single and clean. :)
*/

-- WB: Nice script Chantakrak!