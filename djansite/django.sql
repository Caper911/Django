-- MySQL dump 10.13  Distrib 5.7.21, for Linux (x86_64)
--
-- Host: localhost    Database: django
-- ------------------------------------------------------
-- Server version	5.7.21-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (1,'管理员组');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,13),(5,1,14),(6,1,15),(7,1,16),(8,1,17),(9,1,18),(10,1,19),(11,1,20),(12,1,21),(13,1,22),(14,1,23),(15,1,24),(16,1,25),(17,1,26),(18,1,27),(19,1,28),(20,1,29),(21,1,30),(22,1,31),(23,1,32),(24,1,33),(25,1,34),(26,1,35),(27,1,36),(28,1,37),(29,1,38),(30,1,39),(31,1,40),(32,1,41),(33,1,42),(34,1,43),(35,1,44),(36,1,45),(37,1,46),(38,1,47),(39,1,48),(40,1,49),(41,1,50),(42,1,51),(43,1,52),(44,1,53),(45,1,54);
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add Token',7,'add_token'),(20,'Can change Token',7,'change_token'),(21,'Can delete Token',7,'delete_token'),(22,'Can add cpu info',8,'add_cpuinfo'),(23,'Can change cpu info',8,'change_cpuinfo'),(24,'Can delete cpu info',8,'delete_cpuinfo'),(25,'Can add factory',9,'add_factory'),(26,'Can change factory',9,'change_factory'),(27,'Can delete factory',9,'delete_factory'),(28,'Can add io info',10,'add_ioinfo'),(29,'Can change io info',10,'change_ioinfo'),(30,'Can delete io info',10,'delete_ioinfo'),(31,'Can add machine',11,'add_machine'),(32,'Can change machine',11,'change_machine'),(33,'Can delete machine',11,'delete_machine'),(34,'Can add memory info',12,'add_memoryinfo'),(35,'Can change memory info',12,'change_memoryinfo'),(36,'Can delete memory info',12,'delete_memoryinfo'),(37,'Can add op start enddate',13,'add_opstartenddate'),(38,'Can change op start enddate',13,'change_opstartenddate'),(39,'Can delete op start enddate',13,'delete_opstartenddate'),(40,'Can add product depart',14,'add_productdepart'),(41,'Can change product depart',14,'change_productdepart'),(42,'Can delete product depart',14,'delete_productdepart'),(43,'Can add profile',15,'add_profile'),(44,'Can change profile',15,'change_profile'),(45,'Can delete profile',15,'delete_profile'),(46,'Can add sensor info',16,'add_sensorinfo'),(47,'Can change sensor info',16,'change_sensorinfo'),(48,'Can delete sensor info',16,'delete_sensorinfo'),(49,'Can add sensor raw data',17,'add_sensorrawdata'),(50,'Can change sensor raw data',17,'change_sensorrawdata'),(51,'Can delete sensor raw data',17,'delete_sensorrawdata'),(52,'Can add sensor wavelet data',18,'add_sensorwaveletdata'),(53,'Can change sensor wavelet data',18,'change_sensorwaveletdata'),(54,'Can delete sensor wavelet data',18,'delete_sensorwaveletdata'),(55,'Can add 铣床运行时间段',19,'add_machineruntime'),(56,'Can change 铣床运行时间段',19,'change_machineruntime'),(57,'Can delete 铣床运行时间段',19,'delete_machineruntime');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$36000$ehF3IpS7oRXj$KWmQHwrSrADTxOvL6lKPt3GAvlMsdQrN+mqPCSCNAIQ=','2018-04-12 08:58:42.492457',1,'caper911','廖建锋','','Caper911@outlook.com',1,1,'2018-04-09 01:58:00.000000'),(2,'pbkdf2_sha256$36000$iTO2jtdA53Ud$Xsli1nRqGBtn0hjDLxpCTp7f2KMDmrLs/9g5Utl7B6k=','2018-04-10 07:01:37.101411',0,'caper9111','廖测试','','caper911@outlook.comm',0,1,'2018-04-10 01:29:05.208167');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authtoken_token`
--

DROP TABLE IF EXISTS `authtoken_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authtoken_token`
--

LOCK TABLES `authtoken_token` WRITE;
/*!40000 ALTER TABLE `authtoken_token` DISABLE KEYS */;
INSERT INTO `authtoken_token` VALUES ('0565beb1ea8f71a1a779573e13ae1459197db4bd','2018-04-10 01:29:05.249730',2),('aaeb6416b51c4c91303c6b82dfef316076519583','2018-04-09 01:58:01.143752',1);
/*!40000 ALTER TABLE `authtoken_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bearing_cpuinfo`
--

DROP TABLE IF EXISTS `bearing_cpuinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bearing_cpuinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` double NOT NULL,
  `time` datetime(6) NOT NULL,
  `machine_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bearing_cpuinfo_machine_id_83e8671c_fk_bearing_machine_machineID` (`machine_id`),
  CONSTRAINT `bearing_cpuinfo_machine_id_83e8671c_fk_bearing_machine_machineID` FOREIGN KEY (`machine_id`) REFERENCES `bearing_machine` (`machineID`)
) ENGINE=InnoDB AUTO_INCREMENT=452 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bearing_cpuinfo`
--

LOCK TABLES `bearing_cpuinfo` WRITE;
/*!40000 ALTER TABLE `bearing_cpuinfo` DISABLE KEYS */;
INSERT INTO `bearing_cpuinfo` VALUES (1,0,'2018-04-11 00:18:33.544729',NULL),(2,0.5,'2018-04-11 00:18:34.613345',NULL),(3,0.5,'2018-04-11 00:18:35.670547',NULL),(4,0.5,'2018-04-11 00:18:36.716073',NULL),(5,0.5,'2018-04-11 00:18:37.756649',NULL),(6,0.5,'2018-04-11 00:18:38.826318',NULL),(7,0.7,'2018-04-11 00:18:39.897963',NULL),(8,0.7,'2018-04-11 00:18:40.971647',NULL),(9,0.5,'2018-04-11 00:18:42.028142',NULL),(10,0.9,'2018-04-11 00:18:43.073742',NULL),(11,0.5,'2018-04-11 00:18:44.113261',NULL),(12,0.7,'2018-04-11 00:18:45.166631',NULL),(13,0.7,'2018-04-11 00:18:46.222886',NULL),(14,0.5,'2018-04-11 00:18:47.294623',NULL),(15,0.7,'2018-04-11 00:18:48.348371',NULL),(16,0.7,'2018-04-11 00:18:49.410053',NULL),(17,0.7,'2018-04-11 00:18:50.478101',NULL),(18,7.2,'2018-04-11 00:18:51.546570',NULL),(19,0.5,'2018-04-11 00:18:52.599026',NULL),(20,0.7,'2018-04-11 00:18:53.650741',NULL),(21,0.7,'2018-04-11 00:18:54.724805',NULL),(22,0.7,'2018-04-11 00:18:55.772680',NULL),(23,0.5,'2018-04-11 00:18:56.839950',NULL),(24,0.7,'2018-04-11 00:18:58.950289',NULL),(25,0.2,'2018-04-11 00:18:59.990733',NULL),(26,1,'2018-04-11 00:19:01.078158',NULL),(27,0.5,'2018-04-11 00:19:02.123682',NULL),(28,0.7,'2018-04-11 00:19:03.177462',NULL),(29,0.5,'2018-04-11 00:19:04.219386',NULL),(30,0.7,'2018-04-11 00:19:05.272507',NULL),(31,0.7,'2018-04-11 00:19:06.322884',NULL),(32,0.7,'2018-04-11 00:19:07.370823',NULL),(33,0.5,'2018-04-11 00:19:08.415598',NULL),(34,0.5,'2018-04-11 00:19:09.480620',NULL),(35,1,'2018-04-11 00:19:10.536461',NULL),(36,0.5,'2018-04-11 00:19:11.587939',NULL),(37,0.7,'2018-04-11 00:19:12.657012',NULL),(38,0.5,'2018-04-11 00:19:13.716946',NULL),(39,0.5,'2018-04-11 00:19:14.759294',NULL),(40,1,'2018-04-11 00:19:15.844177',NULL),(41,0.5,'2018-04-11 00:19:16.923119',NULL),(42,0.5,'2018-04-11 00:19:17.990038',NULL),(43,0.7,'2018-04-11 00:19:19.042379',NULL),(44,0.5,'2018-04-11 00:19:20.136868',NULL),(45,0.7,'2018-04-11 00:19:21.195186',NULL),(46,0.7,'2018-04-11 00:19:22.233735',NULL),(47,0.5,'2018-04-11 00:19:23.310070',NULL),(48,0.7,'2018-04-11 00:19:24.373536',NULL),(49,0.5,'2018-04-11 00:19:25.434470',NULL),(50,0.5,'2018-04-11 00:19:26.483608',NULL),(51,0.7,'2018-04-11 00:19:27.610558',NULL),(52,0.7,'2018-04-11 00:19:28.744171',NULL),(53,0.5,'2018-04-11 00:19:29.796557',NULL),(54,0.7,'2018-04-11 00:19:30.880367',NULL),(55,0.7,'2018-04-11 00:19:32.074316',NULL),(56,0.9,'2018-04-11 00:19:33.139756',NULL),(57,0.5,'2018-04-11 00:19:34.210557',NULL),(58,0.5,'2018-04-11 00:19:35.501736',NULL),(59,0.6,'2018-04-11 00:19:36.870750',NULL),(60,0.3,'2018-04-11 00:19:38.320570',NULL),(61,0.7,'2018-04-11 00:19:39.427589',NULL),(62,0.7,'2018-04-11 00:19:40.483453',NULL),(63,55.6,'2018-04-11 00:29:44.141944',NULL),(64,11.2,'2018-04-11 00:29:45.185170',NULL),(65,0.7,'2018-04-11 00:29:46.259268',NULL),(66,12,'2018-04-11 00:29:47.317161',NULL),(67,57.1,'2018-04-11 00:29:51.162957',NULL),(68,12.1,'2018-04-11 00:29:52.203297',NULL),(69,0.7,'2018-04-11 00:29:53.245942',NULL),(70,0.4,'2018-04-11 00:29:54.394844',NULL),(71,0.5,'2018-04-11 00:29:55.431451',NULL),(72,0.7,'2018-04-11 00:29:56.522603',NULL),(73,0.7,'2018-04-11 00:29:57.596937',NULL),(74,0.7,'2018-04-11 00:29:58.635426',NULL),(75,0.5,'2018-04-11 00:29:59.673481',NULL),(76,0.5,'2018-04-11 00:30:00.755128',NULL),(77,0.7,'2018-04-11 00:30:01.820097',NULL),(78,0.5,'2018-04-11 00:30:02.868364',NULL),(79,0.5,'2018-04-11 00:30:03.909073',NULL),(80,1,'2018-04-11 00:30:04.974498',NULL),(81,0.5,'2018-04-11 00:30:06.047591',NULL),(82,0.5,'2018-04-11 00:30:07.120562',NULL),(83,0.5,'2018-04-11 00:30:08.198553',NULL),(84,0.7,'2018-04-11 00:30:09.249382',NULL),(85,0.7,'2018-04-11 00:30:10.361678',NULL),(86,0.7,'2018-04-11 00:30:11.418214',NULL),(87,0.5,'2018-04-11 00:30:12.475485',NULL),(88,0.5,'2018-04-11 00:30:13.531072',NULL),(89,0.5,'2018-04-11 00:30:14.594463',NULL),(90,0.9,'2018-04-11 00:30:15.655396',NULL),(91,0.4,'2018-04-11 00:30:16.863871',NULL),(92,0.6,'2018-04-11 00:30:18.060574',NULL),(93,0.5,'2018-04-11 00:30:19.160281',NULL),(94,0.7,'2018-04-11 00:30:20.198336',NULL),(95,0.7,'2018-04-11 00:30:21.305445',NULL),(96,0.7,'2018-04-11 00:30:22.356893',NULL),(97,0.5,'2018-04-11 00:30:23.400797',NULL),(98,5.1,'2018-04-11 00:30:24.437000',NULL),(99,0.2,'2018-04-11 00:30:25.501304',NULL),(100,0.5,'2018-04-11 00:30:26.552020',NULL),(101,0.2,'2018-04-11 00:30:27.594803',NULL),(102,0.2,'2018-04-11 00:30:28.634719',NULL),(103,0.5,'2018-04-11 00:30:29.679229',NULL),(104,0.5,'2018-04-11 00:30:30.724671',NULL),(105,0.5,'2018-04-11 00:30:31.776502',NULL),(106,0.7,'2018-04-11 00:30:32.833328',NULL),(107,0.7,'2018-04-11 00:30:33.882391',NULL),(108,0.5,'2018-04-11 00:30:34.934043',NULL),(109,0.7,'2018-04-11 00:30:35.981352',NULL),(110,0.5,'2018-04-11 00:30:37.040561',NULL),(111,0.5,'2018-04-11 00:30:38.104942',NULL),(112,0.7,'2018-04-11 00:30:39.161672',NULL),(113,0.7,'2018-04-11 00:30:40.219436',NULL),(114,0.5,'2018-04-11 00:30:41.263681',NULL),(115,0.7,'2018-04-11 00:30:42.300536',NULL),(116,0.5,'2018-04-11 00:30:43.385048',NULL),(117,0.7,'2018-04-11 00:30:44.450254',NULL),(118,0.5,'2018-04-11 00:30:45.531949',NULL),(119,0.5,'2018-04-11 00:30:46.588475',NULL),(120,1,'2018-04-11 00:30:47.638920',NULL),(121,0.5,'2018-04-11 00:30:48.698394',NULL),(122,0.7,'2018-04-11 00:30:49.816761',NULL),(123,0.5,'2018-04-11 00:30:50.869101',NULL),(124,0.5,'2018-04-11 00:30:51.923486',NULL),(125,1,'2018-04-11 00:30:52.980711',NULL),(126,0.5,'2018-04-11 00:30:54.037644',NULL),(127,0.7,'2018-04-11 00:30:55.097164',NULL),(128,0.5,'2018-04-11 00:30:56.149762',NULL),(129,0.7,'2018-04-11 00:30:57.199006',NULL),(130,0.5,'2018-04-11 00:30:58.276667',NULL),(131,0.7,'2018-04-11 00:30:59.330010',NULL),(132,0.5,'2018-04-11 00:31:00.407512',NULL),(133,0.7,'2018-04-11 00:31:01.471415',NULL),(134,0.7,'2018-04-11 00:31:02.521389',NULL),(135,0.5,'2018-04-11 00:31:03.566455',NULL),(136,0.7,'2018-04-11 00:31:04.629597',NULL),(137,0.5,'2018-04-11 00:31:05.698329',NULL),(138,0.5,'2018-04-11 00:31:06.742987',NULL),(139,1,'2018-04-11 00:31:07.791421',NULL),(140,0.5,'2018-04-11 00:31:08.848104',NULL),(141,0.7,'2018-04-11 00:31:09.898065',NULL),(142,0.5,'2018-04-11 00:31:11.014640',NULL),(143,0.7,'2018-04-11 00:31:12.078258',NULL),(144,0.7,'2018-04-11 00:31:13.131513',NULL),(145,0.5,'2018-04-11 00:31:14.186563',NULL),(146,0.5,'2018-04-11 00:31:15.231427',NULL),(147,0.7,'2018-04-11 00:31:16.286595',NULL),(148,0.7,'2018-04-11 00:31:17.338902',NULL),(149,0.5,'2018-04-11 00:31:18.404877',NULL),(150,0.7,'2018-04-11 00:31:19.454050',NULL),(151,0.5,'2018-04-11 00:31:20.505952',NULL),(152,0.7,'2018-04-11 00:31:21.554671',NULL),(153,0.5,'2018-04-11 00:31:22.615823',NULL),(154,0.7,'2018-04-11 00:31:24.654174',NULL),(155,0.4,'2018-04-11 00:31:25.772661',NULL),(156,0.7,'2018-04-11 00:31:26.826211',NULL),(157,5,'2018-04-11 00:31:27.882344',NULL),(158,0.5,'2018-04-11 00:31:28.929436',NULL),(159,0.2,'2018-04-11 00:31:29.994213',NULL),(160,0.2,'2018-04-11 00:31:31.051979',NULL),(161,0.2,'2018-04-11 00:31:32.104827',NULL),(162,0.5,'2018-04-11 00:31:33.157217',NULL),(163,0.5,'2018-04-11 00:31:34.217648',NULL),(164,0.7,'2018-04-11 00:31:35.271399',NULL),(165,0.5,'2018-04-11 00:31:36.328454',NULL),(166,0.7,'2018-04-11 00:31:37.389163',NULL),(167,0.9,'2018-04-11 00:31:38.456405',NULL),(168,0.5,'2018-04-11 00:31:39.503909',NULL),(169,0.7,'2018-04-11 00:31:40.568251',NULL),(170,0.5,'2018-04-11 00:31:41.608298',NULL),(171,0.7,'2018-04-11 00:31:42.669341',NULL),(172,0.5,'2018-04-11 00:31:43.727291',NULL),(173,0.7,'2018-04-11 00:31:44.785455',NULL),(174,0.5,'2018-04-11 00:31:45.863559',NULL),(175,0.7,'2018-04-11 00:31:46.949863',NULL),(176,0.7,'2018-04-11 00:31:47.991067',NULL),(177,0.5,'2018-04-11 00:31:49.125357',NULL),(178,0.7,'2018-04-11 00:31:50.164821',NULL),(179,0.5,'2018-04-11 00:31:51.210524',NULL),(180,0.7,'2018-04-11 00:31:52.365968',NULL),(181,0.7,'2018-04-11 00:31:53.407423',NULL),(182,0.5,'2018-04-11 00:31:54.448275',NULL),(183,0.7,'2018-04-11 00:31:55.518831',NULL),(184,0.5,'2018-04-11 00:31:56.568280',NULL),(185,0.5,'2018-04-11 00:31:57.645629',NULL),(186,0.9,'2018-04-11 00:31:58.724350',NULL),(187,0.5,'2018-04-11 00:31:59.811886',NULL),(188,0.5,'2018-04-11 00:32:00.873714',NULL),(189,0.7,'2018-04-11 00:32:01.932918',NULL),(190,0.7,'2018-04-11 00:32:02.994989',NULL),(191,0.5,'2018-04-11 00:32:04.059695',NULL),(192,0.7,'2018-04-11 00:32:05.110509',NULL),(193,0.5,'2018-04-11 00:32:06.183036',NULL),(194,0.7,'2018-04-11 00:32:07.230635',NULL),(195,0.5,'2018-04-11 00:32:08.278786',NULL),(196,0.7,'2018-04-11 00:32:09.321719',NULL),(197,0.7,'2018-04-11 00:32:10.374787',NULL),(198,0.5,'2018-04-11 00:32:11.427541',NULL),(199,0.7,'2018-04-11 00:32:12.491892',NULL),(200,0.5,'2018-04-11 00:32:13.543827',NULL),(201,0.7,'2018-04-11 00:32:14.615513',NULL),(202,0.7,'2018-04-11 00:32:15.730298',NULL),(203,0.5,'2018-04-11 00:32:16.798126',NULL),(204,0.7,'2018-04-11 00:32:17.859565',NULL),(205,0.5,'2018-04-11 00:32:18.946137',NULL),(206,0.7,'2018-04-11 00:32:20.000499',NULL),(207,0.5,'2018-04-11 00:32:21.055939',NULL),(208,0.7,'2018-04-11 00:32:22.114497',NULL),(209,0.5,'2018-04-11 00:32:23.184721',NULL),(210,0.7,'2018-04-11 00:32:24.242151',NULL),(211,0.7,'2018-04-11 00:32:25.297935',NULL),(212,0.7,'2018-04-11 00:32:26.373923',NULL),(213,0.5,'2018-04-11 00:32:27.447706',NULL),(214,0.7,'2018-04-11 00:32:28.506722',NULL),(215,0.5,'2018-04-11 00:32:29.571540',NULL),(216,6.2,'2018-04-11 00:32:30.624829',NULL),(217,0.2,'2018-04-11 00:32:31.656294',NULL),(218,0.5,'2018-04-11 00:32:32.686439',NULL),(219,0.5,'2018-04-11 00:32:33.717552',NULL),(220,0.2,'2018-04-11 00:32:34.762534',NULL),(221,0.2,'2018-04-11 00:32:35.827933',NULL),(222,0.7,'2018-04-11 00:32:36.895653',NULL),(223,0.5,'2018-04-11 00:32:37.938822',NULL),(224,1,'2018-04-11 00:32:38.983440',NULL),(225,0.5,'2018-04-11 00:32:40.027422',NULL),(226,0.5,'2018-04-11 00:32:41.077008',NULL),(227,0.7,'2018-04-11 00:32:42.126503',NULL),(228,0.5,'2018-04-11 00:32:43.164106',NULL),(229,0.5,'2018-04-11 00:32:44.219327',NULL),(230,1,'2018-04-11 00:32:45.285442',NULL),(231,0.5,'2018-04-11 00:32:46.327715',NULL),(232,0.7,'2018-04-11 00:32:47.366290',NULL),(233,0.7,'2018-04-11 00:32:48.412895',NULL),(234,0.5,'2018-04-11 00:32:49.470582',NULL),(235,0.7,'2018-04-11 00:32:50.515022',NULL),(236,0.5,'2018-04-11 00:32:51.578619',NULL),(237,0.7,'2018-04-11 00:32:52.649177',NULL),(238,0.5,'2018-04-11 00:32:53.725900',NULL),(239,0.7,'2018-04-11 00:32:54.791084',NULL),(240,0.5,'2018-04-11 00:32:55.849443',NULL),(241,0.7,'2018-04-11 00:32:56.937488',NULL),(242,0.5,'2018-04-11 00:32:57.993440',NULL),(243,0.5,'2018-04-11 00:32:59.048578',NULL),(244,0.7,'2018-04-11 00:33:00.115887',NULL),(245,0.5,'2018-04-11 00:33:01.233557',NULL),(246,0.7,'2018-04-11 00:33:02.289959',NULL),(247,0.7,'2018-04-11 00:33:03.339702',NULL),(248,0.7,'2018-04-11 00:33:04.891206',NULL),(249,0.3,'2018-04-11 00:33:06.201547',NULL),(250,0.7,'2018-04-11 00:33:07.242405',NULL),(251,0.5,'2018-04-11 00:33:08.278825',NULL),(252,0.7,'2018-04-11 00:33:09.326453',NULL),(253,0.5,'2018-04-11 00:33:10.381653',NULL),(254,0.5,'2018-04-11 00:33:11.428939',NULL),(255,1,'2018-04-11 00:33:12.480706',NULL),(256,1.2,'2018-04-11 00:33:13.541628',NULL),(257,0.5,'2018-04-11 00:33:14.606836',NULL),(258,0.9,'2018-04-11 00:33:15.674839',NULL),(259,0.5,'2018-04-11 00:33:16.740631',NULL),(260,0.5,'2018-04-11 00:33:17.795772',NULL),(261,7.5,'2018-04-11 00:33:18.830997',NULL),(262,25.4,'2018-04-11 00:33:19.874135',NULL),(263,21.1,'2018-04-11 00:33:20.911790',NULL),(264,0.5,'2018-04-11 00:33:21.941592',NULL),(265,3.2,'2018-04-11 00:33:22.971485',NULL),(266,23.8,'2018-04-11 00:33:24.000555',NULL),(267,4.2,'2018-04-11 00:33:25.040310',NULL),(268,3.9,'2018-04-11 00:33:26.076636',NULL),(269,18.4,'2018-04-11 00:33:27.174632',NULL),(270,0.2,'2018-04-11 00:33:28.208566',NULL),(271,0.7,'2018-04-11 00:33:29.244461',NULL),(272,0.5,'2018-04-11 00:33:30.311020',NULL),(273,0.5,'2018-04-11 00:33:31.368194',NULL),(274,0.5,'2018-04-11 00:33:32.404711',NULL),(275,6.6,'2018-04-11 00:33:33.451672',NULL),(276,0.2,'2018-04-11 00:33:34.490919',NULL),(277,0.5,'2018-04-11 00:33:35.516005',NULL),(278,0.2,'2018-04-11 00:33:36.549963',NULL),(279,0.5,'2018-04-11 00:33:37.582328',NULL),(280,0.5,'2018-04-11 00:33:38.622693',NULL),(281,0.7,'2018-04-11 00:33:39.684601',NULL),(282,0.7,'2018-04-11 00:33:40.769965',NULL),(283,0.5,'2018-04-11 00:33:41.828596',NULL),(284,0.9,'2018-04-11 00:33:42.885511',NULL),(285,69.4,'2018-04-11 00:33:43.916282',NULL),(286,100,'2018-04-11 00:33:45.023736',NULL),(287,100,'2018-04-11 00:33:46.069791',NULL),(288,100,'2018-04-11 00:33:47.126553',NULL),(289,100,'2018-04-11 00:33:48.157417',NULL),(290,100,'2018-04-11 00:33:49.185561',NULL),(291,100,'2018-04-11 00:33:50.216091',NULL),(292,79.1,'2018-04-11 00:33:51.243837',NULL),(293,0.5,'2018-04-11 00:33:52.371810',NULL),(294,0.2,'2018-04-11 00:33:53.399820',NULL),(295,0.1,'2018-04-11 00:33:55.738242',NULL),(296,0.5,'2018-04-11 00:33:56.784618',NULL),(297,0.5,'2018-04-11 00:33:57.834851',NULL),(298,0.2,'2018-04-11 00:33:58.895577',NULL),(299,0.7,'2018-04-11 00:33:59.954812',NULL),(300,0.5,'2018-04-11 00:34:01.008375',NULL),(301,0.5,'2018-04-11 00:34:02.055963',NULL),(302,0.7,'2018-04-11 00:34:03.119147',NULL),(303,0.7,'2018-04-11 00:34:04.186709',NULL),(304,0.7,'2018-04-11 00:34:05.238997',NULL),(305,0.5,'2018-04-11 00:34:06.287595',NULL),(306,37.4,'2018-04-11 00:34:07.323364',NULL),(307,100,'2018-04-11 00:34:08.356602',NULL),(308,100,'2018-04-11 00:34:09.395516',NULL),(309,100,'2018-04-11 00:34:10.431440',NULL),(310,100,'2018-04-11 00:34:11.476066',NULL),(311,100,'2018-04-11 00:34:12.522431',NULL),(312,100,'2018-04-11 00:34:13.549175',NULL),(313,100,'2018-04-11 00:34:14.584181',NULL),(314,16.5,'2018-04-11 00:34:15.629396',NULL),(315,0.2,'2018-04-11 00:34:16.685914',NULL),(316,0.2,'2018-04-11 00:34:17.734471',NULL),(317,0.7,'2018-04-11 00:34:18.765579',NULL),(318,0.2,'2018-04-11 00:34:19.794017',NULL),(319,0.2,'2018-04-11 00:34:20.839409',NULL),(320,0.5,'2018-04-11 00:34:21.903125',NULL),(321,0.2,'2018-04-11 00:34:22.964854',NULL),(322,0.7,'2018-04-11 00:34:24.021115',NULL),(323,0.5,'2018-04-11 00:34:25.073819',NULL),(324,0.7,'2018-04-11 00:34:26.123014',NULL),(325,0.5,'2018-04-11 00:34:27.166881',NULL),(326,0.7,'2018-04-11 00:34:28.240165',NULL),(327,0.7,'2018-04-11 00:34:29.293637',NULL),(328,0.5,'2018-04-11 00:34:30.350756',NULL),(329,0.5,'2018-04-11 00:34:31.393926',NULL),(330,0.7,'2018-04-11 00:34:32.449774',NULL),(331,0.7,'2018-04-11 00:34:33.518744',NULL),(332,0.7,'2018-04-11 00:34:34.572010',NULL),(333,0.5,'2018-04-11 00:34:35.648933',NULL),(334,6.3,'2018-04-11 00:34:36.695770',NULL),(335,0.2,'2018-04-11 00:34:37.737216',NULL),(336,0.5,'2018-04-11 00:34:38.770650',NULL),(337,0.5,'2018-04-11 00:34:39.809047',NULL),(338,0.2,'2018-04-11 00:34:40.837456',NULL),(339,0.2,'2018-04-11 00:34:41.912453',NULL),(340,0.7,'2018-04-11 00:34:42.966907',NULL),(341,0.5,'2018-04-11 00:34:44.008350',NULL),(342,1,'2018-04-11 00:34:45.098789',NULL),(343,0.5,'2018-04-11 00:34:46.307356',NULL),(344,0.3,'2018-04-11 00:34:47.695438',NULL),(345,0.7,'2018-04-11 00:34:48.753057',NULL),(346,0.5,'2018-04-11 00:34:49.837100',NULL),(347,0.9,'2018-04-11 00:34:50.910879',NULL),(348,0.5,'2018-04-11 00:34:51.962755',NULL),(349,0.7,'2018-04-11 00:34:53.014515',NULL),(350,0.5,'2018-04-11 00:34:54.065896',NULL),(351,0.7,'2018-04-11 00:34:55.120832',NULL),(352,0.7,'2018-04-11 00:34:56.174855',NULL),(353,92.2,'2018-04-11 00:34:57.216597',NULL),(354,100,'2018-04-11 00:34:58.262209',NULL),(355,100,'2018-04-11 00:34:59.325258',NULL),(356,100,'2018-04-11 00:35:00.435428',NULL),(357,100,'2018-04-11 00:35:01.479790',NULL),(358,100,'2018-04-11 00:35:02.557390',NULL),(359,100,'2018-04-11 00:35:03.585345',NULL),(360,100,'2018-04-11 00:35:04.614046',NULL),(361,100,'2018-04-11 00:35:05.658137',NULL),(362,100,'2018-04-11 00:35:06.691972',NULL),(363,100,'2018-04-11 00:35:07.749233',NULL),(364,100,'2018-04-11 00:35:08.806568',NULL),(365,100,'2018-04-11 00:35:09.877892',NULL),(366,100,'2018-04-11 00:35:10.942060',NULL),(367,100,'2018-04-11 00:35:11.999413',NULL),(368,100,'2018-04-11 00:35:13.047808',NULL),(369,100,'2018-04-11 00:35:15.263441',NULL),(370,100,'2018-04-11 00:35:16.297093',NULL),(371,100,'2018-04-11 00:35:17.354260',NULL),(372,100,'2018-04-11 00:35:18.471648',NULL),(373,100,'2018-04-11 00:35:19.507391',NULL),(374,100,'2018-04-11 00:35:20.550325',NULL),(375,100,'2018-04-11 00:35:21.598130',NULL),(376,100,'2018-04-11 00:35:22.637106',NULL),(377,100,'2018-04-11 00:35:23.673132',NULL),(378,100,'2018-04-11 00:35:24.723249',NULL),(379,100,'2018-04-11 00:35:25.758562',NULL),(380,100,'2018-04-11 00:35:26.797264',NULL),(381,100,'2018-04-11 00:35:27.847301',NULL),(382,100,'2018-04-11 00:35:28.884790',NULL),(383,100,'2018-04-11 00:35:29.946603',NULL),(384,100,'2018-04-11 00:35:30.999904',NULL),(385,100,'2018-04-11 00:35:32.187394',NULL),(386,100,'2018-04-11 00:35:33.244568',NULL),(387,100,'2018-04-11 00:35:34.273559',NULL),(388,100,'2018-04-11 00:35:35.304523',NULL),(389,100,'2018-04-11 00:35:36.389587',NULL),(390,100,'2018-04-11 00:35:37.466166',NULL),(391,100,'2018-04-11 00:35:38.498163',NULL),(392,100,'2018-04-11 00:35:39.548125',NULL),(393,100,'2018-04-11 00:35:40.593131',NULL),(394,100,'2018-04-11 00:35:41.638922',NULL),(395,100,'2018-04-11 00:35:42.680732',NULL),(396,100,'2018-04-11 00:35:43.722282',NULL),(397,100,'2018-04-11 00:35:44.754710',NULL),(398,100,'2018-04-11 00:35:45.807314',NULL),(399,100,'2018-04-11 00:35:46.855957',NULL),(400,100,'2018-04-11 00:35:47.919305',NULL),(401,100,'2018-04-11 00:35:48.960338',NULL),(402,100,'2018-04-11 00:35:50.000470',NULL),(403,100,'2018-04-11 00:35:51.147064',NULL),(404,100,'2018-04-11 00:35:52.178324',NULL),(405,100,'2018-04-11 00:35:53.207696',NULL),(406,36.4,'2018-04-11 00:35:54.235072',NULL),(407,0.5,'2018-04-11 00:35:55.262824',NULL),(408,2.7,'2018-04-11 00:35:56.310107',NULL),(409,21.6,'2018-04-11 00:35:57.437184',NULL),(410,0.5,'2018-04-11 00:35:58.468397',NULL),(411,0.2,'2018-04-11 00:35:59.539900',NULL),(412,0.2,'2018-04-11 00:36:00.587744',NULL),(413,0.5,'2018-04-11 00:36:01.626490',NULL),(414,0.5,'2018-04-11 00:36:02.703017',NULL),(415,0.7,'2018-04-11 00:36:03.765166',NULL),(416,0.7,'2018-04-11 00:36:04.832106',NULL),(417,0.5,'2018-04-11 00:36:05.883696',NULL),(418,0.5,'2018-04-11 00:36:06.923275',NULL),(419,0.5,'2018-04-11 00:36:07.987166',NULL),(420,0.7,'2018-04-11 00:36:09.037305',NULL),(421,0.7,'2018-04-11 00:36:10.089632',NULL),(422,0.5,'2018-04-11 00:36:11.144764',NULL),(423,1,'2018-04-11 00:36:12.189391',NULL),(424,0.5,'2018-04-11 00:36:13.250355',NULL),(425,0.7,'2018-04-11 00:36:14.306093',NULL),(426,0.5,'2018-04-11 00:36:15.364417',NULL),(427,0.5,'2018-04-11 00:36:16.425921',NULL),(428,0.7,'2018-04-11 00:36:17.466795',NULL),(429,0.5,'2018-04-11 00:36:18.506776',NULL),(430,1,'2018-04-11 00:36:19.556824',NULL),(431,0.5,'2018-04-11 00:36:20.604535',NULL),(432,0.7,'2018-04-11 00:36:21.678827',NULL),(433,0.5,'2018-04-11 00:36:22.747135',NULL),(434,0.9,'2018-04-11 00:36:23.861926',NULL),(435,0.5,'2018-04-11 00:36:24.925998',NULL),(436,0.7,'2018-04-11 00:36:26.487093',NULL),(437,0.5,'2018-04-11 00:36:27.752481',NULL),(438,0.4,'2018-04-11 00:36:28.799894',NULL),(439,0.7,'2018-04-11 00:36:29.855220',NULL),(440,0.5,'2018-04-11 00:36:30.914180',NULL),(441,0.5,'2018-04-11 00:36:31.969224',NULL),(442,0.7,'2018-04-11 00:36:33.062619',NULL),(443,0.5,'2018-04-11 00:36:34.120633',NULL),(444,0.7,'2018-04-11 00:36:35.189462',NULL),(445,0.7,'2018-04-11 00:36:36.241305',NULL),(446,0.5,'2018-04-11 00:36:37.294877',NULL),(447,0.7,'2018-04-11 00:36:38.353616',NULL),(448,0.5,'2018-04-11 00:36:39.409346',NULL),(449,0.7,'2018-04-11 00:36:40.467006',NULL),(450,0.5,'2018-04-11 00:36:41.522709',NULL),(451,6.3,'2018-04-11 00:36:42.550944',NULL);
/*!40000 ALTER TABLE `bearing_cpuinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bearing_factory`
--

DROP TABLE IF EXISTS `bearing_factory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bearing_factory` (
  `factorID` int(11) NOT NULL AUTO_INCREMENT,
  `factorDes` varchar(100) NOT NULL,
  `location` varchar(200) NOT NULL,
  `areaCode` varchar(6) NOT NULL,
  `personInCharge` varchar(12) NOT NULL,
  `phoneNumber` varchar(11) NOT NULL,
  `otherInfo` longtext,
  `saveDate` datetime(6) NOT NULL,
  `modDate` datetime(6) NOT NULL,
  PRIMARY KEY (`factorID`)
) ENGINE=InnoDB AUTO_INCREMENT=1007 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bearing_factory`
--

LOCK TABLES `bearing_factory` WRITE;
/*!40000 ALTER TABLE `bearing_factory` DISABLE KEYS */;
INSERT INTO `bearing_factory` VALUES (1001,'广州番禺制造中心','广东省广州番禺区大学路1号','440105','张博文','15622505458','负责制造生厂转向器','2018-04-09 02:40:00.000000','2018-04-11 02:53:32.606464'),(1002,'深圳沙井制造中心','广东省深圳市宝安区沙井芙蓉路1号','440300','李煜城','15622505460','负责加工机床零部件','2018-04-09 02:47:00.000000','2018-04-09 02:47:48.246302'),(1003,'东莞制造中心','广东省东莞市松山湖区大学路一号','441900','张辰逸','1562250546','负责加工飞机机翼零部件','2018-04-09 02:52:00.000000','2018-04-09 02:53:07.619629'),(1004,'惠州转向器加工中心','广东省惠州市博罗县博罗大道一号','441322','张风华','15622505466','负责转向器二次加工','2018-04-09 02:53:00.000000','2018-04-09 02:53:41.589111'),(1005,'长沙转向器组装中心','湖南省长沙市长沙大道一号','430111','李伟祺','15622505466','负责转向器组装','2018-04-09 02:53:00.000000','2018-04-09 02:54:11.727120'),(1006,'广州黄埔制造中心','广东省广州黄埔区大学路1号','440105','张博文','15622505458','负责制造转向器','2018-04-11 01:53:42.279831','2018-04-11 01:53:42.285759');
/*!40000 ALTER TABLE `bearing_factory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bearing_ioinfo`
--

DROP TABLE IF EXISTS `bearing_ioinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bearing_ioinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` double NOT NULL,
  `time` datetime(6) NOT NULL,
  `machine_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bearing_ioinfo_machine_id_22f2bbf9_fk_bearing_machine_machineID` (`machine_id`),
  CONSTRAINT `bearing_ioinfo_machine_id_22f2bbf9_fk_bearing_machine_machineID` FOREIGN KEY (`machine_id`) REFERENCES `bearing_machine` (`machineID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bearing_ioinfo`
--

LOCK TABLES `bearing_ioinfo` WRITE;
/*!40000 ALTER TABLE `bearing_ioinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `bearing_ioinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bearing_machine`
--

DROP TABLE IF EXISTS `bearing_machine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bearing_machine` (
  `machineID` int(11) NOT NULL AUTO_INCREMENT,
  `machineDes` varchar(100) NOT NULL,
  `saveDate` datetime(6) NOT NULL,
  `modDate` datetime(6) NOT NULL,
  `otherInfo` longtext,
  `productDepart_id` int(11) NOT NULL,
  PRIMARY KEY (`machineID`),
  KEY `bearing_machine_productDepart_id_7983075c_fk_bearing_p` (`productDepart_id`),
  CONSTRAINT `bearing_machine_productDepart_id_7983075c_fk_bearing_p` FOREIGN KEY (`productDepart_id`) REFERENCES `bearing_productdepart` (`departID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bearing_machine`
--

LOCK TABLES `bearing_machine` WRITE;
/*!40000 ALTER TABLE `bearing_machine` DISABLE KEYS */;
INSERT INTO `bearing_machine` VALUES (1,'切割铣床1001','2018-04-09 03:26:00.000000','2018-04-09 04:07:19.658433','负责切割块状金属部件',100001),(2,'冲压铣床1001','2018-04-09 04:07:00.000000','2018-04-09 04:08:01.226424','负责部件冲压成型',100001),(3,'切割铣床1002','2018-04-09 04:08:00.000000','2018-04-09 04:08:19.608145','负责切割零部件',100001),(4,'龙门铣床1001','2018-04-09 04:28:00.000000','2018-04-09 04:31:11.531765','',100002),(5,'升降台铣床1001','2018-04-09 04:31:00.000000','2018-04-09 04:32:13.505369','',100004),(6,'仪表铣床1001','2018-04-09 04:32:00.000000','2018-04-09 04:32:49.285691','对制造出来的机部件进行检查',100003),(7,'工具铣床1001','2018-04-09 04:32:00.000000','2018-04-09 04:33:15.562026','',100005),(8,'工具铣床1001','2018-04-09 04:33:00.000000','2018-04-09 04:33:22.327579','',100006),(9,'工具铣床1002','2018-04-09 04:33:00.000000','2018-04-09 04:33:37.277452','',100007),(10,'工具铣床1001','2018-04-09 04:33:00.000000','2018-04-09 04:33:45.650735','',100009),(11,'切割铣床1001','2018-04-09 04:33:00.000000','2018-04-09 04:33:59.461089','',100008),(12,'切割铣床1002','2018-04-09 04:34:00.000000','2018-04-09 04:34:08.389264','',100008),(13,'冲压铣床1001','2018-04-09 04:34:00.000000','2018-04-09 04:34:19.594771','',100006);
/*!40000 ALTER TABLE `bearing_machine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bearing_machineruntime`
--

DROP TABLE IF EXISTS `bearing_machineruntime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bearing_machineruntime` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `machine_id` int(11) NOT NULL,
  `opStartEnddate_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bearing_machinerunti_machine_id_eac8f45d_fk_bearing_m` (`machine_id`),
  KEY `bearing_machinerunti_opStartEnddate_id_f4ba3ca5_fk_bearing_o` (`opStartEnddate_id`),
  CONSTRAINT `bearing_machinerunti_machine_id_eac8f45d_fk_bearing_m` FOREIGN KEY (`machine_id`) REFERENCES `bearing_machine` (`machineID`),
  CONSTRAINT `bearing_machinerunti_opStartEnddate_id_f4ba3ca5_fk_bearing_o` FOREIGN KEY (`opStartEnddate_id`) REFERENCES `bearing_opstartenddate` (`opCodeID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bearing_machineruntime`
--

LOCK TABLES `bearing_machineruntime` WRITE;
/*!40000 ALTER TABLE `bearing_machineruntime` DISABLE KEYS */;
INSERT INTO `bearing_machineruntime` VALUES (1,1,1),(2,1,2);
/*!40000 ALTER TABLE `bearing_machineruntime` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bearing_memoryinfo`
--

DROP TABLE IF EXISTS `bearing_memoryinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bearing_memoryinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `valueUsed` double NOT NULL,
  `memPercent` double NOT NULL,
  `time` datetime(6) NOT NULL,
  `machine_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bearing_memoryinfo_machine_id_68beaa61_fk_bearing_m` (`machine_id`),
  CONSTRAINT `bearing_memoryinfo_machine_id_68beaa61_fk_bearing_m` FOREIGN KEY (`machine_id`) REFERENCES `bearing_machine` (`machineID`)
) ENGINE=InnoDB AUTO_INCREMENT=452 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bearing_memoryinfo`
--

LOCK TABLES `bearing_memoryinfo` WRITE;
/*!40000 ALTER TABLE `bearing_memoryinfo` DISABLE KEYS */;
INSERT INTO `bearing_memoryinfo` VALUES (1,52,8.8,'2018-04-11 00:18:33.544729',NULL),(2,52,8.8,'2018-04-11 00:18:34.613345',NULL),(3,52,8.8,'2018-04-11 00:18:35.670547',NULL),(4,52,8.8,'2018-04-11 00:18:36.716073',NULL),(5,52,8.8,'2018-04-11 00:18:37.756649',NULL),(6,52,8.8,'2018-04-11 00:18:38.826318',NULL),(7,52,8.8,'2018-04-11 00:18:39.897963',NULL),(8,52,8.8,'2018-04-11 00:18:40.971647',NULL),(9,52,8.8,'2018-04-11 00:18:42.028142',NULL),(10,52,8.8,'2018-04-11 00:18:43.073742',NULL),(11,52,8.8,'2018-04-11 00:18:44.113261',NULL),(12,52,8.8,'2018-04-11 00:18:45.166631',NULL),(13,52,8.8,'2018-04-11 00:18:46.222886',NULL),(14,52,8.8,'2018-04-11 00:18:47.294623',NULL),(15,52,8.8,'2018-04-11 00:18:48.348371',NULL),(16,52,8.8,'2018-04-11 00:18:49.410053',NULL),(17,52,8.8,'2018-04-11 00:18:50.478101',NULL),(18,52,8.9,'2018-04-11 00:18:51.546570',NULL),(19,52,8.9,'2018-04-11 00:18:52.599026',NULL),(20,52,8.9,'2018-04-11 00:18:53.650741',NULL),(21,52,8.9,'2018-04-11 00:18:54.724805',NULL),(22,52,8.9,'2018-04-11 00:18:55.772680',NULL),(23,52,8.9,'2018-04-11 00:18:56.839950',NULL),(24,52,8.9,'2018-04-11 00:18:58.950289',NULL),(25,52,8.9,'2018-04-11 00:18:59.990733',NULL),(26,52,8.9,'2018-04-11 00:19:01.078158',NULL),(27,52,8.8,'2018-04-11 00:19:02.123682',NULL),(28,52,8.8,'2018-04-11 00:19:03.177462',NULL),(29,52,8.9,'2018-04-11 00:19:04.219386',NULL),(30,52,8.9,'2018-04-11 00:19:05.272507',NULL),(31,52,8.9,'2018-04-11 00:19:06.322884',NULL),(32,52,8.8,'2018-04-11 00:19:07.370823',NULL),(33,52,8.9,'2018-04-11 00:19:08.415598',NULL),(34,52,8.9,'2018-04-11 00:19:09.480620',NULL),(35,52,8.9,'2018-04-11 00:19:10.536461',NULL),(36,52,8.9,'2018-04-11 00:19:11.587939',NULL),(37,52,8.9,'2018-04-11 00:19:12.657012',NULL),(38,52,8.9,'2018-04-11 00:19:13.716946',NULL),(39,52,8.9,'2018-04-11 00:19:14.759294',NULL),(40,52,8.9,'2018-04-11 00:19:15.844177',NULL),(41,52,8.9,'2018-04-11 00:19:16.923119',NULL),(42,52,8.9,'2018-04-11 00:19:17.990038',NULL),(43,52,8.9,'2018-04-11 00:19:19.042379',NULL),(44,52,8.9,'2018-04-11 00:19:20.136868',NULL),(45,52,8.9,'2018-04-11 00:19:21.195186',NULL),(46,52,8.9,'2018-04-11 00:19:22.233735',NULL),(47,52,8.9,'2018-04-11 00:19:23.310070',NULL),(48,52,8.9,'2018-04-11 00:19:24.373536',NULL),(49,52,8.9,'2018-04-11 00:19:25.434470',NULL),(50,52,8.9,'2018-04-11 00:19:26.483608',NULL),(51,52,8.9,'2018-04-11 00:19:27.610558',NULL),(52,52,8.9,'2018-04-11 00:19:28.744171',NULL),(53,52,8.9,'2018-04-11 00:19:29.796557',NULL),(54,52,8.9,'2018-04-11 00:19:30.880367',NULL),(55,52,8.9,'2018-04-11 00:19:32.074316',NULL),(56,52,8.9,'2018-04-11 00:19:33.139756',NULL),(57,52,8.9,'2018-04-11 00:19:34.210557',NULL),(58,52,8.8,'2018-04-11 00:19:35.501736',NULL),(59,52,8.8,'2018-04-11 00:19:36.870750',NULL),(60,52,8.8,'2018-04-11 00:19:38.320570',NULL),(61,52,8.8,'2018-04-11 00:19:39.427589',NULL),(62,52,8.9,'2018-04-11 00:19:40.483453',NULL),(63,60,9.7,'2018-04-11 00:29:44.141944',NULL),(64,51,8.7,'2018-04-11 00:29:45.185170',NULL),(65,51,8.7,'2018-04-11 00:29:46.259268',NULL),(66,59,9.6,'2018-04-11 00:29:47.317161',NULL),(67,58,9.5,'2018-04-11 00:29:51.162957',NULL),(68,51,8.7,'2018-04-11 00:29:52.203297',NULL),(69,51,8.7,'2018-04-11 00:29:53.245942',NULL),(70,51,8.7,'2018-04-11 00:29:54.394844',NULL),(71,51,8.7,'2018-04-11 00:29:55.431451',NULL),(72,51,8.7,'2018-04-11 00:29:56.522603',NULL),(73,51,8.7,'2018-04-11 00:29:57.596937',NULL),(74,51,8.7,'2018-04-11 00:29:58.635426',NULL),(75,51,8.7,'2018-04-11 00:29:59.673481',NULL),(76,51,8.7,'2018-04-11 00:30:00.755128',NULL),(77,51,8.7,'2018-04-11 00:30:01.820097',NULL),(78,51,8.7,'2018-04-11 00:30:02.868364',NULL),(79,51,8.7,'2018-04-11 00:30:03.909073',NULL),(80,51,8.7,'2018-04-11 00:30:04.974498',NULL),(81,51,8.7,'2018-04-11 00:30:06.047591',NULL),(82,51,8.7,'2018-04-11 00:30:07.120562',NULL),(83,51,8.7,'2018-04-11 00:30:08.198553',NULL),(84,51,8.7,'2018-04-11 00:30:09.249382',NULL),(85,51,8.7,'2018-04-11 00:30:10.361678',NULL),(86,51,8.7,'2018-04-11 00:30:11.418214',NULL),(87,51,8.7,'2018-04-11 00:30:12.475485',NULL),(88,51,8.7,'2018-04-11 00:30:13.531072',NULL),(89,51,8.7,'2018-04-11 00:30:14.594463',NULL),(90,51,8.7,'2018-04-11 00:30:15.655396',NULL),(91,51,8.7,'2018-04-11 00:30:16.863871',NULL),(92,51,8.7,'2018-04-11 00:30:18.060574',NULL),(93,51,8.7,'2018-04-11 00:30:19.160281',NULL),(94,51,8.7,'2018-04-11 00:30:20.198336',NULL),(95,51,8.7,'2018-04-11 00:30:21.305445',NULL),(96,51,8.7,'2018-04-11 00:30:22.356893',NULL),(97,51,8.7,'2018-04-11 00:30:23.400797',NULL),(98,51,8.7,'2018-04-11 00:30:24.437000',NULL),(99,51,8.7,'2018-04-11 00:30:25.501304',NULL),(100,51,8.7,'2018-04-11 00:30:26.552020',NULL),(101,51,8.7,'2018-04-11 00:30:27.594803',NULL),(102,51,8.7,'2018-04-11 00:30:28.634719',NULL),(103,51,8.7,'2018-04-11 00:30:29.679229',NULL),(104,51,8.7,'2018-04-11 00:30:30.724671',NULL),(105,51,8.7,'2018-04-11 00:30:31.776502',NULL),(106,51,8.7,'2018-04-11 00:30:32.833328',NULL),(107,51,8.7,'2018-04-11 00:30:33.882391',NULL),(108,51,8.7,'2018-04-11 00:30:34.934043',NULL),(109,51,8.7,'2018-04-11 00:30:35.981352',NULL),(110,51,8.7,'2018-04-11 00:30:37.040561',NULL),(111,51,8.7,'2018-04-11 00:30:38.104942',NULL),(112,51,8.7,'2018-04-11 00:30:39.161672',NULL),(113,51,8.7,'2018-04-11 00:30:40.219436',NULL),(114,51,8.7,'2018-04-11 00:30:41.263681',NULL),(115,51,8.7,'2018-04-11 00:30:42.300536',NULL),(116,51,8.7,'2018-04-11 00:30:43.385048',NULL),(117,51,8.7,'2018-04-11 00:30:44.450254',NULL),(118,51,8.7,'2018-04-11 00:30:45.531949',NULL),(119,51,8.7,'2018-04-11 00:30:46.588475',NULL),(120,51,8.7,'2018-04-11 00:30:47.638920',NULL),(121,51,8.7,'2018-04-11 00:30:48.698394',NULL),(122,51,8.7,'2018-04-11 00:30:49.816761',NULL),(123,51,8.7,'2018-04-11 00:30:50.869101',NULL),(124,51,8.7,'2018-04-11 00:30:51.923486',NULL),(125,51,8.7,'2018-04-11 00:30:52.980711',NULL),(126,51,8.7,'2018-04-11 00:30:54.037644',NULL),(127,51,8.7,'2018-04-11 00:30:55.097164',NULL),(128,51,8.7,'2018-04-11 00:30:56.149762',NULL),(129,51,8.7,'2018-04-11 00:30:57.199006',NULL),(130,51,8.7,'2018-04-11 00:30:58.276667',NULL),(131,51,8.7,'2018-04-11 00:30:59.330010',NULL),(132,51,8.7,'2018-04-11 00:31:00.407512',NULL),(133,51,8.7,'2018-04-11 00:31:01.471415',NULL),(134,51,8.7,'2018-04-11 00:31:02.521389',NULL),(135,51,8.7,'2018-04-11 00:31:03.566455',NULL),(136,51,8.7,'2018-04-11 00:31:04.629597',NULL),(137,51,8.7,'2018-04-11 00:31:05.698329',NULL),(138,51,8.7,'2018-04-11 00:31:06.742987',NULL),(139,51,8.7,'2018-04-11 00:31:07.791421',NULL),(140,51,8.7,'2018-04-11 00:31:08.848104',NULL),(141,51,8.7,'2018-04-11 00:31:09.898065',NULL),(142,51,8.7,'2018-04-11 00:31:11.014640',NULL),(143,51,8.7,'2018-04-11 00:31:12.078258',NULL),(144,51,8.7,'2018-04-11 00:31:13.131513',NULL),(145,51,8.7,'2018-04-11 00:31:14.186563',NULL),(146,51,8.7,'2018-04-11 00:31:15.231427',NULL),(147,51,8.7,'2018-04-11 00:31:16.286595',NULL),(148,51,8.7,'2018-04-11 00:31:17.338902',NULL),(149,51,8.7,'2018-04-11 00:31:18.404877',NULL),(150,51,8.7,'2018-04-11 00:31:19.454050',NULL),(151,51,8.7,'2018-04-11 00:31:20.505952',NULL),(152,51,8.7,'2018-04-11 00:31:21.554671',NULL),(153,51,8.7,'2018-04-11 00:31:22.615823',NULL),(154,51,8.7,'2018-04-11 00:31:24.654174',NULL),(155,51,8.7,'2018-04-11 00:31:25.772661',NULL),(156,51,8.7,'2018-04-11 00:31:26.826211',NULL),(157,51,8.7,'2018-04-11 00:31:27.882344',NULL),(158,51,8.7,'2018-04-11 00:31:28.929436',NULL),(159,51,8.8,'2018-04-11 00:31:29.994213',NULL),(160,51,8.7,'2018-04-11 00:31:31.051979',NULL),(161,51,8.7,'2018-04-11 00:31:32.104827',NULL),(162,51,8.7,'2018-04-11 00:31:33.157217',NULL),(163,51,8.7,'2018-04-11 00:31:34.217648',NULL),(164,51,8.7,'2018-04-11 00:31:35.271399',NULL),(165,51,8.7,'2018-04-11 00:31:36.328454',NULL),(166,51,8.7,'2018-04-11 00:31:37.389163',NULL),(167,51,8.7,'2018-04-11 00:31:38.456405',NULL),(168,51,8.7,'2018-04-11 00:31:39.503909',NULL),(169,51,8.7,'2018-04-11 00:31:40.568251',NULL),(170,51,8.7,'2018-04-11 00:31:41.608298',NULL),(171,51,8.7,'2018-04-11 00:31:42.669341',NULL),(172,51,8.8,'2018-04-11 00:31:43.727291',NULL),(173,51,8.7,'2018-04-11 00:31:44.785455',NULL),(174,51,8.7,'2018-04-11 00:31:45.863559',NULL),(175,51,8.7,'2018-04-11 00:31:46.949863',NULL),(176,51,8.7,'2018-04-11 00:31:47.991067',NULL),(177,51,8.7,'2018-04-11 00:31:49.125357',NULL),(178,51,8.7,'2018-04-11 00:31:50.164821',NULL),(179,51,8.7,'2018-04-11 00:31:51.210524',NULL),(180,51,8.7,'2018-04-11 00:31:52.365968',NULL),(181,51,8.7,'2018-04-11 00:31:53.407423',NULL),(182,51,8.7,'2018-04-11 00:31:54.448275',NULL),(183,51,8.7,'2018-04-11 00:31:55.518831',NULL),(184,51,8.7,'2018-04-11 00:31:56.568280',NULL),(185,51,8.7,'2018-04-11 00:31:57.645629',NULL),(186,51,8.7,'2018-04-11 00:31:58.724350',NULL),(187,51,8.7,'2018-04-11 00:31:59.811886',NULL),(188,51,8.7,'2018-04-11 00:32:00.873714',NULL),(189,51,8.7,'2018-04-11 00:32:01.932918',NULL),(190,51,8.7,'2018-04-11 00:32:02.994989',NULL),(191,51,8.7,'2018-04-11 00:32:04.059695',NULL),(192,51,8.7,'2018-04-11 00:32:05.110509',NULL),(193,51,8.7,'2018-04-11 00:32:06.183036',NULL),(194,51,8.7,'2018-04-11 00:32:07.230635',NULL),(195,51,8.7,'2018-04-11 00:32:08.278786',NULL),(196,51,8.7,'2018-04-11 00:32:09.321719',NULL),(197,51,8.7,'2018-04-11 00:32:10.374787',NULL),(198,51,8.7,'2018-04-11 00:32:11.427541',NULL),(199,51,8.7,'2018-04-11 00:32:12.491892',NULL),(200,51,8.7,'2018-04-11 00:32:13.543827',NULL),(201,51,8.7,'2018-04-11 00:32:14.615513',NULL),(202,51,8.7,'2018-04-11 00:32:15.730298',NULL),(203,51,8.7,'2018-04-11 00:32:16.798126',NULL),(204,51,8.7,'2018-04-11 00:32:17.859565',NULL),(205,51,8.7,'2018-04-11 00:32:18.946137',NULL),(206,51,8.7,'2018-04-11 00:32:20.000499',NULL),(207,51,8.7,'2018-04-11 00:32:21.055939',NULL),(208,51,8.7,'2018-04-11 00:32:22.114497',NULL),(209,51,8.7,'2018-04-11 00:32:23.184721',NULL),(210,51,8.7,'2018-04-11 00:32:24.242151',NULL),(211,51,8.7,'2018-04-11 00:32:25.297935',NULL),(212,51,8.7,'2018-04-11 00:32:26.373923',NULL),(213,51,8.7,'2018-04-11 00:32:27.447706',NULL),(214,51,8.7,'2018-04-11 00:32:28.506722',NULL),(215,51,8.7,'2018-04-11 00:32:29.571540',NULL),(216,51,8.8,'2018-04-11 00:32:30.624829',NULL),(217,51,8.8,'2018-04-11 00:32:31.656294',NULL),(218,51,8.8,'2018-04-11 00:32:32.686439',NULL),(219,51,8.8,'2018-04-11 00:32:33.717552',NULL),(220,51,8.8,'2018-04-11 00:32:34.762534',NULL),(221,51,8.7,'2018-04-11 00:32:35.827933',NULL),(222,51,8.7,'2018-04-11 00:32:36.895653',NULL),(223,51,8.7,'2018-04-11 00:32:37.938822',NULL),(224,51,8.7,'2018-04-11 00:32:38.983440',NULL),(225,51,8.7,'2018-04-11 00:32:40.027422',NULL),(226,51,8.7,'2018-04-11 00:32:41.077008',NULL),(227,51,8.7,'2018-04-11 00:32:42.126503',NULL),(228,51,8.7,'2018-04-11 00:32:43.164106',NULL),(229,51,8.7,'2018-04-11 00:32:44.219327',NULL),(230,51,8.7,'2018-04-11 00:32:45.285442',NULL),(231,51,8.7,'2018-04-11 00:32:46.327715',NULL),(232,51,8.7,'2018-04-11 00:32:47.366290',NULL),(233,51,8.7,'2018-04-11 00:32:48.412895',NULL),(234,51,8.7,'2018-04-11 00:32:49.470582',NULL),(235,51,8.7,'2018-04-11 00:32:50.515022',NULL),(236,51,8.7,'2018-04-11 00:32:51.578619',NULL),(237,51,8.7,'2018-04-11 00:32:52.649177',NULL),(238,51,8.7,'2018-04-11 00:32:53.725900',NULL),(239,51,8.7,'2018-04-11 00:32:54.791084',NULL),(240,51,8.7,'2018-04-11 00:32:55.849443',NULL),(241,51,8.7,'2018-04-11 00:32:56.937488',NULL),(242,51,8.7,'2018-04-11 00:32:57.993440',NULL),(243,51,8.7,'2018-04-11 00:32:59.048578',NULL),(244,51,8.7,'2018-04-11 00:33:00.115887',NULL),(245,51,8.7,'2018-04-11 00:33:01.233557',NULL),(246,51,8.7,'2018-04-11 00:33:02.289959',NULL),(247,51,8.7,'2018-04-11 00:33:03.339702',NULL),(248,51,8.7,'2018-04-11 00:33:04.891206',NULL),(249,51,8.7,'2018-04-11 00:33:06.201547',NULL),(250,51,8.7,'2018-04-11 00:33:07.242405',NULL),(251,51,8.7,'2018-04-11 00:33:08.278825',NULL),(252,51,8.7,'2018-04-11 00:33:09.326453',NULL),(253,51,8.7,'2018-04-11 00:33:10.381653',NULL),(254,51,8.7,'2018-04-11 00:33:11.428939',NULL),(255,51,8.7,'2018-04-11 00:33:12.480706',NULL),(256,51,8.8,'2018-04-11 00:33:13.541628',NULL),(257,51,8.7,'2018-04-11 00:33:14.606836',NULL),(258,51,8.8,'2018-04-11 00:33:15.674839',NULL),(259,51,8.8,'2018-04-11 00:33:16.740631',NULL),(260,51,8.7,'2018-04-11 00:33:17.795772',NULL),(261,61,9.8,'2018-04-11 00:33:18.830997',NULL),(262,62,9.9,'2018-04-11 00:33:19.874135',NULL),(263,65,10.3,'2018-04-11 00:33:20.911790',NULL),(264,65,10.3,'2018-04-11 00:33:21.941592',NULL),(265,66,10.4,'2018-04-11 00:33:22.971485',NULL),(266,74,11.3,'2018-04-11 00:33:24.000555',NULL),(267,73,11.2,'2018-04-11 00:33:25.040310',NULL),(268,73,11.2,'2018-04-11 00:33:26.076636',NULL),(269,52,8.8,'2018-04-11 00:33:27.174632',NULL),(270,52,8.8,'2018-04-11 00:33:28.208566',NULL),(271,52,8.8,'2018-04-11 00:33:29.244461',NULL),(272,52,8.8,'2018-04-11 00:33:30.311020',NULL),(273,52,8.8,'2018-04-11 00:33:31.368194',NULL),(274,52,8.8,'2018-04-11 00:33:32.404711',NULL),(275,52,8.8,'2018-04-11 00:33:33.451672',NULL),(276,52,8.8,'2018-04-11 00:33:34.490919',NULL),(277,52,8.8,'2018-04-11 00:33:35.516005',NULL),(278,52,8.8,'2018-04-11 00:33:36.549963',NULL),(279,52,8.8,'2018-04-11 00:33:37.582328',NULL),(280,52,8.8,'2018-04-11 00:33:38.622693',NULL),(281,52,8.8,'2018-04-11 00:33:39.684601',NULL),(282,52,8.8,'2018-04-11 00:33:40.769965',NULL),(283,52,8.8,'2018-04-11 00:33:41.828596',NULL),(284,52,8.8,'2018-04-11 00:33:42.885511',NULL),(285,52,8.8,'2018-04-11 00:33:43.916282',NULL),(286,52,8.8,'2018-04-11 00:33:45.023736',NULL),(287,52,8.8,'2018-04-11 00:33:46.069791',NULL),(288,52,8.8,'2018-04-11 00:33:47.126553',NULL),(289,52,8.8,'2018-04-11 00:33:48.157417',NULL),(290,52,8.8,'2018-04-11 00:33:49.185561',NULL),(291,52,8.8,'2018-04-11 00:33:50.216091',NULL),(292,52,8.8,'2018-04-11 00:33:51.243837',NULL),(293,51,8.8,'2018-04-11 00:33:52.371810',NULL),(294,51,8.8,'2018-04-11 00:33:53.399820',NULL),(295,51,8.8,'2018-04-11 00:33:55.738242',NULL),(296,51,8.8,'2018-04-11 00:33:56.784618',NULL),(297,51,8.8,'2018-04-11 00:33:57.834851',NULL),(298,51,8.8,'2018-04-11 00:33:58.895577',NULL),(299,51,8.8,'2018-04-11 00:33:59.954812',NULL),(300,51,8.7,'2018-04-11 00:34:01.008375',NULL),(301,51,8.8,'2018-04-11 00:34:02.055963',NULL),(302,51,8.8,'2018-04-11 00:34:03.119147',NULL),(303,51,8.8,'2018-04-11 00:34:04.186709',NULL),(304,51,8.8,'2018-04-11 00:34:05.238997',NULL),(305,51,8.8,'2018-04-11 00:34:06.287595',NULL),(306,52,8.8,'2018-04-11 00:34:07.323364',NULL),(307,52,8.8,'2018-04-11 00:34:08.356602',NULL),(308,52,8.8,'2018-04-11 00:34:09.395516',NULL),(309,52,8.8,'2018-04-11 00:34:10.431440',NULL),(310,52,8.8,'2018-04-11 00:34:11.476066',NULL),(311,52,8.8,'2018-04-11 00:34:12.522431',NULL),(312,52,8.8,'2018-04-11 00:34:13.549175',NULL),(313,52,8.8,'2018-04-11 00:34:14.584181',NULL),(314,51,8.7,'2018-04-11 00:34:15.629396',NULL),(315,51,8.7,'2018-04-11 00:34:16.685914',NULL),(316,51,8.7,'2018-04-11 00:34:17.734471',NULL),(317,51,8.7,'2018-04-11 00:34:18.765579',NULL),(318,51,8.7,'2018-04-11 00:34:19.794017',NULL),(319,51,8.7,'2018-04-11 00:34:20.839409',NULL),(320,51,8.7,'2018-04-11 00:34:21.903125',NULL),(321,51,8.7,'2018-04-11 00:34:22.964854',NULL),(322,51,8.7,'2018-04-11 00:34:24.021115',NULL),(323,51,8.7,'2018-04-11 00:34:25.073819',NULL),(324,51,8.7,'2018-04-11 00:34:26.123014',NULL),(325,51,8.7,'2018-04-11 00:34:27.166881',NULL),(326,51,8.7,'2018-04-11 00:34:28.240165',NULL),(327,51,8.7,'2018-04-11 00:34:29.293637',NULL),(328,51,8.7,'2018-04-11 00:34:30.350756',NULL),(329,51,8.7,'2018-04-11 00:34:31.393926',NULL),(330,51,8.7,'2018-04-11 00:34:32.449774',NULL),(331,51,8.7,'2018-04-11 00:34:33.518744',NULL),(332,51,8.7,'2018-04-11 00:34:34.572010',NULL),(333,51,8.7,'2018-04-11 00:34:35.648933',NULL),(334,51,8.7,'2018-04-11 00:34:36.695770',NULL),(335,51,8.7,'2018-04-11 00:34:37.737216',NULL),(336,51,8.7,'2018-04-11 00:34:38.770650',NULL),(337,51,8.7,'2018-04-11 00:34:39.809047',NULL),(338,51,8.7,'2018-04-11 00:34:40.837456',NULL),(339,51,8.7,'2018-04-11 00:34:41.912453',NULL),(340,51,8.7,'2018-04-11 00:34:42.966907',NULL),(341,51,8.7,'2018-04-11 00:34:44.008350',NULL),(342,51,8.7,'2018-04-11 00:34:45.098789',NULL),(343,51,8.7,'2018-04-11 00:34:46.307356',NULL),(344,51,8.7,'2018-04-11 00:34:47.695438',NULL),(345,51,8.7,'2018-04-11 00:34:48.753057',NULL),(346,51,8.7,'2018-04-11 00:34:49.837100',NULL),(347,51,8.7,'2018-04-11 00:34:50.910879',NULL),(348,51,8.7,'2018-04-11 00:34:51.962755',NULL),(349,51,8.7,'2018-04-11 00:34:53.014515',NULL),(350,51,8.7,'2018-04-11 00:34:54.065896',NULL),(351,51,8.7,'2018-04-11 00:34:55.120832',NULL),(352,51,8.7,'2018-04-11 00:34:56.174855',NULL),(353,52,8.8,'2018-04-11 00:34:57.216597',NULL),(354,52,8.8,'2018-04-11 00:34:58.262209',NULL),(355,52,8.8,'2018-04-11 00:34:59.325258',NULL),(356,52,8.8,'2018-04-11 00:35:00.435428',NULL),(357,52,8.8,'2018-04-11 00:35:01.479790',NULL),(358,52,8.8,'2018-04-11 00:35:02.557390',NULL),(359,52,8.8,'2018-04-11 00:35:03.585345',NULL),(360,52,8.8,'2018-04-11 00:35:04.614046',NULL),(361,52,8.8,'2018-04-11 00:35:05.658137',NULL),(362,52,8.8,'2018-04-11 00:35:06.691972',NULL),(363,52,8.8,'2018-04-11 00:35:07.749233',NULL),(364,52,8.8,'2018-04-11 00:35:08.806568',NULL),(365,52,8.8,'2018-04-11 00:35:09.877892',NULL),(366,52,8.8,'2018-04-11 00:35:10.942060',NULL),(367,52,8.8,'2018-04-11 00:35:11.999413',NULL),(368,52,8.8,'2018-04-11 00:35:13.047808',NULL),(369,52,8.8,'2018-04-11 00:35:15.263441',NULL),(370,52,8.8,'2018-04-11 00:35:16.297093',NULL),(371,52,8.8,'2018-04-11 00:35:17.354260',NULL),(372,52,8.8,'2018-04-11 00:35:18.471648',NULL),(373,52,8.8,'2018-04-11 00:35:19.507391',NULL),(374,52,8.8,'2018-04-11 00:35:20.550325',NULL),(375,52,8.8,'2018-04-11 00:35:21.598130',NULL),(376,52,8.8,'2018-04-11 00:35:22.637106',NULL),(377,52,8.8,'2018-04-11 00:35:23.673132',NULL),(378,52,8.8,'2018-04-11 00:35:24.723249',NULL),(379,52,8.8,'2018-04-11 00:35:25.758562',NULL),(380,52,8.8,'2018-04-11 00:35:26.797264',NULL),(381,52,8.8,'2018-04-11 00:35:27.847301',NULL),(382,52,8.8,'2018-04-11 00:35:28.884790',NULL),(383,52,8.8,'2018-04-11 00:35:29.946603',NULL),(384,52,8.8,'2018-04-11 00:35:30.999904',NULL),(385,52,8.8,'2018-04-11 00:35:32.187394',NULL),(386,52,8.8,'2018-04-11 00:35:33.244568',NULL),(387,52,8.8,'2018-04-11 00:35:34.273559',NULL),(388,52,8.8,'2018-04-11 00:35:35.304523',NULL),(389,52,8.8,'2018-04-11 00:35:36.389587',NULL),(390,52,8.8,'2018-04-11 00:35:37.466166',NULL),(391,52,8.8,'2018-04-11 00:35:38.498163',NULL),(392,52,8.8,'2018-04-11 00:35:39.548125',NULL),(393,52,8.8,'2018-04-11 00:35:40.593131',NULL),(394,52,8.8,'2018-04-11 00:35:41.638922',NULL),(395,52,8.8,'2018-04-11 00:35:42.680732',NULL),(396,52,8.8,'2018-04-11 00:35:43.722282',NULL),(397,52,8.8,'2018-04-11 00:35:44.754710',NULL),(398,52,8.8,'2018-04-11 00:35:45.807314',NULL),(399,52,8.8,'2018-04-11 00:35:46.855957',NULL),(400,52,8.8,'2018-04-11 00:35:47.919305',NULL),(401,52,8.8,'2018-04-11 00:35:48.960338',NULL),(402,52,8.8,'2018-04-11 00:35:50.000470',NULL),(403,52,8.8,'2018-04-11 00:35:51.147064',NULL),(404,52,8.8,'2018-04-11 00:35:52.178324',NULL),(405,52,8.8,'2018-04-11 00:35:53.207696',NULL),(406,52,8.8,'2018-04-11 00:35:54.235072',NULL),(407,52,8.8,'2018-04-11 00:35:55.262824',NULL),(408,52,8.8,'2018-04-11 00:35:56.310107',NULL),(409,52,8.8,'2018-04-11 00:35:57.437184',NULL),(410,51,8.8,'2018-04-11 00:35:58.468397',NULL),(411,51,8.8,'2018-04-11 00:35:59.539900',NULL),(412,51,8.7,'2018-04-11 00:36:00.587744',NULL),(413,51,8.7,'2018-04-11 00:36:01.626490',NULL),(414,51,8.7,'2018-04-11 00:36:02.703017',NULL),(415,51,8.7,'2018-04-11 00:36:03.765166',NULL),(416,51,8.7,'2018-04-11 00:36:04.832106',NULL),(417,51,8.7,'2018-04-11 00:36:05.883696',NULL),(418,51,8.7,'2018-04-11 00:36:06.923275',NULL),(419,51,8.8,'2018-04-11 00:36:07.987166',NULL),(420,51,8.7,'2018-04-11 00:36:09.037305',NULL),(421,51,8.8,'2018-04-11 00:36:10.089632',NULL),(422,51,8.8,'2018-04-11 00:36:11.144764',NULL),(423,51,8.8,'2018-04-11 00:36:12.189391',NULL),(424,51,8.7,'2018-04-11 00:36:13.250355',NULL),(425,51,8.7,'2018-04-11 00:36:14.306093',NULL),(426,51,8.7,'2018-04-11 00:36:15.364417',NULL),(427,51,8.7,'2018-04-11 00:36:16.425921',NULL),(428,51,8.7,'2018-04-11 00:36:17.466795',NULL),(429,51,8.7,'2018-04-11 00:36:18.506776',NULL),(430,51,8.7,'2018-04-11 00:36:19.556824',NULL),(431,51,8.7,'2018-04-11 00:36:20.604535',NULL),(432,51,8.7,'2018-04-11 00:36:21.678827',NULL),(433,51,8.7,'2018-04-11 00:36:22.747135',NULL),(434,51,8.7,'2018-04-11 00:36:23.861926',NULL),(435,51,8.8,'2018-04-11 00:36:24.925998',NULL),(436,51,8.8,'2018-04-11 00:36:26.487093',NULL),(437,51,8.8,'2018-04-11 00:36:27.752481',NULL),(438,51,8.8,'2018-04-11 00:36:28.799894',NULL),(439,51,8.7,'2018-04-11 00:36:29.855220',NULL),(440,51,8.7,'2018-04-11 00:36:30.914180',NULL),(441,51,8.8,'2018-04-11 00:36:31.969224',NULL),(442,51,8.7,'2018-04-11 00:36:33.062619',NULL),(443,51,8.7,'2018-04-11 00:36:34.120633',NULL),(444,51,8.8,'2018-04-11 00:36:35.189462',NULL),(445,51,8.7,'2018-04-11 00:36:36.241305',NULL),(446,51,8.7,'2018-04-11 00:36:37.294877',NULL),(447,51,8.7,'2018-04-11 00:36:38.353616',NULL),(448,51,8.7,'2018-04-11 00:36:39.409346',NULL),(449,51,8.7,'2018-04-11 00:36:40.467006',NULL),(450,51,8.7,'2018-04-11 00:36:41.522709',NULL),(451,51,8.7,'2018-04-11 00:36:42.550944',NULL);
/*!40000 ALTER TABLE `bearing_memoryinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bearing_opstartenddate`
--

DROP TABLE IF EXISTS `bearing_opstartenddate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bearing_opstartenddate` (
  `opCodeID` int(11) NOT NULL AUTO_INCREMENT,
  `startDate` datetime(6) NOT NULL,
  `endDate` datetime(6) NOT NULL,
  PRIMARY KEY (`opCodeID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bearing_opstartenddate`
--

LOCK TABLES `bearing_opstartenddate` WRITE;
/*!40000 ALTER TABLE `bearing_opstartenddate` DISABLE KEYS */;
INSERT INTO `bearing_opstartenddate` VALUES (1,'2018-04-11 01:34:00.000000','2018-04-11 01:50:00.000000'),(2,'2018-04-11 03:04:00.000000','2018-04-11 03:15:00.000000');
/*!40000 ALTER TABLE `bearing_opstartenddate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bearing_productdepart`
--

DROP TABLE IF EXISTS `bearing_productdepart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bearing_productdepart` (
  `departID` int(11) NOT NULL AUTO_INCREMENT,
  `depatrDes` varchar(100) NOT NULL,
  `personInCharge` varchar(12) NOT NULL,
  `otherInfo` longtext,
  `saveDate` datetime(6) NOT NULL,
  `modDate` datetime(6) NOT NULL,
  `factory_id` int(11) NOT NULL,
  PRIMARY KEY (`departID`),
  KEY `bearing_productdepar_factory_id_f4b0f1ab_fk_bearing_f` (`factory_id`),
  CONSTRAINT `bearing_productdepar_factory_id_f4b0f1ab_fk_bearing_f` FOREIGN KEY (`factory_id`) REFERENCES `bearing_factory` (`factorID`)
) ENGINE=InnoDB AUTO_INCREMENT=100010 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bearing_productdepart`
--

LOCK TABLES `bearing_productdepart` WRITE;
/*!40000 ALTER TABLE `bearing_productdepart` DISABLE KEYS */;
INSERT INTO `bearing_productdepart` VALUES (100001,'生产部1','李慧语','负责试产转向器订单','2018-04-09 02:15:31.017197','2018-04-09 02:15:31.017600',1001),(100002,'生产部2','李芳蔼','负责量产转向器订单','2018-04-09 02:28:01.197072','2018-04-09 02:28:01.200052',1001),(100003,'检查部','李秦淮','负责检查转向器','2018-04-09 02:28:01.202286','2018-04-09 02:28:01.204029',1001),(100004,'生产部1','李箫剑','负责试产机床零部件','2018-04-09 02:58:00.000000','2018-04-09 02:58:49.782954',1002),(100005,'生产部2','李风游','负责量产产机床零部件','2018-04-09 02:58:00.000000','2018-04-09 02:59:05.744913',1002),(100006,'生产部1','李雪海','负责加工生产飞机机翼零部件','2018-04-09 02:59:00.000000','2018-04-09 02:59:30.167215',1003),(100007,'物料部','李志泽','负责接收转向器零部件','2018-04-09 02:59:00.000000','2018-04-09 02:59:46.470337',1004),(100008,'加工部','李文博','负责加工转向器','2018-04-09 02:59:00.000000','2018-04-09 03:00:03.739705',1004),(100009,'组装部','李博文','负责转向器的来料并组装','2018-04-09 03:00:00.000000','2018-04-09 03:01:07.620641',1005);
/*!40000 ALTER TABLE `bearing_productdepart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bearing_profile`
--

DROP TABLE IF EXISTS `bearing_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bearing_profile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phonenumber` varchar(11) NOT NULL,
  `avatar` varchar(100) DEFAULT NULL,
  `gender` int(11) NOT NULL,
  `otherText` longtext,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `bearing_profile_user_id_a4d62636_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bearing_profile`
--

LOCK TABLES `bearing_profile` WRITE;
/*!40000 ALTER TABLE `bearing_profile` DISABLE KEYS */;
INSERT INTO `bearing_profile` VALUES (1,'15622505459','',2,'测试账号！测试！',1),(2,'15622565656','',1,'测试账户！',2);
/*!40000 ALTER TABLE `bearing_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bearing_sensorinfo`
--

DROP TABLE IF EXISTS `bearing_sensorinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bearing_sensorinfo` (
  `sensorID` int(11) NOT NULL AUTO_INCREMENT,
  `saveDate` datetime(6) NOT NULL,
  `modDate` datetime(6) NOT NULL,
  `machine_id` int(11) DEFAULT NULL,
  `dsensorDes` varchar(50) DEFAULT NULL,
  `sensorCode` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`sensorID`),
  KEY `bearing_sensorinfo_machine_id_c1da53d3_fk_bearing_m` (`machine_id`),
  CONSTRAINT `bearing_sensorinfo_machine_id_c1da53d3_fk_bearing_m` FOREIGN KEY (`machine_id`) REFERENCES `bearing_machine` (`machineID`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bearing_sensorinfo`
--

LOCK TABLES `bearing_sensorinfo` WRITE;
/*!40000 ALTER TABLE `bearing_sensorinfo` DISABLE KEYS */;
INSERT INTO `bearing_sensorinfo` VALUES (1,'2018-04-09 04:39:00.000000','2018-04-09 04:39:39.410758',1,'力信号传感器(X轴)','forceX'),(2,'2018-04-09 04:39:00.000000','2018-04-09 04:39:52.143044',1,'力信号传感器(Y轴)','forceY'),(3,'2018-04-09 04:39:00.000000','2018-04-09 04:40:06.344459',1,'力信号传感器(Z轴)','forceZ'),(4,'2018-04-09 04:40:00.000000','2018-04-09 04:40:21.173740',1,'振动传感器(X轴)','shakeX'),(5,'2018-04-09 04:40:00.000000','2018-04-09 04:40:33.569382',1,'振动传感器(Y轴)','shakeY'),(6,'2018-04-09 04:40:00.000000','2018-04-09 04:40:44.441465',1,'振动传感器(Z轴)','shakeZ'),(7,'2018-04-09 04:40:00.000000','2018-04-09 04:41:04.228623',1,'声发射传感器','acouEmission'),(8,'2018-04-09 04:41:00.000000','2018-04-09 04:41:27.287933',2,'声发射传感器','acouEmission'),(9,'2018-04-09 04:41:00.000000','2018-04-09 04:41:33.458357',2,'力信号传感器(X轴)','forceX'),(10,'2018-04-09 04:41:00.000000','2018-04-09 04:41:41.492379',2,'力信号传感器(Y轴)','forceY'),(11,'2018-04-09 04:41:00.000000','2018-04-09 04:41:51.994561',2,'力信号传感器(Z轴)','forceZ'),(12,'2018-04-09 04:41:00.000000','2018-04-09 04:42:01.955678',3,'振动传感器(X轴)','shakeX'),(13,'2018-04-09 04:42:00.000000','2018-04-09 04:42:13.016894',3,'振动传感器(Y轴)','shakeY'),(14,'2018-04-09 04:42:00.000000','2018-04-09 04:42:27.082604',3,'振动传感器(Z轴)','shakeZ'),(15,'2018-04-09 04:43:00.000000','2018-04-09 04:43:43.732173',4,'声发射传感器','acouEmission'),(16,'2018-04-09 04:43:00.000000','2018-04-09 04:43:50.510631',5,'声发射传感器','acouEmission'),(17,'2018-04-09 04:43:00.000000','2018-04-09 04:43:56.352122',6,'声发射传感器','acouEmission'),(18,'2018-04-09 04:43:00.000000','2018-04-09 04:44:08.683599',6,'声发射传感器','acouEmission'),(19,'2018-04-09 04:44:00.000000','2018-04-09 04:44:15.884747',7,'力信号传感器(X轴)','forceX'),(20,'2018-04-09 04:44:00.000000','2018-04-09 04:44:30.240155',7,'力信号传感器(Y轴)','forceY'),(21,'2018-04-09 04:44:00.000000','2018-04-09 04:44:38.812201',7,'力信号传感器(Z轴)','forceZ'),(22,'2018-04-09 04:44:00.000000','2018-04-09 04:45:29.045249',8,'声发射传感器','acouEmission'),(23,'2018-04-09 04:45:00.000000','2018-04-09 04:45:34.459181',9,'声发射传感器','acouEmission'),(24,'2018-04-09 04:45:00.000000','2018-04-09 04:45:42.275730',10,'声发射传感器','acouEmission'),(25,'2018-04-09 04:45:00.000000','2018-04-09 04:45:49.832994',11,'声发射传感器','acouEmission'),(26,'2018-04-09 04:45:00.000000','2018-04-09 04:45:56.108195',12,'力信号传感器(X轴)','forceX'),(27,'2018-04-09 04:45:00.000000','2018-04-09 04:46:02.010294',12,'力信号传感器(Y轴)','forceY'),(28,'2018-04-09 04:46:00.000000','2018-04-09 04:46:09.612529',12,'力信号传感器(Z轴)','forceZ'),(29,'2018-04-09 04:46:00.000000','2018-04-09 04:46:18.140187',13,'力信号传感器(X轴)','forceX'),(30,'2018-04-09 04:46:00.000000','2018-04-09 04:46:24.076973',13,'力信号传感器(Y轴)','forceY'),(31,'2018-04-09 04:46:00.000000','2018-04-09 04:46:31.746453',13,'力信号传感器(Z轴)','forceZ'),(32,'2018-04-09 04:46:00.000000','2018-04-09 04:46:46.190239',13,'声发射传感器','acouEmission');
/*!40000 ALTER TABLE `bearing_sensorinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bearing_sensorrawdata`
--

DROP TABLE IF EXISTS `bearing_sensorrawdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bearing_sensorrawdata` (
  `sensorID` int(11) NOT NULL AUTO_INCREMENT,
  `sesorValue` double NOT NULL,
  `saveDate` datetime(6) NOT NULL,
  `opStartEnddate_id` int(11) NOT NULL,
  `sensorInfo_id` int(11) NOT NULL,
  PRIMARY KEY (`sensorID`),
  KEY `bearing_sensorrawdat_opStartEnddate_id_3977b7d1_fk_bearing_o` (`opStartEnddate_id`),
  KEY `bearing_sensorrawdat_sensorInfo_id_f1467128_fk_bearing_s` (`sensorInfo_id`),
  CONSTRAINT `bearing_sensorrawdat_opStartEnddate_id_3977b7d1_fk_bearing_o` FOREIGN KEY (`opStartEnddate_id`) REFERENCES `bearing_opstartenddate` (`opCodeID`),
  CONSTRAINT `bearing_sensorrawdat_sensorInfo_id_f1467128_fk_bearing_s` FOREIGN KEY (`sensorInfo_id`) REFERENCES `bearing_sensorinfo` (`sensorID`)
) ENGINE=InnoDB AUTO_INCREMENT=21001 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bearing_sensorrawdata`
--

LOCK TABLES `bearing_sensorrawdata` WRITE;
/*!40000 ALTER TABLE `bearing_sensorrawdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `bearing_sensorrawdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bearing_sensorwaveletdata`
--

DROP TABLE IF EXISTS `bearing_sensorwaveletdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bearing_sensorwaveletdata` (
  `sensorID` int(11) NOT NULL AUTO_INCREMENT,
  `sesorValue` double NOT NULL,
  `saveDate` datetime(6) NOT NULL,
  `opStartEnddate_id` int(11) NOT NULL,
  `sensorInfo_id` int(11) NOT NULL,
  PRIMARY KEY (`sensorID`),
  KEY `bearing_sensorwavele_opStartEnddate_id_bdd383e6_fk_bearing_o` (`opStartEnddate_id`),
  KEY `bearing_sensorwavele_sensorInfo_id_c7968757_fk_bearing_s` (`sensorInfo_id`),
  CONSTRAINT `bearing_sensorwavele_opStartEnddate_id_bdd383e6_fk_bearing_o` FOREIGN KEY (`opStartEnddate_id`) REFERENCES `bearing_opstartenddate` (`opCodeID`),
  CONSTRAINT `bearing_sensorwavele_sensorInfo_id_c7968757_fk_bearing_s` FOREIGN KEY (`sensorInfo_id`) REFERENCES `bearing_sensorinfo` (`sensorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bearing_sensorwaveletdata`
--

LOCK TABLES `bearing_sensorwaveletdata` WRITE;
/*!40000 ALTER TABLE `bearing_sensorwaveletdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `bearing_sensorwaveletdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=168 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2018-04-09 01:58:55.096346','1','caper911',2,'[{\"changed\": {\"fields\": [\"first_name\", \"last_login\"]}}, {\"changed\": {\"name\": \"profile\", \"object\": \"Profile object\", \"fields\": [\"phonenumber\", \"gender\", \"otherText\"]}}]',4,1),(2,'2018-04-09 02:39:05.509307','1001','factory object',1,'[{\"added\": {}}]',9,1),(3,'2018-04-09 02:39:25.646325','1001','factory object',2,'[]',9,1),(4,'2018-04-09 02:40:54.386729','1001','factory object',1,'[{\"added\": {}}]',9,1),(5,'2018-04-09 02:47:48.246868','1002','factory object',1,'[{\"added\": {}}]',9,1),(6,'2018-04-09 02:53:07.620319','1003','factory object',1,'[{\"added\": {}}]',9,1),(7,'2018-04-09 02:53:41.589607','1004','factory object',1,'[{\"added\": {}}]',9,1),(8,'2018-04-09 02:54:11.727713','1005','factory object',1,'[{\"added\": {}}]',9,1),(9,'2018-04-09 02:58:49.783631','100004','生产部1',1,'[{\"added\": {}}]',14,1),(10,'2018-04-09 02:59:05.745462','100005','生产部2',1,'[{\"added\": {}}]',14,1),(11,'2018-04-09 02:59:30.167853','100006','生产部1',1,'[{\"added\": {}}]',14,1),(12,'2018-04-09 02:59:46.470814','100007','物料部',1,'[{\"added\": {}}]',14,1),(13,'2018-04-09 03:00:03.740211','100008','加工部',1,'[{\"added\": {}}]',14,1),(14,'2018-04-09 03:01:07.621142','100009','组装部',1,'[{\"added\": {}}]',14,1),(15,'2018-04-09 04:07:19.659261','1','machine object',1,'[{\"added\": {}}]',11,1),(16,'2018-04-09 04:08:01.227001','2','machine object',1,'[{\"added\": {}}]',11,1),(17,'2018-04-09 04:08:19.608636','3','machine object',1,'[{\"added\": {}}]',11,1),(18,'2018-04-09 04:31:11.532397','4','生产部2龙门铣床1001',1,'[{\"added\": {}}]',11,1),(19,'2018-04-09 04:31:37.749066','5','生产部1升降台铣床0001',1,'[{\"added\": {}}]',11,1),(20,'2018-04-09 04:31:46.406112','5','生产部1升降台铣床1001',2,'[{\"changed\": {\"fields\": [\"machineDes\"]}}]',11,1),(21,'2018-04-09 04:32:13.506969','5','生产部1升降台铣床1001',2,'[]',11,1),(22,'2018-04-09 04:32:49.286262','6','检查部仪表铣床1001',1,'[{\"added\": {}}]',11,1),(23,'2018-04-09 04:33:15.562550','7','生产部2工具铣床1001',1,'[{\"added\": {}}]',11,1),(24,'2018-04-09 04:33:22.328168','8','生产部1工具铣床1001',1,'[{\"added\": {}}]',11,1),(25,'2018-04-09 04:33:37.277878','9','物料部工具铣床1002',1,'[{\"added\": {}}]',11,1),(26,'2018-04-09 04:33:45.651158','10','组装部工具铣床1001',1,'[{\"added\": {}}]',11,1),(27,'2018-04-09 04:33:59.461657','11','加工部切割铣床1001',1,'[{\"added\": {}}]',11,1),(28,'2018-04-09 04:34:08.389912','12','加工部切割铣床1002',1,'[{\"added\": {}}]',11,1),(29,'2018-04-09 04:34:19.595728','13','生产部1冲压铣床1001',1,'[{\"added\": {}}]',11,1),(30,'2018-04-09 04:39:39.411272','1','sensorInfo object',1,'[{\"added\": {}}]',16,1),(31,'2018-04-09 04:39:52.143571','2','sensorInfo object',1,'[{\"added\": {}}]',16,1),(32,'2018-04-09 04:40:06.344985','3','sensorInfo object',1,'[{\"added\": {}}]',16,1),(33,'2018-04-09 04:40:21.174239','4','sensorInfo object',1,'[{\"added\": {}}]',16,1),(34,'2018-04-09 04:40:33.569866','5','sensorInfo object',1,'[{\"added\": {}}]',16,1),(35,'2018-04-09 04:40:44.442122','6','sensorInfo object',1,'[{\"added\": {}}]',16,1),(36,'2018-04-09 04:41:04.229281','7','sensorInfo object',1,'[{\"added\": {}}]',16,1),(37,'2018-04-09 04:41:27.288480','8','sensorInfo object',1,'[{\"added\": {}}]',16,1),(38,'2018-04-09 04:41:33.459437','9','sensorInfo object',1,'[{\"added\": {}}]',16,1),(39,'2018-04-09 04:41:41.493001','10','sensorInfo object',1,'[{\"added\": {}}]',16,1),(40,'2018-04-09 04:41:51.995801','11','sensorInfo object',1,'[{\"added\": {}}]',16,1),(41,'2018-04-09 04:42:01.956102','12','sensorInfo object',1,'[{\"added\": {}}]',16,1),(42,'2018-04-09 04:42:13.017657','13','sensorInfo object',1,'[{\"added\": {}}]',16,1),(43,'2018-04-09 04:42:27.083112','14','sensorInfo object',1,'[{\"added\": {}}]',16,1),(44,'2018-04-09 04:43:43.732766','15','声发射传感器',1,'[{\"added\": {}}]',16,1),(45,'2018-04-09 04:43:50.511059','16','声发射传感器',1,'[{\"added\": {}}]',16,1),(46,'2018-04-09 04:43:56.353439','17','声发射传感器',1,'[{\"added\": {}}]',16,1),(47,'2018-04-09 04:44:08.684010','18','声发射传感器',1,'[{\"added\": {}}]',16,1),(48,'2018-04-09 04:44:15.885160','19','力信号传感器(X轴)',1,'[{\"added\": {}}]',16,1),(49,'2018-04-09 04:44:30.240603','20','力信号传感器(Y轴)',1,'[{\"added\": {}}]',16,1),(50,'2018-04-09 04:44:38.813139','21','力信号传感器(Z轴)',1,'[{\"added\": {}}]',16,1),(51,'2018-04-09 04:45:29.045683','22','声发射传感器',1,'[{\"added\": {}}]',16,1),(52,'2018-04-09 04:45:34.459672','23','声发射传感器',1,'[{\"added\": {}}]',16,1),(53,'2018-04-09 04:45:42.276257','24','声发射传感器',1,'[{\"added\": {}}]',16,1),(54,'2018-04-09 04:45:49.833564','25','声发射传感器',1,'[{\"added\": {}}]',16,1),(55,'2018-04-09 04:45:56.109189','26','力信号传感器(X轴)',1,'[{\"added\": {}}]',16,1),(56,'2018-04-09 04:46:02.011231','27','力信号传感器(Y轴)',1,'[{\"added\": {}}]',16,1),(57,'2018-04-09 04:46:09.613297','28','力信号传感器(Z轴)',1,'[{\"added\": {}}]',16,1),(58,'2018-04-09 04:46:18.140717','29','力信号传感器(X轴)',1,'[{\"added\": {}}]',16,1),(59,'2018-04-09 04:46:24.077377','30','力信号传感器(Y轴)',1,'[{\"added\": {}}]',16,1),(60,'2018-04-09 04:46:31.746843','31','力信号传感器(Z轴)',1,'[{\"added\": {}}]',16,1),(61,'2018-04-09 04:46:46.190758','32','声发射传感器',1,'[{\"added\": {}}]',16,1),(62,'2018-04-10 09:41:04.152702','1','管理员组',1,'[{\"added\": {}}]',3,1),(63,'2018-04-11 01:35:03.362041','1','opStartEnddate object',1,'[{\"added\": {}}]',13,1),(64,'2018-04-11 02:13:01.712159','12307','1.力信号传感器(X轴):1.23',3,'',17,1),(65,'2018-04-11 02:13:01.715176','12306','1.声发射传感器:-0.004',3,'',17,1),(66,'2018-04-11 02:13:01.717296','12305','1.振动传感器(Z轴):-0.008',3,'',17,1),(67,'2018-04-11 02:13:01.719935','12304','1.振动传感器(Y轴):-0.003',3,'',17,1),(68,'2018-04-11 02:13:01.721957','12303','1.振动传感器(X轴):-0.003',3,'',17,1),(69,'2018-04-11 02:13:01.725089','12302','1.力信号传感器(Z轴):1.331',3,'',17,1),(70,'2018-04-11 02:13:01.731641','12301','1.力信号传感器(Y轴):1.96',3,'',17,1),(71,'2018-04-11 02:13:01.735768','12300','1.力信号传感器(X轴):1.259',3,'',17,1),(72,'2018-04-11 02:13:01.740124','12299','1.声发射传感器:-0.004',3,'',17,1),(73,'2018-04-11 02:13:01.742384','12298','1.振动传感器(Z轴):0.021',3,'',17,1),(74,'2018-04-11 02:13:01.745245','12297','1.振动传感器(Y轴):0.024',3,'',17,1),(75,'2018-04-11 02:13:01.748225','12296','1.振动传感器(X轴):0.017',3,'',17,1),(76,'2018-04-11 02:13:01.750944','12295','1.力信号传感器(Z轴):1.34',3,'',17,1),(77,'2018-04-11 02:13:01.753112','12294','1.力信号传感器(Y轴):1.95',3,'',17,1),(78,'2018-04-11 02:13:01.755804','12293','1.力信号传感器(X轴):1.279',3,'',17,1),(79,'2018-04-11 02:13:01.757848','12292','1.声发射传感器:-0.004',3,'',17,1),(80,'2018-04-11 02:13:01.760501','12291','1.振动传感器(Z轴):-0.064',3,'',17,1),(81,'2018-04-11 02:13:01.763542','12290','1.振动传感器(Y轴):-0.067',3,'',17,1),(82,'2018-04-11 02:13:01.766017','12289','1.振动传感器(X轴):-0.063',3,'',17,1),(83,'2018-04-11 02:13:01.769185','12288','1.力信号传感器(Z轴):1.327',3,'',17,1),(84,'2018-04-11 02:13:01.772043','12287','1.力信号传感器(Y轴):1.924',3,'',17,1),(85,'2018-04-11 02:13:01.773937','12286','1.力信号传感器(X轴):1.278',3,'',17,1),(86,'2018-04-11 02:13:01.776476','12285','1.声发射传感器:-0.004',3,'',17,1),(87,'2018-04-11 02:13:01.779101','12284','1.振动传感器(Z轴):-0.029',3,'',17,1),(88,'2018-04-11 02:13:01.781106','12283','1.振动传感器(Y轴):-0.037',3,'',17,1),(89,'2018-04-11 02:13:01.784503','12282','1.振动传感器(X轴):-0.02',3,'',17,1),(90,'2018-04-11 02:13:01.787398','12281','1.力信号传感器(Z轴):1.342',3,'',17,1),(91,'2018-04-11 02:13:01.789713','12280','1.力信号传感器(Y轴):1.92',3,'',17,1),(92,'2018-04-11 02:13:01.792483','12279','1.力信号传感器(X轴):1.308',3,'',17,1),(93,'2018-04-11 02:13:01.795522','12278','1.声发射传感器:-0.004',3,'',17,1),(94,'2018-04-11 02:13:01.797411','12277','1.振动传感器(Z轴):-0.011',3,'',17,1),(95,'2018-04-11 02:13:01.800151','12276','1.振动传感器(Y轴):-0.015',3,'',17,1),(96,'2018-04-11 02:13:01.802425','12275','1.振动传感器(X轴):-0.008',3,'',17,1),(97,'2018-04-11 02:13:01.805077','12274','1.力信号传感器(Z轴):1.358',3,'',17,1),(98,'2018-04-11 02:13:01.807636','12273','1.力信号传感器(Y轴):1.882',3,'',17,1),(99,'2018-04-11 02:13:01.809559','12272','1.力信号传感器(X轴):1.305',3,'',17,1),(100,'2018-04-11 02:13:01.812089','12271','1.声发射传感器:-0.004',3,'',17,1),(101,'2018-04-11 02:13:01.814312','12270','1.振动传感器(Z轴):-0.031',3,'',17,1),(102,'2018-04-11 02:13:01.818617','12269','1.振动传感器(Y轴):-0.03',3,'',17,1),(103,'2018-04-11 02:13:01.821125','12268','1.振动传感器(X轴):-0.048',3,'',17,1),(104,'2018-04-11 02:13:01.823751','12267','1.力信号传感器(Z轴):1.367',3,'',17,1),(105,'2018-04-11 02:13:01.825567','12266','1.力信号传感器(Y轴):1.881',3,'',17,1),(106,'2018-04-11 02:13:01.828166','12265','1.力信号传感器(X轴):1.322',3,'',17,1),(107,'2018-04-11 02:13:01.831172','12264','1.声发射传感器:-0.004',3,'',17,1),(108,'2018-04-11 02:13:01.833345','12263','1.振动传感器(Z轴):-0.133',3,'',17,1),(109,'2018-04-11 02:13:01.836160','12262','1.振动传感器(Y轴):-0.13',3,'',17,1),(110,'2018-04-11 02:13:01.838208','12261','1.振动传感器(X轴):-0.131',3,'',17,1),(111,'2018-04-11 02:13:01.840798','12260','1.力信号传感器(Z轴):1.38',3,'',17,1),(112,'2018-04-11 02:13:01.843358','12259','1.力信号传感器(Y轴):1.927',3,'',17,1),(113,'2018-04-11 02:13:01.846229','12258','1.力信号传感器(X轴):1.342',3,'',17,1),(114,'2018-04-11 02:13:01.849465','12257','1.声发射传感器:-0.004',3,'',17,1),(115,'2018-04-11 02:13:01.852746','12256','1.振动传感器(Z轴):0.026',3,'',17,1),(116,'2018-04-11 02:13:01.855498','12255','1.振动传感器(Y轴):0.032',3,'',17,1),(117,'2018-04-11 02:13:01.857374','12254','1.振动传感器(X轴):0.039',3,'',17,1),(118,'2018-04-11 02:13:01.859896','12253','1.力信号传感器(Z轴):1.385',3,'',17,1),(119,'2018-04-11 02:13:01.861749','12252','1.力信号传感器(Y轴):1.916',3,'',17,1),(120,'2018-04-11 02:13:01.864062','12251','1.力信号传感器(X轴):1.341',3,'',17,1),(121,'2018-04-11 02:13:01.866161','12250','1.声发射传感器:-0.004',3,'',17,1),(122,'2018-04-11 02:13:01.868955','12249','1.振动传感器(Z轴):-0.056',3,'',17,1),(123,'2018-04-11 02:13:01.871536','12248','1.振动传感器(Y轴):-0.056',3,'',17,1),(124,'2018-04-11 02:13:01.873517','12247','1.振动传感器(X轴):-0.055',3,'',17,1),(125,'2018-04-11 02:13:01.876231','12246','1.力信号传感器(Z轴):1.391',3,'',17,1),(126,'2018-04-11 02:13:01.878324','12245','1.力信号传感器(Y轴):1.871',3,'',17,1),(127,'2018-04-11 02:13:01.881629','12244','1.力信号传感器(X轴):1.367',3,'',17,1),(128,'2018-04-11 02:13:01.885475','12243','1.声发射传感器:-0.004',3,'',17,1),(129,'2018-04-11 02:13:01.888132','12242','1.振动传感器(Z轴):-0.043',3,'',17,1),(130,'2018-04-11 02:13:01.890349','12241','1.振动传感器(Y轴):-0.04',3,'',17,1),(131,'2018-04-11 02:13:01.893080','12240','1.振动传感器(X轴):-0.051',3,'',17,1),(132,'2018-04-11 02:13:01.895700','12239','1.力信号传感器(Z轴):1.392',3,'',17,1),(133,'2018-04-11 02:13:01.897742','12238','1.力信号传感器(Y轴):1.827',3,'',17,1),(134,'2018-04-11 02:13:01.900501','12237','1.力信号传感器(X轴):1.394',3,'',17,1),(135,'2018-04-11 02:13:01.903246','12236','1.声发射传感器:-0.004',3,'',17,1),(136,'2018-04-11 02:13:01.905385','12235','1.振动传感器(Z轴):-0.055',3,'',17,1),(137,'2018-04-11 02:13:01.908558','12234','1.振动传感器(Y轴):-0.055',3,'',17,1),(138,'2018-04-11 02:13:01.911577','12233','1.振动传感器(X轴):-0.047',3,'',17,1),(139,'2018-04-11 02:13:01.913796','12232','1.力信号传感器(Z轴):1.395',3,'',17,1),(140,'2018-04-11 02:13:01.916927','12231','1.力信号传感器(Y轴):1.815',3,'',17,1),(141,'2018-04-11 02:13:01.919762','12230','1.力信号传感器(X轴):1.397',3,'',17,1),(142,'2018-04-11 02:13:01.921889','12229','1.声发射传感器:-0.004',3,'',17,1),(143,'2018-04-11 02:13:01.924885','12228','1.振动传感器(Z轴):-0.057',3,'',17,1),(144,'2018-04-11 02:13:01.927743','12227','1.振动传感器(Y轴):-0.055',3,'',17,1),(145,'2018-04-11 02:13:01.931195','12226','1.振动传感器(X轴):-0.056',3,'',17,1),(146,'2018-04-11 02:13:01.934082','12225','1.力信号传感器(Z轴):1.403',3,'',17,1),(147,'2018-04-11 02:13:01.937382','12224','1.力信号传感器(Y轴):1.797',3,'',17,1),(148,'2018-04-11 02:13:01.940223','12223','1.力信号传感器(X轴):1.389',3,'',17,1),(149,'2018-04-11 02:13:01.942256','12222','1.声发射传感器:-0.004',3,'',17,1),(150,'2018-04-11 02:13:01.945066','12221','1.振动传感器(Z轴):-0.016',3,'',17,1),(151,'2018-04-11 02:13:01.948497','12220','1.振动传感器(Y轴):-0.022',3,'',17,1),(152,'2018-04-11 02:13:01.952373','12219','1.振动传感器(X轴):-0.014',3,'',17,1),(153,'2018-04-11 02:13:01.955091','12218','1.力信号传感器(Z轴):1.4',3,'',17,1),(154,'2018-04-11 02:13:01.957083','12217','1.力信号传感器(Y轴):1.728',3,'',17,1),(155,'2018-04-11 02:13:01.959723','12216','1.力信号传感器(X轴):1.356',3,'',17,1),(156,'2018-04-11 02:13:01.961685','12215','1.声发射传感器:-0.004',3,'',17,1),(157,'2018-04-11 02:13:01.964432','12214','1.振动传感器(Z轴):-0.032',3,'',17,1),(158,'2018-04-11 02:13:01.967237','12213','1.振动传感器(Y轴):-0.048',3,'',17,1),(159,'2018-04-11 02:13:01.969142','12212','1.振动传感器(X轴):-0.039',3,'',17,1),(160,'2018-04-11 02:13:01.971670','12211','1.力信号传感器(Z轴):1.393',3,'',17,1),(161,'2018-04-11 02:13:01.973472','12210','1.力信号传感器(Y轴):1.624',3,'',17,1),(162,'2018-04-11 02:13:01.976030','12209','1.力信号传感器(X轴):1.311',3,'',17,1),(163,'2018-04-11 02:13:01.977898','12208','1.声发射传感器:-0.004',3,'',17,1),(164,'2018-04-11 02:53:32.608808','1001','广州番禺制造中心',2,'[{\"changed\": {\"fields\": [\"factorDes\", \"location\", \"otherInfo\"]}}]',9,1),(165,'2018-04-11 03:04:13.904510','2','2018-04-11 11:04:00 - 2018-04-11 11:15:00',1,'[{\"added\": {}}]',13,1),(166,'2018-04-11 07:31:18.909201','1','machineRunTime object',1,'[{\"added\": {}}]',19,1),(167,'2018-04-12 04:41:07.842726','2','切割铣床1001 - 2',1,'[{\"added\": {}}]',19,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(7,'authtoken','token'),(8,'bearing','cpuinfo'),(9,'bearing','factory'),(10,'bearing','ioinfo'),(11,'bearing','machine'),(19,'bearing','machineruntime'),(12,'bearing','memoryinfo'),(13,'bearing','opstartenddate'),(14,'bearing','productdepart'),(15,'bearing','profile'),(16,'bearing','sensorinfo'),(17,'bearing','sensorrawdata'),(18,'bearing','sensorwaveletdata'),(5,'contenttypes','contenttype'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2018-04-09 01:56:34.507775'),(2,'auth','0001_initial','2018-04-09 01:56:34.779752'),(3,'admin','0001_initial','2018-04-09 01:56:34.851171'),(4,'admin','0002_logentry_remove_auto_add','2018-04-09 01:56:34.867719'),(5,'contenttypes','0002_remove_content_type_name','2018-04-09 01:56:34.920516'),(6,'auth','0002_alter_permission_name_max_length','2018-04-09 01:56:34.948823'),(7,'auth','0003_alter_user_email_max_length','2018-04-09 01:56:34.983606'),(8,'auth','0004_alter_user_username_opts','2018-04-09 01:56:34.993212'),(9,'auth','0005_alter_user_last_login_null','2018-04-09 01:56:35.021450'),(10,'auth','0006_require_contenttypes_0002','2018-04-09 01:56:35.024218'),(11,'auth','0007_alter_validators_add_error_messages','2018-04-09 01:56:35.034309'),(12,'auth','0008_alter_user_username_max_length','2018-04-09 01:56:35.065471'),(13,'authtoken','0001_initial','2018-04-09 01:56:35.113551'),(14,'authtoken','0002_auto_20160226_1747','2018-04-09 01:56:35.186074'),(15,'bearing','0001_initial','2018-04-09 01:56:35.731785'),(16,'sessions','0001_initial','2018-04-09 01:56:35.756668'),(17,'bearing','0002_auto_20180409_1046','2018-04-09 02:46:55.973387'),(18,'bearing','0003_auto_20180409_1238','2018-04-09 04:39:00.157709'),(19,'bearing','0004_auto_20180411_0934','2018-04-11 01:34:21.231830'),(20,'bearing','0005_auto_20180411_1056','2018-04-11 02:56:50.451349'),(21,'bearing','0006_machine_opstartenddate','2018-04-11 07:12:37.629875'),(22,'bearing','0007_remove_machine_opstartenddate','2018-04-11 07:14:05.148776'),(23,'bearing','0008_machineruntime','2018-04-11 07:30:22.997813');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('1aisp5gji89gwpeprw7lvfvguw8be8yz','N2FjM2I0Mzg2YjRjM2VjMDFkZWVmM2UxNDlmMzBmMWJiN2JkZTAxMDp7IlZlckNvZGVLZXkiOiIzMkVUIiwidXNlcm5hbWUiOiJjYXBlcjkxMSIsInBob25lbnVtYmVyIjoiMTU2MjI1MDU0NTkiLCJuYW1lIjoiXHU1ZWQ2XHU1ZWZhXHU5NTBiIiwiZ2VuZGVyIjoyLCJvdGhlclRleHQiOiJcdTZkNGJcdThiZDVcdThkMjZcdTUzZjdcdWZmMDFcdTZkNGJcdThiZDVcdWZmMDEiLCJlbWFpbCI6IkNhcGVyOTExQG91dGxvb2suY29tIiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjgzNjk3YjQyNDI4OWE5MDg0NzA0YTA3NDVhMzI1ODRlMmNjNDhjZjEifQ==','2018-04-25 10:19:28.865853'),('4ydgdw4ttsc2u679ochviczvcdvohe3l','Mjg2YmQ2MzMwYWIyNWQ1YTNjZmJlMWNmMTUwNmRhYTNlODU3ZDM0NTp7IlZlckNvZGVLZXkiOiJIUDBaIiwidXNlcm5hbWUiOiJjYXBlcjkxMSIsInBob25lbnVtYmVyIjoiMTU2MjI1MDU0NTkiLCJuYW1lIjoiXHU1ZWQ2XHU1ZWZhXHU5NTBiIiwiZ2VuZGVyIjoyLCJvdGhlclRleHQiOiJcdTZkNGJcdThiZDVcdThkMjZcdTUzZjdcdWZmMDFcdTZkNGJcdThiZDVcdWZmMDEiLCJlbWFpbCI6IkNhcGVyOTExQG91dGxvb2suY29tIiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjgzNjk3YjQyNDI4OWE5MDg0NzA0YTA3NDVhMzI1ODRlMmNjNDhjZjEifQ==','2018-04-26 08:57:26.227766'),('58xn81la1gi1yg6lc3n5yllxs07er4uu','Y2I5NjY2N2M3MjJiNTRjOTU2ZGViNWI5ZjUyZWQ1ZWM5N2RhOWFmNTp7IlZlckNvZGVLZXkiOiI0WE1FIiwidXNlcm5hbWUiOiJjYXBlcjkxMSIsInBob25lbnVtYmVyIjoiMTU2MjI1MDU0NTkiLCJuYW1lIjoiXHU1ZWQ2XHU1ZWZhXHU5NTBiIiwiZ2VuZGVyIjoyLCJvdGhlclRleHQiOiJcdTZkNGJcdThiZDVcdThkMjZcdTUzZjdcdWZmMDFcdTZkNGJcdThiZDVcdWZmMDEiLCJlbWFpbCI6IkNhcGVyOTExQG91dGxvb2suY29tIiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjgzNjk3YjQyNDI4OWE5MDg0NzA0YTA3NDVhMzI1ODRlMmNjNDhjZjEifQ==','2018-04-25 10:14:12.580425'),('5rhfwvxrnxiub5wew13k3379z9uzsrto','Y2YwNjA5YWQxYWY1ZTRmZjc1ZTMxMDI4ODNhMTcwMDk3NmJjMzQxOTp7IlZlckNvZGVLZXkiOiI3QUlMIiwidXNlcm5hbWUiOiJjYXBlcjkxMTEiLCJwaG9uZW51bWJlciI6IjE1NjIyNTY1NjU2IiwibmFtZSI6IiIsIm90aGVyVGV4dCI6bnVsbCwiZW1haWwiOiJjYXBlcjkxMUBvdXRsb29rLmNvbW0iLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYjg2NDgxZmQzMDBmZTk1ZmJiMzIyOTA5NTk2YzUzMWNiZDBmZmNmMSJ9','2018-04-24 02:21:09.267421'),('6impcag703svhx6eexvd2tlextmipn9t','YTViYjI4YjZkZDczYWE4NTRkY2RlMmEwMjVkYjExZTFlNjkxYWY0MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4MzY5N2I0MjQyODlhOTA4NDcwNGEwNzQ1YTMyNTg0ZTJjYzQ4Y2YxIn0=','2018-04-24 09:39:28.682487'),('7wbw38hsdzn1ia4c3i46yhj2yqitad64','YzQ2ZTg1OTFiMGZlY2Q2Mzg3NjZmYWVmZDA5MzA2ZDFjZjdhMDUyOTp7IlZlckNvZGVLZXkiOiJHUFJMIn0=','2018-04-24 02:44:17.193502'),('b5tg92hfr8ib46enoinyr0jiw9dn7j1k','MWM4OWViMDBhYzRhZTRjMDYwZmQzOWFhNjVhMmNlMjA1YjFmN2UzODp7IlZlckNvZGVLZXkiOiJSQzQyIiwidXNlcm5hbWUiOiJjYXBlcjkxMSIsInBob25lbnVtYmVyIjoiMTU2MjI1MDU0NTkiLCJuYW1lIjoiXHU1ZWQ2XHU1ZWZhXHU5NTBiIiwiZ2VuZGVyIjoyLCJvdGhlclRleHQiOiJcdTZkNGJcdThiZDVcdThkMjZcdTUzZjdcdWZmMDFcdTZkNGJcdThiZDVcdWZmMDEiLCJlbWFpbCI6IkNhcGVyOTExQG91dGxvb2suY29tIiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjgzNjk3YjQyNDI4OWE5MDg0NzA0YTA3NDVhMzI1ODRlMmNjNDhjZjEifQ==','2018-04-26 08:58:42.499348'),('eygch0l60hr2yjmn2xe1b33d2eok5yln','NzNkM2EyYmViZTkxZjM1ZTAzZDIyNTBjNTM3ZTBiN2JlZTBlMTg5Njp7IlZlckNvZGVLZXkiOiJUSFY3IiwidXNlcm5hbWUiOiJjYXBlcjkxMTEiLCJwaG9uZW51bWJlciI6IjE1NjIyNTY1NjU2IiwibmFtZSI6IiIsIm90aGVyVGV4dCI6bnVsbCwiZW1haWwiOiJjYXBlcjkxMUBvdXRsb29rLmNvbW0iLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYjg2NDgxZmQzMDBmZTk1ZmJiMzIyOTA5NTk2YzUzMWNiZDBmZmNmMSJ9','2018-04-24 02:25:16.467471'),('g5ju5h4gjc6hi030a4wiyjx9q7el6xjc','ZDgyMTU1MTU2ZDYzOGM0ZjdhNGQ5MWI5ZjBiMjQ0ZmM4ZjY1Nzg4Nzp7IlZlckNvZGVLZXkiOiJITTY5In0=','2018-04-24 02:34:52.999019'),('hhuf3vg1h2cvcmumb61c6934bmt7h34v','OGU4Yzc3YTAyMWY0NGU1Zjc3NTIzY2Y5YjBiYWI0YjQzMjJlYWZiOTp7IlZlckNvZGVLZXkiOiI2TkwwIiwidXNlcm5hbWUiOiJjYXBlcjkxMSIsInBob25lbnVtYmVyIjoiMTU2MjI1MDU0NTkiLCJuYW1lIjoiXHU1ZWQ2XHU1ZWZhXHU5NTBiIiwiZ2VuZGVyIjoyLCJvdGhlclRleHQiOiJcdTZkNGJcdThiZDVcdThkMjZcdTUzZjdcdWZmMDFcdTZkNGJcdThiZDVcdWZmMDEiLCJlbWFpbCI6IkNhcGVyOTExQG91dGxvb2suY29tIiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjgzNjk3YjQyNDI4OWE5MDg0NzA0YTA3NDVhMzI1ODRlMmNjNDhjZjEifQ==','2018-04-25 00:16:15.729479'),('ka4exm0oatvlfa2w3qb3y2jqtb26d81x','MTZjYTdiMTg5YTc1MDJhZjI3N2YzYzIxNDA5ODMwOWNiZDBhMmQ2ZDp7IlZlckNvZGVLZXkiOiJaN0MyIiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjgzNjk3YjQyNDI4OWE5MDg0NzA0YTA3NDVhMzI1ODRlMmNjNDhjZjEifQ==','2018-04-23 14:39:11.773464'),('psf75pd623wncms2a3vz6duk1d9u0pyn','ZTYwOTYwYTA2YjA0MzlhOTBiYjE0OGViZTIyMTdiODgxNzQzYWZhZjp7IlZlckNvZGVLZXkiOiJLRkxYIiwidXNlcm5hbWUiOiJjYXBlcjkxMTEiLCJwaG9uZW51bWJlciI6IjE1NjIyNTY1NjU2IiwibmFtZSI6IiIsIm90aGVyVGV4dCI6bnVsbCwiZW1haWwiOiJjYXBlcjkxMUBvdXRsb29rLmNvbW0iLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYjg2NDgxZmQzMDBmZTk1ZmJiMzIyOTA5NTk2YzUzMWNiZDBmZmNmMSJ9','2018-04-24 02:20:03.349087'),('r9i67eqas3h8xlx0yi9l3klb20uuu7pt','ZmQ4MzI1MWNjOTZiOTRjNzExNDQ3MmRkYzBlMDk0MjRhY2M0NWYzOTp7IlZlckNvZGVLZXkiOiJNQjZHIiwidXNlcm5hbWUiOiJjYXBlcjkxMTEiLCJwaG9uZW51bWJlciI6IjE1NjIyNTY1NjU2IiwibmFtZSI6Ilx1NWVkNlx1NmQ0Ylx1OGJkNSIsIm90aGVyVGV4dCI6Ilx1NmQ0Ylx1OGJkNVx1OGQyNlx1NjIzN1x1ZmYwMSIsImVtYWlsIjoiY2FwZXI5MTFAb3V0bG9vay5jb21tIiwiX2F1dGhfdXNlcl9pZCI6IjIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImI4NjQ4MWZkMzAwZmU5NWZiYjMyMjkwOTU5NmM1MzFjYmQwZmZjZjEifQ==','2018-04-24 03:07:40.932245'),('ub4qe9q7il938a4r4ikvbz0rib3g7zd4','OWNiMjA1YzVmMjliMDYzYjg0NDUzZGNhMDU0NTA3OTljMDVjYzM4ZDp7IlZlckNvZGVLZXkiOiJEWENOIiwidXNlcm5hbWUiOiJjYXBlcjkxMTEiLCJwaG9uZW51bWJlciI6IjE1NjIyNTY1NjU2IiwibmFtZSI6IiIsIm90aGVyVGV4dCI6bnVsbCwiZW1haWwiOiJjYXBlcjkxMUBvdXRsb29rLmNvbW0iLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYjg2NDgxZmQzMDBmZTk1ZmJiMzIyOTA5NTk2YzUzMWNiZDBmZmNmMSJ9','2018-04-24 02:47:30.511446'),('xou25ybean88pbbekt92n4tclcmk23n9','MmU5Nzc0NWJkNWJiOGI5MDcwMTQzYTdmNjE5ODZiOTY4NTI2ZmQ0Zjp7IlZlckNvZGVLZXkiOiJSTTA2IiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjgzNjk3YjQyNDI4OWE5MDg0NzA0YTA3NDVhMzI1ODRlMmNjNDhjZjEifQ==','2018-04-23 12:21:22.407809'),('yji2rqo2yl04svgrty8maxnws5t87mp8','M2ViYTg5OWMwMTRlNGY4ODc1YTAzMjE2NTJiZjc1ZWViODAxMzQwZDp7IlZlckNvZGVLZXkiOiJNN0JJIn0=','2018-04-24 02:33:03.840593'),('zkaqyu729stw243cfi2boc3qjbds7y8d','NzMxMjE0YWUyNGYxNDA3ZjhiY2Y5M2JjMWE0ZDZjYjViOWQ1NTI0MDp7IlZlckNvZGVLZXkiOiJTTUhYIiwidXNlcm5hbWUiOiJjYXBlcjkxMTEiLCJwaG9uZW51bWJlciI6IjE1NjIyNTY1NjU2IiwibmFtZSI6IiIsIm90aGVyVGV4dCI6bnVsbCwiZW1haWwiOiJjYXBlcjkxMUBvdXRsb29rLmNvbW0iLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYjg2NDgxZmQzMDBmZTk1ZmJiMzIyOTA5NTk2YzUzMWNiZDBmZmNmMSJ9','2018-04-24 02:45:38.224011'),('zo5q7c9n5ys1rjeeb3ime0s3ndk2y4ey','ODA5NmZjYzliN2MxYjllM2NjODk1NjJkMjY4NzY0YzQ5NjVlNGVmOTp7IlZlckNvZGVLZXkiOiI3U0VRIiwidXNlcm5hbWUiOiJjYXBlcjkxMTEiLCJwaG9uZW51bWJlciI6IjE1NjIyNTY1NjU2IiwibmFtZSI6IiIsIm90aGVyVGV4dCI6bnVsbCwiZW1haWwiOiJjYXBlcjkxMUBvdXRsb29rLmNvbW0iLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYjg2NDgxZmQzMDBmZTk1ZmJiMzIyOTA5NTk2YzUzMWNiZDBmZmNmMSJ9','2018-04-24 02:24:32.361554');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-04-12 17:21:28