CREATE DATABASE  IF NOT EXISTS `project_jyothikaj_nittalad` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `project_jyothikaj_nittalad`;
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: project_jyothikaj_nittalad
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `child_class_enrollment`
--

DROP TABLE IF EXISTS `child_class_enrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `child_class_enrollment` (
  `class_id` int DEFAULT NULL,
  `student_id` int DEFAULT NULL,
  `year` year DEFAULT NULL,
  KEY `class_enrolled` (`class_id`),
  KEY `child_enrolled` (`student_id`),
  CONSTRAINT `child_enrolled` FOREIGN KEY (`student_id`) REFERENCES `children` (`student_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `class_enrolled` FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `child_class_enrollment`
--

LOCK TABLES `child_class_enrollment` WRITE;
/*!40000 ALTER TABLE `child_class_enrollment` DISABLE KEYS */;
INSERT INTO `child_class_enrollment` VALUES (10,11,2023);
/*!40000 ALTER TABLE `child_class_enrollment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `children`
--

DROP TABLE IF EXISTS `children`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `children` (
  `student_id` int NOT NULL,
  `name` varchar(30) NOT NULL,
  `sex` enum('M','F','Undisclosed') DEFAULT NULL,
  `age` int NOT NULL,
  `shelter_home` varchar(50) NOT NULL,
  `grade` enum('1','2','3','4','5','6','7','8','9','10','11','12') DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  KEY `child_shelter` (`shelter_home`),
  CONSTRAINT `child_shelter` FOREIGN KEY (`shelter_home`) REFERENCES `shelter_home` (`shelter_name`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `children`
--

LOCK TABLES `children` WRITE;
/*!40000 ALTER TABLE `children` DISABLE KEYS */;
INSERT INTO `children` VALUES (11,'John Doe','M',13,'Angels Group Home','8');
/*!40000 ALTER TABLE `children` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `city` (
  `city_name` varchar(25) NOT NULL,
  PRIMARY KEY (`city_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` VALUES ('Atlanta'),('Austin'),('Boston'),('Detroit'),('New York');
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class`
--

DROP TABLE IF EXISTS `class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `class` (
  `class_id` int NOT NULL AUTO_INCREMENT,
  `subject` varchar(20) NOT NULL,
  `class_schedule` datetime NOT NULL,
  `grade_level` enum('1','2','3','4','5','6','7','8','9','10','11','12') DEFAULT NULL,
  `teacher_id` varchar(10) NOT NULL,
  `shelter_home` varchar(50) NOT NULL,
  PRIMARY KEY (`class_id`),
  KEY `class_shelter` (`shelter_home`),
  KEY `class_teacher` (`teacher_id`),
  CONSTRAINT `class_shelter` FOREIGN KEY (`shelter_home`) REFERENCES `shelter_home` (`shelter_name`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `class_teacher` FOREIGN KEY (`teacher_id`) REFERENCES `volunteer` (`staff_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class`
--

LOCK TABLES `class` WRITE;
/*!40000 ALTER TABLE `class` DISABLE KEYS */;
INSERT INTO `class` VALUES (10,'Chemistry','2023-04-24 12:00:00','8','VL100','Angels Group Home');
/*!40000 ALTER TABLE `class` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `child_after_insert_class` AFTER INSERT ON `class` FOR EACH ROW BEGIN
    
    INSERT INTO child_class_enrollment 
    SELECT  new.class_id,  ch.student_id, year(curdate()) 
    FROM children AS ch
    WHERE ch.shelter_home = new.shelter_home AND ch.grade = new.grade_level;
    
    
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `class_before_delete_children_enrolled` BEFORE DELETE ON `class` FOR EACH ROW BEGIN
	DECLARE num_enrolled INT;
    SELECT COUNT(*) INTO num_enrolled FROM child_class_enrollment WHERE class_id = old.class_id;
	IF (num_enrolled != 0)
    THEN 
		DELETE FROM child_class_enrollment WHERE class_id = old.class_id;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `dept_name` varchar(30) NOT NULL,
  PRIMARY KEY (`dept_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES ('Campaigns'),('Finance'),('Fundraising'),('HR'),('Teaching');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donation`
--

DROP TABLE IF EXISTS `donation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donation` (
  `receipt_no` int NOT NULL,
  `amount` int NOT NULL,
  `date_of_payment` date NOT NULL,
  `donation_type` enum('One time','Monthly','Yearly') NOT NULL,
  `donor_id` int NOT NULL,
  PRIMARY KEY (`receipt_no`),
  KEY `donor_donation` (`donor_id`),
  CONSTRAINT `donor_donation` FOREIGN KEY (`donor_id`) REFERENCES `donor` (`donor_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donation`
--

LOCK TABLES `donation` WRITE;
/*!40000 ALTER TABLE `donation` DISABLE KEYS */;
INSERT INTO `donation` VALUES (1234,50,'2023-04-21','Monthly',1),(2123,445,'2023-04-21','Yearly',3),(3456,23,'2023-04-21','Monthly',8),(13111,100,'2023-04-20','One time',1),(34567,500,'2023-04-21','One time',3);
/*!40000 ALTER TABLE `donation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donor`
--

DROP TABLE IF EXISTS `donor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donor` (
  `donor_id` int NOT NULL AUTO_INCREMENT,
  `donor_name` varchar(25) NOT NULL,
  `phone_no` varchar(10) NOT NULL,
  `email_address` varchar(30) NOT NULL,
  `referred_by` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`donor_id`),
  UNIQUE KEY `email_address` (`email_address`),
  KEY `referring_volunteer` (`referred_by`),
  CONSTRAINT `referring_volunteer` FOREIGN KEY (`referred_by`) REFERENCES `volunteer` (`staff_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donor`
--

LOCK TABLES `donor` WRITE;
/*!40000 ALTER TABLE `donor` DISABLE KEYS */;
INSERT INTO `donor` VALUES (1,'Jack Maisel','2912111293','maiselmaisel@gmail.com','VL102'),(3,'Rupa','647364767','rupa@gmail.com','VL100'),(5,'Adams','2382163','adams.k@gmail.com','V121'),(7,'Priyanka','38378738','priyanka@ose.edu','V121'),(8,'Shivani','28382333','shivani@gmail.com','V121');
/*!40000 ALTER TABLE `donor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `full_time_employee`
--

DROP TABLE IF EXISTS `full_time_employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `full_time_employee` (
  `staff_id` varchar(10) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `age` int NOT NULL,
  `date_of_joining` datetime DEFAULT NULL,
  `contact_no` varchar(10) NOT NULL,
  `email_address` varchar(35) NOT NULL,
  `username` varchar(35) NOT NULL,
  `login_password` varchar(30) NOT NULL,
  `department_name` varchar(30) NOT NULL,
  `city` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`staff_id`),
  UNIQUE KEY `contact_no` (`contact_no`),
  UNIQUE KEY `email_address` (`email_address`),
  UNIQUE KEY `username` (`username`),
  KEY `employee_dept` (`department_name`),
  CONSTRAINT `employee_dept` FOREIGN KEY (`department_name`) REFERENCES `department` (`dept_name`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `age_check` CHECK ((`age` >= 18))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `full_time_employee`
--

LOCK TABLES `full_time_employee` WRITE;
/*!40000 ALTER TABLE `full_time_employee` DISABLE KEYS */;
INSERT INTO `full_time_employee` VALUES ('AD111','Max','Davids',24,'2023-04-20 00:00:00','3222923421','max1999@gmail.com','mdavid','pass1','Campaigns','Austin'),('AD121','Anushka','Patel',25,'2023-04-20 00:00:00','3341114432','apatel@gmail.com','apatel','password','Teaching','Boston'),('AD133','Gertrude','Peters',19,'2023-04-20 00:00:00','2322222432','gertie@gmail.com','gpeters','pass1','Teaching','New York');
/*!40000 ALTER TABLE `full_time_employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_report`
--

DROP TABLE IF EXISTS `issue_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issue_report` (
  `report_id` int NOT NULL AUTO_INCREMENT,
  `report_desc` text,
  `status` enum('Under investigation','Closed') NOT NULL,
  `date_of_reporting` datetime NOT NULL,
  `reported_by` varchar(10) NOT NULL,
  `assigned_to` varchar(10) NOT NULL,
  `child_id` int NOT NULL,
  `date_of_resolution` datetime DEFAULT NULL,
  PRIMARY KEY (`report_id`),
  KEY `reporting_volunteer` (`reported_by`),
  KEY `resolving_employee` (`assigned_to`),
  KEY `child_issue` (`child_id`),
  CONSTRAINT `child_issue` FOREIGN KEY (`child_id`) REFERENCES `children` (`student_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `reporting_volunteer` FOREIGN KEY (`reported_by`) REFERENCES `volunteer` (`staff_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `resolving_employee` FOREIGN KEY (`assigned_to`) REFERENCES `full_time_employee` (`staff_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_report`
--

LOCK TABLES `issue_report` WRITE;
/*!40000 ALTER TABLE `issue_report` DISABLE KEYS */;
INSERT INTO `issue_report` VALUES (1,'Child is easily distracted','Closed','2023-04-20 00:00:00','VL100','AD121',11,NULL),(10,'Having trouble concentrating','Under investigation','2023-04-21 00:00:00','V121','AD121',11,NULL),(11,'low grades','Closed','2023-04-21 00:00:00','VL102','AD121',11,NULL),(13,'Problem with teaching methods','Closed','2023-04-21 00:00:00','V121','AD121',11,NULL),(15,'low attendance','Closed','2023-04-21 00:00:00','VL100','AD121',11,NULL),(16,'Notes availability','Closed','2023-04-21 00:00:00','VL102','AD121',11,NULL),(17,'Notes availability','Under investigation','2023-04-21 00:00:00','VL102','AD121',11,NULL),(18,'Conceptual','Under investigation','2023-04-21 00:00:00','VL100','AD121',11,NULL),(19,'Differentiating concepts problem','Closed','2023-04-21 00:00:00','VL100','AD121',11,NULL),(20,'sfndjksaf','Under investigation','2023-04-21 00:00:00','VL100','AD121',11,NULL),(21,'Lack of supplies','Under investigation','2023-04-21 00:00:00','VL100','AD121',11,NULL),(22,'lack of emotional support','Under investigation','2023-04-21 00:00:00','V123','AD121',11,NULL),(24,'Having mental health issues','Under investigation','2023-04-21 00:00:00','VL100','AD121',11,NULL);
/*!40000 ALTER TABLE `issue_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shelter_home`
--

DROP TABLE IF EXISTS `shelter_home`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shelter_home` (
  `shelter_name` varchar(50) NOT NULL,
  `address` varchar(100) DEFAULT NULL,
  `contact_no` varchar(10) NOT NULL,
  `representative_name` varchar(30) NOT NULL,
  `city` varchar(25) NOT NULL,
  PRIMARY KEY (`shelter_name`),
  UNIQUE KEY `representative_name` (`representative_name`),
  UNIQUE KEY `address` (`address`),
  KEY `shelter_city` (`city`),
  CONSTRAINT `shelter_city` FOREIGN KEY (`city`) REFERENCES `city` (`city_name`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shelter_home`
--

LOCK TABLES `shelter_home` WRITE;
/*!40000 ALTER TABLE `shelter_home` DISABLE KEYS */;
INSERT INTO `shelter_home` VALUES ('Angels Group Home','Test Street','8001231234','Johanna John','Boston'),('Children\'s Home','Jackson Street','8001223424','Timothy Dalton','Boston'),('Jane Mary Home','Mars Street','8571444234','Mary Doe','Atlanta'),('Little Hearts','Umbrella Lane','1201239934','Mary Poppins','New York'),('Teresa Home for Children','West Village','2111231234','Johanna Marks','Austin'),('Young Soul Home','Bloom Lane','5343431234','John Doe','Detroit');
/*!40000 ALTER TABLE `shelter_home` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volunteer`
--

DROP TABLE IF EXISTS `volunteer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `volunteer` (
  `staff_id` varchar(10) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `age` int NOT NULL,
  `date_of_joining` datetime DEFAULT NULL,
  `contact_no` varchar(10) NOT NULL,
  `email_address` varchar(35) NOT NULL,
  `username` varchar(35) NOT NULL,
  `login_password` varchar(30) NOT NULL,
  `department_name` varchar(30) NOT NULL,
  `city` varchar(25) NOT NULL,
  `shelter_home` varchar(50) NOT NULL,
  PRIMARY KEY (`staff_id`),
  UNIQUE KEY `contact_no` (`contact_no`),
  UNIQUE KEY `email_address` (`email_address`),
  UNIQUE KEY `username` (`username`),
  KEY `volunteer_shelter` (`shelter_home`),
  KEY `volunteer_city` (`city`),
  KEY `volunteer_dept` (`department_name`),
  CONSTRAINT `volunteer_city` FOREIGN KEY (`city`) REFERENCES `city` (`city_name`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `volunteer_dept` FOREIGN KEY (`department_name`) REFERENCES `department` (`dept_name`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `volunteer_shelter` FOREIGN KEY (`shelter_home`) REFERENCES `shelter_home` (`shelter_name`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `age_check_volunteer` CHECK ((`age` >= 18))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volunteer`
--

LOCK TABLES `volunteer` WRITE;
/*!40000 ALTER TABLE `volunteer` DISABLE KEYS */;
INSERT INTO `volunteer` VALUES ('V121','Jyothika','Jalla',21,'2023-04-21 00:00:00','76378682','katy@gmail.com','jalla.j','password@100','HR','New York','Little Hearts'),('V123','Mike','Ross',30,'2023-04-21 00:00:00','343423224','mike.r@gmail.com','mike.r','password','Finance','Detroit','Jane Mary Home'),('V2348','jamie','anderson',34,'2023-04-21 00:00:00','247862628','jam@gmail.com','jamie.j','jamie','Fundraising','New York','Children\'s Home'),('V2367','Mathew','Kai',20,'2023-04-21 00:00:00','3829384939','mathew.k@gmail.com','mathew.k','mathew','Finance','Detroit','Little Hearts'),('V456','harry','james',23,'2023-04-21 00:00:00','2467267467','hello@gmail.com','harry.j','pass2','Finance','Atlanta','Jane Mary Home'),('VL100','Sakshi','Mehta',28,'2023-04-20 00:00:00','1111111111','skmehta1@gmail.com','smehta','pass1','Teaching','Boston','Angels Group Home'),('VL102','Jane','Ross',22,'2023-04-20 00:00:00','2132223312','jross@yahoo.in','jross','pass1','Teaching','Boston','Angels Group Home');
/*!40000 ALTER TABLE `volunteer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'project_jyothikaj_nittalad'
--

--
-- Dumping routines for database 'project_jyothikaj_nittalad'
--
/*!50003 DROP FUNCTION IF EXISTS `get_emp_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_emp_id`(
					username VARCHAR(30),
                    type VARCHAR(20)
				) RETURNS varchar(10) CHARSET utf8mb4
    READS SQL DATA
    DETERMINISTIC
BEGIN
	DECLARE emp_id VARCHAR(10);
    
	IF(type='volunteer') THEN
		SELECT staff_id INTO emp_id FROM volunteer WHERE username = username;
	ELSE 
		SELECT staff_id INTO emp_id FROM full_time_employee WHERE username = username;
	END IF;
RETURN emp_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `is_admin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `is_admin`(
					emp_id VARCHAR(10)
                ) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
	DECLARE num_admin INT;
	SELECT COUNT(*) INTO num_admin FROM full_time_employee WHERE staff_id = emp_id;
	IF(num_admin =1) THEN
        RETURN 1;
	END IF;
	RETURN 0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `is_volunteer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `is_volunteer`(
					emp_id VARCHAR(10)
                ) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
	DECLARE num_volunteer INT;
	SELECT COUNT(*) INTO num_volunteer FROM volunteer WHERE staff_id = emp_id;
	IF(num_volunteer =1) THEN
        RETURN 1;
	END IF;
	RETURN 0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_classes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_classes`(
					subject VARCHAR(20),
                    class_date DATE,
                    class_time TIME,
                    grade_level enum('1','2','3','4','5','6','7','8','9','10','11','12'),
                    teacher_id VARCHAR(10),
                    shelter VARCHAR(50)
				)
BEGIN
	DECLARE class_datetime DATETIME;
    DECLARE volunteer_city VARCHAR(25);
    DECLARE shelter_city VARCHAR(25);    
    
    SELECT TIMESTAMP(class_date,class_time) INTO class_datetime;
    
    SELECT city INTO volunteer_city FROM volunteer WHERE staff_id = teacher_id;
    
    SELECT city INTO shelter_city FROM shelter_home WHERE shelter_name = shelter;
    
    IF(volunteer_city != shelter_city) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT  = 'Given volunteer does not live in the same city as shelter home city.';
    END IF;
    
    INSERT INTO class(subject,class_schedule,grade_level,teacher_id,shelter_home) VALUES(subject, class_datetime, grade_level, teacher_id, shelter); 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_donation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_donation`(
					receipt INT,
                    amount INT,
                    type enum('One time','Monthly','Yearly'),
                    donor_id INT
				)
BEGIN
	DECLARE num_donation INT;
    SELECT COUNT(*) INTO num_donation FROM donation WHERE receipt_no = receipt;
    
    IF(num_donation != 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT  = 'Given donation already exists.';
	END IF;
    
	INSERT INTO donation VALUES(receipt, amount, curdate(), type, donor_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_donor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_donor`(donor_name VARCHAR(25),
                    phone_no VARCHAR(25),
                    email_address VARCHAR(30),
                    emp_id VARCHAR(10))
BEGIN
INSERT INTO donor(donor_name, phone_no, email_address, referred_by) VALUES(donor_name, phone_no, email_address, emp_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_fulltime_employee` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_fulltime_employee`(IN id VARCHAR(10),
				IN fname VARCHAR(10),
                IN lname VARCHAR(10),
                IN age INT,
                IN contact_no VARCHAR(10),
                IN email_address VARCHAR(35),
                IN username VARCHAR(35),
                IN pwd VARCHAR(30),
                IN dept VARCHAR(30),
                IN city VARCHAR(25))
BEGIN
					DECLARE curr_date DATETIME;
                    DECLARE num_dept INT;
                    
                    SELECT COUNT(*) INTO num_dept FROM department AS d WHERE d.dept_name = dept;
                    
                    IF(num_dept = 0) THEN
						SIGNAL SQLSTATE '45000'
						SET MESSAGE_TEXT  = 'Given department name is invalid';
					END IF;
                    
                    SELECT curdate() INTO curr_date;
					INSERT INTO full_time_employee VALUES (id,fname,lname,age,curr_date,contact_no,email_address,username,pwd,dept,city);
                END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_volunteer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_volunteer`(IN id VARCHAR(10),
				IN fname VARCHAR(10),
                IN lname VARCHAR(10),
                IN age INT,
                IN contact_no VARCHAR(10),
                IN email_address VARCHAR(35),
                IN username VARCHAR(35),
                IN pwd VARCHAR(30),
                IN dept VARCHAR(30),
                IN city_add VARCHAR(25),
                IN shelter VARCHAR(50))
BEGIN
					DECLARE curr_date DATETIME;
                    DECLARE num_city INT;
                    DECLARE num_shelter INT;
                    DECLARE num_user INT;
                    
                    SELECT COUNT(*) INTO num_city FROM city AS c WHERE c.city_name = city_add;
                    SELECT COUNT(*) INTO num_shelter FROM shelter_home AS s WHERE s.shelter_name = shelter;
                    SELECT COUNT(*) INTO num_user FROM volunteer AS v WHERE v.username = username;
                    
                    IF(num_city = 0) THEN
						SIGNAL SQLSTATE '45000'
						SET MESSAGE_TEXT  = 'Given city is not valid.';
					END IF;
                    
                    IF(num_shelter = 0) THEN
						SIGNAL SQLSTATE '45000'
						SET MESSAGE_TEXT  = 'Given shelter is not valid.';
					END IF;
                    
                    IF(num_user != 0) THEN
						SIGNAL SQLSTATE '45000'
						SET MESSAGE_TEXT  = 'Given username already exists.';
					END IF;
                    
                    SELECT curdate() INTO curr_date;
					INSERT INTO volunteer VALUES (id,fname,lname,age,curr_date,contact_no,email_address,username,pwd,dept,city_add,shelter);
                END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_assigned` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_assigned`(
				emp_id VARCHAR(10)
            )
BEGIN
     SELECT report_id, report_desc, date_of_reporting, c.name, status 
     FROM issue_report JOIN children AS c ON child_id = c.student_id
     WHERE assigned_to = emp_id; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_classes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_classes`()
BEGIN
     SELECT class_id,subject, class_schedule, grade_level, shelter_home 
     FROM class; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_classes_city` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_classes_city`(
				city_name VARCHAR(25)
            )
BEGIN
     SELECT subject, DATE(class_schedule), TIME(class_schedule), grade_level, c.shelter_home, CONCAT(first_name,' ', last_name) AS teacher_name 
     FROM class AS c JOIN shelter_home AS s ON c.shelter_home = s.shelter_name JOIN volunteer AS v ON teacher_id = v.staff_id 
     WHERE v.city = s.city AND v.city = city_name; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_donations` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_donations`()
BEGIN
     SELECT donor_id, donor_name, amount, donation_type,phone_no, email_address, date_of_payment, referred_by 
     FROM donor NATURAL JOIN donation;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_fte_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_fte_details`()
BEGIN
select * from full_time_employee;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_reported` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_reported`()
BEGIN
     SELECT report_id, report_desc, date_of_reporting, status,reported_by 
     FROM issue_report; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_shelterhome_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_shelterhome_details`()
BEGIN
select * from shelter_home;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_volunteer_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_volunteer_details`()
BEGIN
     SELECT * FROM volunteer; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `remove_class` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_class`(
					class INT
                )
BEGIN
	DELETE FROM class WHERE class_id = class;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `remove_volunteer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_volunteer`(
					staff VARCHAR(10)
				)
BEGIN
	DECLARE open_issues INT;
    
    SELECT COUNT(*) INTO open_issues FROM issue_report WHERE reported_by = staff AND status = 'Under Investigation';
    
    
    IF(open_issues = 0) THEN
		DELETE FROM class WHERE teacher_id = staff;
		DELETE FROM issue_report WHERE reported_by = staff;
		DELETE FROM volunteer WHERE staff_id = staff;
	ELSE 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT  = 'Given volunteer still has open reported issues.';
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `report_issue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `report_issue`(
				IN description text,
                IN reported_by VARCHAR(10),
                IN child_id INT
            )
BEGIN
	DECLARE num_reported VARCHAR(10);
    DECLARE num_assigned VARCHAR(10);
    DECLARE num_child INT;
    DECLARE assigned_to VARCHAR(10);
    
	SELECT COUNT(*) INTO num_reported FROM volunteer AS v WHERE v.staff_id = reported_by;
	SELECT COUNT(*) INTO num_child FROM children AS c WHERE c.student_id = child_id;
	
    SELECT f.staff_id INTO assigned_to FROM full_time_employee AS f, volunteer AS v 
    WHERE f.department_name = v.department_name AND f.city = v.city
    LIMIT 1;
    
    
	IF(num_reported = 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT  = 'Given volunteer id is not valid.';
	END IF;
	
	IF(num_child = 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT  = 'Given student id is not valid.';
	END IF;
    
    
	INSERT INTO issue_report(report_desc,status,date_of_reporting,reported_by,assigned_to, child_id) 
    VALUES(description, 'Under Investigation', curdate(), reported_by, assigned_to, child_id);
    
    SELECT report_id FROM issue_report
    ORDER BY report_id DESC
    LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_class_teacher` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_class_teacher`(
					class INT,
                    new_teacher VARCHAR(10)
				)
BEGIN
	UPDATE class SET teacher_id = new_teacher WHERE class_id = class;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_report_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_report_status`(
					IN report INT)
BEGIN
	DECLARE num_report INT;
	SELECT COUNT(*) INTO num_report FROM issue_report WHERE report_id = report;

	IF(num_report = 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT  = 'Given report id is not valid.';
	END IF;
	UPDATE issue_report SET status = 'Closed' WHERE report_id = report;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_volunteer_city` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_volunteer_city`(
					staff VARCHAR(10),
                    city VARCHAR(25)
                )
BEGIN
	UPDATE volunteer SET city = city WHERE staff_id = staff;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_volunteer_contact` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_volunteer_contact`(
					staff VARCHAR(10),
					contact_no VARCHAR(10)
                )
BEGIN
	UPDATE volunteer SET contact_no = contact_no WHERE staff_id = staff;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_volunteer_email` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_volunteer_email`(
					staff VARCHAR(10),
                    email_address VARCHAR(35)
                )
BEGIN
	UPDATE volunteer SET email_address = email_address WHERE staff_id = staff;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_volunteer_shelter` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_volunteer_shelter`(
					staff VARCHAR(10),
                    shelter VARCHAR(50)
                )
BEGIN
	UPDATE volunteer SET shelter_home = shelter WHERE staff_id = staff;
END ;;
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

-- Dump completed on 2023-04-21 21:52:09
