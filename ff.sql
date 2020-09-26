CREATE DATABASE  IF NOT EXISTS `vmart` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `vmart`;
-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: vmart
-- ------------------------------------------------------
-- Server version	8.0.19

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
-- Table structure for table `account_emailaddress`
--

DROP TABLE IF EXISTS `account_emailaddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_emailaddress` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(254) NOT NULL,
  `verified` tinyint(1) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `account_emailaddress_user_id_2c513194_fk_auth_user_id` (`user_id`),
  CONSTRAINT `account_emailaddress_user_id_2c513194_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_emailaddress`
--

LOCK TABLES `account_emailaddress` WRITE;
/*!40000 ALTER TABLE `account_emailaddress` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_emailaddress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_emailconfirmation`
--

DROP TABLE IF EXISTS `account_emailconfirmation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_emailconfirmation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `sent` datetime(6) DEFAULT NULL,
  `key` varchar(64) NOT NULL,
  `email_address_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`),
  KEY `account_emailconfirm_email_address_id_5b7f8c58_fk_account_e` (`email_address_id`),
  CONSTRAINT `account_emailconfirm_email_address_id_5b7f8c58_fk_account_e` FOREIGN KEY (`email_address_id`) REFERENCES `account_emailaddress` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_emailconfirmation`
--

LOCK TABLES `account_emailconfirmation` WRITE;
/*!40000 ALTER TABLE `account_emailconfirmation` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_emailconfirmation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add address',1,'add_address'),(2,'Can change address',1,'change_address'),(3,'Can delete address',1,'delete_address'),(4,'Can view address',1,'view_address'),(5,'Can add category',2,'add_category'),(6,'Can change category',2,'change_category'),(7,'Can delete category',2,'delete_category'),(8,'Can view category',2,'view_category'),(9,'Can add coupon',3,'add_coupon'),(10,'Can change coupon',3,'change_coupon'),(11,'Can delete coupon',3,'delete_coupon'),(12,'Can view coupon',3,'view_coupon'),(13,'Can add item',4,'add_item'),(14,'Can change item',4,'change_item'),(15,'Can delete item',4,'delete_item'),(16,'Can view item',4,'view_item'),(17,'Can add order',5,'add_order'),(18,'Can change order',5,'change_order'),(19,'Can delete order',5,'delete_order'),(20,'Can view order',5,'view_order'),(21,'Can add slider',6,'add_slider'),(22,'Can change slider',6,'change_slider'),(23,'Can delete slider',6,'delete_slider'),(24,'Can view slider',6,'view_slider'),(25,'Can add user profile',7,'add_userprofile'),(26,'Can change user profile',7,'change_userprofile'),(27,'Can delete user profile',7,'delete_userprofile'),(28,'Can view user profile',7,'view_userprofile'),(29,'Can add refund',8,'add_refund'),(30,'Can change refund',8,'change_refund'),(31,'Can delete refund',8,'delete_refund'),(32,'Can view refund',8,'view_refund'),(33,'Can add payment',9,'add_payment'),(34,'Can change payment',9,'change_payment'),(35,'Can delete payment',9,'delete_payment'),(36,'Can view payment',9,'view_payment'),(37,'Can add order item',10,'add_orderitem'),(38,'Can change order item',10,'change_orderitem'),(39,'Can delete order item',10,'delete_orderitem'),(40,'Can view order item',10,'view_orderitem'),(41,'Can add log entry',11,'add_logentry'),(42,'Can change log entry',11,'change_logentry'),(43,'Can delete log entry',11,'delete_logentry'),(44,'Can view log entry',11,'view_logentry'),(45,'Can add permission',12,'add_permission'),(46,'Can change permission',12,'change_permission'),(47,'Can delete permission',12,'delete_permission'),(48,'Can view permission',12,'view_permission'),(49,'Can add group',13,'add_group'),(50,'Can change group',13,'change_group'),(51,'Can delete group',13,'delete_group'),(52,'Can view group',13,'view_group'),(53,'Can add user',14,'add_user'),(54,'Can change user',14,'change_user'),(55,'Can delete user',14,'delete_user'),(56,'Can view user',14,'view_user'),(57,'Can add content type',15,'add_contenttype'),(58,'Can change content type',15,'change_contenttype'),(59,'Can delete content type',15,'delete_contenttype'),(60,'Can view content type',15,'view_contenttype'),(61,'Can add session',16,'add_session'),(62,'Can change session',16,'change_session'),(63,'Can delete session',16,'delete_session'),(64,'Can view session',16,'view_session'),(65,'Can add site',17,'add_site'),(66,'Can change site',17,'change_site'),(67,'Can delete site',17,'delete_site'),(68,'Can view site',17,'view_site'),(69,'Can add email address',18,'add_emailaddress'),(70,'Can change email address',18,'change_emailaddress'),(71,'Can delete email address',18,'delete_emailaddress'),(72,'Can view email address',18,'view_emailaddress'),(73,'Can add email confirmation',19,'add_emailconfirmation'),(74,'Can change email confirmation',19,'change_emailconfirmation'),(75,'Can delete email confirmation',19,'delete_emailconfirmation'),(76,'Can view email confirmation',19,'view_emailconfirmation'),(77,'Can add social account',20,'add_socialaccount'),(78,'Can change social account',20,'change_socialaccount'),(79,'Can delete social account',20,'delete_socialaccount'),(80,'Can view social account',20,'view_socialaccount'),(81,'Can add social application',21,'add_socialapp'),(82,'Can change social application',21,'change_socialapp'),(83,'Can delete social application',21,'delete_socialapp'),(84,'Can view social application',21,'view_socialapp'),(85,'Can add social application token',22,'add_socialtoken'),(86,'Can change social application token',22,'change_socialtoken'),(87,'Can delete social application token',22,'delete_socialtoken'),(88,'Can view social application token',22,'view_socialtoken'),(89,'Can add retailer',23,'add_retailer'),(90,'Can change retailer',23,'change_retailer'),(91,'Can delete retailer',23,'delete_retailer'),(92,'Can view retailer',23,'view_retailer');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$150000$0j15NLYgVSr2$GUzzy5uPWNs6XbA1VwrjY5r0F5Pzr5ZyRVCqVUBRwyU=','2020-06-07 05:31:08.521453',1,'Ravi','','','',1,1,'2020-02-18 20:28:46.495288'),(3,'pbkdf2_sha256$150000$5dapONyPT6o3$pYW/IRIyLkKATC72dTzhHp1qm7unMg0XVapxdZpxoh4=','2020-06-01 07:28:24.311930',1,'admin','','','',1,1,'2020-03-24 04:56:23.644305'),(4,'pbkdf2_sha256$150000$aVTUga4xZrlZ$8sRrBbWra2YxNmzQBbZwkzkIwLbVxAvv6Il4/nEdnNU=','2020-05-24 20:11:54.911255',0,'test','Anurag','Goyal','ravishankersingh.tfl@gmail.com',1,1,'2020-05-24 20:04:22.000000');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
INSERT INTO `auth_user_user_permissions` VALUES (1,4,5),(4,4,8),(5,4,9),(6,4,10),(7,4,11),(8,4,12),(9,4,13),(12,4,16),(13,4,17),(14,4,18),(15,4,19),(16,4,20),(17,4,21),(18,4,22),(19,4,23),(20,4,24),(21,4,25),(22,4,26),(23,4,27),(24,4,28),(25,4,29),(26,4,30),(27,4,31),(28,4,32),(29,4,33),(30,4,34),(31,4,35),(32,4,36),(33,4,37),(34,4,38),(35,4,39),(36,4,40);
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2020-02-18 20:29:37.380154','1','Men',1,'[{\"added\": {}}]',2,1),(2,'2020-02-18 20:29:44.175938','2','Women',1,'[{\"added\": {}}]',2,1),(3,'2020-02-18 20:30:00.454661','3','Kids',1,'[{\"added\": {}}]',2,1),(4,'2020-02-18 20:38:07.599349','1','1 of NIKE FREE RN 2019 ID',1,'[{\"added\": {}}]',4,1),(5,'2020-02-18 20:38:45.840919','2','2 of NIKE FREE RN 2019 ID',1,'[{\"added\": {}}]',4,1),(6,'2020-02-18 20:39:32.987881','3','3 of NIKE FREE RN 2019 ID',1,'[{\"added\": {}}]',4,1),(7,'2020-02-18 20:40:35.821453','4','4 of NIKE FREE RN 2019 ID',1,'[{\"added\": {}}]',4,1),(8,'2020-02-18 20:41:08.766714','5','5 of NIKE FREE RN 2019 ID',1,'[{\"added\": {}}]',4,1),(9,'2020-02-18 20:41:50.765173','6','6 of NIKE FREE RN 2019 ID',1,'[{\"added\": {}}]',4,1),(10,'2020-02-18 20:42:21.583721','7','7 of NIKE FREE RN 2019 ID',1,'[{\"added\": {}}]',4,1),(11,'2020-02-18 20:43:12.018088','8','8 of NIKE FREE RN 2019 ID',1,'[{\"added\": {}}]',4,1),(12,'2020-02-18 20:44:31.412011','1','Shoes Collection 2019 is 1 ',1,'[{\"added\": {}}]',6,1),(13,'2020-02-18 20:44:43.777321','2','Shoes Collection 2019 is 2 ',1,'[{\"added\": {}}]',6,1),(14,'2020-02-18 20:53:31.698351','4','Women -> shoes',1,'[{\"added\": {}}]',2,1),(15,'2020-02-18 20:54:01.355808','1','1 of NIKE FREE RN 2019 ID',2,'[{\"changed\": {\"fields\": [\"product_category\"]}}]',4,1),(16,'2020-02-19 15:46:05.593632','1','1 of NIKE FREE RN 2019 ID',3,'',10,1),(17,'2020-02-19 17:55:09.360931','4','NIKE FREE RN 2019 ID No. of quantity : 3',3,'',10,1),(18,'2020-02-19 17:55:09.709961','3','NIKE FREE RN 2019 ID No. of quantity : 1',3,'',10,1),(19,'2020-02-19 17:55:09.849929','2','NIKE FREE RN 2019 ID No. of quantity : 1',3,'',10,1),(20,'2020-02-23 09:48:16.558717','2','Shoes Collection 2019 is 2 ',3,'',6,1),(21,'2020-02-23 09:48:46.745470','3','Shoes Collection 2019 is 3 ',1,'[{\"added\": {}}]',6,1),(22,'2020-02-24 06:21:38.664548','2','ravi_S',1,'[{\"added\": {}}]',14,1),(23,'2020-02-24 06:22:48.706836','2','ravi_S',2,'[{\"changed\": {\"fields\": [\"is_superuser\"]}}]',14,1),(24,'2020-02-24 06:29:21.605887','3','Shoes Collection 2019 is 3 ',2,'[{\"changed\": {\"fields\": [\"slider_image\"]}}]',6,1),(25,'2020-02-24 06:29:50.332879','3','Shoes Collection 2019 is 3 ',2,'[{\"changed\": {\"fields\": [\"slider_image\"]}}]',6,1),(26,'2020-02-24 06:31:59.658509','3','Shoes Collection 2019 is 3 ',2,'[{\"changed\": {\"fields\": [\"slider_image\"]}}]',6,1),(27,'2020-02-24 09:48:16.110447','8','8 of NIKE FREE RN 2019 ID',2,'[{\"changed\": {\"fields\": [\"product_category\"]}}]',4,1),(28,'2020-02-25 11:08:23.167777','5','Men -> Tshirt',1,'[{\"added\": {}}]',2,1),(29,'2020-03-24 09:41:42.631440','6','6 of NIKE FREE RN 2019 ID',2,'[{\"changed\": {\"fields\": [\"product_category\"]}}]',4,3),(30,'2020-05-06 17:40:29.580068','5','Men -> Tshirt',3,'',2,1),(31,'2020-05-06 17:40:29.999821','4','Women -> shoes',3,'',2,1),(32,'2020-05-06 17:40:30.349620','3','Kids',3,'',2,1),(33,'2020-05-06 17:40:30.951275','2','Women',3,'',2,1),(34,'2020-05-06 17:40:31.261097','1','Men',3,'',2,1),(35,'2020-05-06 17:41:16.097194','6','Men',1,'[{\"added\": {}}]',2,1),(36,'2020-05-06 17:41:28.909647','7','Women',1,'[{\"added\": {}}]',2,1),(37,'2020-05-06 17:41:38.937520','8','Kids',1,'[{\"added\": {}}]',2,1),(38,'2020-05-06 17:42:37.089416','9','Men -> Shoe',1,'[{\"added\": {}}]',2,1),(39,'2020-05-06 17:43:45.721593','10','Women -> lady Shoe',1,'[{\"added\": {}}]',2,1),(40,'2020-05-06 17:44:41.048033','9','Men -> Man Shoe',2,'[{\"changed\": {\"fields\": [\"name\"]}}]',2,1),(41,'2020-05-06 17:44:53.515379','9','Men -> Men Shoe',2,'[{\"changed\": {\"fields\": [\"name\"]}}]',2,1),(42,'2020-05-06 18:20:11.281950','11','Women -> lady Running Shoe',1,'[{\"added\": {}}]',2,1),(43,'2020-05-06 18:21:04.938454','12','Women -> lady Party Wear Shoe',1,'[{\"added\": {}}]',2,1),(44,'2020-05-09 16:15:50.734073','10','Women -> lady Shoe',3,'',2,1),(45,'2020-05-09 16:16:35.035074','11','Women -> lady Running Shoe',3,'',2,1),(46,'2020-05-09 16:46:42.837713','9','9 of NIKE FREE RN 2019 ID01',1,'[{\"added\": {}}]',4,1),(47,'2020-05-09 17:35:37.113473','10','10 of NIKE FREE RN 2019 ID02',1,'[{\"added\": {}}]',4,1),(48,'2020-05-09 17:37:06.706744','11','11 of NIKE FREE RN 2019 ID03',1,'[{\"added\": {}}]',4,1),(49,'2020-05-09 17:38:05.152562','12','12 of NIKE FREE RN 2019 ID04',1,'[{\"added\": {}}]',4,1),(50,'2020-05-09 17:39:29.118246','13','13 of NIKE FREE RN 2019 ID05',1,'[{\"added\": {}}]',4,1),(51,'2020-05-09 17:40:47.578381','14','14 of NIKE FREE RN 2019 ID06',1,'[{\"added\": {}}]',4,1),(52,'2020-05-09 17:40:59.176980','14','14 of NIKE FREE RN 2019 ID06',2,'[{\"changed\": {\"fields\": [\"product_offer\"]}}]',4,1),(53,'2020-05-09 17:42:05.579014','15','15 of NIKE FREE RN 2019 ID07',1,'[{\"added\": {}}]',4,1),(54,'2020-05-09 17:42:49.560569','16','16 of NIKE FREE RN 2019 ID08',1,'[{\"added\": {}}]',4,1),(55,'2020-05-12 08:38:30.743770','1','Ravi',1,'[{\"added\": {}}]',1,1),(56,'2020-05-12 12:58:06.407701','1','Ravi',3,'',1,1),(57,'2020-05-12 13:01:59.572688','2','Ravi',1,'[{\"added\": {}}]',1,1),(58,'2020-05-12 13:03:11.704874','3','Ravi',1,'[{\"added\": {}}]',1,1),(59,'2020-05-12 19:32:14.490077','4','Ravi',1,'[{\"added\": {}}]',1,1),(60,'2020-05-12 21:57:39.896093','4','Ravi',3,'',1,1),(61,'2020-05-12 21:57:39.999034','3','Ravi',3,'',1,1),(62,'2020-05-12 21:57:40.121965','2','Ravi',3,'',1,1),(63,'2020-05-12 23:38:26.297114','13','NIKE FREE RN 2019 ID08 No. of quantity : 1',3,'',10,1),(64,'2020-05-12 23:38:26.415313','12','NIKE FREE RN 2019 ID01 No. of quantity : 3',3,'',10,1),(65,'2020-05-12 23:38:40.961741','1','Ravi',3,'',5,1),(66,'2020-05-13 20:59:01.736157','15','NIKE FREE RN 2019 ID02 No. of quantity : 1',2,'[{\"changed\": {\"fields\": [\"ordered\"]}}]',10,1),(67,'2020-05-15 21:28:18.346571','17','17 of NIKE FREE RN 2019 ID09',1,'[{\"added\": {}}]',4,1),(68,'2020-05-15 22:46:18.228675','18','18 of NIKE FREE RN 2019 ID10',1,'[{\"added\": {}}]',4,1),(69,'2020-05-15 22:47:28.729598','19','19 of NIKE FREE RN 2019 ID11',1,'[{\"added\": {}}]',4,1),(70,'2020-05-15 22:56:13.647880','20','20 of NIKE FREE RN 2019 ID12',1,'[{\"added\": {}}]',4,1),(71,'2020-05-15 22:57:13.882753','20','20 of NIKE FREE RN 2019 ID12',2,'[{\"changed\": {\"fields\": [\"product_image\"]}}]',4,1),(72,'2020-05-15 22:57:54.020498','20','20 of NIKE FREE RN 2019 ID12',2,'[{\"changed\": {\"fields\": [\"product_image\"]}}]',4,1),(73,'2020-05-15 22:59:05.608641','20','20 of NIKE FREE RN 2019 ID12',2,'[{\"changed\": {\"fields\": [\"product_image\"]}}]',4,1),(74,'2020-05-16 20:50:43.343100','1','free',1,'[{\"added\": {}}]',3,1),(75,'2020-05-24 18:12:13.481643','1','free',3,'',3,1),(76,'2020-05-24 19:28:53.081913','2','free',1,'[{\"added\": {}}]',3,1),(77,'2020-05-24 19:39:32.517992','17','NIKE FREE RN 2019 ID07 No. of quantity : 1',3,'',10,1),(78,'2020-05-24 19:39:32.624926','16','NIKE FREE RN 2019 ID04 No. of quantity : 1',3,'',10,1),(79,'2020-05-24 19:39:32.712876','15','NIKE FREE RN 2019 ID02 No. of quantity : 1',3,'',10,1),(80,'2020-05-24 19:39:32.808825','14','NIKE FREE RN 2019 ID01 No. of quantity : 1',3,'',10,1),(81,'2020-05-24 19:39:57.761468','2','Ravi',3,'',5,1),(82,'2020-05-24 20:03:55.225774','2','ravi_S',3,'',14,1),(83,'2020-05-24 20:04:24.743174','4','test',1,'[{\"added\": {}}]',14,1),(84,'2020-05-24 20:05:49.680305','4','test',2,'[{\"changed\": {\"fields\": [\"user_permissions\"]}}]',14,1),(85,'2020-05-24 20:08:31.924769','4','test',2,'[{\"changed\": {\"fields\": [\"first_name\", \"last_name\", \"email\"]}}]',14,1),(86,'2020-05-24 20:09:35.858596','4','test',2,'[{\"changed\": {\"fields\": [\"is_staff\"]}}]',14,1),(87,'2020-05-24 20:09:36.109451','4','test',2,'[{\"changed\": {\"fields\": [\"is_staff\"]}}]',14,1),(88,'2020-05-24 20:11:36.317108','4','test',2,'[{\"changed\": {\"fields\": [\"user_permissions\"]}}]',14,1),(89,'2020-05-24 20:14:01.264846','21','21 of NIKE FREE RN 2019 ID13',1,'[{\"added\": {}}]',4,4),(90,'2020-05-24 20:47:23.266573','19','NIKE FREE RN 2019 ID08 No. of quantity : 1',3,'',10,1),(91,'2020-05-24 20:47:23.380499','18','NIKE FREE RN 2019 ID01 No. of quantity : 1',3,'',10,1),(92,'2020-05-24 20:48:52.457466','3','Ravi',3,'',5,1),(93,'2020-05-24 20:51:04.562239','4','Ravi',3,'',5,1),(94,'2020-05-24 21:44:55.925042','2','free',3,'',3,1),(95,'2020-05-24 21:47:31.263543','3','free',1,'[{\"added\": {}}]',3,1),(96,'2020-05-25 23:44:26.724604','1','1',2,'[{\"changed\": {\"fields\": [\"accepted\"]}}]',8,1),(97,'2020-05-25 23:57:54.106990','2','2',2,'[{\"changed\": {\"fields\": [\"accepted\"]}}]',8,1),(98,'2020-05-26 00:10:10.128466','6','Ravi',2,'[{\"changed\": {\"fields\": [\"being_delivered\", \"received\"]}}]',5,1),(99,'2020-05-26 00:11:53.995721','5','Ravi',2,'[{\"changed\": {\"fields\": [\"being_delivered\", \"received\"]}}]',5,1),(100,'2020-05-26 00:12:40.425380','7','Ravi',2,'[{\"changed\": {\"fields\": [\"being_delivered\"]}}]',5,1),(101,'2020-05-26 00:13:17.929918','28','NIKE FREE RN 2019 ID01 No. of quantity : 1',3,'',10,1),(102,'2020-05-26 00:13:18.035862','27','NIKE FREE RN 2019 ID09 No. of quantity : 1',3,'',10,1),(103,'2020-05-26 00:13:18.135807','26','NIKE FREE RN 2019 ID11 No. of quantity : 1',3,'',10,1),(104,'2020-05-26 00:13:18.202759','25','NIKE FREE RN 2019 ID12 No. of quantity : 1',3,'',10,1),(105,'2020-05-26 00:13:18.290742','24','NIKE FREE RN 2019 ID08 No. of quantity : 1',3,'',10,1),(106,'2020-05-26 00:13:18.356671','23','NIKE FREE RN 2019 ID04 No. of quantity : 1',3,'',10,1),(107,'2020-05-26 00:13:18.445628','22','NIKE FREE RN 2019 ID13 No. of quantity : 1',3,'',10,1),(108,'2020-05-26 00:13:18.588539','21','NIKE FREE RN 2019 ID08 No. of quantity : 1',3,'',10,1),(109,'2020-05-26 00:13:18.688480','20','NIKE FREE RN 2019 ID01 No. of quantity : 2',3,'',10,1),(110,'2020-05-26 00:14:16.776208','29','NIKE FREE RN 2019 ID01 No. of quantity : 1',1,'[{\"added\": {}}]',10,1),(111,'2020-05-26 00:15:16.542818','30','NIKE FREE RN 2019 ID04 No. of quantity : 1',1,'[{\"added\": {}}]',10,1),(112,'2020-05-26 00:15:26.812848','7','Ravi',2,'[{\"changed\": {\"fields\": [\"items\"]}}]',5,1),(113,'2020-06-01 09:25:17.990321','9','9 of NIKE_FREE_RN_2019_ID01',2,'[{\"changed\": {\"fields\": [\"product_title\"]}}]',4,3),(114,'2020-06-01 09:28:43.809650','9','9 of NIKE FREE RN 2019 ID01',2,'[{\"changed\": {\"fields\": [\"product_title\"]}}]',4,3),(115,'2020-06-02 05:29:26.030536','1','Ravi',1,'[{\"added\": {}}]',23,1),(116,'2020-06-02 05:29:52.949112','1','Ravi',2,'[{\"changed\": {\"fields\": [\"retailer_phonenumber\"]}}]',23,1),(117,'2020-06-02 05:30:51.475569','1','Ravi',2,'[{\"changed\": {\"fields\": [\"complete_address\"]}}]',23,1),(118,'2020-06-02 05:31:35.564622','1','John',2,'[{\"changed\": {\"fields\": [\"retailer_firstname\", \"retailer_lastname\"]}}]',23,1),(119,'2020-06-03 07:33:32.137199','13','oil',1,'[{\"added\": {}}]',2,1),(120,'2020-06-03 07:34:15.916921','14','oil -> safola',1,'[{\"added\": {}}]',2,1),(121,'2020-06-03 07:35:03.806627','15','oil -> fortune',1,'[{\"added\": {}}]',2,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (18,'account','emailaddress'),(19,'account','emailconfirmation'),(11,'admin','logentry'),(13,'auth','group'),(12,'auth','permission'),(14,'auth','user'),(15,'contenttypes','contenttype'),(1,'public','address'),(2,'public','category'),(3,'public','coupon'),(4,'public','item'),(5,'public','order'),(10,'public','orderitem'),(9,'public','payment'),(8,'public','refund'),(23,'public','retailer'),(6,'public','slider'),(7,'public','userprofile'),(16,'sessions','session'),(17,'sites','site'),(20,'socialaccount','socialaccount'),(21,'socialaccount','socialapp'),(22,'socialaccount','socialtoken');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2020-02-18 20:24:07.506389'),(2,'auth','0001_initial','2020-02-18 20:24:11.674730'),(3,'account','0001_initial','2020-02-18 20:24:42.951381'),(4,'account','0002_email_max_length','2020-02-18 20:24:49.264044'),(5,'admin','0001_initial','2020-02-18 20:24:50.287388'),(6,'admin','0002_logentry_remove_auto_add','2020-02-18 20:24:57.884126'),(7,'admin','0003_logentry_add_action_flag_choices','2020-02-18 20:24:57.998430'),(8,'contenttypes','0002_remove_content_type_name','2020-02-18 20:25:02.540929'),(9,'auth','0002_alter_permission_name_max_length','2020-02-18 20:25:04.897295'),(10,'auth','0003_alter_user_email_max_length','2020-02-18 20:25:05.525195'),(11,'auth','0004_alter_user_username_opts','2020-02-18 20:25:05.646341'),(12,'auth','0005_alter_user_last_login_null','2020-02-18 20:25:08.411436'),(13,'auth','0006_require_contenttypes_0002','2020-02-18 20:25:08.567713'),(14,'auth','0007_alter_validators_add_error_messages','2020-02-18 20:25:08.818657'),(15,'auth','0008_alter_user_username_max_length','2020-02-18 20:25:14.445816'),(16,'auth','0009_alter_user_last_name_max_length','2020-02-18 20:25:17.786118'),(17,'auth','0010_alter_group_name_max_length','2020-02-18 20:25:18.304811'),(18,'auth','0011_update_proxy_permissions','2020-02-18 20:25:18.554973'),(19,'public','0001_initial','2020-02-18 20:25:32.884795'),(20,'sessions','0001_initial','2020-02-18 20:26:28.787617'),(21,'sites','0001_initial','2020-02-18 20:26:29.890424'),(22,'sites','0002_alter_domain_unique','2020-02-18 20:26:30.683610'),(23,'socialaccount','0001_initial','2020-02-18 20:26:36.186473'),(24,'socialaccount','0002_token_max_lengths','2020-02-18 20:26:55.957576'),(25,'socialaccount','0003_extra_data_default_dict','2020-02-18 20:26:56.358707'),(26,'public','0002_auto_20200219_1815','2020-02-19 12:46:09.784877'),(27,'public','0003_auto_20200225_1658','2020-02-25 11:29:11.961131'),(28,'public','0004_auto_20200502_2338','2020-05-02 18:09:06.831417'),(29,'public','0005_auto_20200506_2226','2020-05-06 16:57:14.090829'),(30,'public','0006_auto_20200512_1812','2020-05-12 12:43:21.353839'),(31,'public','0007_auto_20200512_1814','2020-05-12 12:44:27.476905'),(32,'public','0002_auto_20200513_0252','2020-05-12 21:41:24.475456'),(33,'public','0003_auto_20200513_0256','2020-05-12 21:41:24.571411'),(34,'public','0004_auto_20200513_0301','2020-05-12 21:41:24.896237'),(35,'public','0005_auto_20200514_0003','2020-05-13 18:33:55.622114'),(36,'public','0006_auto_20200514_0007','2020-05-13 18:37:59.895518'),(37,'public','0007_retailer','2020-06-02 05:07:59.905509'),(38,'public','0008_auto_20200602_1049','2020-06-02 05:27:34.499360'),(39,'public','0009_auto_20200602_1057','2020-06-02 05:27:36.991786');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('0amp5fgqqtwo5nmwzh39ln01gb8k5foq','ZTVjMjBkMDJlODY3MDk4YzNlOWUwMmE3ZjY2MjZhMzVkZTk5M2JiYzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MDBkYmE5YTVmY2I0ZDFjYjRjMzE0M2E2OGYwMmFmYmUzMGU5ZWVkIn0=','2020-03-03 20:29:22.707242'),('0qmsn1s0vxfecjbx31l4njl22z40jxwx','ZTVjMjBkMDJlODY3MDk4YzNlOWUwMmE3ZjY2MjZhMzVkZTk5M2JiYzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MDBkYmE5YTVmY2I0ZDFjYjRjMzE0M2E2OGYwMmFmYmUzMGU5ZWVkIn0=','2020-06-07 20:18:18.878188'),('1q9wxkmo9ra6vbr0fgq70dldxdm8xm88','ZTVjMjBkMDJlODY3MDk4YzNlOWUwMmE3ZjY2MjZhMzVkZTk5M2JiYzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MDBkYmE5YTVmY2I0ZDFjYjRjMzE0M2E2OGYwMmFmYmUzMGU5ZWVkIn0=','2020-06-20 11:36:41.750251'),('1whnzuftr80djdza9otdmntgs86dedkl','NDIxMGRkZTVmOWEwNzU5NTkxMGNiNjljZWY2NGFkMWE0NmRmNjlkNTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MDBkYmE5YTVmY2I0ZDFjYjRjMzE0M2E2OGYwMmFmYmUzMGU5ZWVkIiwiX3Nlc3Npb25fZXhwaXJ5IjoxMjA5NjAwfQ==','2020-05-26 12:51:53.231069'),('27u7d86m597lv93v7cqvfcioty1bvqep','MWM0YzM1YWNiYjliNGI2OWZkZWZlMjFiYzc1MGQzOTg4YThjODAwMzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MDBkYmE5YTVmY2I0ZDFjYjRjMzE0M2E2OGYwMmFmYmUzMGU5ZWVkIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2020-05-29 12:49:52.242385'),('67lajy1rmxq7at37e4nlzowamq1i9c4y','MWM0YzM1YWNiYjliNGI2OWZkZWZlMjFiYzc1MGQzOTg4YThjODAwMzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MDBkYmE5YTVmY2I0ZDFjYjRjMzE0M2E2OGYwMmFmYmUzMGU5ZWVkIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2020-04-23 12:40:08.555210'),('72st391164emht577htsoyf7lkpdp0rt','NDIxMGRkZTVmOWEwNzU5NTkxMGNiNjljZWY2NGFkMWE0NmRmNjlkNTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MDBkYmE5YTVmY2I0ZDFjYjRjMzE0M2E2OGYwMmFmYmUzMGU5ZWVkIiwiX3Nlc3Npb25fZXhwaXJ5IjoxMjA5NjAwfQ==','2020-06-21 05:31:09.279671'),('78reaqipvee3mdesxue21akk1h287snn','MWM0YzM1YWNiYjliNGI2OWZkZWZlMjFiYzc1MGQzOTg4YThjODAwMzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MDBkYmE5YTVmY2I0ZDFjYjRjMzE0M2E2OGYwMmFmYmUzMGU5ZWVkIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2020-03-09 06:15:45.770660'),('958b501u3qqreqw4p1z2cemnvq3x3qnv','ZTMxZjA5YjFlNGJjYzg0OWU5MWU1ZjgxN2VlZTZlNWQyYWM4MDIzODp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxMWNkN2QzYTdkMWU2M2NiZWQyODhmYTVjM2E2ZjZmN2Y1ZDAxY2M2In0=','2020-06-15 07:28:24.428868'),('azy366n6e1z49hx96qmfffows6s2cimn','MWM0YzM1YWNiYjliNGI2OWZkZWZlMjFiYzc1MGQzOTg4YThjODAwMzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MDBkYmE5YTVmY2I0ZDFjYjRjMzE0M2E2OGYwMmFmYmUzMGU5ZWVkIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2020-06-17 07:27:44.135556'),('bd8zonlwgvd9g2yehdzxlg9fqnb81ibh','MWM0YzM1YWNiYjliNGI2OWZkZWZlMjFiYzc1MGQzOTg4YThjODAwMzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MDBkYmE5YTVmY2I0ZDFjYjRjMzE0M2E2OGYwMmFmYmUzMGU5ZWVkIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2020-05-24 16:55:17.767553'),('dyvvmi9pa1bpykoinmixaewjqleqn7lj','MWM0YzM1YWNiYjliNGI2OWZkZWZlMjFiYzc1MGQzOTg4YThjODAwMzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MDBkYmE5YTVmY2I0ZDFjYjRjMzE0M2E2OGYwMmFmYmUzMGU5ZWVkIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2020-06-19 11:57:59.208561'),('fpwgfrs7e8ap4jfzn41c4bpqo108ch7p','ZTVjMjBkMDJlODY3MDk4YzNlOWUwMmE3ZjY2MjZhMzVkZTk5M2JiYzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MDBkYmE5YTVmY2I0ZDFjYjRjMzE0M2E2OGYwMmFmYmUzMGU5ZWVkIn0=','2020-03-09 06:27:45.211264'),('gfoxkupps1dnd0aigpo9pxxser8i3m4l','ZTVjMjBkMDJlODY3MDk4YzNlOWUwMmE3ZjY2MjZhMzVkZTk5M2JiYzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MDBkYmE5YTVmY2I0ZDFjYjRjMzE0M2E2OGYwMmFmYmUzMGU5ZWVkIn0=','2020-05-16 18:00:11.933936'),('ggnq47mpiu9amrk2q0vdrue5wvb5rjcw','MWM0YzM1YWNiYjliNGI2OWZkZWZlMjFiYzc1MGQzOTg4YThjODAwMzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MDBkYmE5YTVmY2I0ZDFjYjRjMzE0M2E2OGYwMmFmYmUzMGU5ZWVkIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2020-05-29 14:01:30.727507'),('iteveoh0eiogidvbaqwxv07giwk9bffv','MWM0YzM1YWNiYjliNGI2OWZkZWZlMjFiYzc1MGQzOTg4YThjODAwMzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MDBkYmE5YTVmY2I0ZDFjYjRjMzE0M2E2OGYwMmFmYmUzMGU5ZWVkIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2020-03-09 08:05:32.069848'),('jpxcmgdxy2n1gm8k3wvo68n2zxpsh20d','MWM0YzM1YWNiYjliNGI2OWZkZWZlMjFiYzc1MGQzOTg4YThjODAwMzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MDBkYmE5YTVmY2I0ZDFjYjRjMzE0M2E2OGYwMmFmYmUzMGU5ZWVkIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2020-06-15 11:45:57.702670'),('k5mr9f3sca9mixkwucgyu3ohz0nmw8lz','ZTVjMjBkMDJlODY3MDk4YzNlOWUwMmE3ZjY2MjZhMzVkZTk5M2JiYzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MDBkYmE5YTVmY2I0ZDFjYjRjMzE0M2E2OGYwMmFmYmUzMGU5ZWVkIn0=','2020-06-18 11:34:25.886562'),('p0rk1r5suo9ywh7yjyoxzbzu87f69g1v','MWM0YzM1YWNiYjliNGI2OWZkZWZlMjFiYzc1MGQzOTg4YThjODAwMzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MDBkYmE5YTVmY2I0ZDFjYjRjMzE0M2E2OGYwMmFmYmUzMGU5ZWVkIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2020-05-29 20:33:04.119068'),('pc3bzjqdzaenh9wx1juo78i05z9sizrd','MWM0YzM1YWNiYjliNGI2OWZkZWZlMjFiYzc1MGQzOTg4YThjODAwMzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MDBkYmE5YTVmY2I0ZDFjYjRjMzE0M2E2OGYwMmFmYmUzMGU5ZWVkIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2020-04-25 17:50:35.950720'),('qnzvo0eisoltb7zequv1qasfw2bq6n0c','ZTVjMjBkMDJlODY3MDk4YzNlOWUwMmE3ZjY2MjZhMzVkZTk5M2JiYzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MDBkYmE5YTVmY2I0ZDFjYjRjMzE0M2E2OGYwMmFmYmUzMGU5ZWVkIn0=','2020-06-16 05:09:44.763325'),('qppe374uagoa39mftc0bf9l95vqnvxxh','ZTMxZjA5YjFlNGJjYzg0OWU5MWU1ZjgxN2VlZTZlNWQyYWM4MDIzODp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxMWNkN2QzYTdkMWU2M2NiZWQyODhmYTVjM2E2ZjZmN2Y1ZDAxY2M2In0=','2020-04-08 04:02:37.518316'),('r4l6nivems0tgpfb4ni8drnxmudsq0n5','MWM0YzM1YWNiYjliNGI2OWZkZWZlMjFiYzc1MGQzOTg4YThjODAwMzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MDBkYmE5YTVmY2I0ZDFjYjRjMzE0M2E2OGYwMmFmYmUzMGU5ZWVkIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2020-04-25 05:34:55.628517'),('rhlhf2bvjczscdgd8mdahv2c4qg30w0j','MWM0YzM1YWNiYjliNGI2OWZkZWZlMjFiYzc1MGQzOTg4YThjODAwMzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MDBkYmE5YTVmY2I0ZDFjYjRjMzE0M2E2OGYwMmFmYmUzMGU5ZWVkIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2020-05-29 19:28:58.610279'),('sz38tg5d4wvxtd8mssyx44v01acexi24','MWM0YzM1YWNiYjliNGI2OWZkZWZlMjFiYzc1MGQzOTg4YThjODAwMzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MDBkYmE5YTVmY2I0ZDFjYjRjMzE0M2E2OGYwMmFmYmUzMGU5ZWVkIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2020-05-26 11:08:27.409128'),('uj7lsp60vwmqu69oc5oemxgmk1y9vkii','ZTVjMjBkMDJlODY3MDk4YzNlOWUwMmE3ZjY2MjZhMzVkZTk5M2JiYzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MDBkYmE5YTVmY2I0ZDFjYjRjMzE0M2E2OGYwMmFmYmUzMGU5ZWVkIn0=','2020-03-04 15:43:04.629847'),('vavdmsfp3lk1s1m3j8ktqvvlei3ojke8','MWM0YzM1YWNiYjliNGI2OWZkZWZlMjFiYzc1MGQzOTg4YThjODAwMzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MDBkYmE5YTVmY2I0ZDFjYjRjMzE0M2E2OGYwMmFmYmUzMGU5ZWVkIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2020-06-17 10:28:55.496689'),('w24tdthjlvh2ma9s34rv1iysw296pz1w','MWM0YzM1YWNiYjliNGI2OWZkZWZlMjFiYzc1MGQzOTg4YThjODAwMzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MDBkYmE5YTVmY2I0ZDFjYjRjMzE0M2E2OGYwMmFmYmUzMGU5ZWVkIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2020-05-25 08:31:29.989136'),('wfgqofat1lmgie0zatc0z3tid3blzyao','MWM0YzM1YWNiYjliNGI2OWZkZWZlMjFiYzc1MGQzOTg4YThjODAwMzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MDBkYmE5YTVmY2I0ZDFjYjRjMzE0M2E2OGYwMmFmYmUzMGU5ZWVkIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2020-05-26 11:53:44.752702'),('wwilfye6s7c2vcrq30lccsw3pj9tdqkr','MWM0YzM1YWNiYjliNGI2OWZkZWZlMjFiYzc1MGQzOTg4YThjODAwMzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MDBkYmE5YTVmY2I0ZDFjYjRjMzE0M2E2OGYwMmFmYmUzMGU5ZWVkIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2020-05-29 20:10:09.687225'),('x2qju8hqmsggno9s0kby6gfdxw4607qj','MWM0YzM1YWNiYjliNGI2OWZkZWZlMjFiYzc1MGQzOTg4YThjODAwMzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MDBkYmE5YTVmY2I0ZDFjYjRjMzE0M2E2OGYwMmFmYmUzMGU5ZWVkIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2020-04-23 13:49:45.489540'),('xq2vj8wa4thmfwag9k5x97q0klvw4ars','MWM0YzM1YWNiYjliNGI2OWZkZWZlMjFiYzc1MGQzOTg4YThjODAwMzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MDBkYmE5YTVmY2I0ZDFjYjRjMzE0M2E2OGYwMmFmYmUzMGU5ZWVkIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2020-03-03 20:45:38.241912'),('y0bvbxl6z86xf7gz5nzjls8ho846e7lm','Yzk2YmJmNmI4MDBlYmRkM2QzOGM0ZGI4NDk4ODFkOWJiOWJiMmQyNDp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxMWNkN2QzYTdkMWU2M2NiZWQyODhmYTVjM2E2ZjZmN2Y1ZDAxY2M2IiwiX21lc3NhZ2VzIjoiW1tcIl9fanNvbl9tZXNzYWdlXCIsMCwyMCxcIllvdSBkbyBub3QgaGF2ZSBhbiBhY3RpdmUgb3JkZXJcIl0sW1wiX19qc29uX21lc3NhZ2VcIiwwLDIwLFwiWW91IGRvIG5vdCBoYXZlIGFuIGFjdGl2ZSBvcmRlclwiXSxbXCJfX2pzb25fbWVzc2FnZVwiLDAsMjAsXCJZb3UgZG8gbm90IGhhdmUgYW4gYWN0aXZlIG9yZGVyXCJdLFtcIl9fanNvbl9tZXNzYWdlXCIsMCwyMCxcIllvdSBkbyBub3QgaGF2ZSBhbiBhY3RpdmUgb3JkZXJcIl0sW1wiX19qc29uX21lc3NhZ2VcIiwwLDIwLFwiWW91IGRvIG5vdCBoYXZlIGFuIGFjdGl2ZSBvcmRlclwiXSxbXCJfX2pzb25fbWVzc2FnZVwiLDAsMjAsXCJZb3UgZG8gbm90IGhhdmUgYW4gYWN0aXZlIG9yZGVyXCJdLFtcIl9fanNvbl9tZXNzYWdlXCIsMCwyMCxcIllvdSBkbyBub3QgaGF2ZSBhbiBhY3RpdmUgb3JkZXJcIl0sW1wiX19qc29uX21lc3NhZ2VcIiwwLDIwLFwiWW91IGRvIG5vdCBoYXZlIGFuIGFjdGl2ZSBvcmRlclwiXSxbXCJfX2pzb25fbWVzc2FnZVwiLDAsMjAsXCJZb3UgZG8gbm90IGhhdmUgYW4gYWN0aXZlIG9yZGVyXCJdLFtcIl9fanNvbl9tZXNzYWdlXCIsMCwyMCxcIllvdSBkbyBub3QgaGF2ZSBhbiBhY3RpdmUgb3JkZXJcIl0sW1wiX19qc29uX21lc3NhZ2VcIiwwLDIwLFwiWW91IGRvIG5vdCBoYXZlIGFuIGFjdGl2ZSBvcmRlclwiXSxbXCJfX2pzb25fbWVzc2FnZVwiLDAsMjAsXCJZb3UgZG8gbm90IGhhdmUgYW4gYWN0aXZlIG9yZGVyXCJdLFtcIl9fanNvbl9tZXNzYWdlXCIsMCwyMCxcIllvdSBkbyBub3QgaGF2ZSBhbiBhY3RpdmUgb3JkZXJcIl1dIn0=','2020-04-07 11:57:46.240501'),('y4t4aw9hb664q1ba939uuhlozrhv3rd2','MWM0YzM1YWNiYjliNGI2OWZkZWZlMjFiYzc1MGQzOTg4YThjODAwMzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MDBkYmE5YTVmY2I0ZDFjYjRjMzE0M2E2OGYwMmFmYmUzMGU5ZWVkIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2020-05-24 22:06:20.724686'),('zifhc4d7y0n0jmb34p78v93gf1f6dh40','MWM0YzM1YWNiYjliNGI2OWZkZWZlMjFiYzc1MGQzOTg4YThjODAwMzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MDBkYmE5YTVmY2I0ZDFjYjRjMzE0M2E2OGYwMmFmYmUzMGU5ZWVkIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2020-05-25 15:17:56.425451');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_site` (
  `id` int NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_site_domain_a2e37b91_uniq` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'example.com','example.com');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `public_address`
--

DROP TABLE IF EXISTS `public_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `public_address` (
  `id` int NOT NULL AUTO_INCREMENT,
  `street_address` varchar(100) NOT NULL,
  `apartment_address` varchar(100) NOT NULL,
  `country` varchar(2) NOT NULL,
  `zipcode` varchar(15) NOT NULL,
  `address_type` varchar(1) NOT NULL,
  `default` tinyint(1) NOT NULL,
  `user_id` int NOT NULL,
  `email` varchar(254) NOT NULL,
  `firstname` varchar(25) NOT NULL,
  `lastname` varchar(20) NOT NULL,
  `phone` varchar(31) NOT NULL,
  `city` varchar(35) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `public_address_user_id_280f81f1_fk_auth_user_id` (`user_id`),
  CONSTRAINT `public_address_user_id_280f81f1_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `public_address`
--

LOCK TABLES `public_address` WRITE;
/*!40000 ALTER TABLE `public_address` DISABLE KEYS */;
INSERT INTO `public_address` VALUES (5,'SitaPura  Partap Nagar 28, Near Modern Public school','','IN','45001','S',0,1,'ravishankersingh.tfl@gmail.com','Anurag','Goyal','+919001420329','Jaipur'),(6,'SitaPura  Partap Nagar 28, Near Modern Public school','','IN','45001','B',0,1,'ravishankersingh.tfl@gmail.com','Anurag','Goyal','+919001420329','Jaipur'),(7,'New Market','483, Rawtbhata','IN','323307','S',1,1,'ravishankersingh.tfl@gmail.com','Ravi','Singh','+919001420329','Rawatbhata'),(8,'SitaPura  Partap Nagar 28, Near Modern Public school','chinab apartment','IN','45001','B',1,1,'ravishankersingh.tfl@gmail.com','Vinit','Goyal','+919001420329','Jaipur'),(9,'SitaPura  Partap Nagar 28, Near Modern Public school','405A rani','IN','45001','S',0,1,'ravishankersingh.tfl@gmail.com','Vinit','Goyal','+919001420329','Jaipur'),(10,'New Market','','IN','323307','B',0,1,'ravishankersingh.tfl@gmail.com','Ravi','Singh','+919001420329','Rawatbhata'),(11,'SitaPura  Partap Nagar 28, Near Modern Public school','','IN','45001','S',0,1,'ravishankersingh.tfl@gmail.com','Vinit','Goyal','+919001420329','Jaipur'),(12,'SitaPura  Partap Nagar 28, Near Modern Public school','','IN','45001','B',0,1,'ravishankersingh.tfl@gmail.com','Vinit','Goyal','+919001420329','Jaipur'),(13,'SitaPura  Partap Nagar 28, Near Modern Public school','','IN','45001','S',0,1,'ravishankersingh.tfl@gmail.com','Vinit','Goyal','+919001420329','Jaipur'),(14,'SitaPura  Partap Nagar 28, Near Modern Public school','','IN','45001','B',0,1,'ravishankersingh.tfl@gmail.com','Vinit','Goyal','+919001420329','Jaipur');
/*!40000 ALTER TABLE `public_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `public_category`
--

DROP TABLE IF EXISTS `public_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `public_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `parent_id` int DEFAULT NULL,
  `level` int unsigned NOT NULL,
  `lft` int unsigned NOT NULL,
  `rght` int unsigned NOT NULL,
  `tree_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `public_category_name_ea54d08e_uniq` (`name`),
  KEY `public_category_slug_4e99bc36` (`slug`),
  KEY `public_category_tree_id_4e949f28` (`tree_id`),
  KEY `public_category_parent_id_f484a65c_fk_public_category_id` (`parent_id`),
  CONSTRAINT `public_category_parent_id_f484a65c_fk_public_category_id` FOREIGN KEY (`parent_id`) REFERENCES `public_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `public_category`
--

LOCK TABLES `public_category` WRITE;
/*!40000 ALTER TABLE `public_category` DISABLE KEYS */;
INSERT INTO `public_category` VALUES (6,'Men','Men',NULL,0,1,4,2),(7,'Women','Women',NULL,0,1,4,3),(8,'Kids','Kids',NULL,0,1,2,1),(9,'Men Shoe','Men-Shoes',6,1,2,3,2),(12,'lady Party Wear Shoe','lady_Party_Wear_Shoe',7,1,2,3,3),(13,'oil','oil',NULL,0,1,6,4),(14,'safola','safola-oil',13,1,2,3,4),(15,'fortune','fortune-oil',13,1,4,5,4);
/*!40000 ALTER TABLE `public_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `public_coupon`
--

DROP TABLE IF EXISTS `public_coupon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `public_coupon` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(15) NOT NULL,
  `amount` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `public_coupon`
--

LOCK TABLES `public_coupon` WRITE;
/*!40000 ALTER TABLE `public_coupon` DISABLE KEYS */;
INSERT INTO `public_coupon` VALUES (3,'free',500);
/*!40000 ALTER TABLE `public_coupon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `public_item`
--

DROP TABLE IF EXISTS `public_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `public_item` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `product_title` varchar(100) NOT NULL,
  `product_slug` varchar(50) NOT NULL,
  `product_description` longtext NOT NULL,
  `product_image` varchar(100) NOT NULL,
  `product_price` double NOT NULL,
  `product_offer` tinyint(1) NOT NULL,
  `product_discount_price` double DEFAULT NULL,
  `product_category_id` int DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  KEY `public_item_product_slug_51cc91d9` (`product_slug`),
  KEY `public_item_product_category_id_5d6a81fc_fk_public_category_id` (`product_category_id`),
  CONSTRAINT `public_item_product_category_id_5d6a81fc_fk_public_category_id` FOREIGN KEY (`product_category_id`) REFERENCES `public_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `public_item`
--

LOCK TABLES `public_item` WRITE;
/*!40000 ALTER TABLE `public_item` DISABLE KEYS */;
INSERT INTO `public_item` VALUES (9,'NIKE FREE RN 2019 ID01','NIKEID01','Best Quality material and smouth for party wear.','product/product-1_SwIi2ou.jpg',1500,0,NULL,9),(10,'NIKE FREE RN 2019 ID02','NIKEID02','Best Quality material and smooth for casual wear.','product/product-2_2QJ5EVy.jpg',1800,0,NULL,9),(11,'NIKE FREE RN 2019 ID03','NIKEID03','Best Quality material and smooth for Running wear.','product/product-3_8lokxRD.jpg',1900,0,NULL,9),(12,'NIKE FREE RN 2019 ID04','NIKEID04','Best Quality material and smooth for Running wear.','product/product-4_3ujSmNb.jpg',2700,1,2250,9),(13,'NIKE FREE RN 2019 ID05','NIKEID05','Best Quality material and smooth for party wear.','product/product-5_EyejVNd.png',2500,1,1700,12),(14,'NIKE FREE RN 2019 ID06','NIKEID06','Best Quality material and smooth for Casual wear.','product/product-6_cL513PF.png',8500,1,5570,12),(15,'NIKE FREE RN 2019 ID07','NIKEID07','Best Quality material and smooth for Casual wear.','product/product-7_jbNr8DO.png',1650,0,NULL,12),(16,'NIKE FREE RN 2019 ID08','NIKEID08','Best Quality material and smooth for Running wear.','product/product-8_rA5AJa7.png',22500,1,8500,12),(17,'NIKE FREE RN 2019 ID09','NIKEID09','Kids Shoes','product/product_5.jpg',1300,1,1150,8),(18,'NIKE FREE RN 2019 ID10','NIKEID10','Kid','product/product_9.jpg',1530,0,NULL,8),(19,'NIKE FREE RN 2019 ID11','NIKEID11','Queen kitty','product/product_13.jpg',1100,0,NULL,8),(20,'NIKE FREE RN 2019 ID12','NIKEID12','kids','product/product_15.jpg',3590,1,1600,8),(21,'NIKE FREE RN 2019 ID13','NIKEID13','kids','product/choose-3.jpg',350,1,323,8);
/*!40000 ALTER TABLE `public_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `public_order`
--

DROP TABLE IF EXISTS `public_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `public_order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ref_code` varchar(20) DEFAULT NULL,
  `start_date` datetime(6) NOT NULL,
  `ordered_date` datetime(6) NOT NULL,
  `ordered` tinyint(1) NOT NULL,
  `being_delivered` tinyint(1) NOT NULL,
  `received` tinyint(1) NOT NULL,
  `refund_requested` tinyint(1) NOT NULL,
  `refund_granted` tinyint(1) NOT NULL,
  `billing_address_id` int DEFAULT NULL,
  `coupon_id` int DEFAULT NULL,
  `payment_id` int DEFAULT NULL,
  `shipping_address_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `public_order_billing_address_id_a43ff918_fk_public_address_id` (`billing_address_id`),
  KEY `public_order_coupon_id_59f6e5e1_fk_public_coupon_id` (`coupon_id`),
  KEY `public_order_payment_id_3a5b350c_fk_public_payment_id` (`payment_id`),
  KEY `public_order_shipping_address_id_479f9f71_fk_public_address_id` (`shipping_address_id`),
  KEY `public_order_user_id_b3f4d212_fk_auth_user_id` (`user_id`),
  CONSTRAINT `public_order_billing_address_id_a43ff918_fk_public_address_id` FOREIGN KEY (`billing_address_id`) REFERENCES `public_address` (`id`),
  CONSTRAINT `public_order_coupon_id_59f6e5e1_fk_public_coupon_id` FOREIGN KEY (`coupon_id`) REFERENCES `public_coupon` (`id`),
  CONSTRAINT `public_order_payment_id_3a5b350c_fk_public_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `public_payment` (`id`),
  CONSTRAINT `public_order_shipping_address_id_479f9f71_fk_public_address_id` FOREIGN KEY (`shipping_address_id`) REFERENCES `public_address` (`id`),
  CONSTRAINT `public_order_user_id_b3f4d212_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `public_order`
--

LOCK TABLES `public_order` WRITE;
/*!40000 ALTER TABLE `public_order` DISABLE KEYS */;
INSERT INTO `public_order` VALUES (5,'foacaycnomby7ermivkr','2020-05-24 20:51:22.913473','2020-05-24 20:51:22.000000',1,1,1,0,0,8,3,1,7,1),(6,'w0u1ka0tfnu3qgfr64bq','2020-05-25 23:21:32.997786','2020-05-25 23:21:32.000000',1,1,1,1,1,8,3,2,7,1),(7,'ydffc35c8rzyshpw9h2j','2020-05-25 23:58:24.927946','2020-05-25 23:58:24.000000',1,1,0,0,0,10,3,3,9,1),(8,'u6aol5iueyvs2e1jzysz','2020-06-03 00:54:26.288543','2020-06-03 00:54:26.286544',1,0,0,0,0,14,NULL,4,13,1),(9,'4ahwe5fjvde70bjs63us','2020-06-03 07:27:45.316862','2020-06-03 07:27:45.314863',1,0,0,0,0,8,3,5,7,1),(10,NULL,'2020-06-07 15:36:46.385456','2020-06-07 15:36:46.384455',0,0,0,0,0,NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `public_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `public_order_items`
--

DROP TABLE IF EXISTS `public_order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `public_order_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `orderitem_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `public_order_items_order_id_orderitem_id_e6f63126_uniq` (`order_id`,`orderitem_id`),
  KEY `public_order_items_orderitem_id_8c1821f1_fk_public_orderitem_id` (`orderitem_id`),
  CONSTRAINT `public_order_items_order_id_4595e532_fk_public_order_id` FOREIGN KEY (`order_id`) REFERENCES `public_order` (`id`),
  CONSTRAINT `public_order_items_orderitem_id_8c1821f1_fk_public_orderitem_id` FOREIGN KEY (`orderitem_id`) REFERENCES `public_orderitem` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `public_order_items`
--

LOCK TABLES `public_order_items` WRITE;
/*!40000 ALTER TABLE `public_order_items` DISABLE KEYS */;
INSERT INTO `public_order_items` VALUES (40,7,30),(41,8,29),(42,9,31),(43,10,32);
/*!40000 ALTER TABLE `public_order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `public_orderitem`
--

DROP TABLE IF EXISTS `public_orderitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `public_orderitem` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ordered` tinyint(1) NOT NULL,
  `quantity` int NOT NULL,
  `item_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `public_orderitem_item_id_49982cd5_fk_public_item_product_id` (`item_id`),
  KEY `public_orderitem_user_id_8098756a_fk_auth_user_id` (`user_id`),
  CONSTRAINT `public_orderitem_item_id_49982cd5_fk_public_item_product_id` FOREIGN KEY (`item_id`) REFERENCES `public_item` (`product_id`),
  CONSTRAINT `public_orderitem_user_id_8098756a_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `public_orderitem`
--

LOCK TABLES `public_orderitem` WRITE;
/*!40000 ALTER TABLE `public_orderitem` DISABLE KEYS */;
INSERT INTO `public_orderitem` VALUES (29,1,1,9,1),(30,0,1,12,1),(31,1,1,9,1),(32,0,1,9,1);
/*!40000 ALTER TABLE `public_orderitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `public_payment`
--

DROP TABLE IF EXISTS `public_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `public_payment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `stripe_charge_id` varchar(50) NOT NULL,
  `amount` double NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `public_payment_user_id_c50c906b_fk_auth_user_id` (`user_id`),
  CONSTRAINT `public_payment_user_id_c50c906b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `public_payment`
--

LOCK TABLES `public_payment` WRITE;
/*!40000 ALTER TABLE `public_payment` DISABLE KEYS */;
INSERT INTO `public_payment` VALUES (1,'ch_1Gmk4oL6QP3aNn0sO6qgZO6J',11000,'2020-05-25 17:26:41.051818',1),(2,'ch_1GmpegL6QP3aNn0s9tTMrOSH',14423,'2020-05-25 23:24:05.200256',1),(3,'ch_1GmqFQL6QP3aNn0se1r1PHH6',1000,'2020-05-26 00:02:03.272880',1),(4,'ch_1Gpl5kL6QP3aNn0s8M8pXjDo',1500,'2020-06-03 01:08:21.713363',1),(5,'ch_1Gpr4WL6QP3aNn0sgPnyE9kI',1000,'2020-06-03 07:31:29.152121',1);
/*!40000 ALTER TABLE `public_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `public_refund`
--

DROP TABLE IF EXISTS `public_refund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `public_refund` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reason` longtext NOT NULL,
  `accepted` tinyint(1) NOT NULL,
  `email` varchar(254) NOT NULL,
  `order_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `public_refund_order_id_ae97aed2_fk_public_order_id` (`order_id`),
  CONSTRAINT `public_refund_order_id_ae97aed2_fk_public_order_id` FOREIGN KEY (`order_id`) REFERENCES `public_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `public_refund`
--

LOCK TABLES `public_refund` WRITE;
/*!40000 ALTER TABLE `public_refund` DISABLE KEYS */;
INSERT INTO `public_refund` VALUES (1,'I need my Refund',1,'ravishankersingh.tfl@gmail.com',6),(2,'vvvvvvvvvvvvvvvvvv',1,'ravishankersingh.tfl@gmail.com',6);
/*!40000 ALTER TABLE `public_refund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `public_retailer`
--

DROP TABLE IF EXISTS `public_retailer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `public_retailer` (
  `retailer_id` int NOT NULL AUTO_INCREMENT,
  `retailer_firstname` varchar(35) NOT NULL,
  `retailer_lastname` varchar(25) NOT NULL,
  `retailer_GSTIN` varchar(25) NOT NULL,
  `retailer_phonenumber` varchar(31) NOT NULL,
  `retailer_phonenumber2` varchar(31) DEFAULT NULL,
  `retailer_register_email_id` varchar(254) NOT NULL,
  `retailer_email_id` varchar(254) DEFAULT NULL,
  `longtitue` double NOT NULL,
  `antitude` double NOT NULL,
  `complete_address` varchar(100) NOT NULL,
  PRIMARY KEY (`retailer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `public_retailer`
--

LOCK TABLES `public_retailer` WRITE;
/*!40000 ALTER TABLE `public_retailer` DISABLE KEYS */;
INSERT INTO `public_retailer` VALUES (1,'John','Kedely','GTKS87JHP','+19001420329x+91','','ravishankersingh.tfl@gmail.com',NULL,44444444.333,-4444.333,'New Market,rawatbhata,rajasthan');
/*!40000 ALTER TABLE `public_retailer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `public_slider`
--

DROP TABLE IF EXISTS `public_slider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `public_slider` (
  `silder_id` int NOT NULL AUTO_INCREMENT,
  `slider_image` varchar(100) NOT NULL,
  `slider_title` varchar(100) NOT NULL,
  `slider_description` longtext NOT NULL,
  PRIMARY KEY (`silder_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `public_slider`
--

LOCK TABLES `public_slider` WRITE;
/*!40000 ALTER TABLE `public_slider` DISABLE KEYS */;
INSERT INTO `public_slider` VALUES (1,'picture/bg_1_K11HczV.png','Shoes Collection 2019','Shop for Skechers Shoes for Women from the Hottest New Arrival Collection in India which includes performance shoes, running shoes, walking shoes, sport'),(3,'picture/bg_2_TNPzBiK.png','Shoes Collection 2019',',widget=forms.TextInput(attrs={\'Placeholder\': \'Email Address\',\'class\': \'form-control\'})');
/*!40000 ALTER TABLE `public_slider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `public_userprofile`
--

DROP TABLE IF EXISTS `public_userprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `public_userprofile` (
  `id` int NOT NULL AUTO_INCREMENT,
  `stripe_customer_id` varchar(50) DEFAULT NULL,
  `one_click_purchasing` tinyint(1) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `public_userprofile_user_id_547c3957_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `public_userprofile`
--

LOCK TABLES `public_userprofile` WRITE;
/*!40000 ALTER TABLE `public_userprofile` DISABLE KEYS */;
INSERT INTO `public_userprofile` VALUES (1,'cus_HLWiNwA5hkik8l',1,1),(3,NULL,0,3),(4,NULL,0,4);
/*!40000 ALTER TABLE `public_userprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialaccount`
--

DROP TABLE IF EXISTS `socialaccount_socialaccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socialaccount_socialaccount` (
  `id` int NOT NULL AUTO_INCREMENT,
  `provider` varchar(30) NOT NULL,
  `uid` varchar(191) NOT NULL,
  `last_login` datetime(6) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `extra_data` longtext NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialaccount_provider_uid_fc810c6e_uniq` (`provider`,`uid`),
  KEY `socialaccount_socialaccount_user_id_8146e70c_fk_auth_user_id` (`user_id`),
  CONSTRAINT `socialaccount_socialaccount_user_id_8146e70c_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialaccount`
--

LOCK TABLES `socialaccount_socialaccount` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialaccount` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialaccount_socialaccount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialapp`
--

DROP TABLE IF EXISTS `socialaccount_socialapp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socialaccount_socialapp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `provider` varchar(30) NOT NULL,
  `name` varchar(40) NOT NULL,
  `client_id` varchar(191) NOT NULL,
  `secret` varchar(191) NOT NULL,
  `key` varchar(191) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialapp`
--

LOCK TABLES `socialaccount_socialapp` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialapp` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialaccount_socialapp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialapp_sites`
--

DROP TABLE IF EXISTS `socialaccount_socialapp_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socialaccount_socialapp_sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `socialapp_id` int NOT NULL,
  `site_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialapp_sites_socialapp_id_site_id_71a9a768_uniq` (`socialapp_id`,`site_id`),
  KEY `socialaccount_socialapp_sites_site_id_2579dee5_fk_django_site_id` (`site_id`),
  CONSTRAINT `socialaccount_social_socialapp_id_97fb6e7d_fk_socialacc` FOREIGN KEY (`socialapp_id`) REFERENCES `socialaccount_socialapp` (`id`),
  CONSTRAINT `socialaccount_socialapp_sites_site_id_2579dee5_fk_django_site_id` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialapp_sites`
--

LOCK TABLES `socialaccount_socialapp_sites` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialapp_sites` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialaccount_socialapp_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialtoken`
--

DROP TABLE IF EXISTS `socialaccount_socialtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socialaccount_socialtoken` (
  `id` int NOT NULL AUTO_INCREMENT,
  `token` longtext NOT NULL,
  `token_secret` longtext NOT NULL,
  `expires_at` datetime(6) DEFAULT NULL,
  `account_id` int NOT NULL,
  `app_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialtoken_app_id_account_id_fca4e0ac_uniq` (`app_id`,`account_id`),
  KEY `socialaccount_social_account_id_951f210e_fk_socialacc` (`account_id`),
  CONSTRAINT `socialaccount_social_account_id_951f210e_fk_socialacc` FOREIGN KEY (`account_id`) REFERENCES `socialaccount_socialaccount` (`id`),
  CONSTRAINT `socialaccount_social_app_id_636a42d7_fk_socialacc` FOREIGN KEY (`app_id`) REFERENCES `socialaccount_socialapp` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialtoken`
--

LOCK TABLES `socialaccount_socialtoken` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialtoken` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialaccount_socialtoken` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-08 20:07:36
