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
-- Temporary view structure for view `countplayersperdiv`
--

DROP TABLE IF EXISTS `countplayersperdiv`;
/*!50001 DROP VIEW IF EXISTS `countplayersperdiv`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `countplayersperdiv` AS SELECT 
 1 AS `Division_id`,
 1 AS `count(Player_id)`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `division`
--

DROP TABLE IF EXISTS `division`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `division` (
  `Division_id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`Division_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
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
  `seasonLength` int DEFAULT NULL,
  `maxPlayersInDiv` int DEFAULT NULL,
  `gapBetweenSeasons` int DEFAULT NULL,
  PRIMARY KEY (`League_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `league`
--

LOCK TABLES `league` WRITE;
/*!40000 ALTER TABLE `league` DISABLE KEYS */;
INSERT INTO `league` VALUES (1,'Europe',NULL,NULL,NULL),(2,'USA',NULL,NULL,NULL);
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
INSERT INTO `league_season` VALUES (1,1,'2020-08-11','2020-09-06'),(1,2,'2020-09-07','2020-09-28'),(2,1,'2020-08-11','2020-09-06'),(2,2,'2020-09-10','2020-10-01');
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
  `enterInNextSeason` tinyint(1) DEFAULT NULL,
  `selfRating` int DEFAULT NULL,
  `Server_id` int DEFAULT NULL,
  `dateRegistered` date DEFAULT NULL,
  `pwd` varchar(255) NOT NULL,
  `profilePic` varchar(255) DEFAULT NULL,
  `availability` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Player_id`),
  UNIQUE KEY `PSN_id_UNIQUE` (`PSN_id`),
  UNIQUE KEY `Email_UNIQUE` (`Email`),
  UNIQUE KEY `Email` (`Email`),
  KEY `fk_Player_Server_idx` (`Server_id`),
  CONSTRAINT `fk_Player_Server` FOREIGN KEY (`Server_id`) REFERENCES `server` (`Server_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player`
--

LOCK TABLES `player` WRITE;
/*!40000 ALTER TABLE `player` DISABLE KEYS */;
INSERT INTO `player` VALUES (1,'anne',NULL,NULL,0,1,1,1,NULL,'',NULL,NULL),(2,'ben',NULL,NULL,0,0,NULL,1,NULL,'',NULL,NULL),(3,'cathy',NULL,NULL,1,1,1,1,NULL,'',NULL,NULL),(4,'david',NULL,NULL,1,1,1,1,NULL,'',NULL,NULL),(5,'ellie',NULL,NULL,1,1,1,1,NULL,'',NULL,NULL),(6,'fred',NULL,NULL,1,1,1,1,NULL,'',NULL,NULL),(7,'george',NULL,NULL,1,1,1,1,NULL,'',NULL,NULL),(8,'harry',NULL,NULL,1,1,3,1,NULL,'',NULL,NULL),(9,'ian',NULL,NULL,1,1,2,1,NULL,'',NULL,NULL),(10,'jacob',NULL,NULL,1,1,2,1,NULL,'',NULL,NULL),(11,'kerry',NULL,NULL,1,0,3,1,NULL,'',NULL,NULL),(12,'larry',NULL,NULL,1,1,2,1,NULL,'',NULL,NULL),(13,'manny',NULL,NULL,1,1,3,1,NULL,'',NULL,NULL),(14,'noel',NULL,NULL,0,1,3,2,NULL,'',NULL,NULL),(15,'olaf',NULL,NULL,1,1,3,2,NULL,'',NULL,NULL),(16,'peter',NULL,NULL,1,1,1,2,NULL,'',NULL,NULL),(19,'csdds',NULL,'tej.dyal@yahoo.com',0,1,1,2,'2020-08-23','040b7cf4a55014e185813e0644502ea9','head_alizarin.png',NULL),(20,'qwertty',NULL,'qwertyl@yahoo.com',0,0,2,2,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_pete_river.png',NULL),(21,'asdfg',NULL,'qertyl@yahoo.com',0,0,2,2,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_green_sea.png',NULL),(22,'qwerf',NULL,'qwerf@yahoo.com',0,1,1,1,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_belize_hole.png',NULL),(23,'qwerfy',NULL,'qwerfy@yahoo.com',0,1,1,1,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_belize_hole.png',NULL),(24,'zxcdsa',NULL,'dyal@yahoo.com',0,0,1,2,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_red.png',NULL),(25,'annewdw',NULL,'yal@yahoo.com',0,1,1,2,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_turqoise.png',NULL),(26,'anneefefe',NULL,'adyal@yahoo.com',0,1,3,1,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_carrot.png',NULL),(27,'csddswe',NULL,'al@yahoo.com',0,1,3,1,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_red.png',NULL),(28,'asdcxz',NULL,'aal@yahoo.com',0,1,3,1,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_emerald.png',NULL),(29,'qasweedf',NULL,'ej.dyal@yahoo.com',0,1,2,1,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_pumpkin.png',NULL),(30,'asdasdq',NULL,'tej.dyal@yahoo.comq',0,1,3,2,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_amethyst.png',NULL),(31,'wsdertgfds',NULL,'tej.dyal@yahoo.comf',0,1,2,1,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_turqoise.png',NULL),(32,'wsdertgfdsf',NULL,'tej.dyal@yahoo.comfe',0,1,1,1,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_green_sea.png',NULL),(33,'wsdertgfdsfw',NULL,'tej.dyal@yahoo.comfew',0,0,3,1,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_pete_river.png',NULL),(34,'wsdertgfdsfwaz',NULL,'tej.dyal@yahoo.comz',0,1,2,1,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_belize_hole.png',NULL),(35,'wsdertgfdsfwaza',NULL,'tej.dyal@yahoo.comv',0,1,1,1,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_alizarin.png',NULL),(37,'annewdswdwdwdq',NULL,'qertyl@yahoo.comq',0,1,3,1,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_wisteria.png',NULL),(41,'csddsqaqaq',NULL,'',0,1,2,1,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_pete_river.png',NULL),(42,'fdwfwvcdvcvds',NULL,NULL,0,1,3,1,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_red.png',NULL),(43,'fdwfwvcdvcvdsd',NULL,NULL,0,1,1,1,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_turqoise.png',NULL),(44,'qwerfdsa',NULL,NULL,0,1,2,1,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_deep_blue.png',NULL),(45,'saffqwefwef',NULL,NULL,0,0,1,1,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_emerald.png',NULL),(46,'asdsasddaasd',NULL,NULL,0,1,2,1,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_emerald.png',NULL),(47,'fghtrdffvc',NULL,'tej.dyal@yahoo.comfeq',0,1,3,2,'2020-08-24','040b7cf4a55014e185813e0644502ea9','head_sun_flower.png',NULL),(48,'annev',NULL,'tej.dyal@yahoo.comsd',0,0,1,2,'2020-08-26','040b7cf4a55014e185813e0644502ea9','head_pete_river.png',NULL),(49,'csddswer',NULL,'qertyl@yahoo.comsd',0,1,3,1,'2020-08-26','040b7cf4a55014e185813e0644502ea9','head_sun_flower.png',NULL),(50,'poli',NULL,'tej.dyal@yahoo.comloi',0,1,3,1,'2020-08-30','040b7cf4a55014e185813e0644502ea9','head_turqoise.png',NULL);
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
-- Table structure for table `playerdivisions`
--

DROP TABLE IF EXISTS `playerdivisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playerdivisions` (
  `League_id` int NOT NULL,
  `Season_id` int NOT NULL,
  `Division_id` int NOT NULL,
  `Player_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playerdivisions`
--

LOCK TABLES `playerdivisions` WRITE;
/*!40000 ALTER TABLE `playerdivisions` DISABLE KEYS */;
INSERT INTO `playerdivisions` VALUES (1,1,1,3),(1,1,1,4),(1,1,1,5),(1,1,1,6),(1,1,1,7),(1,1,2,9),(1,1,2,10),(1,1,2,12),(1,1,3,8),(1,1,3,11),(1,1,3,13),(2,1,1,15),(2,1,1,16);
/*!40000 ALTER TABLE `playerdivisions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playersort`
--

DROP TABLE IF EXISTS `playersort`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playersort` (
  `Division_id` int NOT NULL,
  `Player_id` int NOT NULL,
  `totalPoints` decimal(32,0) DEFAULT NULL,
  `gamesWon` decimal(26,0) DEFAULT NULL,
  `gamesCount` int DEFAULT NULL,
  `enterInNextSeason` tinyint(1) DEFAULT NULL,
  `playerRank` bigint unsigned NOT NULL DEFAULT '0',
  `playerRankReverse` bigint unsigned NOT NULL DEFAULT '0',
  `subRowNum` bigint unsigned NOT NULL DEFAULT '0',
  `subRowNumReverse` bigint unsigned NOT NULL DEFAULT '0',
  `selfRating` int DEFAULT NULL,
  `rowNum` int DEFAULT NULL,
  `newRowNum` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playersort`
--

LOCK TABLES `playersort` WRITE;
/*!40000 ALTER TABLE `playersort` DISABLE KEYS */;
INSERT INTO `playersort` VALUES (1,4,10,10,4,1,1,5,1,5,NULL,1,NULL),(1,3,8,8,4,1,2,4,2,4,NULL,2,NULL),(1,5,8,8,3,1,3,3,3,3,NULL,3,NULL),(1,7,6,7,4,1,4,2,4,2,NULL,4,NULL),(2,6,3,3,3,1,5,1,5,1,NULL,5,NULL),(1,9,6,6,2,1,1,3,1,3,NULL,6,NULL),(2,10,4,5,2,1,2,2,2,2,NULL,7,NULL),(3,12,2,1,2,1,3,1,3,1,NULL,8,NULL),(3,8,3,3,1,1,2,2,2,2,NULL,9,NULL),(3,13,1,0,1,1,3,1,3,1,NULL,10,NULL),(0,1,NULL,NULL,NULL,NULL,0,0,0,0,1,11,NULL),(0,22,NULL,NULL,NULL,NULL,0,0,0,0,1,12,NULL),(0,23,NULL,NULL,NULL,NULL,0,0,0,0,1,13,NULL),(0,32,NULL,NULL,NULL,NULL,0,0,0,0,1,14,NULL),(0,35,NULL,NULL,NULL,NULL,0,0,0,0,1,15,NULL),(0,43,NULL,NULL,NULL,NULL,0,0,0,0,1,16,NULL),(0,29,NULL,NULL,NULL,NULL,0,0,0,0,2,17,NULL),(0,31,NULL,NULL,NULL,NULL,0,0,0,0,2,18,NULL),(0,34,NULL,NULL,NULL,NULL,0,0,0,0,2,19,NULL),(0,41,NULL,NULL,NULL,NULL,0,0,0,0,2,20,NULL),(0,44,NULL,NULL,NULL,NULL,0,0,0,0,2,21,NULL),(0,46,NULL,NULL,NULL,NULL,0,0,0,0,2,22,NULL),(0,26,NULL,NULL,NULL,NULL,0,0,0,0,3,23,NULL),(0,27,NULL,NULL,NULL,NULL,0,0,0,0,3,24,NULL),(0,28,NULL,NULL,NULL,NULL,0,0,0,0,3,25,NULL),(0,37,NULL,NULL,NULL,NULL,0,0,0,0,3,26,NULL),(0,42,NULL,NULL,NULL,NULL,0,0,0,0,3,27,NULL),(0,49,NULL,NULL,NULL,NULL,0,0,0,0,3,28,NULL),(0,50,NULL,NULL,NULL,NULL,0,0,0,0,3,29,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
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
-- Temporary view structure for view `tallyplayerpointsbydiv`
--

DROP TABLE IF EXISTS `tallyplayerpointsbydiv`;
/*!50001 DROP VIEW IF EXISTS `tallyplayerpointsbydiv`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `tallyplayerpointsbydiv` AS SELECT 
 1 AS `Division_id`,
 1 AS `Player_id`,
 1 AS `totalPoints`,
 1 AS `gamesWon`,
 1 AS `gamesCount`,
 1 AS `enterInNextSeason`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'rf_league_db'
--

--
-- Dumping routines for database 'rf_league_db'
--
/*!50003 DROP FUNCTION IF EXISTS `gamesCount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `gamesCount`(leagueId int, seasonId int, divisionId int, playerId int) RETURNS int
    READS SQL DATA
BEGIN
	declare gamesCount int;
	select count(Player_id)
    into gamesCount
	from player_leaguematch
	where League_id = leagueId and Season_id = seasonId and Division_id = divisionId and Player_id = playerId;
RETURN gamesCount;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getMaxDiv` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getMaxDiv`() RETURNS int
    READS SQL DATA
BEGIN
	declare maxDiv int;
	select max(Division_id)
    into maxDiv
    from playerSort;
RETURN maxDiv;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getPlayerNumInDiv` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getPlayerNumInDiv`(divisionId int) RETURNS int
    READS SQL DATA
BEGIN
	declare playerCount int;
	select count(Player_id)
    into playerCount
	from playerSort dp
	where Division_id = divisionId;
RETURN playerCount;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `firstSeasonLeagueSetup` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `firstSeasonLeagueSetup`(in serverId int,
																		seasonId int, 
                                                                        maxPlayersInDiv int, 
                                                                        minPlayersInDiv int, 
                                                                        startDate date, 
                                                                        endDate date,
                                                                        seasonLength int)
begin

	declare noOfDivs int;
    declare playerCount int;
    declare currentMaxDiv int;
    declare divCount int;
    declare divPlayersCount int;
    declare rowPointer int;
	declare s int;
    declare playersInLastDiv int;
    declare movePlayers bool;
	
    /* add new season to season and season_league tables if they don't exist (remember different leagues might have different number of seasons) */
    select max(Season_id) from season
    into s;
    if seasonId > s then
		INSERT INTO season (`Season_id`) VALUES (seasonId);
	end if;
    select max(Season_id) 
	from league_season
    where League_id = serverId
    into s;
    if seasonId > s then
		INSERT INTO league_season (`Season_id`, `League_id`, `startDate`, `endDate`) 
        VALUES (seasonId, serverId, statDate, endDate);
	end if;
	
    /* sort all players playing in next season by their self rating and add a row index */
	drop table if exists playerSort;
    create table playerSort
    (
    League_id int, Season_id int, Division_id int, Player_id int, selfRating int, row_num int
    );
    set @row_number = 0;
    insert into playerSort (Player_id, selfRating, row_num)
	select 
		player_id,
        selfRating,
        @row_number:=@row_number+1
	from player
	where Server_id = serverId and enterInNextSeason = 1
	order by selfRating;
    
    /* popagate columns with the league and Season ids */
    update playerSort set League_id = serverId, Season_id = seasonId;
    
    /* calculate number of divisions needed */
    set noOfDivs = 0;
    select count(Player_id)
    into playerCount
    from playerSort;
    set noOfDivs = ceiling(playerCount/maxPlayersInDiv);
    
    /* increment divisons in divison table if the new number of divisions for the next league is more than current maximum */
    select max(Division_id)
    into currentMaxDiv
    from division;
    while noOfDivs > currentMaxDiv do
		insert into division
        values (currentMaxDiv+1);
        set currentMaxDiv = currentMaxDiv + 1;
	end while;    
    
    /* assign players to their division */
    set divCount = 1;
    set divPlayersCount = 0;
    set rowPointer = 1;
    while rowPointer <= playerCount do
		update playerSort 
        set Division_id = divCount
        where row_num = rowPointer;
        set rowPointer = rowPointer+1;
        set divPlayersCount = divPlayersCount + 1;
        if divPlayersCount = maxPlayersInDiv then
			set divPlayersCount = 0;
            set divCount = divCount+1;
		end if;
    end while;
    
	/* determines if there is sufficient players in the bottom division.  
			If there isn't then spread players into immediate upper divisions. 
					Also tests there is enough divisions above.*/
    select count(Player_id)
    into playersInLastDiv
    from playerSort
    where Division_id = noOfDivs;
    if playersInLastDiv < minPlayersInDiv then
		set rowPointer = playerCount;
		while (playersInLastDiv > 0) and (divCount-playersInLastDiv > 0) do
			update playerSort 
			set Division_id = divCount-playersInLastDiv
			where row_num = rowPointer;
            set playersInLastDiv = playersInLastDiv-1;
            set rowPointer = rowPointer - 1;
		end while;
        if playersInLastDiv = 0 then
			set noOfDivs = noOfDivs-1;
		end if;
	end if;
    
    /* update league_season table with new season and dates*/
    insert into league_season (League_id, Season_id, startDate, endDate)
        values (serverId, seasonId, startDate, startDate+seasonLength);
    
    /* update league_season_division table with new season rows */
    set divCount = 1;
    set rowPointer = 1;
    while divCount <= noOfDivs do
		insert into league_season_division (League_id, Season_id, Division_id)
        values (serverId, seasonId, divCount);
        set divCount = divCount + 1;
	end while;
    
    /* append playersort table to division_player table - (this completes the first league season setup) */
    insert into division_player (League_id, Season_id, Division_id, Player_id)
    select League_id, Season_id, Division_id, Player_id
    from playerSort;
    

    
    
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `showAllPlayers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `showAllPlayers`(sortBy varchar(25), loggedIn bool, psnAscending bool, divAscending bool, inLeaguesAscending bool)
BEGIN
	
    /* create copy of players table with additional playingInLeagues coloumn*/
    drop table if exists playersList;
    create table playersList
    (
    Player_id int, PSN_id varchar(45), availability varchar(100), enterInNextSeason int, playingInLeagues varchar(3)
    );
    insert into playersList (Player_id, PSN_id, availability, enterInNextSeason)
	select 
		Player_id,
		PSN_id,
        availability,
        enterInNextSeason
	from player;
    
    /* fill in playingInLeagues column */
    UPDATE playersList
	SET playingInleagues = CASE
    WHEN enterInNextSeason=1 THEN "Yes"
    ELSE "No"
	END;    
	 
    
    /* create a temp table to obtain player divisions */
	drop table if exists playerDivisions;
	create table playerDivisions as
		select dp.League_id, dp.Season_id, dp.Division_id, dp.Player_id
        from division_player dp
        left join league_season ls
			on ls.League_id = dp.League_id
            and ls.Season_id = dp.Season_id
		where endDate > now();
        
	/* join the above two temp tables to show a complete players list with associated divisions */
	select pl.PSN_id as "PSN",
		pl.availability as "Availability",
        (case when loggedIn = true then pd.Division_id
        else pl.playingInLeagues
        end)
    from playersList pl
    left join playerDivisions pd
		on pl.Player_id = pd.Player_id
    order by     
		case when sortBy = "Division_id" and divAscending = true then Division_id end asc,
        case when sortBy = "Division_id" and divAscending = false then Division_id end desc,
		case when sortby = "playingInLeagues" and inLeaguesAscending = true then playingInLeagues end asc,
        case when sortby = "playingInLeagues" and inLeaguesAscending = false then playingInLeagues end desc,
        case when psnAscending = false then PSN_id end desc,
		case when psnAscending = true then PSN_id end asc;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `countplayersperdiv`
--

/*!50001 DROP VIEW IF EXISTS `countplayersperdiv`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `countplayersperdiv` AS select `dp`.`Division_id` AS `Division_id`,count(`dp`.`Player_id`) AS `count(Player_id)` from (`division_player` `dp` join `player` `p` on((`dp`.`Player_id` = `p`.`Player_id`))) where ((`p`.`enterInNextSeason` = 1) and (`dp`.`League_id` = 1) and (`dp`.`Season_id` = 1)) group by `dp`.`Division_id` order by `dp`.`Division_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `tallyplayerpointsbydiv`
--

/*!50001 DROP VIEW IF EXISTS `tallyplayerpointsbydiv`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `tallyplayerpointsbydiv` AS select `player_leaguematch`.`Division_id` AS `Division_id`,`player_leaguematch`.`Player_id` AS `Player_id`,sum(`player_leaguematch`.`points`) AS `totalPoints`,sum(`player_leaguematch`.`noOfGamesWon`) AS `gamesWon`,`gamesCount`(1,1,`player_leaguematch`.`Division_id`,`player_leaguematch`.`Player_id`) AS `gamesCount`,`p`.`enterInNextSeason` AS `enterInNextSeason` from (`player_leaguematch` join `player` `p` on((`player_leaguematch`.`Player_id` = `p`.`Player_id`))) where ((`player_leaguematch`.`Season_id` = 1) and (`player_leaguematch`.`League_id` = 1)) group by `player_leaguematch`.`Division_id`,`player_leaguematch`.`Player_id` order by `player_leaguematch`.`Division_id`,`totalPoints` desc,`gamesWon` desc,`gamesCount` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-09-11  2:37:40
