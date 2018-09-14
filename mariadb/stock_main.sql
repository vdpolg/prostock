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


DROP VIEW IF EXISTS `成長率排序`;
CREATE TABLE `成長率排序` (`primary_key` int(7), `股名` char(20), `成交價` float, `與平均價差` double(19,2), `平均價` float, `成長百分比` double(19,2), `更新時間` timestamp);


DROP TABLE IF EXISTS `小資股(不到10萬)`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `小資股(不到10萬)` AS select `stock_main`.`stock_name` AS `股名`,`stock_main`.`done_price` AS `股價`,max(`stock_main`.`check_time`) AS `查詢時間` from `stock_main` where `stock_main`.`done_price` <= 10 group by `stock_main`.`stock_name` order by `stock_main`.`done_price`;

DROP TABLE IF EXISTS `成長率排序`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `成長率排序` AS select `skm`.`primary_key` AS `primary_key`,`skm`.`股名` AS `股名`,`skm`.`成交價` AS `成交價`,`skm`.`與平均價差` AS `與平均價差`,`skm`.`平均價` AS `平均價`,`skm`.`成長百分比` AS `成長百分比`,`skm`.`更新時間` AS `更新時間` from (select `prostock_db`.`price_main`.`primary_key` AS `primary_key`,`c`.`stock_name` AS `股名`,`c`.`done_price` AS `成交價`,round(`prostock_db`.`price_main`.`done_price` - `prostock_db`.`price_main`.`avg_price`,2) AS `與平均價差`,`prostock_db`.`price_main`.`avg_price` AS `平均價`,round((`prostock_db`.`price_main`.`done_price` - `prostock_db`.`price_main`.`avg_price`) / `prostock_db`.`price_main`.`avg_price`,2) AS `成長百分比`,`c`.`check_time` AS `更新時間` from ((`prostock_db`.`price_main` join (select max(`b`.`primary_key`) AS `mp`,`b`.`done_price` AS `done_price` from `prostock_db`.`stock_main` `b` group by `b`.`stock_name`) `newb` on(`prostock_db`.`price_main`.`primary_key` = `newb`.`mp`)) join `prostock_db`.`stock_main` `c` on(`c`.`primary_key` = `prostock_db`.`price_main`.`primary_key`)) group by `c`.`stock_name` order by round((`prostock_db`.`price_main`.`done_price` - `prostock_db`.`price_main`.`avg_price`) / `prostock_db`.`price_main`.`avg_price`,2) desc) `skm`;

-- 2018-09-14 17:50:01
