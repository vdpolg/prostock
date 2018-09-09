-- Adminer 4.6.3 MySQL dump

SET NAMES utf8;
SET time_zone = '+08:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP DATABASE IF EXISTS `prostock_db`;
CREATE DATABASE `prostock_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `prostock_db`;

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

TRUNCATE `stock_main`;
INSERT INTO `stock_main` (`primary_key`, `stock_name`, `stock_num`, `done_price`, `check_time`) VALUES
(1,	'台泥',	1101,	41.3,	'2018-09-09 05:05:14');
