CREATE TABLE IF NOT EXISTS `rf_league_db`.`Round_Robin_Schedule` (
  `League_id` INT NOT NULL,
  `Season_id` INT NOT NULL,
  `Division_id` INT NOT NULL,
  `Player1_id` INT NOT NULL,
  `Player2_id` INT NOT NULL,
  `p1_challenges_p2` TINYINT(1) NULL,
  PRIMARY KEY (`League_id`, `Season_id`, `Division_id`, `Player1_id`, `Player2_id`),
  INDEX `fk_Player2_divPlayer_idx` (`Player2_id` ASC, `League_id` ASC, `Season_id` ASC, `Division_id` ASC) VISIBLE,
  CONSTRAINT `fk_Player1_divPlayer`
    FOREIGN KEY (`League_id` , `Season_id` , `Division_id` , `Player1_id`)
    REFERENCES `rf_league_db`.`Division_Player` (`League_id` , `Season_id` , `Division_id` , `Player_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Player2_divPlayer`
    FOREIGN KEY (`Player2_id` , `League_id` , `Season_id` , `Division_id`)
    REFERENCES `rf_league_db`.`Division_Player` (`Player_id` , `League_id` , `Season_id` , `Division_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB