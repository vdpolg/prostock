-- Adminer 4.6.3 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP DATABASE IF EXISTS `prostock_db`;
CREATE DATABASE `prostock_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `prostock_db`;

DROP TABLE IF EXISTS `price_main`;
CREATE TABLE `price_main` (
  `price_key` int(7) NOT NULL AUTO_INCREMENT,
  `primary_key` int(7) NOT NULL,
  `done_price` float NOT NULL,
  `avg_price` float NOT NULL,
  `max_price` float NOT NULL,
  `min_price` float NOT NULL,
  PRIMARY KEY (`price_key`),
  UNIQUE KEY `price_key_primary_key` (`price_key`,`primary_key`),
  KEY `done_price` (`done_price`),
  KEY `primary_key` (`primary_key`),
  CONSTRAINT `price_main_ibfk_1` FOREIGN KEY (`primary_key`) REFERENCES `stock_main` (`primary_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `stock_main`;
CREATE TABLE `stock_main` (
  `primary_key` int(7) NOT NULL AUTO_INCREMENT,
  `stock_name` char(20) COLLATE utf8_unicode_ci NOT NULL,
  `stock_num` int(12) unsigned NOT NULL,
  `done_price` float NOT NULL,
  `check_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`primary_key`),
  UNIQUE KEY `stock_name_date` (`stock_name`,`check_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP VIEW IF EXISTS `小資股(不到10萬)`;
CREATE TABLE `小資股(不到10萬)` (`股名` char(20), `股價` float, `查詢時間` timestamp);


DROP TABLE IF EXISTS `小資股(不到10萬)`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `小資股(不到10萬)` AS select `stock_main`.`stock_name` AS `股名`,`stock_main`.`done_price` AS `股價`,max(`stock_main`.`check_time`) AS `查詢時間` from `stock_main` where `stock_main`.`done_price` <= 10 group by `stock_main`.`stock_name` order by `stock_main`.`done_price`;

-- 2018-09-14 13:05:55

