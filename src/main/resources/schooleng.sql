-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: localhost    Database: schooleng
-- ------------------------------------------------------
-- Server version	8.0.22

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `attachedproduct`
--

DROP TABLE IF EXISTS `attachedproduct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attachedproduct` (
  `MainProductID` int NOT NULL,
  `AttachedProductID` int NOT NULL,
  PRIMARY KEY (`MainProductID`,`AttachedProductID`),
  KEY `FK_AttachedProduct_Product1` (`AttachedProductID`),
  CONSTRAINT `FK_AttachedProduct_Product` FOREIGN KEY (`MainProductID`) REFERENCES `product` (`ID`),
  CONSTRAINT `FK_AttachedProduct_Product1` FOREIGN KEY (`AttachedProductID`) REFERENCES `product` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attachedproduct`
--

LOCK TABLES `attachedproduct` WRITE;
/*!40000 ALTER TABLE `attachedproduct` DISABLE KEYS */;
/*!40000 ALTER TABLE `attachedproduct` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `LastName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Patronymic` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `Birthday` date DEFAULT NULL,
  `RegistrationDate` datetime(6) NOT NULL,
  `Email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `Phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `GenderCode` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `PhotoPath` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_Client_Gender` (`GenderCode`),
  CONSTRAINT `FK_Client_Gender` FOREIGN KEY (`GenderCode`) REFERENCES `gender` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientservice`
--

DROP TABLE IF EXISTS `clientservice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientservice` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ClientID` int NOT NULL,
  `ServiceID` int NOT NULL,
  `StartTime` datetime(6) NOT NULL,
  `Comment` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`ID`),
  KEY `FK_ClientService_Client` (`ClientID`),
  KEY `FK_ClientService_Service` (`ServiceID`),
  CONSTRAINT `FK_ClientService_Client` FOREIGN KEY (`ClientID`) REFERENCES `client` (`ID`),
  CONSTRAINT `FK_ClientService_Service` FOREIGN KEY (`ServiceID`) REFERENCES `service` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientservice`
--

LOCK TABLES `clientservice` WRITE;
/*!40000 ALTER TABLE `clientservice` DISABLE KEYS */;
/*!40000 ALTER TABLE `clientservice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documentbyservice`
--

DROP TABLE IF EXISTS `documentbyservice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documentbyservice` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ClientServiceID` int NOT NULL,
  `DocumentPath` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_DocumentByService_ClientService` (`ClientServiceID`),
  CONSTRAINT `FK_DocumentByService_ClientService` FOREIGN KEY (`ClientServiceID`) REFERENCES `clientservice` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentbyservice`
--

LOCK TABLES `documentbyservice` WRITE;
/*!40000 ALTER TABLE `documentbyservice` DISABLE KEYS */;
/*!40000 ALTER TABLE `documentbyservice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gender`
--

DROP TABLE IF EXISTS `gender`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gender` (
  `code` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `NameGender` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gender`
--

LOCK TABLES `gender` WRITE;
/*!40000 ALTER TABLE `gender` DISABLE KEYS */;
INSERT INTO `gender` VALUES ('1','м'),('2','ж');
/*!40000 ALTER TABLE `gender` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manufacturer`
--

DROP TABLE IF EXISTS `manufacturer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manufacturer` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `LastVisitDate` date DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manufacturer`
--

LOCK TABLES `manufacturer` WRITE;
/*!40000 ALTER TABLE `manufacturer` DISABLE KEYS */;
INSERT INTO `manufacturer` VALUES (1,'Princeton Review','2015-01-06'),(2,'Кнорус','2017-08-18'),(3,'Яуза','2015-10-22'),(4,'Аванта+','2017-02-22'),(5,'Dorling Kindersley','2015-01-02'),(6,'Delta Publishing','2017-05-17'),(7,'Проспект','2017-11-16'),(8,'Express Publishing','2016-09-15'),(9,'Эксмо-Пресс','2018-02-26'),(10,'Розовый жираф','2017-09-20'),(11,'Стандарт-Коллекция','2015-11-07'),(12,'Медиарама','2016-10-17'),(13,'Вагриус','2018-06-07'),(14,'Академкнига','2015-05-13'),(15,'Прогресс','2018-06-16'),(16,'Возвращение','2017-01-16'),(17,'АСТ','2017-10-31'),(18,'Ladybird','2017-02-15'),(19,'ЛитРес','2017-06-21'),(20,'Матезис','2017-10-12'),(21,'Gallimard','2016-08-23'),(22,'Современник','2016-03-16'),(23,'Алгоритм','2015-07-21'),(24,'Антология','2017-06-04'),(25,'Росмэн','2017-04-14'),(26,'Просвещение','2018-03-24'),(27,'Мир хобби','2016-09-27'),(28,'Попурри','2015-05-24'),(29,'Феникс','2016-09-07'),(30,'Абрис','2017-10-24'),(31,'Де Агостини','2015-08-08'),(32,'Виват','2018-04-11'),(33,'Весь мир','2017-10-31'),(34,'Велес-ВА','2017-09-09'),(35,'Дрофа','2015-08-16'),(36,'Эксмо','2015-03-16'),(37,'Аврора','2016-09-24'),(38,'Cambridge','2015-08-18'),(39,'Планета','2017-11-04'),(40,'Вита Нова','2017-03-28'),(41,'РОССПЭН','2017-09-04'),(42,'Мир','2017-11-18'),(43,'Росток','2017-10-20'),(44,'Питер','2018-05-06'),(45,'Вита-Пресс','2016-10-25'),(46,'Литературная Россия','2015-02-03'),(47,'Флинта','2017-04-10'),(48,'Академический проект','2016-12-02'),(49,'ИНФРА-М','2015-11-21'),(50,'Прометей','2017-02-11');
/*!40000 ALTER TABLE `manufacturer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Cost` decimal(19,4) NOT NULL,
  `Description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `MainImagePath` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `IsActive` tinyint(1) NOT NULL,
  `ManufacturerID` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_Product_Manufacturer` (`ManufacturerID`),
  CONSTRAINT `FK_Product_Manufacturer` FOREIGN KEY (`ManufacturerID`) REFERENCES `manufacturer` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'Super Minds. Level 4. Workbook with Online Resources',1210.0000,'Cambridge','image\\701132.jpg',0,38),(2,'Super Minds. Workbook 2 with Online Resources',1200.0000,'Cambridge','image\\701128.jpg',1,38),(3,'Eyes Open. Level 3. Student\'s Book\'',1350.0000,'Cambridge','image\\700890.jpg',1,38),(4,'Advanced Grammar in Use. Book without Answers',1850.0000,'Cambridge','image\\700673.jpg',1,38),(5,'Английский на каждый день',670.0000,'АСТ','image\\698477.jpg',1,17),(6,'English for Everyone. English Vocabulary Builder',1980.0000,'DorlingKindersley','image\\715802.jpg',1,5),(7,'Cracking GMAT Premium 2020 Edition. 6 Practice Tests',3140.0000,'PrincetonReview','image\\724652.jpg',1,1),(8,'Учебник английского языка. Полный курс',1000.0000,'Эксмо','image\\729944.jpg',1,36),(9,'Английский без страха для тех, кому за...',290.0000,'АСТ','image\\720888.jpg',1,17),(10,'Grammarway 2. Teacher\'s Book. Elementary\'',910.0000,'ExpressPublishing','image\\702075.jpg',1,8),(11,'Tree or Three? An elementary pronunciation course',1870.0000,'Cambridge','image\\701141.jpg',1,38),(12,'Prism Reading. Intro. Student\'s Book\'',2930.0000,'Cambridge','image\\699858.jpg',1,38),(13,'Think. Level 3. B1+. Student\'s Book\'',1640.0000,'Cambridge','image\\701135.jpg',1,38),(14,'Учим английский язык с енотами-полиглотами',340.0000,'АСТ','image\\724934.jpg',1,17),(15,'Super Minds. Workbook 1 with Online Resources',1230.0000,'Cambridge','image\\701125.jpg',1,38),(16,'Говори как английская королева. The Queen\'s English and how to use it\'',420.0000,'АСТ','image\\699791.jpg',1,17),(17,'Dive in! Blue',630.0000,'DeltaPublishing','image\\729198.jpg',1,6),(18,'Вся грамматика английского языка в таблицах. Учебное пособие',390.0000,'Флинта','image\\716788.jpg',1,47),(19,'New Enterprise A2. Workbook with digibook app',1220.0000,'ExpressPublishing','image\\701884.jpg',1,8),(20,'Eyes Open Level 1 Student\'s Book\'',1340.0000,'Cambridge','image\\700889.jpg',1,38),(21,'Английский язык. Популярный иллюстрированный самоучитель',400.0000,'АСТ','image\\726891.jpg',1,17),(22,'Grammarway 1. Book with Answers. Beginner',1270.0000,'ExpressPublishing','image\\702074.jpg',1,8),(23,'Business Vocabulary in Use. Advanced. Book with Answers',2220.0000,'Cambridge','image\\700674.jpg',1,38),(24,'Разговорный английский в диалогах. Учебное пособие',1140.0000,'Кнорус','image\\730838.jpg',1,2),(25,'Английский без барьеров. For beginners',420.0000,'Питер','image\\722958.jpg',1,44),(26,'Pocket English Grammar (Карманная грамматика английского языка). Справочное пособие',390.0000,'ИНФРА-М','image\\690825.jpg',1,49),(27,'Evolve. Level 1. Student\'s Book\'',1840.0000,'Cambridge','image\\702640.jpg',0,38),(28,'Реальный English. Как подружиться с грамматикой раз и навсегда',690.0000,'Феникс','image\\704508.jpg',1,29),(29,'English Vocabulary in Use. Advanced. Book with Answers',1860.0000,'Cambridge','image\\700703.jpg',0,38),(30,'Быстрый английский. Тренажер по чтению',240.0000,'АСТ','image\\715170.jpg',1,17),(31,'Деловой английский язык. (Бакалавриат и магистратура). Учебное пособие',1080.0000,'Кнорус','image\\712853.jpg',1,2),(32,'Английский язык. Самые нужные правила',180.0000,'АСТ','image\\729858.jpg',1,17),(33,'Legal English. Английский язык для юристов. Учебник',2720.0000,'ИНФРА-М','image\\707289.jpg',1,49),(34,'OK English! Все правила английского языка с упражнениями',370.0000,'АСТ','image\\694544.jpg',1,17),(35,'Dive in! Orange',650.0000,'DeltaPublishing','image\\729200.jpg',1,6),(36,'Английская грамматика. Просто и понятно: правила, модели, упражнения. Учебное пособие',2060.0000,'Прометей','image\\716808.jpg',1,50),(37,'Grammar in Use. Intermediate. Student\'s Book without Answers\'',1740.0000,'Cambridge','image\\700903.jpg',0,38),(38,'Современная английская грамматика в таблицах',340.0000,'Эксмо-Пресс','image\\721525.jpg',1,9),(39,'Everyday Vocabulary + Grammar. For Intermediate Students. Учебное пособие',1180.0000,'Антология','image\\722745.jpg',1,24),(40,'English for Everyone. English Idioms',2290.0000,'DorlingKindersley','image\\715801.jpg',1,5),(41,'Вся грамматика английского языка. Теория и практика',410.0000,'АСТ','image\\724335.jpg',1,17),(42,'Говорим по-английски',220.0000,'Виват','image\\706297.jpg',1,32),(43,'Business Vocabulary in Use. Intermediate. Book with Answers and Enhanced ebook',2690.0000,'Cambridge','image\\700676.jpg',1,38),(44,'Безупречная английская грамматика. Простые правила и увлекательные тесты',720.0000,'АСТ','image\\723769.jpg',1,17),(45,'Exam Booster For Advanced Without Ans Key + Audio',1300.0000,'Cambridge','image\\714676.jpg',1,38),(46,'Grammar in Use. Intermediate. Student\'s Book with Answers and Interactive eBook\'',2380.0000,'Cambridge','image\\700900.jpg',0,38),(47,'Английская грамматика в схемах и таблицах',170.0000,'АСТ','image\\713804.jpg',1,17),(48,'Английский язык. Тренажер по чтению',170.0000,'АСТ','image\\710082.jpg',1,17),(49,'Английский язык для технических специальностей. Учебное пособие',2550.0000,'ИНФРА-М','image\\730048.jpg',0,49),(50,'Интенсивный английский hibernate 4 в 1: говорим, читаем, пишем, слушаем',1840.0000,'Прометей','image\\716807.jpg',1,50),(51,'Английские пословицы и поговорки. Учебное пособие',260.0000,'Флинта','image\\714143.jpg',0,47),(52,'Super Minds. Level 3. Workbook with Online Resources',1200.0000,'Cambridge','image\\701130.jpg',1,38),(53,'Английский язык. Времена глаголов',150.0000,'АСТ','image\\710081.jpg',1,17),(54,'Английский курсив: прописи',300.0000,'Яуза','image\\715875.jpg',0,3),(55,'Английский язык. Фразовые глаголы',160.0000,'АСТ','image\\710083.jpg',1,17),(56,'English for Beginners: Everyday English',330.0000,'Ladybird','image\\693086.jpg',1,18),(57,'Курс английской разговорной речи. Учебное пособие',1790.0000,'Прометей','image\\722820.jpg',1,50),(58,'New Enterprise A2 Student\'s Book with DigiBooks App\'',1650.0000,'ExpressPublishing','image\\701882.jpg',1,8),(59,'Business Vocabulary in Use. Advanced. Book with Answers and Enhanced ebook',2840.0000,'Cambridge','image\\700675.jpg',1,38),(60,'Prepare. Level 2. Student\'s Book\'',1780.0000,'Cambridge','image\\701088.jpg',0,38),(61,'Your Space Level 2 Student\'s Book\'',1380.0000,'Cambridge','image\\701151.jpg',1,38),(62,'Вся английская грамматика в схемах и таблицах',370.0000,'АСТ','image\\729025.jpg',0,17),(63,'Dive in! Green',640.0000,'DeltaPublishing','image\\729199.jpg',0,6),(64,'English Grammar Today Book with Workbook',4110.0000,'Cambridge','image\\700707.jpg',0,38),(65,'Разговорная грамматика английского языка',360.0000,'АСТ','image\\725306.jpg',1,17),(66,'Think. Level 3. B1+. Workbook with Online Practice',1140.0000,'Cambridge','image\\701138.jpg',1,38),(67,'Английский язык за 3 месяца. Быстрый восстановитель знаний',270.0000,'АСТ','image\\714131.jpg',1,17),(68,'Prepare. Level 4. B1. Student\'s Book\'',1810.0000,'Cambridge','image\\701097.jpg',1,38),(69,'Английский язык. Идиомы (полезные карточки)',140.0000,'АСТ','image\\729857.jpg',1,17),(70,'Английский язык. Все времена и глаголы в схемах и таблицах',350.0000,'АСТ','image\\729495.jpg',1,17),(71,'Английский с нуля. Учебное пособие',1840.0000,'Прометей','image\\716806.jpg',1,50),(72,'English Vocabulary in Use. Elementary. Book with Answers and Enhanced eBook',2380.0000,'Cambridge','image\\700704.jpg',1,38),(73,'Каллиграфия. Английский курсив. Самоучитель',270.0000,'Яуза','image\\721737.jpg',0,3),(74,'Ship or Sheep? An intermediate pronunciation course',2210.0000,'Cambridge','image\\701112.jpg',1,38),(75,'Eyes Open. Level 3. Workbook with Online Practice',1110.0000,'Cambridge','image\\700891.jpg',1,38),(76,'New Enterprise A2 - Grammar Book (with Digibooks App)',1250.0000,'ExpressPublishing','image\\701883.jpg',1,8),(77,'Cracking the GRE Premium Edition with 6 Practice Tests, 2020',3110.0000,'PrincetonReview','image\\730252.jpg',1,1),(78,'Prepare. Level 5. B1. Student\'s Book\'',1790.0000,'Cambridge','image\\701098.jpg',1,38),(79,'Английский язык для менеджеров. Учебное пособие',1280.0000,'Прометей','image\\693032.jpg',1,50),(80,'Учебник английского языка. Часть 2',690.0000,'Эксмо','image\\717996.jpg',1,36),(81,'Быстрый английский для начинающих',230.0000,'АСТ','image\\714137.jpg',1,17),(82,'Prepare. Level 3. A2. Student\'s Book\'',1810.0000,'Cambridge','image\\701094.jpg',1,38),(83,'Тренажер по чтению. Самый быстрый способ выучить английский язык',120.0000,'АСТ','image\\718058.jpg',0,17),(84,'English Vocabulary in Use. Upper-Intermediate. Book with Answers',1890.0000,'Cambridge','image\\700705.jpg',1,38),(85,'Professional English for PR Students: People and Society',780.0000,'Прометей','image\\716803.jpg',1,50),(86,'Английский язык. Идиомы',130.0000,'АСТ','image\\713805.jpg',1,17),(87,'Elementary Vocabulary + Grammar. Foe Beginners and Pre-Intermediate Students. Учебное пособие',960.0000,'Антология','image\\731489.jpg',0,24),(88,'Самый быстрый способ выучить неправильные английские глаголы',70.0000,'АСТ','image\\718057.jpg',1,17),(89,'English Grammar in Use. Book without Answers',1760.0000,'Cambridge','image\\700691.jpg',0,38),(90,'Английская грамматика. Самое важное. Учебное пособие (мини)',80.0000,'Проспект','image\\726085.jpg',1,7),(91,'Grammar in Use Intermediate Student\'s Book with Answers Self-study Reference and Practice\'',1950.0000,'Cambridge','image\\700901.jpg',1,38),(92,'English Grammar in Use. Book with Answers',1950.0000,'Cambridge','image\\700689.jpg',1,38),(93,'Английский для малышей и мам @my_english_baby. Как воспитать билингвального ребенка',390.0000,'АСТ','image\\718408.jpg',1,17),(94,'Грамматический профиль. Grammar Profile. Учебное пособие',450.0000,'Флинта','image\\710904.jpg',0,47),(95,'Английский язык на пальцах',360.0000,'АСТ','image\\712495.jpg',0,17),(96,'Prepare. Level 2. A2. Workbook with Audio Download',1340.0000,'Cambridge','image\\701093.jpg',1,38),(97,'Учебник английского языка. Часть 1',710.0000,'Эксмо','image\\713136.jpg',1,36),(98,'Грамматика английского языка. Просто и доступно. Учебное пособие',450.0000,'Флинта','image\\696499.jpg',0,47),(99,'Безупречный английский. Самоучитель для начинающих',680.0000,'АСТ','image\\727495.jpg',1,17),(100,'Your Space. Level 1. Student\'s Book\'',1370.0000,'Cambridge','image\\701149.jpg',1,38);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productphoto`
--

DROP TABLE IF EXISTS `productphoto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productphoto` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ProductID` int NOT NULL,
  `PhotoPath` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_ProductPhoto_Product` (`ProductID`),
  CONSTRAINT `FK_ProductPhoto_Product` FOREIGN KEY (`ProductID`) REFERENCES `product` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productphoto`
--

LOCK TABLES `productphoto` WRITE;
/*!40000 ALTER TABLE `productphoto` DISABLE KEYS */;
/*!40000 ALTER TABLE `productphoto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productsale`
--

DROP TABLE IF EXISTS `productsale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productsale` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `SaleDate` datetime(6) NOT NULL,
  `ProductID` int NOT NULL,
  `Quantity` int NOT NULL,
  `ClientServiceID` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_ProductSale_Product` (`ProductID`),
  KEY `FK_ProductSale_ClientService` (`ClientServiceID`),
  CONSTRAINT `FK_ProductSale_ClientService` FOREIGN KEY (`ClientServiceID`) REFERENCES `clientservice` (`ID`),
  CONSTRAINT `FK_ProductSale_Product` FOREIGN KEY (`ProductID`) REFERENCES `product` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productsale`
--

LOCK TABLES `productsale` WRITE;
/*!40000 ALTER TABLE `productsale` DISABLE KEYS */;
INSERT INTO `productsale` VALUES (1,'2019-10-13 00:00:00.000000',1,1,NULL),(2,'2019-03-11 00:00:00.000000',2,1,NULL),(3,'2019-08-10 00:00:00.000000',3,1,NULL),(4,'2019-05-22 00:00:00.000000',4,1,NULL),(5,'2019-02-09 00:00:00.000000',5,2,NULL),(6,'2019-07-13 00:00:00.000000',6,2,NULL),(7,'2019-05-26 00:00:00.000000',7,1,NULL),(8,'2019-03-28 00:00:00.000000',1,1,NULL),(9,'2019-10-22 00:00:00.000000',9,2,NULL),(10,'2019-03-04 00:00:00.000000',10,2,NULL),(11,'2019-09-17 00:00:00.000000',11,1,NULL),(12,'2019-04-16 00:00:00.000000',12,2,NULL),(13,'2019-05-10 00:00:00.000000',13,1,NULL),(14,'2019-04-13 00:00:00.000000',9,2,NULL),(15,'2019-01-31 00:00:00.000000',15,1,NULL),(16,'2019-03-29 00:00:00.000000',16,3,NULL),(17,'2019-08-18 00:00:00.000000',17,1,NULL),(18,'2019-05-19 00:00:00.000000',18,2,NULL),(19,'2019-03-30 00:00:00.000000',19,2,NULL),(20,'2019-06-02 00:00:00.000000',20,1,NULL),(21,'2019-07-05 00:00:00.000000',7,3,NULL),(22,'2019-08-29 00:00:00.000000',22,2,NULL),(23,'2019-03-06 00:00:00.000000',23,3,NULL),(24,'2019-04-03 00:00:00.000000',24,3,NULL),(25,'2019-02-21 00:00:00.000000',25,2,NULL),(26,'2019-09-03 00:00:00.000000',26,1,NULL),(27,'2019-09-26 00:00:00.000000',27,2,NULL),(28,'2019-09-21 00:00:00.000000',25,3,NULL),(29,'2019-01-04 00:00:00.000000',29,1,NULL),(30,'2019-12-07 00:00:00.000000',30,2,NULL),(31,'2019-06-20 00:00:00.000000',31,2,NULL),(32,'2019-02-27 00:00:00.000000',32,1,NULL),(33,'2019-03-02 00:00:00.000000',33,3,NULL),(34,'2019-07-10 00:00:00.000000',34,1,NULL),(35,'2019-11-01 00:00:00.000000',35,3,NULL),(36,'2019-08-26 00:00:00.000000',32,2,NULL),(37,'2019-08-06 00:00:00.000000',37,3,NULL),(38,'2019-11-23 00:00:00.000000',38,2,NULL),(39,'2019-10-15 00:00:00.000000',31,1,NULL),(40,'2019-03-02 00:00:00.000000',7,3,NULL),(41,'2019-02-10 00:00:00.000000',41,3,NULL),(42,'2019-11-29 00:00:00.000000',42,1,NULL),(43,'2019-07-23 00:00:00.000000',43,1,NULL),(44,'2019-12-08 00:00:00.000000',38,2,NULL),(45,'2019-04-09 00:00:00.000000',42,1,NULL),(46,'2019-02-22 00:00:00.000000',46,2,NULL),(47,'2019-08-17 00:00:00.000000',26,2,NULL),(48,'2019-03-11 00:00:00.000000',1,3,NULL),(49,'2019-03-19 00:00:00.000000',49,1,NULL),(50,'2019-10-17 00:00:00.000000',50,1,NULL),(51,'2019-11-26 00:00:00.000000',4,2,NULL),(52,'2019-02-16 00:00:00.000000',52,3,NULL),(53,'2019-12-31 00:00:00.000000',7,3,NULL),(54,'2019-11-19 00:00:00.000000',54,1,NULL),(55,'2019-09-13 00:00:00.000000',55,1,NULL),(56,'2019-12-14 00:00:00.000000',56,2,NULL),(57,'2019-05-20 00:00:00.000000',31,1,NULL),(58,'2019-03-26 00:00:00.000000',58,2,NULL),(59,'2019-09-14 00:00:00.000000',59,2,NULL),(60,'2019-09-06 00:00:00.000000',60,1,NULL),(61,'2019-05-09 00:00:00.000000',61,3,NULL),(62,'2019-03-06 00:00:00.000000',6,2,NULL),(63,'2019-03-29 00:00:00.000000',43,1,NULL),(64,'2019-07-25 00:00:00.000000',64,2,NULL),(65,'2019-10-13 00:00:00.000000',65,3,NULL),(66,'2019-01-06 00:00:00.000000',60,3,NULL),(67,'2019-04-10 00:00:00.000000',54,1,NULL),(68,'2019-05-13 00:00:00.000000',68,1,NULL),(69,'2019-07-25 00:00:00.000000',37,1,NULL),(70,'2019-03-18 00:00:00.000000',31,2,NULL),(71,'2019-01-05 00:00:00.000000',15,3,NULL),(72,'2019-03-25 00:00:00.000000',43,2,NULL),(73,'2019-08-13 00:00:00.000000',73,3,NULL),(74,'2019-03-25 00:00:00.000000',74,2,NULL),(75,'2019-02-18 00:00:00.000000',17,2,NULL),(76,'2019-02-28 00:00:00.000000',55,3,NULL),(77,'2019-06-28 00:00:00.000000',35,1,NULL),(78,'2019-11-04 00:00:00.000000',16,3,NULL),(79,'2019-11-09 00:00:00.000000',79,2,NULL),(80,'2019-05-17 00:00:00.000000',30,2,NULL),(81,'2019-05-29 00:00:00.000000',2,2,NULL),(82,'2019-04-11 00:00:00.000000',22,1,NULL),(83,'2019-04-15 00:00:00.000000',25,1,NULL),(84,'2019-12-04 00:00:00.000000',84,1,NULL),(85,'2019-02-04 00:00:00.000000',85,2,NULL),(86,'2019-03-07 00:00:00.000000',54,3,NULL),(87,'2019-03-04 00:00:00.000000',87,1,NULL),(88,'2019-10-01 00:00:00.000000',43,1,NULL),(89,'2019-05-23 00:00:00.000000',56,1,NULL),(90,'2019-06-10 00:00:00.000000',20,1,NULL),(91,'2019-04-24 00:00:00.000000',91,2,NULL),(92,'2019-03-09 00:00:00.000000',92,2,NULL),(93,'2019-06-09 00:00:00.000000',6,1,NULL),(94,'2019-10-09 00:00:00.000000',9,3,NULL),(95,'2019-07-29 00:00:00.000000',84,3,NULL),(96,'2019-12-16 00:00:00.000000',96,2,NULL),(97,'2019-08-28 00:00:00.000000',91,2,NULL),(98,'2019-06-01 00:00:00.000000',98,2,NULL),(99,'2019-02-04 00:00:00.000000',9,1,NULL),(100,'2019-10-13 00:00:00.000000',26,1,NULL);
/*!40000 ALTER TABLE `productsale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Cost` decimal(19,4) NOT NULL,
  `DurationInSeconds` int NOT NULL,
  `Description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `Discount` double DEFAULT NULL,
  `MainImagePath` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servicephoto`
--

DROP TABLE IF EXISTS `servicephoto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servicephoto` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ServiceID` int NOT NULL,
  `PhotoPath` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_ServicePhoto_Service` (`ServiceID`),
  CONSTRAINT `FK_ServicePhoto_Service` FOREIGN KEY (`ServiceID`) REFERENCES `service` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicephoto`
--

LOCK TABLES `servicephoto` WRITE;
/*!40000 ALTER TABLE `servicephoto` DISABLE KEYS */;
/*!40000 ALTER TABLE `servicephoto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tag` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Title` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Color` char(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tagofclient`
--

DROP TABLE IF EXISTS `tagofclient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tagofclient` (
  `ClientID` int NOT NULL,
  `TagID` int NOT NULL,
  PRIMARY KEY (`ClientID`,`TagID`),
  KEY `FK_TagOfClient_Tag` (`TagID`),
  CONSTRAINT `FK_TagOfClient_Client` FOREIGN KEY (`ClientID`) REFERENCES `client` (`ID`),
  CONSTRAINT `FK_TagOfClient_Tag` FOREIGN KEY (`TagID`) REFERENCES `tag` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tagofclient`
--

LOCK TABLES `tagofclient` WRITE;
/*!40000 ALTER TABLE `tagofclient` DISABLE KEYS */;
/*!40000 ALTER TABLE `tagofclient` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-09 17:42:59
