CREATE DATABASE  IF NOT EXISTS `rf_league_db` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `rf_league_db`;
-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: localhost    Database: rf_league_db
-- ------------------------------------------------------
-- Server version	8.0.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `division`
--

DROP TABLE IF EXISTS `division`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `division` (
  `Division_id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`Division_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `division`
--

LOCK TABLES `division` WRITE;
/*!40000 ALTER TABLE `division` DISABLE KEYS */;
INSERT INTO `division` VALUES (1),(2),(3);
/*!40000 ALTER TABLE `division` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `division_player`
--

DROP TABLE IF EXISTS `division_player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `division_player` (
  `League_id` int NOT NULL,
  `Season_id` int NOT NULL,
  `Division_id` int NOT NULL,
  `Player_id` int NOT NULL,
  `totalPoints` int DEFAULT NULL,
  `totalGamesWon` int DEFAULT NULL,
  `position` int DEFAULT NULL,
  PRIMARY KEY (`League_id`,`Season_id`,`Division_id`,`Player_id`),
  KEY `fk_Lg_Seas_Div_Plyr_Plyr1_idx` (`Player_id`),
  KEY `fk_Lg_Seas_Div_Plyr_Lg_Seas_Div_idx` (`League_id`,`Season_id`,`Division_id`),
  CONSTRAINT `fk_Division` FOREIGN KEY (`League_id`, `Season_id`, `Division_id`) REFERENCES `league_season_division` (`League_id`, `Season_id`, `Division_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Player` FOREIGN KEY (`Player_id`) REFERENCES `player` (`Player_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `division_player`
--

LOCK TABLES `division_player` WRITE;
/*!40000 ALTER TABLE `division_player` DISABLE KEYS */;
INSERT INTO `division_player` VALUES (1,1,1,3,NULL,NULL,NULL),(1,1,1,4,NULL,NULL,NULL),(1,1,1,5,NULL,NULL,NULL),(1,1,1,6,NULL,NULL,NULL),(1,1,1,7,NULL,NULL,NULL),(1,1,2,9,NULL,NULL,NULL),(1,1,2,10,NULL,NULL,NULL),(1,1,2,12,NULL,NULL,NULL),(1,1,3,8,NULL,NULL,NULL),(1,1,3,11,NULL,NULL,NULL),(1,1,3,13,NULL,NULL,NULL),(2,1,1,15,NULL,NULL,NULL),(2,1,1,16,NULL,NULL,NULL);
/*!40000 ALTER TABLE `division_player` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `league`
--

DROP TABLE IF EXISTS `league`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `league` (
  `League_id` int NOT NULL AUTO_INCREMENT,
  `leagueName` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`League_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `league`
--

LOCK TABLES `league` WRITE;
/*!40000 ALTER TABLE `league` DISABLE KEYS */;
INSERT INTO `league` VALUES (1,'Europe'),(2,'USA');
/*!40000 ALTER TABLE `league` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `league_season`
--

DROP TABLE IF EXISTS `league_season`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `league_season` (
  `League_id` int NOT NULL,
  `Season_id` int NOT NULL,
  `startDate` date DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  PRIMARY KEY (`League_id`,`Season_id`),
  KEY `fk_lg_seas_lg_idx` (`Season_id`) /*!80000 INVISIBLE */,
  KEY `fk_Lg_seas_seas_idx` (`League_id`) /*!80000 INVISIBLE */,
  CONSTRAINT `fk_League_id` FOREIGN KEY (`League_id`) REFERENCES `league` (`League_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Season_id` FOREIGN KEY (`Season_id`) REFERENCES `season` (`Season_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `league_season`
--

LOCK TABLES `league_season` WRITE;
/*!40000 ALTER TABLE `league_season` DISABLE KEYS */;
INSERT INTO `league_season` VALUES (1,1,'2020-08-11','2020-08-09'),(1,2,'2020-08-27','2020-08-24'),(2,1,'2020-08-11','2020-09-09'),(2,2,'2020-08-27','2020-09-24');
/*!40000 ALTER TABLE `league_season` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `league_season_division`
--

DROP TABLE IF EXISTS `league_season_division`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `league_season_division` (
  `League_id` int NOT NULL,
  `Season_id` int NOT NULL,
  `Division_id` int NOT NULL,
  PRIMARY KEY (`League_id`,`Season_id`,`Division_id`),
  KEY `fk_Lg_Seas_Div_Div_idx` (`Division_id`),
  KEY `fk_Lg_Seas_Div_Lg_Seas_idx` (`League_id`,`Season_id`) /*!80000 INVISIBLE */,
  CONSTRAINT `fk_Division1` FOREIGN KEY (`Division_id`) REFERENCES `division` (`Division_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Season1` FOREIGN KEY (`League_id`, `Season_id`) REFERENCES `league_season` (`League_id`, `Season_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `league_season_division`
--

LOCK TABLES `league_season_division` WRITE;
/*!40000 ALTER TABLE `league_season_division` DISABLE KEYS */;
INSERT INTO `league_season_division` VALUES (1,1,1),(2,1,1),(1,1,2),(1,1,3);
/*!40000 ALTER TABLE `league_season_division` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leaguematch`
--

DROP TABLE IF EXISTS `leaguematch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leaguematch` (
  `LeagueMatch_id` int NOT NULL AUTO_INCREMENT,
  `datePlayed` date NOT NULL DEFAULT '9999-12-31',
  `drawn` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`LeagueMatch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leaguematch`
--

LOCK TABLES `leaguematch` WRITE;
/*!40000 ALTER TABLE `leaguematch` DISABLE KEYS */;
INSERT INTO `leaguematch` VALUES (1,'2020-08-11',NULL),(2,'2020-08-12',1),(3,'2020-08-12',NULL),(4,'2020-08-12',NULL),(5,'2020-08-27',NULL),(6,'2020-08-12',NULL),(7,'2020-08-12',NULL),(8,'2020-08-12',NULL),(9,'2020-08-12',NULL),(10,'2020-08-11',NULL),(11,'2020-08-12',NULL),(12,'2020-08-12',NULL),(13,'2020-08-12',NULL),(14,'2020-08-24',NULL),(15,'2020-08-12',NULL);
/*!40000 ALTER TABLE `leaguematch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player`
--

DROP TABLE IF EXISTS `player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player` (
  `Player_id` int NOT NULL AUTO_INCREMENT,
  `PSN_id` varchar(45) NOT NULL,
  `callingName` varchar(45) DEFAULT NULL,
  `Email` varchar(254) DEFAULT NULL,
  `activeInLeague` tinyint(1) NOT NULL DEFAULT '0',
  `enterInNextLeague` tinyint(1) NOT NULL DEFAULT '0',
  `selfRating` int DEFAULT NULL,
  `Server_id` int DEFAULT NULL,
  `dateRegistered` date DEFAULT NULL,
  `pwd` varchar(255) NOT NULL,
  `profilePic` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Player_id`),
  UNIQUE KEY `PSN_id_UNIQUE` (`PSN_id`),
  UNIQUE KEY `Email_UNIQUE` (`Email`),
  UNIQUE KEY `Email` (`Email`),
  KEY `fk_Player_Server_idx` (`Server_id`),
  CONSTRAINT `fk_Player_Server` FOREIGN KEY (`Server_id`) REFERENCES `server` (`Server_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player`
--

LOCK TABLES `player` WRITE;
/*!40000 ALTER TABLE `player` DISABLE KEYS */;
INSERT INTO `player` VALUES (1,'anne',NULL,NULL,0,1,1,1,NULL,'',NULL),(2,'ben',NULL,NULL,0,0,NULL,1,NULL,'',NULL),(3,'cathy',NULL,NULL,1,1,1,1,NULL,'',NULL),(4,'david',NULL,NULL,1,1,1,1,NULL,'',NULL),(5,'ellie',NULL,NULL,1,1,1,1,NULL,'',NULL),(6,'fred',NULL,NULL,1,1,1,1,NULL,'',NULL),(7,'george',NULL,NULL,1,1,1,1,NULL,'',NULL),(8,'harry',NULL,NULL,1,1,3,1,NULL,'',NULL),(9,'ian',NULL,NULL,1,1,2,1,NULL,'',NULL),(10,'jacob',NULL,NULL,1,1,2,1,NULL,'',NULL),(11,'kerry',NULL,NULL,1,0,3,1,NULL,'',NULL),(12,'larry',NULL,NULL,1,1,2,1,NULL,'',NULL),(13,'manny',NULL,NULL,1,1,3,1,NULL,'',NULL),(14,'noel',NULL,NULL,0,1,3,2,NULL,'',NULL),(15,'olaf',NULL,NULL,1,1,3,2,NULL,'',NULL),(16,'peter',NULL,NULL,1,1,1,2,NULL,'',NULL),(19,'csdds',NULL,'tej.dyal@yahoo.com',0,1,1,2,'2020-08-23','040b7cf4a55014e185813e0644502ea9','head_alizarin.png'),(20,'qwertty',NULL,'qwertyl@yahoo.com',0,0,2,2,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_pete_river.png'),(21,'asdfg',NULL,'qertyl@yahoo.com',0,0,2,2,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_green_sea.png'),(22,'qwerf',NULL,'qwerf@yahoo.com',0,1,1,1,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_belize_hole.png'),(23,'qwerfy',NULL,'qwerfy@yahoo.com',0,1,1,1,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_belize_hole.png'),(24,'zxcdsa',NULL,'dyal@yahoo.com',0,0,1,2,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_red.png'),(25,'annewdw',NULL,'yal@yahoo.com',0,1,1,2,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_turqoise.png'),(26,'anneefefe',NULL,'adyal@yahoo.com',0,1,3,1,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_carrot.png'),(27,'csddswe',NULL,'al@yahoo.com',0,1,3,1,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_red.png'),(28,'asdcxz',NULL,'aal@yahoo.com',0,1,3,1,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_emerald.png'),(29,'qasweedf',NULL,'ej.dyal@yahoo.com',0,1,2,1,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_pumpkin.png'),(30,'asdasdq',NULL,'tej.dyal@yahoo.comq',0,1,3,2,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_amethyst.png'),(31,'wsdertgfds',NULL,'tej.dyal@yahoo.comf',0,1,2,1,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_turqoise.png'),(32,'wsdertgfdsf',NULL,'tej.dyal@yahoo.comfe',0,1,1,1,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_green_sea.png'),(33,'wsdertgfdsfw',NULL,'tej.dyal@yahoo.comfew',0,0,3,1,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_pete_river.png'),(34,'wsdertgfdsfwaz',NULL,'tej.dyal@yahoo.comz',0,1,2,1,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_belize_hole.png'),(35,'wsdertgfdsfwaza',NULL,'tej.dyal@yahoo.comv',0,1,1,1,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_alizarin.png'),(37,'annewdswdwdwdq',NULL,'qertyl@yahoo.comq',0,1,3,1,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_wisteria.png'),(41,'csddsqaqaq',NULL,'',0,1,2,1,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_pete_river.png'),(42,'fdwfwvcdvcvds',NULL,NULL,0,1,3,1,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_red.png'),(43,'fdwfwvcdvcvdsd',NULL,NULL,0,1,1,1,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_turqoise.png'),(44,'qwerfdsa',NULL,NULL,0,1,2,1,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_deep_blue.png'),(45,'saffqwefwef',NULL,NULL,0,0,1,1,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_emerald.png'),(46,'asdsasddaasd',NULL,NULL,0,1,2,1,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_emerald.png'),(47,'fghtrdffvc',NULL,'tej.dyal@yahoo.comfeq',0,1,3,2,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_sun_flower.png'),(48,'annev',NULL,'tej.dyal@yahoo.comsd',0,0,1,2,'2020-08-26','040b7cf4a55014e185813e0644502ea9','head_pete_river.png'),(49,'csddswer',NULL,'qertyl@yahoo.comsd',0,1,3,1,'2020-08-26','040b7cf4a55014e185813e0644502ea9','head_sun_flower.png');
/*!40000 ALTER TABLE `player` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_leaguematch`
--

DROP TABLE IF EXISTS `player_leaguematch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player_leaguematch` (
  `League_id` int NOT NULL,
  `Season_id` int NOT NULL,
  `Division_id` int NOT NULL,
  `Player_id` int NOT NULL,
  `LeagueMatch_id` int NOT NULL,
  `points` int DEFAULT NULL,
  `noOfGamesWon` tinyint DEFAULT NULL,
  `hasForfeited` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`League_id`,`Season_id`,`Division_id`,`Player_id`,`LeagueMatch_id`),
  KEY `fk_Division_Player_LeagueMatch_LeagueMatch1_idx` (`LeagueMatch_id`),
  KEY `fk_Division_Player_LeagueMatch_Division_Player1_idx` (`League_id`,`Season_id`,`Division_id`,`Player_id`),
  CONSTRAINT `fk_Division_Player_LeagueMatch_Division_Player1` FOREIGN KEY (`League_id`, `Season_id`, `Division_id`, `Player_id`) REFERENCES `division_player` (`League_id`, `Season_id`, `Division_id`, `Player_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Division_Player_LeagueMatch_LeagueMatch1` FOREIGN KEY (`LeagueMatch_id`) REFERENCES `leaguematch` (`LeagueMatch_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_leaguematch`
--

LOCK TABLES `player_leaguematch` WRITE;
/*!40000 ALTER TABLE `player_leaguematch` DISABLE KEYS */;
INSERT INTO `player_leaguematch` VALUES (1,1,1,3,1,0,0,1),(1,1,1,3,2,2,2,NULL),(1,1,1,3,3,3,3,NULL),(1,1,1,3,4,3,3,NULL),(1,1,1,4,1,3,3,NULL),(1,1,1,4,5,1,1,NULL),(1,1,1,4,6,3,3,NULL),(1,1,1,4,7,3,3,NULL),(1,1,1,5,2,2,2,NULL),(1,1,1,5,5,3,3,NULL),(1,1,1,5,8,3,3,NULL),(1,1,1,6,3,1,2,NULL),(1,1,1,6,6,1,0,NULL),(1,1,1,6,9,1,1,NULL),(1,1,1,7,4,1,1,NULL),(1,1,1,7,7,1,1,NULL),(1,1,1,7,8,1,2,NULL),(1,1,1,7,9,3,3,NULL),(1,1,2,9,10,3,3,NULL),(1,1,2,9,11,3,3,NULL),(1,1,2,10,10,1,2,NULL),(1,1,2,10,12,3,3,NULL),(1,1,2,12,11,1,0,NULL),(1,1,2,12,12,1,1,NULL),(1,1,3,8,13,3,3,NULL),(1,1,3,11,13,1,0,NULL),(1,1,3,11,14,3,3,NULL),(1,1,3,13,14,1,0,NULL),(2,1,1,15,15,3,3,NULL),(2,1,1,16,15,1,0,NULL);
/*!40000 ALTER TABLE `player_leaguematch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playersort`
--

DROP TABLE IF EXISTS `playersort`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playersort` (
  `League_id` int DEFAULT NULL,
  `Season_id` int DEFAULT NULL,
  `Division_id` int DEFAULT NULL,
  `Player_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playersort`
--

LOCK TABLES `playersort` WRITE;
/*!40000 ALTER TABLE `playersort` DISABLE KEYS */;
INSERT INTO `playersort` VALUES (1,3,NULL,1),(1,3,NULL,3),(1,3,NULL,4),(1,3,NULL,5),(1,3,NULL,6),(1,3,NULL,7),(1,3,NULL,22),(1,3,NULL,23),(1,3,NULL,32),(1,3,NULL,35),(1,3,NULL,43),(1,3,NULL,9),(1,3,NULL,10),(1,3,NULL,12),(1,3,NULL,29),(1,3,NULL,31),(1,3,NULL,34),(1,3,NULL,41),(1,3,NULL,44),(1,3,NULL,46),(1,3,NULL,8),(1,3,NULL,13),(1,3,NULL,26),(1,3,NULL,27),(1,3,NULL,28),(1,3,NULL,37),(1,3,NULL,42),(1,3,NULL,49);
/*!40000 ALTER TABLE `playersort` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `season`
--

DROP TABLE IF EXISTS `season`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `season` (
  `Season_id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`Season_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `season`
--

LOCK TABLES `season` WRITE;
/*!40000 ALTER TABLE `season` DISABLE KEYS */;
INSERT INTO `season` VALUES (1),(2);
/*!40000 ALTER TABLE `season` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `server`
--

DROP TABLE IF EXISTS `server`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `server` (
  `Server_id` int NOT NULL AUTO_INCREMENT,
  `serverName` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Server_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server`
--

LOCK TABLES `server` WRITE;
/*!40000 ALTER TABLE `server` DISABLE KEYS */;
INSERT INTO `server` VALUES (1,'Europe'),(2,'USA');
/*!40000 ALTER TABLE `server` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'rf_league_db'
--

--
-- Dumping routines for database 'rf_league_db'
--
/*!50003 DROP PROCEDURE IF EXISTS `add_new_season` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_new_season`(in seasonId int)
BEGIN
	select max(Season_id) s from season;
    if seasonId > s then
		INSERT INTO season (`Season_id`) VALUES ('seasonId');
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sortBySelfRating` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sortBySelfRating`(in serverId int, seasonId int, playersInDiv int)
begin

	declare noOfDivs int;
    declare playerCount int;
    declare currentMaxDiv int;
	
    /* sort all players playing in next season by their self rating */
	drop table if exists playerSort;
    create table playerSort
    (
    League_id int, Season_id int, Division_id int, Player_id int
    );
    insert into playerSort (Player_id)
	select Player_id 
	from player
	where Server_id = serverId and enterInNextLeague = 1
	order by selfRating;
    
    /* popagate columns with the league and Season ids */
    update playerSort set League_id = serverId, Season_id = seasonId;
    
    /* calculate number of divisions needed */
    set noOfDivs = 0;
    select count(Player_id)
    into playerCount
    from playerSort;
    set noOfDivs = ceiling(playerCount/playersInDiv);
    
    select playerCount, noOfDivs;
    
    /* increment divisons in divison table if the new number of divisions for the next league is more than current maximum */
    select max(Division_id)
    into currentMaxDiv
    from division;
   

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-08-28 16:52:08
