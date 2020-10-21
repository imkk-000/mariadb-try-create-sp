DROP TABLE IF EXISTS `mydb`.`users`;

CREATE TABLE IF NOT EXISTS `mydb`.`users` (
    `user_id` VARCHAR(40) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`user_id`),
    INDEX `user_id_idx` (`user_id` ASC)
) ENGINE = InnoDB;
DELIMITER ;;
CREATE TRIGGER `mydb`.`users_BEFORE_INSERT`
    BEFORE INSERT ON `users`
    FOR EACH ROW
BEGIN
    SET NEW.user_id = UUID();
END
;;

DELIMITER ;;
CREATE OR REPLACE PROCEDURE mydb.get_user_sp (name VARCHAR(255))
BEGIN
	IF (name IS NULL OR name = '') THEN
		SELECT * FROM mydb.users;
	ELSE
		SELECT * FROM mydb.users u
		WHERE u.name = name;
    END IF;
END
;;
