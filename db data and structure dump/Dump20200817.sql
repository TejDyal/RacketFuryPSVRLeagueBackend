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
INSERT INTO `league_season` VALUES (1,1,'2020-08-11','2020-08-24'),(1,2,'2020-08-11','2020-08-24'),(2,1,'2020-08-27','2020-09-09'),(2,2,'2020-08-27','2020-09-09');
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
  `standard` varchar(45) NOT NULL,
  `Server_Server_id` int NOT NULL,
  PRIMARY KEY (`Player_id`),
  UNIQUE KEY `PSN_id_UNIQUE` (`PSN_id`),
  UNIQUE KEY `Email_UNIQUE` (`Email`),
  KEY `fk_Player_Server_idx` (`Server_Server_id`),
  CONSTRAINT `fk_Player_Server` FOREIGN KEY (`Server_Server_id`) REFERENCES `server` (`Server_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player`
--

LOCK TABLES `player` WRITE;
/*!40000 ALTER TABLE `player` DISABLE KEYS */;
INSERT INTO `player` VALUES (1,'anne',NULL,NULL,0,1,'Good',1),(2,'ben',NULL,NULL,0,0,'',1),(3,'cathy',NULL,NULL,1,1,'Good',1),(4,'david',NULL,NULL,1,1,'Good',1),(5,'ellie',NULL,NULL,1,1,'Good',1),(6,'fred',NULL,NULL,1,1,'Good',1),(7,'george',NULL,NULL,1,1,'Good',1),(8,'harry',NULL,NULL,1,1,'Beginner',1),(9,'ian',NULL,NULL,1,1,'Medium',1),(10,'jacob',NULL,NULL,1,1,'Medium',1),(11,'kerry',NULL,NULL,1,0,'Beginner',1),(12,'larry',NULL,NULL,1,1,'Medium',1),(13,'manny',NULL,NULL,1,1,'Beginner',1),(14,'noel',NULL,NULL,0,1,'Beginner',2),(15,'olaf',NULL,NULL,1,1,'Beginner',2),(16,'peter',NULL,NULL,1,1,'Good',2);
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-08-17 12:27:29
