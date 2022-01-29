-- MySQL dump 10.13  Distrib 5.7.36, for Win64 (x86_64)
--
-- Host: localhost    Database: dbo
-- ------------------------------------------------------
-- Server version	5.7.36-log

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
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=158 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
INSERT INTO `cities` VALUES (42,'Архангельск'),(43,'Астрахань'),(44,'Барнаул'),(47,'Белгород'),(48,'Биробиджан'),(49,'Благовещенск'),(50,'Брянск'),(53,'Великий Новгород'),(55,'Владивосток'),(57,'Владикавказ'),(58,'Владимир'),(60,'Волгоград'),(62,'Вологда'),(65,'Воронеж'),(67,'Горно-Алтайск'),(4,'Екатеринбург'),(69,'Иваново'),(72,'Ижевск'),(74,'Иркутск'),(117,'Йошкар-Ола'),(3,'Казань'),(120,'Калининград'),(121,'Калуга'),(124,'Кемерово'),(126,'Киров'),(129,'Кострома'),(132,'Краснодар'),(135,'Красноярск'),(138,'Курган'),(140,'Курск'),(141,'Кызыл'),(142,'Липецк'),(147,'Магадан'),(146,'Майкоп'),(148,'Махачкала'),(1,'Москва'),(154,'Мурманск'),(155,'Набережные Челны'),(157,'Нальчик'),(41,'Нижний Новгород'),(45,'Новороссийск'),(46,'Новосибирск'),(51,'Омск'),(52,'Орел'),(54,'Оренбург'),(56,'Пенза'),(59,'Пермь'),(61,'Петрозаводск'),(63,'Петропавловск-Камчатский'),(64,'Псков'),(66,'Ростов-на-Дону'),(68,'Рязань'),(70,'Салехард'),(71,'Самара'),(2,'Санкт-Петербург'),(73,'Саранск'),(118,'Саратов'),(119,'Смоленск'),(5,'Сочи'),(122,'Ставрополь'),(123,'Сургут'),(125,'Сыктывкар'),(127,'Тамбов'),(128,'Тверь'),(130,'Тольятти'),(131,'Томск'),(133,'Тула'),(134,'Тюмень'),(136,'Улан-Удэ'),(137,'Ульяновск'),(139,'Уфа'),(143,'Хабаровск'),(144,'Чебоксары'),(145,'Челябинск'),(149,'Череповец'),(150,'Черкесск'),(151,'Чита'),(152,'Южно-Сахалинск'),(153,'Якутск'),(156,'Ярославль');
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friends`
--

DROP TABLE IF EXISTS `friends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friends` (
  `userid` int(11) NOT NULL,
  `friendid` int(11) NOT NULL,
  UNIQUE KEY `user_friends` (`userid`,`friendid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friends`
--

LOCK TABLES `friends` WRITE;
/*!40000 ALTER TABLE `friends` DISABLE KEYS */;
INSERT INTO `friends` VALUES (2,3),(2,4),(3,2),(3,4),(3,81),(79,3),(79,4);
/*!40000 ALTER TABLE `friends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interests`
--

DROP TABLE IF EXISTS `interests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interests`
--

LOCK TABLES `interests` WRITE;
/*!40000 ALTER TABLE `interests` DISABLE KEYS */;
INSERT INTO `interests` VALUES (41,''),(17,'Активный спорт'),(18,'Ведение блога'),(7,'Выращивание цветов'),(1,'Дизайн'),(5,'Иностранные языки'),(16,'Конструирование'),(15,'Копирайтинг'),(40,'мир'),(3,'Написание сценариев'),(39,'огонь'),(9,'Охота'),(12,'Походы'),(14,'Программирование'),(6,'Психология'),(38,'пустота'),(19,'Редактирование видео'),(10,'Ремонтные работы'),(11,'Реставрация'),(8,'Самодельные украшения'),(4,'Спортивные секции'),(2,'Фотосъёмка'),(13,'Шахматы');
/*!40000 ALTER TABLE `interests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_interests`
--

DROP TABLE IF EXISTS `user_interests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_interests` (
  `userid` int(11) NOT NULL,
  `interestsid` int(11) NOT NULL,
  UNIQUE KEY `rowUNIQUE` (`userid`,`interestsid`),
  KEY `id_idx` (`interestsid`),
  CONSTRAINT `fk_interests_user_interests` FOREIGN KEY (`interestsid`) REFERENCES `interests` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_userid_user_interests` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_interests`
--

LOCK TABLES `user_interests` WRITE;
/*!40000 ALTER TABLE `user_interests` DISABLE KEYS */;
INSERT INTO `user_interests` VALUES (80,38),(80,39),(80,40),(81,41),(82,41);
/*!40000 ALTER TABLE `user_interests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `surname` varchar(64) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `sex` tinyint(4) DEFAULT NULL,
  `cityid` int(11) DEFAULT NULL,
  `login` varchar(64) NOT NULL,
  `password` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `login_UNIQUE` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (2,'ivan','Ivanov',33,1,1,'login@gmail.com','698d51a19d8a121ce581499d7b701668'),(3,'Олег','Сидоров',23,1,2,'login1@gmail.com','698d51a19d8a121ce581499d7b701668'),(4,'Оксана','Минаева',26,0,3,'login2@gmail.com','698d51a19d8a121ce581499d7b701668'),(10,'123','423',23,0,145,'login3@gmail.com','698d51a19d8a121ce581499d7b701668'),(79,'ddd','sss',1,1,62,'login4@gmail.com','698d51a19d8a121ce581499d7b701668'),(80,'FFF','DDD',122,0,153,'login6@gmail.com','698d51a19d8a121ce581499d7b701668'),(81,'fdsfs','bcvb',112,0,49,'login7@gmail.com','698d51a19d8a121ce581499d7b701668'),(82,'dsad','fsdds',123,1,42,'login10@gmail.com','698d51a19d8a121ce581499d7b701668');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-01-03 18:10:27
