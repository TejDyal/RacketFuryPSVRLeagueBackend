-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema rf_league_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema rf_league_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `rf_league_db` DEFAULT CHARACTER SET utf8 ;
USE `rf_league_db` ;

-- -----------------------------------------------------
-- Table `rf_league_db`.`Server`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rf_league_db`.`Server` (
  `Server_id` INT NOT NULL AUTO_INCREMENT,
  `serverName` VARCHAR(45) NULL,
  PRIMARY KEY (`Server_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rf_league_db`.`Player`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rf_league_db`.`Player` (
  `Player_id` INT NOT NULL AUTO_INCREMENT,
  `PSN_id` VARCHAR(45) NOT NULL,
  `callingName` VARCHAR(45) NULL,
  `Email` VARCHAR(254) NULL,
  `activeInLeague` TINYINT(1) NOT NULL DEFAULT 0,
  `enterInNextLeague` TINYINT(1) NOT NULL DEFAULT 0,
  `standard` VARCHAR(45) NOT NULL,
  `Server_Server_id` INT NOT NULL,
  PRIMARY KEY (`Player_id`),
  UNIQUE INDEX `PSN_id_UNIQUE` (`PSN_id` ASC) VISIBLE,
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE,
  INDEX `fk_Player_Server_idx` (`Server_Server_id` ASC) VISIBLE,
  CONSTRAINT `fk_Player_Server`
    FOREIGN KEY (`Server_Server_id`)
    REFERENCES `rf_league_db`.`Server` (`Server_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rf_league_db`.`League`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rf_league_db`.`League` (
  `League_id` INT NOT NULL AUTO_INCREMENT,
  `leagueName` VARCHAR(45) NULL,
  PRIMARY KEY (`League_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rf_league_db`.`Season`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rf_league_db`.`Season` (
  `Season_id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`Season_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rf_league_db`.`League_Season`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rf_league_db`.`League_Season` (
  `League_id` INT NOT NULL,
  `Season_id` INT NOT NULL,
  `startDate` DATE NULL,
  `endDate` DATE NULL,
  PRIMARY KEY (`League_id`, `Season_id`),
  INDEX `fk_lg_seas_lg_idx` (`Season_id` ASC) INVISIBLE,
  INDEX `fk_Lg_seas_seas_idx` (`League_id` ASC) INVISIBLE,
  CONSTRAINT `fk_League_id`
    FOREIGN KEY (`League_id`)
    REFERENCES `rf_league_db`.`League` (`League_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Season_id`
    FOREIGN KEY (`Season_id`)
    REFERENCES `rf_league_db`.`Season` (`Season_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rf_league_db`.`Division`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rf_league_db`.`Division` (
  `Division_id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`Division_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rf_league_db`.`League_Season_Division`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rf_league_db`.`League_Season_Division` (
  `League_id` INT NOT NULL,
  `Season_id` INT NOT NULL,
  `Division_id` INT NOT NULL,
  PRIMARY KEY (`League_id`, `Season_id`, `Division_id`),
  INDEX `fk_Lg_Seas_Div_Div_idx` (`Division_id` ASC) VISIBLE,
  INDEX `fk_Lg_Seas_Div_Lg_Seas_idx` (`League_id` ASC, `Season_id` ASC) INVISIBLE,
  CONSTRAINT `fk_Season1`
    FOREIGN KEY (`League_id` , `Season_id`)
    REFERENCES `rf_league_db`.`League_Season` (`League_id` , `Season_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Division1`
    FOREIGN KEY (`Division_id`)
    REFERENCES `rf_league_db`.`Division` (`Division_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rf_league_db`.`LeagueMatch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rf_league_db`.`LeagueMatch` (
  `LeagueMatch_id` INT NOT NULL AUTO_INCREMENT,
  `datePlayed` DATE NOT NULL DEFAULT '9999-12-31',
  `drawn` TINYINT(1) NULL,
  PRIMARY KEY (`LeagueMatch_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rf_league_db`.`Division_Player`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rf_league_db`.`Division_Player` (
  `League_id` INT NOT NULL,
  `Season_id` INT NOT NULL,
  `Division_id` INT NOT NULL,
  `Player_id` INT NOT NULL,
  `totalPoints` INT NULL,
  `totalGamesWon` INT NULL,
  PRIMARY KEY (`League_id`, `Season_id`, `Division_id`, `Player_id`),
  INDEX `fk_Lg_Seas_Div_Plyr_Plyr1_idx` (`Player_id` ASC) VISIBLE,
  INDEX `fk_Lg_Seas_Div_Plyr_Lg_Seas_Div_idx` (`League_id` ASC, `Season_id` ASC, `Division_id` ASC) VISIBLE,
  CONSTRAINT `fk_Division`
    FOREIGN KEY (`League_id` , `Season_id` , `Division_id`)
    REFERENCES `rf_league_db`.`League_Season_Division` (`League_id` , `Season_id` , `Division_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Player`
    FOREIGN KEY (`Player_id`)
    REFERENCES `rf_league_db`.`Player` (`Player_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rf_league_db`.`Player_LeagueMatch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rf_league_db`.`Player_LeagueMatch` (
  `League_id` INT NOT NULL,
  `Season_id` INT NOT NULL,
  `Division_id` INT NOT NULL,
  `Player_id` INT NOT NULL,
  `LeagueMatch_id` INT NOT NULL,
  `points` INT NULL,
  `noOfGamesWon` TINYINT(5) NULL,
  `hasForfeited` TINYINT(1) NULL,
  PRIMARY KEY (`League_id`, `Season_id`, `Division_id`, `Player_id`, `LeagueMatch_id`),
  INDEX `fk_Division_Player_LeagueMatch_LeagueMatch1_idx` (`LeagueMatch_id` ASC) VISIBLE,
  INDEX `fk_Division_Player_LeagueMatch_Division_Player1_idx` (`League_id` ASC, `Season_id` ASC, `Division_id` ASC, `Player_id` ASC) VISIBLE,
  CONSTRAINT `fk_Division_Player_LeagueMatch_Division_Player1`
    FOREIGN KEY (`League_id` , `Season_id` , `Division_id` , `Player_id`)
    REFERENCES `rf_league_db`.`Division_Player` (`League_id` , `Season_id` , `Division_id` , `Player_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Division_Player_LeagueMatch_LeagueMatch1`
    FOREIGN KEY (`LeagueMatch_id`)
    REFERENCES `rf_league_db`.`LeagueMatch` (`LeagueMatch_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
