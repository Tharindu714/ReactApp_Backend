-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.32 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.0.0.6468
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for chanakaelect_chat
CREATE DATABASE IF NOT EXISTS `chanakaelect_chat` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `chanakaelect_chat`;

-- Dumping structure for table chanakaelect_chat.chat
CREATE TABLE IF NOT EXISTS `chat` (
  `id` int NOT NULL AUTO_INCREMENT,
  `message` text NOT NULL,
  `from_user_id` int NOT NULL,
  `to_user_id` int NOT NULL,
  `date_time` datetime NOT NULL,
  `chat_status_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_chat_user1_idx` (`from_user_id`),
  KEY `fk_chat_user2_idx` (`to_user_id`),
  KEY `fk_chat_chat_status1_idx` (`chat_status_id`),
  CONSTRAINT `fk_chat_chat_status1` FOREIGN KEY (`chat_status_id`) REFERENCES `chat_status` (`id`),
  CONSTRAINT `fk_chat_user1` FOREIGN KEY (`from_user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_chat_user2` FOREIGN KEY (`to_user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table chanakaelect_chat.chat: ~10 rows (approximately)
REPLACE INTO `chat` (`id`, `message`, `from_user_id`, `to_user_id`, `date_time`, `chat_status_id`) VALUES
	(1, 'Hey Wassup', 16, 5, '2024-10-02 13:09:47', 1),
	(2, 'Not much How are you', 5, 16, '2024-10-02 15:31:49', 1),
	(3, 'Hey good morning', 16, 6, '2024-10-02 07:32:28', 2),
	(4, 'Hello Good to see you one piece ', 16, 10, '2024-10-02 15:33:51', 1),
	(5, 'Hey what about you ', 10, 16, '2024-10-02 15:37:27', 2),
	(6, 'I am having some peaceful time', 16, 5, '2024-10-02 15:38:38', 2),
	(7, 'Hey you woke up ??', 7, 12, '2024-10-02 15:39:34', 1),
	(8, 'Yepzzz!!!!', 12, 7, '2024-10-02 15:40:08', 2),
	(9, 'Yesterday u were lucky punk', 13, 12, '2024-10-02 15:41:14', 1),
	(10, 'Haa Haa Well I am always p.u.n.k', 12, 13, '2024-10-02 15:42:01', 2);

-- Dumping structure for table chanakaelect_chat.chat_status
CREATE TABLE IF NOT EXISTS `chat_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table chanakaelect_chat.chat_status: ~3 rows (approximately)
REPLACE INTO `chat_status` (`id`, `name`) VALUES
	(1, 'Seen'),
	(2, 'Unseen'),
	(3, 'offline');

-- Dumping structure for table chanakaelect_chat.user
CREATE TABLE IF NOT EXISTS `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mobile` varchar(10) NOT NULL,
  `first_name` varchar(25) NOT NULL,
  `last_name` varchar(25) NOT NULL,
  `password` varchar(30) NOT NULL,
  `registered_date_time` datetime NOT NULL,
  `user_status_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_user_status_idx` (`user_status_id`),
  CONSTRAINT `fk_user_user_status` FOREIGN KEY (`user_status_id`) REFERENCES `user_status` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table chanakaelect_chat.user: ~10 rows (approximately)
REPLACE INTO `user` (`id`, `mobile`, `first_name`, `last_name`, `password`, `registered_date_time`, `user_status_id`) VALUES
	(1, '0766135782', 'Delta', 'Codex Graphics', 'dcGraphs2025', '2024-09-28 03:43:35', 2),
	(5, '0742356980', 'Black ', 'Widow ', 'Black@Widow123', '2024-10-01 03:17:26', 1),
	(6, '0741265893', 'Blue ', 'Beetle ', 'BlueBee@2023', '2024-10-01 03:30:02', 2),
	(7, '0786932147', 'Smart', 'Hulk ', 'WiseHull@345', '2024-10-01 03:31:02', 2),
	(8, '0712367845', 'Wade The ', 'Deadpool', 'Wade&Deadpool2025', '2024-10-01 03:32:21', 2),
	(9, '0726935809', 'The Real ', 'Bat Man ', 'RealBat@2024', '2024-10-01 03:34:10', 2),
	(10, '0756935809', 'Wonder', 'Woman', 'GalGabot@WW2', '2024-10-01 03:35:18', 2),
	(11, '0776935809', 'Barry The Real', 'Flash ', 'Flash@2025', '2024-10-01 03:37:28', 2),
	(12, '0776943322', 'Peter ', 'Parker Spidey', 'PPSpider@67', '2024-10-01 03:39:04', 2),
	(13, '0781441587', 'Venom', 'Itself', 'Venom@345', '2024-10-01 03:40:20', 2),
	(16, '0786532147', 'Soldier ', 'Boy ', 'SoldierBoy@2025', '2024-10-02 18:07:58', 2);

-- Dumping structure for table chanakaelect_chat.user_status
CREATE TABLE IF NOT EXISTS `user_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table chanakaelect_chat.user_status: ~2 rows (approximately)
REPLACE INTO `user_status` (`id`, `name`) VALUES
	(1, 'Online'),
	(2, 'Offline');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
