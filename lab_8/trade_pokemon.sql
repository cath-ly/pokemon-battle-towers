--CREATE PROCEDURE
DROP FUNCTION IF EXISTS get_trainer;
CREATE FUNCTION get_trainer(id INT)
RETURNS INT
RETURN(
    SELECT trainer_id FROM pokemon
    WHERE pokemon_id = t_id
);

DROP FUNCTION IF EXISTS count_party;
CREATE FUNCTION count_party(t_id INT)
RETURNS INT
RETURN(
    SELECT COUNT(t_id) FROM trainers_party_members
    WHERE trainer_id = t_id
);
-- //
--if pokemon has capped
    -- SET FOREIGN_KEY_CHECKS = 0;
DELIMITER //
DROP PROCEDURE IF EXISTS trade_pk;
CREATE PROCEDURE trade_pk (IN p1_id INT, IN p2_id INT)
BEGIN
    START TRANSACTION;
        SET @joe = get_trainer(p1_id);

        UPDATE pokemon
        SET    trainer_id = get_trainer(p2_id)
        WHERE  pokemon_id = p1_id;

        UPDATE pokemon
        SET    trainer_id = @joe
        WHERE pokemon_id = p2_id;
    COMMIT;
END;
//
DELIMITER ;

-- cascade already does this!
-- but if restricted then...
/*DELIMITER //
DROP PROCEDURE IF EXISTS delete_trainer;
CREATE PROCEDURE delete_trainer(IN t_id INT)
BEGIN
    START TRANSACTION;
        SET FOREIGN_KEY_CHECKS = 0;

        DELETE FROM trainer
        WHERE trainer_id = t_id;

        DELETE FROM pokemon
        WHERE trainer_id = t_id;

        SET FOREIGN_KEY_CHECKS = 1;
    COMMIT;
END;
//
DELIMITER ;
*/
DELIMITER //
CREATE OR REPLACE TRIGGER max_party
    BEFORE INSERT ON trainer_party_members FOR EACH ROW
    IF (count_party(trainer_id)) >= 6 THEN
        -- error here
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Too many Pokemon/max party';
END IF;
//

-- if trainer has none in party
CREATE OR REPLACE TRIGGER no_party
    BEFORE DELETE ON trainer_party_members FOR EACH ROW
    IF (count_party(OLD.trainer_id)) < 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No Pokemon party';
END IF;
//

-- if pokemon is in party
CREATE OR REPLACE TRIGGER trade_pt
    BEFORE UPDATE ON trainer_party_members FOR EACH ROW
    IF (pokemon_id = OLD.pokemon_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No Pokemon party';
END IF;
//

-- procedure?

-- //
DELIMITER ;


