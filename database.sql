-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: tourmaline
-- ------------------------------------------------------
-- Server version	8.0.29

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
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `createTime` datetime NOT NULL,
  `lastEditedTime` datetime NOT NULL,
  `song` int NOT NULL,
  `username` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_USER_idx` (`username`),
  KEY `FK_COMMENT_USER_idx` (`username`),
  KEY `FK_CommentSong_SongId_idx` (`song`),
  CONSTRAINT `FK_COMMENT_USER` FOREIGN KEY (`username`) REFERENCES `user` (`username`),
  CONSTRAINT `FK_CommentSong_SongId` FOREIGN KEY (`song`) REFERENCES `song` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (3,'@anhquan7826 Ehe','2022-12-07 23:46:07','2022-12-07 23:55:26',41726473,'anhquan7826'),(4,'@anhquan7826 Thang nao vao nick t day dmm','2022-12-07 23:46:22','2022-12-07 23:46:22',41726473,'anhquan7826');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorites` (
  `userid` varchar(45) NOT NULL,
  `songid` int NOT NULL,
  KEY `FK_FAVORITE_USER_idx` (`userid`),
  KEY `FK_FAVORITE_SONG_idx` (`songid`),
  CONSTRAINT `FK_FAVORITE_SONG` FOREIGN KEY (`songid`) REFERENCES `song` (`id`),
  CONSTRAINT `FK_FAVORITE_USER` FOREIGN KEY (`userid`) REFERENCES `user` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorites`
--

LOCK TABLES `favorites` WRITE;
/*!40000 ALTER TABLE `favorites` DISABLE KEYS */;
/*!40000 ALTER TABLE `favorites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `follow`
--

DROP TABLE IF EXISTS `follow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `follow` (
  `username` varchar(45) NOT NULL,
  `following` varchar(45) NOT NULL,
  KEY `FK_FollowUsername_UserUsername_idx` (`username`),
  KEY `FK_FollowFollowing_UserUsername_idx` (`following`),
  CONSTRAINT `FK_FollowFollowing_UserUsername` FOREIGN KEY (`following`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_FollowUsername_UserUsername` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follow`
--

LOCK TABLES `follow` WRITE;
/*!40000 ALTER TABLE `follow` DISABLE KEYS */;
/*!40000 ALTER TABLE `follow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playlist`
--

DROP TABLE IF EXISTS `playlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playlist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `cover_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_PLAYLIST_USER_idx` (`user`),
  CONSTRAINT `FK_PLAYLIST_USER` FOREIGN KEY (`user`) REFERENCES `user` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=1975350825 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playlist`
--

LOCK TABLES `playlist` WRITE;
/*!40000 ALTER TABLE `playlist` DISABLE KEYS */;
INSERT INTO `playlist` VALUES (68301647,'anhquan7826','80s jp pop','68301647.jpg'),(1975350824,'anhquan7826','my playlist',NULL);
/*!40000 ALTER TABLE `playlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playlistsongs`
--

DROP TABLE IF EXISTS `playlistsongs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playlistsongs` (
  `playlistId` int NOT NULL,
  `songId` int NOT NULL,
  PRIMARY KEY (`playlistId`,`songId`),
  KEY `FK_PlaylistSongPlaylistId_PlaylistId_idx` (`playlistId`),
  KEY `FK_PlaylistSongsSongId_SongId_idx` (`songId`,`playlistId`),
  CONSTRAINT `FK_PlaylistSongsPlaylistId_PlaylistId` FOREIGN KEY (`playlistId`) REFERENCES `playlist` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_PlaylistSongsSongId_SongId` FOREIGN KEY (`songId`) REFERENCES `song` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playlistsongs`
--

LOCK TABLES `playlistsongs` WRITE;
/*!40000 ALTER TABLE `playlistsongs` DISABLE KEYS */;
INSERT INTO `playlistsongs` VALUES (68301647,1720979461),(68301647,1847161374),(68301647,1980301390);
/*!40000 ALTER TABLE `playlistsongs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recents`
--

DROP TABLE IF EXISTS `recents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recents` (
  `username` varchar(45) NOT NULL,
  `song` int NOT NULL,
  `added_date` datetime NOT NULL,
  PRIMARY KEY (`username`,`song`),
  KEY `fk_recents_song_idx` (`song`),
  CONSTRAINT `fk_recents_song` FOREIGN KEY (`song`) REFERENCES `song` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_recents_username` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recents`
--

LOCK TABLES `recents` WRITE;
/*!40000 ALTER TABLE `recents` DISABLE KEYS */;
INSERT INTO `recents` VALUES ('anhquan7826',41726473,'2022-12-07 23:53:09'),('anhquan7826',144930306,'2022-11-30 23:20:05');
/*!40000 ALTER TABLE `recents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `song`
--

DROP TABLE IF EXISTS `song`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `song` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uploadTime` datetime NOT NULL,
  `uploader` varchar(45) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text,
  `duration` double DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_USER_idx` (`uploader`),
  CONSTRAINT `FK_SONG_USER` FOREIGN KEY (`uploader`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2146263886 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `song`
--

LOCK TABLES `song` WRITE;
/*!40000 ALTER TABLE `song` DISABLE KEYS */;
INSERT INTO `song` VALUES (16919402,'2022-12-02 19:29:22','anhquan7826','new stage','',0),(24665185,'2022-12-02 19:29:21','anhquan7826','Drive','',0),(41726473,'2022-12-07 22:11:22','anhquan7826','I love my dog','',268.643),(45212631,'2022-12-02 19:29:20','anhquan7826','Colors','',0),(82352503,'2022-12-02 19:29:23','anhquan7826','Wanderer','',0),(101157243,'2022-12-02 19:29:22','anhquan7826','Romantic Travel','',0),(114652819,'2022-12-02 19:29:23','anhquan7826','? TAKE ME HOME ? — FEAT. WISHLYST [AIKA REMIX]','',0),(117946796,'2022-12-02 19:29:21','anhquan7826','Lost','',0),(124521406,'2022-12-02 19:29:20','anhquan7826','Claires - Evening Sky','',0),(131703190,'2022-12-02 19:29:22','anhquan7826','noguchii & Jecan - Anymore','',0),(144930306,'2022-11-30 23:17:05','anhquan7826','Magical Candy','',0),(165911875,'2022-12-02 19:29:21','anhquan7826','Lois - Spotlight','',0),(189369224,'2022-12-02 19:46:22','anhquan7826','04 C418 - Death','',0),(196896603,'2022-12-02 19:29:21','anhquan7826','KMNZ - VR (GF ElectroHouse Bootleg)','',0),(204029025,'2022-12-02 19:29:22','anhquan7826','Remember Me','',0),(206879533,'2022-12-02 19:48:04','anhquan7826','Mat. - Perspective EP Track 5','',0),(214631054,'2022-12-02 19:29:20','anhquan7826','breeze','',0),(238957802,'2022-12-02 19:29:21','anhquan7826','Happy Kuru Kuru - Hanbunko Hanabi (Kabuki Remix)','',0),(272565980,'2022-12-02 19:29:21','anhquan7826','Like A Sweet','',0),(287897962,'2022-12-02 19:48:05','anhquan7826','Mat. - Perspective EP Track 7','',0),(313529512,'2022-12-02 19:29:23','anhquan7826','You & Me (Feat.Plemoon)','',0),(346643694,'2022-11-30 23:17:04','anhquan7826','Dance Down','',0),(349288679,'2022-11-30 23:17:05','anhquan7826','Night Tempo - Yukiko','',0),(385237912,'2022-11-30 23:17:05','anhquan7826','Greyl - Planetarium','',0),(393898071,'2022-12-02 19:29:22','anhquan7826','Phantasy','',0),(417570392,'2022-12-02 19:29:23','anhquan7826','Twinkle Layer','',0),(451890113,'2022-12-02 19:29:21','anhquan7826','Jade Key & Meredith Bull - Breathe (Author wind remix)','',0),(465914001,'2022-12-02 19:29:20','anhquan7826','Bloom','',0),(482869611,'2022-12-02 19:48:04','anhquan7826','Mat. - Perspective EP Track 3','',0),(485091761,'2022-12-02 19:29:22','anhquan7826','My Heart','',0),(493068892,'2022-12-02 19:29:22','anhquan7826','Relive','',0),(497055592,'2022-12-02 19:29:22','anhquan7826','Sakura (feat. Kimura Rin) [PIKASONIC Remix]','',0),(505261946,'2022-11-30 23:17:06','anhquan7826','【﻿ｆａｎｔａｓｙ】 MEIKO NAKAHARA (1982)','',0),(512886986,'2022-12-02 19:29:21','anhquan7826','Ferst & Zentra - Pastel Sky (feat. Rainy)(Amidst Remix)','',0),(514405900,'2022-12-02 19:29:22','anhquan7826','MojiX! x Elkuu - Minamo','',0),(565477168,'2022-11-30 23:17:06','anhquan7826','悲しみFOREVER [失恋Rhapsody] EP','',0),(572977732,'2022-12-02 19:29:21','anhquan7826','Flow [5k Followers]','',0),(644362288,'2022-12-02 19:29:21','anhquan7826','Forest','',0),(650949325,'2022-12-02 19:29:20','anhquan7826','COR!S - Moon Garden (GHOST DATA Remix)','',0),(675394911,'2022-12-02 19:29:22','anhquan7826','Moe Punch','',0),(686138791,'2022-12-02 19:29:22','anhquan7826','Mirror','',0),(690090236,'2022-12-02 19:29:22','anhquan7826','Over-Hit!','',0),(702742878,'2022-12-02 19:29:23','anhquan7826','Starlight','',0),(720783535,'2022-12-02 19:29:23','anhquan7826','World (WPIKASONIC)','',0),(733691765,'2022-12-02 19:29:20','anhquan7826','AbyanF - True','',0),(753308253,'2022-12-02 19:29:22','anhquan7826','Ohayou!','',0),(772830337,'2022-12-02 19:29:20','anhquan7826','Artificial','',0),(779739787,'2022-12-02 19:29:22','anhquan7826','Pikasonic - Asuka','',0),(786435040,'2022-12-02 19:29:23','anhquan7826','Virtual (w Puniden)','',0),(794202302,'2022-12-02 19:48:04','anhquan7826','Mat. - Perspective EP Track 4','',0),(827604666,'2022-12-02 19:29:21','anhquan7826','Emptiness','',0),(836437411,'2022-12-02 19:29:22','anhquan7826','Setsuna (Kirara Magic Remix)','',0),(860079903,'2022-12-02 19:29:22','anhquan7826','Rain (w KITSUNE)','',0),(889415535,'2022-12-02 19:29:22','anhquan7826','Osaka Express','',0),(907395639,'2022-12-02 19:48:05','anhquan7826','Mat. - Perspective EP Track 6','',0),(925220689,'2022-12-02 19:29:22','anhquan7826','PIKASONIC - Horizon','',0),(928805643,'2022-12-02 19:29:22','anhquan7826','PIKASONIC - Wildflowers [UXN Release]','',0),(929863895,'2022-11-30 23:17:06','anhquan7826','Yasuha - Flyday Chinatown (Night Tempo Edit)','',0),(934738827,'2022-12-02 19:29:22','anhquan7826','Nostalgica','',0),(946027106,'2022-12-02 19:29:21','anhquan7826','Edge Of The Way','',0),(958018574,'2022-12-02 19:29:20','anhquan7826','AByanF - Slidewalk 『Dubstep』','',0),(988715273,'2022-11-30 23:17:05','anhquan7826','HD - Ramen 5670NINE','',0),(992226217,'2022-11-30 23:17:05','anhquan7826','SUPER RISER!','',0),(1017395806,'2022-12-02 19:29:23','anhquan7826','U And Me','',0),(1018189668,'2022-12-02 19:29:23','anhquan7826','Twinklestar','',0),(1030238271,'2022-12-02 19:29:20','anhquan7826','Awaiting (feat. Rainy)','',0),(1079452472,'2022-12-02 19:48:04','anhquan7826','Mat. - Perspective EP Track 1','',0),(1129699765,'2022-12-02 19:29:22','anhquan7826','Rise','',0),(1133247758,'2022-12-02 19:29:22','anhquan7826','Path To Fairyland','',0),(1142730826,'2022-12-02 19:29:20','anhquan7826','Daydream Cafe (Kirara Magic Remix) feat. Shion','',0),(1146631662,'2022-12-02 19:29:20','anhquan7826','Cosmos','',0),(1202625906,'2022-12-02 19:29:20','anhquan7826','Dreaming','',0),(1217918966,'2022-12-02 19:29:23','anhquan7826','Smile','',0),(1227443045,'2022-12-02 19:29:22','anhquan7826','Play','',0),(1236932759,'2022-12-02 19:29:22','anhquan7826','Rainbow sky(wREVERSED)','',0),(1261048123,'2022-12-02 19:29:21','anhquan7826','Fantasy (w MONICO)','',0),(1263927684,'2022-11-30 23:17:05','anhquan7826','October 3 Project','',0),(1275941856,'2022-11-30 23:17:06','anhquan7826','時空 Rendez-Vous','',0),(1284151857,'2022-12-02 19:29:23','anhquan7826','Summer Of Beach','',0),(1302122541,'2022-11-30 23:17:04','anhquan7826','Android52 - Real Love','',0),(1305740319,'2022-11-30 23:17:06','anhquan7826','ミカヅキBIGWAVE - シャボンのシャンプー','',0),(1323228764,'2022-11-30 23:17:05','anhquan7826','S U B W A Y S - アイスクリーム','',0),(1331674615,'2022-11-30 23:17:04','anhquan7826','Android52 - Romance','',0),(1333697111,'2022-12-02 19:48:04','anhquan7826','Mat. - Perspective EP Track 2','',0),(1358822488,'2022-12-02 19:29:23','anhquan7826','The twenty three (Free Download)','',0),(1359486456,'2022-12-02 19:29:20','anhquan7826','Amidst x Sacry - Carousel','',0),(1384781338,'2022-12-02 19:29:21','anhquan7826','Mihony - Cute Swing','',0),(1420621256,'2022-11-30 23:17:06','anhquan7826','heaven beach','',0),(1420811583,'2022-12-02 19:29:21','anhquan7826','Eternity','',0),(1421402119,'2022-11-30 23:17:05','anhquan7826','Payᵖᵃʸ','',0),(1432367093,'2022-12-02 19:29:22','anhquan7826','Rytmeklubben - Girlfriend (Moe Shop Edit)','',0),(1466908070,'2022-12-02 19:28:08','anhquan7826','AByanF - Slidewalk 『Dubstep』','',0),(1475184453,'2022-12-02 19:29:21','anhquan7826','Kyori','',0),(1477897836,'2022-12-02 19:29:21','anhquan7826','Honey (feat. Shion)','',0),(1488365695,'2022-12-02 19:29:20','anhquan7826','Creed','',0),(1497542337,'2022-12-02 19:29:21','anhquan7826','Michael Li - Gomenasai','',0),(1517870492,'2022-12-02 19:29:23','anhquan7826','Tako','',0),(1522146267,'2022-12-02 19:29:22','anhquan7826','PIKASONIC & Tatsunoshin - Lockdown (ft. NEONA)','',0),(1544402921,'2022-12-02 19:29:22','anhquan7826','PIKASONIC - Inside [UXN Release]','',0),(1578902249,'2022-11-30 23:17:05','anhquan7826','She Is...','',0),(1589426509,'2022-12-02 19:29:20','anhquan7826','Cloudier - A Centimetre Apart (Systile Remix)','',0),(1602301361,'2022-12-02 19:29:22','anhquan7826','Shooting star','',0),(1631183107,'2022-11-30 23:17:04','anhquan7826','First Season','',0),(1664822041,'2022-11-30 23:17:06','anhquan7826','To You','',0),(1693345589,'2022-12-02 19:29:21','anhquan7826','Forever','',0),(1696527422,'2022-11-30 23:17:05','anhquan7826','In Love With You','',0),(1707110337,'2022-12-02 19:29:20','anhquan7826','Couple N & Flay! - Natsumeku','',0),(1708728926,'2022-12-02 19:46:22','anhquan7826','01 C418 - Key','',0),(1720979461,'2022-11-30 23:17:06','anhquan7826','夢の続き ~ Dreams Of Light ~','',0),(1738788031,'2022-12-02 19:29:21','anhquan7826','K-NEXT - Access (Author Wind Remix)','',0),(1742428243,'2022-12-02 19:29:21','anhquan7826','Make A Wish!','',0),(1756539735,'2022-12-02 19:29:20','anhquan7826','Baq5 - Once Again','',0),(1759995885,'2022-12-02 19:29:21','anhquan7826','FreYou - Flight','',0),(1766499416,'2022-12-02 19:46:22','anhquan7826','02 C418 - Door','',0),(1787944684,'2022-12-02 19:29:23','anhquan7826','Tashikametai Nukumori (feat. Shoyun)','',0),(1795000161,'2022-12-02 19:29:21','anhquan7826','Field','',0),(1811741842,'2022-11-30 23:17:05','anhquan7826','TELL ME TELL ME','',0),(1825363300,'2022-12-02 19:29:23','anhquan7826','Surf','',0),(1847161374,'2022-11-30 23:17:05','anhquan7826','SUI UZI - Midnight Sailor','',0),(1849608669,'2022-12-02 19:29:21','anhquan7826','Lone Alpha & KITSUNE - U & Me','',0),(1863330795,'2022-12-02 19:29:23','anhquan7826','SuperNova【FutureProgressive House】','',0),(1866437038,'2022-12-02 19:29:20','anhquan7826','A Sweet Start','',0),(1874020779,'2022-12-02 19:29:20','anhquan7826','Bright','',0),(1918196644,'2022-12-02 19:29:20','anhquan7826','Charm (w Puniden)','',0),(1919003477,'2022-12-02 19:29:22','anhquan7826','Miss You','',0),(1923793143,'2022-12-02 19:29:21','anhquan7826','Imagine','',0),(1925922370,'2022-11-30 23:17:04','anhquan7826','Borderless','',0),(1926788209,'2022-12-02 19:29:23','anhquan7826','You Look So Good','',0),(1942041696,'2022-11-30 23:17:06','anhquan7826','夢のDancing','',0),(1980301390,'2022-11-30 23:17:06','anhquan7826','luv.ly & eiiwun - summer magic','',0),(2002473944,'2022-12-02 19:29:21','anhquan7826','Lunai2 & Pikasonic - Climax (Etopia Remix)','',0),(2050156374,'2022-12-02 19:29:22','anhquan7826','My Kind Of Love (feat. CHIARA)','',0),(2056730330,'2022-12-02 19:29:22','anhquan7826','Notice (w TORIENA)','',0),(2082890648,'2022-12-02 19:29:21','anhquan7826','Halcyon','',0),(2101573346,'2022-12-02 19:29:21','anhquan7826','Mardi - Sunflower [E.T. Summering Release]','',0),(2101619215,'2022-11-30 23:17:04','anhquan7826','Future Rhapsody [失恋Rhapsody] EP','',0),(2102269203,'2022-12-02 19:46:22','anhquan7826','03 C418 - Subwoofer Lullaby','',0),(2113015871,'2022-12-02 19:29:20','anhquan7826','Cosmic [Vibes Release]','',0),(2113671589,'2022-11-30 23:17:05','anhquan7826','SUI UZI - City Night Shadows','',0),(2135920033,'2022-12-02 19:29:21','anhquan7826','Endless Hanabi','',0),(2136127768,'2022-12-02 19:29:21','anhquan7826','Journey (feat. Ugu)','',0),(2139091126,'2022-12-02 19:29:20','anhquan7826','Claires - Submerge','',0),(2146263885,'2022-11-30 23:17:05','anhquan7826','LISA','',0);
/*!40000 ALTER TABLE `song` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `songtags`
--

DROP TABLE IF EXISTS `songtags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `songtags` (
  `id` int NOT NULL,
  `tag` varchar(50) NOT NULL,
  PRIMARY KEY (`id`,`tag`),
  KEY `songtags_tag_fk` (`tag`),
  CONSTRAINT `songtags_id_fk` FOREIGN KEY (`id`) REFERENCES `song` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `songtags_tag_fk` FOREIGN KEY (`tag`) REFERENCES `tags` (`tag`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `songtags`
--

LOCK TABLES `songtags` WRITE;
/*!40000 ALTER TABLE `songtags` DISABLE KEYS */;
/*!40000 ALTER TABLE `songtags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags` (
  `tag` varchar(50) NOT NULL,
  PRIMARY KEY (`tag`),
  UNIQUE KEY `tag_UNIQUE` (`tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `username` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `bio` varchar(255) DEFAULT NULL,
  `createTime` datetime NOT NULL,
  `birth` datetime NOT NULL,
  `password` mediumtext NOT NULL,
  `gender` tinyint NOT NULL,
  `email` varchar(120) NOT NULL,
  `isAdmin` tinyint DEFAULT '0',
  `tag` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('anhquan7826','Nguyen Anh Quan','Temporary','2022-11-18 11:00:50','2015-05-16 05:50:06','AQAAAAEAACcQAAAAEH0d5Z8K2mT20ExGXmAtdLFCUXXf/3Wtgrnv5FqU+9m7hVaT0YctAxXKxb/BLWUTLg==',1,'anhquan7826@gmail.com',0,NULL),('anhquan7826_2','','','2022-11-18 11:15:25','1970-01-01 00:00:00','AQAAAAEAACcQAAAAEKnAO4Q3WEjsedgirBHWx1iXsWKTkivTNH86/6yIf9d5Qf+pAQh1ROd1rR7xWd2Z6w==',1,'',0,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'tourmaline'
--
/*!50003 DROP PROCEDURE IF EXISTS `EditComment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EditComment`(IN commentId INT, IN newContent TEXT, IN editTime DATETIME)
BEGIN
	UPDATE comment SET
		content = newContent,
        lastEditedTime = editTime
	WHERE id = commentId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EditUserProfile` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EditUserProfile`(IN username VARCHAR(45), IN newName VARCHAR(45), IN newBio VARCHAR(255), IN newBirth DATETIME,
	IN newGender TINYINT, IN newEmail VARCHAR(120), IN newIsAdmin TINYINT)
BEGIN
	UPDATE user SET
		name = newName,
        bio = newBio,
        birth = newBirth,
        gender = newGender,
        email = newEmail,
        isAdmin = newIsAdmin
	WHERE user.username = username;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FindSongs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FindSongs`(IN keyword VARCHAR(100))
BEGIN
	DECLARE keywordLowered VARCHAR(100);
    SET keywordLowered = lower(keyword);

	SELECT id, uploadTime, uploader, name, lyrics, description, album FROM song
    WHERE (LOWER(name) LIKE keywordLowered) OR (LOWER(lyrics) LIKE keywordLowered) OR (LOWER(album) LIKE keywordLowered)
	OR (LOWER(description) LIKE keywordLowered);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FindUsers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `FindUsers`(IN keyword VARCHAR(100))
BEGIN
	SELECT username, name, bio, createTime, birth, gender, isAdmin FROM user
    WHERE (lower(username) LIKE lower(keyword) OR lower(name) = lower(keyword));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ListCommentsOfSong` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ListCommentsOfSong`(IN id INT)
BEGIN
	SELECT id, username, content, createTime, lastEditedTime FROM comment WHERE song = id;
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

-- Dump completed on 2022-12-07 23:59:45
