-- MySQL dump 10.13  Distrib 5.7.22, for Linux (x86_64)
--
-- Host: localhost    Database: mainDB
-- ------------------------------------------------------
-- Server version	5.7.22-0ubuntu0.17.10.1

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
-- Table structure for table `Dzialy`
--

DROP TABLE IF EXISTS `Dzialy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Dzialy` (
  `dzial_id` int(11) NOT NULL AUTO_INCREMENT,
  `nazwa` varchar(30) NOT NULL,
  PRIMARY KEY (`dzial_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Dzialy`
--

LOCK TABLES `Dzialy` WRITE;
/*!40000 ALTER TABLE `Dzialy` DISABLE KEYS */;
INSERT INTO `Dzialy` VALUES (1,'LOGISTYKA'),(2,'SPRZEDAZ'),(3,'PRODUKCJA');
/*!40000 ALTER TABLE `Dzialy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Odbicia`
--

DROP TABLE IF EXISTS `Odbicia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Odbicia` (
  `odbicie_id` int(11) NOT NULL AUTO_INCREMENT,
  `godzina` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `We_Wy` varchar(2) NOT NULL,
  `pracownik_id` int(11) NOT NULL,
  PRIMARY KEY (`odbicie_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Odbicia`
--

LOCK TABLES `Odbicia` WRITE;
/*!40000 ALTER TABLE `Odbicia` DISABLE KEYS */;
INSERT INTO `Odbicia` VALUES (2,'2018-06-02 12:27:44','Wy',6),(3,'2018-06-02 00:32:03','We',6),(4,'2018-06-02 00:32:04','We',6),(5,'2018-06-02 02:36:16','We',6),(6,'2018-06-02 02:36:18','We',6),(7,'2018-06-02 02:36:18','We',6),(8,'2018-06-02 02:36:19','We',6),(9,'2018-06-02 02:36:19','We',6),(10,'2018-06-02 02:36:20','We',6),(11,'2018-06-02 02:36:20','We',6),(12,'2018-06-02 02:36:25','Wy',6),(13,'2018-06-02 02:36:26','Wy',6),(14,'2018-06-02 02:36:27','Wy',6);
/*!40000 ALTER TABLE `Odbicia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pracownicy`
--

DROP TABLE IF EXISTS `Pracownicy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Pracownicy` (
  `pracownik_id` int(11) NOT NULL AUTO_INCREMENT,
  `imie` varchar(30) NOT NULL,
  `nazwisko` varchar(30) NOT NULL,
  `data_urodzenia` date NOT NULL,
  `data_dodania` date NOT NULL,
  `plec` char(1) NOT NULL,
  `stanowisko_id` int(11) NOT NULL,
  PRIMARY KEY (`pracownik_id`),
  KEY `Pracownicy_Stanowisko` (`stanowisko_id`),
  CONSTRAINT `Pracownicy_Stanowisko` FOREIGN KEY (`stanowisko_id`) REFERENCES `Stanowiska` (`stanowisko_id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pracownicy`
--

LOCK TABLES `Pracownicy` WRITE;
/*!40000 ALTER TABLE `Pracownicy` DISABLE KEYS */;
INSERT INTO `Pracownicy` VALUES (6,'Czarek','Cebulski','1976-05-10','2010-01-05','m',2),(7,'Stanislaw','Moniuszko','1967-10-13','2011-04-11','m',2),(9,'Roksana','Roniek','2000-01-23','2013-10-05','k',4),(10,'Wiktoria','Mikulska','1999-03-08','2012-11-14','k',5),(11,'Adam','Mickiewicz','1976-06-25','2011-04-19','m',6);
/*!40000 ALTER TABLE `Pracownicy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Stanowiska`
--

DROP TABLE IF EXISTS `Stanowiska`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Stanowiska` (
  `stanowisko_id` int(11) NOT NULL AUTO_INCREMENT,
  `nazwa_stanowiska` varchar(30) NOT NULL,
  `stawka_godz` double(5,2) NOT NULL,
  `godz_rozpoczecia_naliczania_oplaty` time NOT NULL,
  `godz_zakonczenia_naliczania_oplaty` time NOT NULL,
  `dzial_id` int(11) NOT NULL,
  PRIMARY KEY (`stanowisko_id`),
  KEY `Stanowisko_Dzial` (`dzial_id`),
  CONSTRAINT `Stanowisko_Dzial` FOREIGN KEY (`dzial_id`) REFERENCES `Dzialy` (`dzial_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Stanowiska`
--

LOCK TABLES `Stanowiska` WRITE;
/*!40000 ALTER TABLE `Stanowiska` DISABLE KEYS */;
INSERT INTO `Stanowiska` VALUES (1,'SPECJALISTA DO SPRAW LOGISTYKI',20.00,'08:00:00','22:00:00',1),(2,'KIEROWCA',15.00,'03:00:00','24:00:00',1),(4,'SPRZEDAWCA',13.00,'07:00:00','17:00:00',2),(5,'KONSULTANT',13.00,'07:00:00','17:00:00',2),(6,'TLUMACZ',19.00,'07:00:00','17:00:00',2),(7,'PRACOWNIK FIZYCZNY',10.00,'07:00:00','17:00:00',3),(8,'KIEROWNIK PRODUKCJI',15.00,'07:00:00','17:00:00',3);
/*!40000 ALTER TABLE `Stanowiska` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Wynagrodzenie`
--

DROP TABLE IF EXISTS `Wynagrodzenie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Wynagrodzenie` (
  `wynagrodzenia_id` int(11) NOT NULL AUTO_INCREMENT,
  `pracownik_id` int(11) NOT NULL,
  `wyplata` double(11,2) NOT NULL,
  PRIMARY KEY (`wynagrodzenia_id`),
  KEY `Wynagrodzenie_Pracownicy` (`pracownik_id`),
  CONSTRAINT `Wynagrodzenie_Pracownicy` FOREIGN KEY (`pracownik_id`) REFERENCES `Pracownicy` (`pracownik_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Wynagrodzenie`
--

LOCK TABLES `Wynagrodzenie` WRITE;
/*!40000 ALTER TABLE `Wynagrodzenie` DISABLE KEYS */;
/*!40000 ALTER TABLE `Wynagrodzenie` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-06-03 15:54:18
