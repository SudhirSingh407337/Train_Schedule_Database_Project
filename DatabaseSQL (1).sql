-- MySQL dump 10.13  Distrib 8.0.42, for macos15 (arm64)
--
-- Host: 127.0.0.1    Database: railwaydb
-- ------------------------------------------------------
-- Server version	9.3.0

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
-- Table structure for table `Customer`
--

DROP TABLE IF EXISTS `Customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Customer` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(20) NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customer`
--

LOCK TABLES `Customer` WRITE;
/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
INSERT INTO `Customer` VALUES (1,'John','Doe','john@example.com','johndoe','1234','customer'),(2,'Alice','Smith','alice@example.com','alicesmith','5678','customer'),(3,'Bob','Taylor','bob@example.com','bobtaylor','pass1234','customer');
/*!40000 ALTER TABLE `Customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Customer_Questions`
--

DROP TABLE IF EXISTS `Customer_Questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Customer_Questions` (
  `question_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `question_text` text NOT NULL,
  `question_date` datetime DEFAULT NULL,
  `reply_text` text,
  `reply_date` datetime DEFAULT NULL,
  PRIMARY KEY (`question_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `customer_questions_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `Customer` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customer_Questions`
--

LOCK TABLES `Customer_Questions` WRITE;
/*!40000 ALTER TABLE `Customer_Questions` DISABLE KEYS */;
INSERT INTO `Customer_Questions` VALUES (1,1,'This is a question.','2025-07-19 22:22:17','This is correct answer','2025-07-20 03:11:48'),(2,1,'This is question 2','2025-07-19 22:44:42','This is correct answer 2','2025-07-20 03:11:59'),(3,1,'This is question one','2025-07-20 09:03:20','This is answer one','2025-07-20 09:50:03'),(4,3,'This is question 3','2025-07-20 09:56:53','This is answer 3','2025-07-20 16:51:26'),(5,1,'This is a question I have','2025-07-20 16:46:19','This is the answer ','2025-07-20 16:51:39'),(6,1,'This is test 5','2025-07-20 17:21:02','This is answer 5','2025-07-20 17:21:20');
/*!40000 ALTER TABLE `Customer_Questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Employee`
--

DROP TABLE IF EXISTS `Employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Employee` (
  `employee_ssn` int NOT NULL,
  `last_name` varchar(50) NOT NULL DEFAULT '',
  `first_name` varchar(50) NOT NULL DEFAULT '',
  `username` varchar(50) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `role` varchar(20) DEFAULT 'rep',
  PRIMARY KEY (`employee_ssn`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employee`
--

LOCK TABLES `Employee` WRITE;
/*!40000 ALTER TABLE `Employee` DISABLE KEYS */;
INSERT INTO `Employee` VALUES (1001,'Smith','Jane','admin','admin123','admin'),(1002,'Brown','Robert','rep1','rep123','rep');
/*!40000 ALTER TABLE `Employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reservation`
--

DROP TABLE IF EXISTS `Reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Reservation` (
  `reservation_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL DEFAULT '0',
  `schedule_id` int NOT NULL DEFAULT '0',
  `origin_station_id` int NOT NULL DEFAULT '0',
  `destination_station_id` int NOT NULL DEFAULT '0',
  `reservation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `travel_date` date NOT NULL DEFAULT '2025-01-01',
  `total_fare` decimal(10,2) NOT NULL DEFAULT '0.00',
  `ticket_type` varchar(20) NOT NULL DEFAULT 'Standard',
  `passenger_type` varchar(20) NOT NULL DEFAULT 'Adult',
  `fare` decimal(10,2) NOT NULL DEFAULT '0.00',
  `trip_type` varchar(20) NOT NULL DEFAULT 'One-way',
  PRIMARY KEY (`reservation_id`),
  KEY `customer_id` (`customer_id`),
  KEY `schedule_id` (`schedule_id`),
  KEY `origin_station_id` (`origin_station_id`),
  KEY `destination_station_id` (`destination_station_id`),
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `Customer` (`customer_id`),
  CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`schedule_id`) REFERENCES `Train_Schedule` (`schedule_id`),
  CONSTRAINT `reservation_ibfk_3` FOREIGN KEY (`origin_station_id`) REFERENCES `Station` (`station_id`),
  CONSTRAINT `reservation_ibfk_4` FOREIGN KEY (`destination_station_id`) REFERENCES `Station` (`station_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100657 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reservation`
--

LOCK TABLES `Reservation` WRITE;
/*!40000 ALTER TABLE `Reservation` DISABLE KEYS */;
INSERT INTO `Reservation` VALUES (3714,3,211,3,5,'2025-07-20 10:19:27','2025-07-25',18.00,'Standard','Adult',0.00,'One Way'),(15227,3,888,2,3,'2025-07-20 10:40:57','2025-07-24',0.00,'Standard','Adult',0.00,'One Way'),(17125,3,888,2,3,'2025-07-20 11:02:09','2025-07-24',20.00,'Standard','Adult',0.00,'One Way'),(22397,3,1,1,2,'2025-07-20 10:20:31','2025-01-24',80.00,'Standard','Adult',0.00,'Round Trip'),(23823,1,303,2,4,'2025-07-20 16:45:31','2025-07-25',50.00,'Standard','Disabled',0.00,'Round Trip'),(25830,3,1,1,3,'2025-07-20 13:22:28','2025-01-24',30.00,'Standard','Disabled',0.00,'One Way'),(27571,3,1,1,2,'2025-07-20 11:15:22','2025-01-24',15.00,'Standard','Disabled',0.00,'One Way'),(27634,3,213,2,4,'2025-07-20 09:55:55','2025-07-25',22.50,'Standard','Adult',0.00,'One Way'),(31995,2,1,2,3,'2025-07-20 10:26:26','2025-01-24',20.00,'Standard','Disabled',0.00,'One Way'),(33271,2,204,6,3,'2025-07-20 10:03:22','2025-07-21',32.50,'Standard','Adult',0.00,'One Way'),(42276,3,888,2,3,'2025-07-20 10:57:23','2025-07-24',20.00,'Standard','Adult',0.00,'One Way'),(43491,3,211,3,5,'2025-07-20 10:12:41','2025-07-25',18.00,'Standard','Adult',0.00,'One Way'),(48863,3,303,2,4,'2025-07-20 13:25:36','2025-07-25',50.00,'Standard','Disabled',0.00,'Round Trip'),(51202,2,211,3,4,'2025-07-20 10:04:14','2025-07-25',36.00,'Standard','Adult',0.00,'Round Trip'),(57336,2,888,2,3,'2025-07-20 11:14:05','2025-07-24',20.00,'Standard','Adult',0.00,'One Way'),(76809,3,1,1,2,'2025-07-20 10:20:51','2025-01-24',20.00,'Standard','Disabled',0.00,'One Way'),(77476,1,1,1,3,'2025-07-20 17:26:15','2025-01-24',60.00,'Standard','Adult',0.00,'One Way'),(79225,2,1,2,3,'2025-07-20 10:29:32','2025-01-24',40.00,'Standard','Adult',0.00,'One Way'),(83130,2,888,2,3,'2025-07-20 10:49:45','2025-07-24',20.00,'Standard','Adult',0.00,'One Way'),(83223,3,212,1,3,'2025-07-20 09:56:35','2025-07-25',12.50,'Standard','Disabled',0.00,'One Way'),(97989,2,1,1,2,'2025-07-20 10:50:08','2025-01-24',30.00,'Standard','Disabled',0.00,'Round Trip'),(100022,1,888,0,0,'2025-07-20 11:00:27','2025-07-24',20.00,'Standard','Adult',0.00,'One Way'),(100656,3,303,2,4,'2025-07-20 13:25:02','2025-07-25',50.00,'Standard','Disabled',0.00,'Round Trip');
/*!40000 ALTER TABLE `Reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Schedule_Stop`
--

DROP TABLE IF EXISTS `Schedule_Stop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Schedule_Stop` (
  `stop_id` int NOT NULL,
  `schedule_id` int NOT NULL,
  `station_id` int NOT NULL,
  `stop_order` int NOT NULL DEFAULT '1',
  `arrival_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `departure_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`stop_id`),
  KEY `schedule_id` (`schedule_id`),
  KEY `station_id` (`station_id`),
  CONSTRAINT `schedule_stop_ibfk_1` FOREIGN KEY (`schedule_id`) REFERENCES `Train_Schedule` (`schedule_id`) ON DELETE CASCADE,
  CONSTRAINT `schedule_stop_ibfk_2` FOREIGN KEY (`station_id`) REFERENCES `Station` (`station_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Schedule_Stop`
--

LOCK TABLES `Schedule_Stop` WRITE;
/*!40000 ALTER TABLE `Schedule_Stop` DISABLE KEYS */;
INSERT INTO `Schedule_Stop` VALUES (1,1,1,1,'2025-01-24 03:48:00','2025-01-24 03:48:00'),(2,1,2,2,'2025-01-24 04:00:00','2025-01-24 04:01:00'),(3,1,3,3,'2025-01-24 04:10:00','2025-01-24 04:11:00'),(4,1,4,4,'2025-01-24 04:20:00','2025-01-24 04:21:00'),(5,1,5,5,'2025-01-24 04:30:00','2025-01-24 04:31:00'),(6,1,6,6,'2025-01-24 05:21:00','2025-01-24 05:21:00'),(301,201,1,1,'2025-07-20 08:00:00','2025-07-20 08:10:00'),(302,201,3,2,'2025-07-20 10:00:00','2025-07-20 10:10:00'),(303,201,4,3,'2025-07-20 12:00:00','2025-07-20 12:05:00'),(401,201,1,1,'2025-07-21 08:00:00','2025-07-21 08:05:00'),(402,201,2,2,'2025-07-21 08:45:00','2025-07-21 08:50:00'),(403,201,3,3,'2025-07-21 10:00:00','2025-07-21 10:05:00'),(404,202,2,1,'2025-07-21 09:00:00','2025-07-21 09:05:00'),(405,202,4,2,'2025-07-21 10:15:00','2025-07-21 10:20:00'),(406,203,3,1,'2025-07-21 10:00:00','2025-07-21 10:05:00'),(407,203,5,2,'2025-07-21 13:00:00','2025-07-21 13:05:00'),(1001,204,6,1,'2025-07-21 09:00:00','2025-07-21 09:05:00'),(1002,204,3,2,'2025-07-21 10:00:00','2025-07-21 10:05:00'),(1003,205,3,1,'2025-07-21 11:00:00','2025-07-21 11:05:00'),(1004,205,6,2,'2025-07-21 12:00:00','2025-07-21 12:05:00'),(1005,206,2,1,'2025-01-24 11:00:00','2025-01-24 11:05:00'),(1006,206,1,2,'2025-01-24 11:35:00','2025-01-24 11:40:00'),(1018,211,3,1,'2025-07-25 15:00:00','2025-07-25 15:05:00'),(1019,211,4,2,'2025-07-25 15:20:00','2025-07-25 15:25:00'),(1020,211,5,3,'2025-07-25 15:35:00','2025-07-25 15:40:00'),(1021,212,1,1,'2025-07-25 14:00:00','2025-07-25 14:05:00'),(1022,212,3,2,'2025-07-25 14:35:00','2025-07-25 14:40:00'),(1023,213,2,1,'2025-07-25 16:00:00','2025-07-25 16:05:00'),(1024,213,4,2,'2025-07-25 16:40:00','2025-07-25 16:45:00'),(2001,888,2,1,'2025-07-24 10:00:00','2025-07-24 10:05:00'),(2002,888,3,2,'2025-07-24 10:40:00','2025-07-24 10:45:00'),(9993,303,2,1,'2025-07-25 09:00:00','2025-07-25 09:05:00'),(9994,303,4,2,'2025-07-25 09:25:00','2025-07-25 09:30:00'),(9995,303,5,3,'2025-07-25 09:45:00','2025-07-25 09:50:00');
/*!40000 ALTER TABLE `Schedule_Stop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Station`
--

DROP TABLE IF EXISTS `Station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Station` (
  `station_id` int NOT NULL,
  `station_name` varchar(100) NOT NULL DEFAULT '',
  `city_name` varchar(50) NOT NULL DEFAULT '',
  `state` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`station_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Station`
--

LOCK TABLES `Station` WRITE;
/*!40000 ALTER TABLE `Station` DISABLE KEYS */;
INSERT INTO `Station` VALUES (1,'Trenton','Trenton','NJ'),(2,'Princeton','Princeton','NJ'),(3,'New Brunswick','New Brunswick','NJ'),(4,'Edison','Edison','NJ'),(5,'Metuchen','Metuchen','NJ'),(6,'Penn Station','New York','NY');
/*!40000 ALTER TABLE `Station` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Train`
--

DROP TABLE IF EXISTS `Train`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Train` (
  `train_id` char(4) NOT NULL,
  `train_name` varchar(50) NOT NULL DEFAULT '',
  `line_id` int NOT NULL DEFAULT '0',
  `capacity` int NOT NULL DEFAULT '100',
  PRIMARY KEY (`train_id`),
  KEY `fk_train_line` (`line_id`),
  CONSTRAINT `fk_train_line` FOREIGN KEY (`line_id`) REFERENCES `Transit_Line` (`line_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Train`
--

LOCK TABLES `Train` WRITE;
/*!40000 ALTER TABLE `Train` DISABLE KEYS */;
INSERT INTO `Train` VALUES ('3806','Train 3806',1,200),('999','',102,100),('T001','Falcon Express',0,100),('T002','Liberty Line',0,100),('T009','Temp Train',0,100),('T101','',101,100),('T105','Hudson Express',105,150),('T106','Raritan Local',106,150),('T107','Atlantic Star',107,150);
/*!40000 ALTER TABLE `Train` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Train_Schedule`
--

DROP TABLE IF EXISTS `Train_Schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Train_Schedule` (
  `schedule_id` int NOT NULL,
  `line_id` int NOT NULL DEFAULT '0',
  `train_id` char(4) NOT NULL DEFAULT '',
  `departure_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `arrival_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `travel_time_minutes` int NOT NULL DEFAULT '0',
  `fare` decimal(6,2) NOT NULL DEFAULT '0.00',
  `fare_per_minute` decimal(5,2) NOT NULL DEFAULT '0.50',
  `travel_time` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`schedule_id`),
  KEY `line_id` (`line_id`),
  KEY `train_id` (`train_id`),
  CONSTRAINT `train_schedule_ibfk_1` FOREIGN KEY (`line_id`) REFERENCES `Transit_Line` (`line_id`),
  CONSTRAINT `train_schedule_ibfk_2` FOREIGN KEY (`train_id`) REFERENCES `Train` (`train_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Train_Schedule`
--

LOCK TABLES `Train_Schedule` WRITE;
/*!40000 ALTER TABLE `Train_Schedule` DISABLE KEYS */;
INSERT INTO `Train_Schedule` VALUES (1,1,'3806','2025-01-24 08:00:00','2025-01-25 09:30:00',93,40.00,0.50,1530),(201,101,'T001','2025-07-21 08:00:00','2025-07-20 12:00:00',240,24.00,0.50,-1200),(202,102,'T002','2025-07-20 09:00:00','2025-07-20 10:30:00',90,12.00,0.50,90),(204,101,'T001','2025-07-21 09:00:00','2025-07-21 10:05:00',65,32.50,0.50,65),(205,101,'T002','2025-07-21 11:00:00','2025-07-21 12:05:00',65,32.50,0.50,65),(206,102,'T003','2025-01-24 11:00:00','2025-01-24 11:40:00',40,20.00,0.50,40),(211,103,'T008','2025-07-25 15:00:00','2025-07-25 15:40:00',40,18.00,0.45,40),(212,105,'T009','2025-07-25 14:00:00','2025-07-25 14:40:00',40,25.00,0.63,40),(213,106,'T106','2025-07-25 16:00:00','2025-07-25 16:45:00',45,22.50,0.50,45),(301,105,'T105','2025-07-21 08:00:00','2025-07-21 10:00:00',0,10.00,0.50,120),(303,105,'T101','2025-07-25 09:00:00','2025-07-25 10:00:00',0,20.00,0.50,60),(888,102,'999','2025-07-24 10:00:00','2025-07-24 10:45:00',0,15.00,0.50,45);
/*!40000 ALTER TABLE `Train_Schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Transit_Line`
--

DROP TABLE IF EXISTS `Transit_Line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Transit_Line` (
  `line_id` int NOT NULL,
  `line_name` varchar(100) NOT NULL,
  `base_fare` decimal(8,2) NOT NULL,
  `total_stops` int NOT NULL,
  `origin_station_id` int NOT NULL,
  `destination_station_id` int NOT NULL,
  PRIMARY KEY (`line_id`),
  UNIQUE KEY `line_name` (`line_name`),
  KEY `origin_station_id` (`origin_station_id`),
  KEY `destination_station_id` (`destination_station_id`),
  CONSTRAINT `transit_line_ibfk_1` FOREIGN KEY (`origin_station_id`) REFERENCES `Station` (`station_id`),
  CONSTRAINT `transit_line_ibfk_2` FOREIGN KEY (`destination_station_id`) REFERENCES `Station` (`station_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Transit_Line`
--

LOCK TABLES `Transit_Line` WRITE;
/*!40000 ALTER TABLE `Transit_Line` DISABLE KEYS */;
INSERT INTO `Transit_Line` VALUES (1,'Northeast Corridor',30.00,10,1,2),(101,'Northeast Express',50.00,4,1,4),(102,'Midtown Local',20.00,2,2,3),(105,'Hudson Line',25.00,6,1,3),(106,'Raritan Valley Line',22.50,5,2,4),(107,'Atlantic City Line',30.00,7,3,5);
/*!40000 ALTER TABLE `Transit_Line` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-20 18:06:46
