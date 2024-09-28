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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table chanakaelect_chat.chat: ~0 rows (approximately)

-- Dumping structure for table chanakaelect_chat.chat_status
CREATE TABLE IF NOT EXISTS `chat_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table chanakaelect_chat.chat_status: ~0 rows (approximately)
REPLACE INTO `chat_status` (`id`, `name`) VALUES
	(1, 'Seen'),
	(2, 'Delivered'),
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table chanakaelect_chat.user: ~0 rows (approximately)
REPLACE INTO `user` (`id`, `mobile`, `first_name`, `last_name`, `password`, `registered_date_time`, `user_status_id`) VALUES
	(1, '0766135782', 'Delta', 'Codex Graphics', 'dcGraphs2025', '2024-09-28 03:43:35', 2),
	(2, '0785693217', 'Amanda', 'Diaz', 'Amanda@234', '2024-09-29 03:07:40', 2),
	(3, '0762358912', 'Sadeesha ', 'Nilakshini', 'Sadee@325Nilakshi', '2024-09-29 03:10:30', 2),
	(4, '0789632147', 'Puppy', 'Puff', 'Puppy2354@Puff', '2024-09-29 03:22:47', 2);

-- Dumping structure for table chanakaelect_chat.user_status
CREATE TABLE IF NOT EXISTS `user_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table chanakaelect_chat.user_status: ~0 rows (approximately)
REPLACE INTO `user_status` (`id`, `name`) VALUES
	(1, 'Online'),
	(2, 'Offline');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
