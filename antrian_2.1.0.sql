/*
SQLyog Community v13.1.9 (64 bit)
MySQL - 10.4.14-MariaDB : Database - u1114618_antrian
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`u1114618_antrian` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `u1114618_antrian`;

/*Table structure for table `antrian_detail` */

DROP TABLE IF EXISTS `antrian_detail`;

CREATE TABLE `antrian_detail` (
  `id_antrian_detail` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_antrian_kategori` int(10) unsigned DEFAULT NULL,
  `id_antrian_tujuan` int(10) unsigned DEFAULT NULL,
  `aktif` enum('Y','N') NOT NULL DEFAULT 'Y',
  `tgl_update` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_antrian_detail`),
  UNIQUE KEY `id_antrian_kategori_id_antrian_tujuan` (`id_antrian_kategori`,`id_antrian_tujuan`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4;

/*Data for the table `antrian_detail` */

insert  into `antrian_detail`(`id_antrian_detail`,`id_antrian_kategori`,`id_antrian_tujuan`,`aktif`,`tgl_update`) values 
(6,3,17,'Y','2022-07-17 05:41:06'),
(7,3,18,'Y','2022-07-17 05:41:00'),
(20,3,19,'Y','2023-07-15 23:30:38'),
(22,3,20,'Y','2023-07-15 23:36:14'),
(23,3,21,'Y','2023-07-15 23:36:27'),
(24,3,22,'Y','2023-07-15 23:36:35'),
(25,3,23,'Y','2023-07-15 23:36:45'),
(26,9,17,'Y','2023-07-15 23:37:32'),
(27,9,18,'Y','2023-07-15 23:37:38'),
(28,9,19,'Y','2023-07-15 23:37:47'),
(29,9,20,'Y','2023-07-15 23:37:53'),
(30,9,21,'Y','2023-07-15 23:38:00'),
(31,9,22,'Y','2023-07-15 23:38:06'),
(32,9,23,'Y','2023-07-15 23:38:13'),
(33,10,24,'Y','2023-07-16 23:16:27'),
(34,11,25,'Y','2023-07-24 20:57:52'),
(35,11,26,'Y','2023-07-24 20:58:01'),
(37,11,27,'Y','2023-07-24 20:58:40'),
(38,11,28,'Y','2023-07-24 20:58:47');

/*Table structure for table `antrian_kategori` */

DROP TABLE IF EXISTS `antrian_kategori`;

CREATE TABLE `antrian_kategori` (
  `id_antrian_kategori` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nama_antrian_kategori` varchar(255) NOT NULL,
  `awalan` char(1) NOT NULL,
  `aktif` enum('Y','N') NOT NULL,
  `tgl_input` datetime DEFAULT NULL,
  `id_user_input` int(10) unsigned DEFAULT NULL,
  `tgl_update` datetime DEFAULT NULL,
  `id_user_update` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_antrian_kategori`) USING BTREE,
  UNIQUE KEY `nama_antrian_kategori` (`nama_antrian_kategori`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;

/*Data for the table `antrian_kategori` */

insert  into `antrian_kategori`(`id_antrian_kategori`,`nama_antrian_kategori`,`awalan`,`aktif`,`tgl_input`,`id_user_input`,`tgl_update`,`id_user_update`) values 
(3,'Loket Tunai','A','Y','2022-07-03 18:34:48',1,'2023-07-15 23:31:58',1),
(9,'Loket Non Tunai','B','Y','2023-07-15 23:37:21',1,NULL,NULL),
(10,'Loket Hasil','D','Y','2023-07-16 23:16:14',1,NULL,NULL),
(11,'Bilik','C','Y','2023-07-24 20:51:34',1,NULL,NULL);

/*Table structure for table `antrian_lab` */

DROP TABLE IF EXISTS `antrian_lab`;

CREATE TABLE `antrian_lab` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_antrian_detail` int(11) DEFAULT NULL,
  `nama_antrian_tujuan` varchar(255) DEFAULT NULL,
  `no_lab` varchar(255) DEFAULT NULL,
  `nomor_antrian` varchar(255) DEFAULT NULL,
  `no_bilik` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `status` varchar(255) DEFAULT 'kosong',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4;

/*Data for the table `antrian_lab` */

insert  into `antrian_lab`(`id`,`id_antrian_detail`,`nama_antrian_tujuan`,`no_lab`,`nomor_antrian`,`no_bilik`,`created_at`,`updated_at`,`status`) values 
(6,6,'Loket 1','B22','8',NULL,'2023-07-25 22:02:49',NULL,'kosong'),
(7,6,'Loket 1','B22','9',NULL,'2023-07-25 22:03:53',NULL,'kosong'),
(8,6,'Loket 1','B22','10',NULL,'2023-07-25 22:04:40',NULL,'kosong'),
(9,6,'Loket 1','B22','11',NULL,'2023-07-25 22:05:44',NULL,'kosong'),
(10,6,'Loket 1','c22','12',NULL,'2023-07-25 22:06:47',NULL,'kosong'),
(11,6,'Loket 1','c22','13',NULL,'2023-07-25 22:08:01',NULL,'kosong'),
(12,6,'Loket 1','c22','14',NULL,'2023-07-25 22:08:28',NULL,'kosong'),
(13,6,'Loket 1','c22','15',NULL,'2023-07-25 22:09:03',NULL,'kosong'),
(14,6,'Loket 1','c22','16',NULL,'2023-07-25 22:09:23',NULL,'kosong'),
(15,6,'Loket 1','c22','17',NULL,'2023-07-25 22:09:34',NULL,'kosong'),
(16,6,'Loket 1','c22','18',NULL,'2023-07-25 22:09:35',NULL,'kosong'),
(17,6,'Loket 1','c22','19',NULL,'2023-07-25 22:09:36',NULL,'kosong'),
(18,6,'Loket 1','b22','1',NULL,'2023-07-25 22:15:47',NULL,'kosong'),
(19,6,'Loket 1','b23','2',NULL,'2023-07-25 22:15:56',NULL,'kosong'),
(20,6,'Loket 1','b23','3',NULL,'2023-07-25 22:16:18',NULL,'kosong'),
(21,6,'Loket 1','23','4',NULL,'2023-07-25 22:25:18',NULL,'kosong'),
(22,6,'Loket 1','25','5',NULL,'2023-07-25 22:26:01',NULL,'kosong'),
(23,6,'Loket 1','25','6',NULL,'2023-07-25 22:26:18',NULL,'kosong'),
(24,6,'Loket 1','55','7',NULL,'2023-07-25 22:27:00',NULL,'kosong'),
(25,6,'Loket 1','55','8',NULL,'2023-07-25 22:27:06',NULL,'kosong'),
(26,6,'Loket 1','000','1','1','2023-07-29 12:09:46','2023-07-29 13:31:37','kosong'),
(27,6,'Loket 1','111','2','2','2023-07-29 13:36:02','2023-07-29 13:48:29','kosong'),
(28,6,'Loket 1','333','3','3','2023-07-29 13:49:47','2023-07-29 15:28:48','selesai'),
(29,6,'Loket 1','444','4','4','2023-07-29 14:42:20','2023-07-29 15:31:25','selesai'),
(30,6,'Loket 1','444','5','4','2023-07-29 15:30:27','2023-07-29 15:31:25','selesai'),
(31,6,'Loket 1','C333','1',NULL,'2023-08-02 12:46:38',NULL,'kosong'),
(32,6,'Loket 1','C333','2',NULL,'2023-08-02 12:47:44',NULL,'kosong'),
(33,6,'Loket 1','C333','3',NULL,'2023-08-02 12:48:01',NULL,'kosong');

/*Table structure for table `antrian_panggil` */

DROP TABLE IF EXISTS `antrian_panggil`;

CREATE TABLE `antrian_panggil` (
  `id_antrian_panggil` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_antrian_kategori` int(10) unsigned NOT NULL,
  `jml_antrian` smallint(5) unsigned NOT NULL,
  `jml_dipanggil` smallint(5) unsigned NOT NULL,
  `tanggal` date NOT NULL,
  `time_ambil` time NOT NULL,
  `time_dipanggil` time NOT NULL,
  PRIMARY KEY (`id_antrian_panggil`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4;

/*Data for the table `antrian_panggil` */

insert  into `antrian_panggil`(`id_antrian_panggil`,`id_antrian_kategori`,`jml_antrian`,`jml_dipanggil`,`tanggal`,`time_ambil`,`time_dipanggil`) values 
(2,3,14,0,'2022-07-16','21:08:29','00:00:00'),
(4,3,13,5,'2022-07-17','13:22:55','05:49:10'),
(11,3,7,5,'2022-07-24','14:47:07','14:47:25'),
(12,3,6,0,'2023-07-13','14:42:54','00:00:00'),
(21,3,4,0,'2023-07-15','23:53:48','23:16:26'),
(22,9,2,0,'2023-07-15','23:53:51','00:00:00'),
(23,3,23,23,'2023-07-16','22:56:07','22:57:32'),
(24,9,23,22,'2023-07-16','22:56:05','23:46:42'),
(25,10,4,4,'2023-07-16','23:17:48','23:35:44'),
(26,3,5,2,'2023-07-17','12:34:53','12:35:08'),
(27,9,3,2,'2023-07-17','12:34:48','12:35:40'),
(28,3,27,26,'2023-07-18','15:12:03','15:12:07'),
(29,9,10,10,'2023-07-18','15:12:00','15:15:32'),
(30,3,2,1,'2023-07-19','23:20:13','23:20:32'),
(31,3,15,2,'2023-07-21','23:57:35','22:53:38'),
(32,10,2,0,'2023-07-21','23:52:37','00:00:00'),
(33,9,1,0,'2023-07-21','22:34:54','00:00:00'),
(34,3,3,0,'2023-07-22','00:03:01','00:00:00'),
(35,10,1,0,'2023-07-22','00:01:51','00:00:00'),
(36,9,1,0,'2023-07-22','00:02:03','00:00:00'),
(37,3,0,0,'2023-07-23','23:55:39','23:55:50'),
(38,3,0,0,'2023-07-24','20:48:49','12:18:43'),
(39,9,0,0,'2023-07-24','12:00:02','12:16:03'),
(40,10,0,0,'2023-07-24','21:45:10','20:47:56'),
(41,11,0,0,'2023-07-24','21:45:14','21:45:27'),
(42,3,0,0,'2023-07-25','22:09:36','22:23:31'),
(43,9,0,0,'2023-07-25','20:42:02','00:00:00'),
(44,10,0,0,'2023-07-25','20:42:01','00:00:00'),
(46,11,0,0,'2023-07-25','22:27:06','22:42:07'),
(47,3,7,7,'2023-07-29','13:35:12','14:42:08'),
(48,11,5,5,'2023-07-29','15:30:27','15:30:48'),
(49,3,3,1,'2023-08-02','12:46:03','12:46:22'),
(50,11,3,0,'2023-08-02','12:48:01','00:00:00');

/*Table structure for table `antrian_panggil_awalan` */

DROP TABLE IF EXISTS `antrian_panggil_awalan`;

CREATE TABLE `antrian_panggil_awalan` (
  `nama_file` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='Pengaturan suara sebawai awalan pemanggilan antrian, seperti bunyi bell';

/*Data for the table `antrian_panggil_awalan` */

insert  into `antrian_panggil_awalan`(`nama_file`) values 
('[\"bell_long.wav\",\"nomor_antrian.wav\"]');

/*Table structure for table `antrian_panggil_detail` */

DROP TABLE IF EXISTS `antrian_panggil_detail`;

CREATE TABLE `antrian_panggil_detail` (
  `id_antrian_panggil_detail` int(11) NOT NULL AUTO_INCREMENT,
  `id_antrian_panggil` int(11) unsigned NOT NULL,
  `id_antrian_detail` int(11) unsigned NOT NULL,
  `awalan_panggil` char(1) NOT NULL,
  `nomor_panggil` smallint(5) unsigned NOT NULL,
  `waktu_panggil` time DEFAULT current_timestamp(),
  `lewati` datetime DEFAULT NULL,
  `spesial_panggil` int(11) DEFAULT 0,
  PRIMARY KEY (`id_antrian_panggil_detail`)
) ENGINE=InnoDB AUTO_INCREMENT=322 DEFAULT CHARSET=utf8mb4;

/*Data for the table `antrian_panggil_detail` */

insert  into `antrian_panggil_detail`(`id_antrian_panggil_detail`,`id_antrian_panggil`,`id_antrian_detail`,`awalan_panggil`,`nomor_panggil`,`waktu_panggil`,`lewati`,`spesial_panggil`) values 
(1,1,3,'A',1,'20:11:18',NULL,0),
(2,1,3,'A',2,'20:11:35',NULL,0),
(3,1,4,'A',3,'20:11:51',NULL,0),
(4,1,2,'A',4,'20:11:55',NULL,0),
(5,1,2,'A',5,'20:11:57',NULL,0),
(6,1,2,'A',6,'20:11:57',NULL,0),
(7,1,4,'A',7,'20:11:58',NULL,0),
(8,1,4,'A',8,'20:11:59',NULL,0),
(9,1,4,'A',9,'20:12:00',NULL,0),
(10,1,3,'A',10,'20:17:31',NULL,0),
(11,1,3,'A',11,'20:28:39',NULL,0),
(12,1,5,'A',12,'20:33:07',NULL,0),
(13,1,2,'A',13,'20:35:03',NULL,0),
(14,1,5,'A',14,'20:35:10',NULL,0),
(15,1,3,'A',15,'20:54:17',NULL,0),
(16,1,2,'A',16,'21:12:32',NULL,0),
(17,1,4,'A',17,'21:31:00',NULL,0),
(18,1,5,'A',18,'21:35:59',NULL,0),
(19,1,2,'A',19,'21:36:24',NULL,0),
(20,1,4,'A',20,'21:37:26',NULL,0),
(21,3,2,'A',1,'05:10:21',NULL,0),
(22,3,3,'A',2,'05:10:38',NULL,0),
(23,3,2,'A',3,'05:11:41',NULL,0),
(24,4,6,'B',1,'05:37:35',NULL,0),
(25,4,6,'B',2,'05:42:02',NULL,0),
(26,4,6,'B',3,'05:45:33',NULL,0),
(27,4,6,'B',4,'05:49:00',NULL,0),
(28,4,7,'B',5,'05:49:10',NULL,0),
(29,8,1,'A',1,'07:07:37',NULL,0),
(30,3,3,'A',4,'07:07:57',NULL,0),
(31,5,8,'C',1,'07:19:58',NULL,0),
(32,5,8,'C',2,'07:20:15',NULL,0),
(33,8,1,'A',2,'07:21:54',NULL,0),
(34,8,1,'A',3,'07:22:21',NULL,0),
(35,3,2,'A',5,'07:23:55',NULL,0),
(36,3,4,'A',6,'07:24:01',NULL,0),
(37,3,3,'A',7,'13:03:59',NULL,0),
(65,11,6,'B',1,'14:47:17',NULL,0),
(66,11,7,'B',2,'14:47:18',NULL,0),
(67,11,6,'B',3,'14:47:22',NULL,0),
(68,11,6,'B',4,'14:47:23',NULL,0),
(69,11,7,'B',5,'14:47:25',NULL,0),
(70,10,2,'A',1,'14:49:24',NULL,0),
(71,10,3,'A',2,'14:49:25',NULL,0),
(72,10,5,'A',3,'14:49:28',NULL,0),
(73,10,2,'A',4,'14:49:31',NULL,0),
(74,10,3,'A',5,'14:49:32',NULL,0),
(75,10,2,'A',6,'14:49:34',NULL,0),
(76,10,5,'A',7,'14:49:36',NULL,0),
(77,13,2,'A',1,'14:44:17',NULL,0),
(78,14,8,'C',1,'10:43:18',NULL,0),
(79,14,8,'C',2,'10:43:32',NULL,0),
(80,15,9,'B',1,'10:43:47',NULL,0),
(81,15,9,'B',2,'10:44:00',NULL,0),
(82,15,9,'B',3,'10:44:35',NULL,0),
(83,14,8,'C',3,'10:44:48',NULL,0),
(84,16,1,'A',1,'10:48:57',NULL,0),
(85,16,1,'A',2,'10:49:26',NULL,0),
(86,19,2,'A',1,'23:21:41',NULL,0),
(87,19,2,'A',2,'23:24:22',NULL,0),
(88,19,3,'A',3,'23:31:54',NULL,0),
(89,19,3,'A',4,'23:42:56',NULL,0),
(90,19,2,'A',5,'23:47:07',NULL,0),
(91,19,3,'A',6,'23:51:40',NULL,0),
(92,19,2,'A',7,'23:52:56',NULL,0),
(124,23,6,'A',1,'00:39:18',NULL,0),
(125,24,26,'B',1,'00:39:40',NULL,0),
(126,24,26,'B',2,'00:55:15',NULL,0),
(127,24,26,'B',3,'00:57:15',NULL,0),
(128,23,6,'A',2,'00:57:41',NULL,0),
(129,24,26,'B',4,'00:57:56',NULL,0),
(130,24,29,'B',5,'00:58:09',NULL,0),
(131,24,27,'B',6,'01:16:08',NULL,0),
(132,23,20,'A',3,'01:16:24',NULL,0),
(133,23,23,'A',4,'01:16:42',NULL,0),
(134,23,23,'A',5,'01:17:09',NULL,0),
(135,23,23,'A',6,'01:17:17',NULL,0),
(136,23,24,'A',7,'01:17:29',NULL,0),
(137,23,22,'A',8,'01:17:47',NULL,0),
(138,24,31,'B',7,'01:20:16',NULL,0),
(139,24,32,'B',8,'01:22:06',NULL,0),
(140,23,23,'A',9,'01:22:26',NULL,0),
(141,23,24,'A',10,'01:53:40',NULL,0),
(142,24,30,'B',9,'01:54:10',NULL,0),
(143,23,7,'A',11,'01:57:45',NULL,0),
(144,24,29,'B',10,'01:57:55',NULL,0),
(145,24,31,'B',11,'01:58:05',NULL,0),
(146,23,6,'A',12,'18:19:23',NULL,0),
(147,23,6,'A',13,'19:42:14',NULL,0),
(148,23,6,'A',14,'19:43:22',NULL,0),
(149,24,26,'B',12,'19:43:33',NULL,0),
(150,24,26,'B',13,'19:43:44',NULL,0),
(151,23,6,'A',15,'19:45:06',NULL,0),
(152,23,6,'A',16,'22:06:06',NULL,0),
(153,24,26,'B',14,'22:06:10',NULL,0),
(154,23,6,'A',17,'22:06:12',NULL,0),
(155,24,26,'B',15,'22:06:18',NULL,0),
(156,23,6,'A',18,'22:56:15',NULL,0),
(157,24,26,'B',16,'22:56:25',NULL,0),
(158,23,6,'A',19,'22:56:36',NULL,0),
(159,23,6,'A',20,'22:56:46',NULL,0),
(160,24,26,'B',17,'22:56:58',NULL,0),
(161,23,6,'A',21,'22:57:09',NULL,0),
(162,23,6,'A',22,'22:57:20',NULL,0),
(163,23,6,'A',23,'22:57:32',NULL,0),
(164,25,33,'D',1,'23:17:22',NULL,0),
(165,25,33,'D',2,'23:17:31',NULL,0),
(166,25,33,'D',3,'23:17:52',NULL,0),
(167,24,26,'B',18,'23:31:02',NULL,0),
(168,24,26,'B',19,'23:33:02',NULL,0),
(169,25,33,'D',4,'23:35:44',NULL,0),
(170,24,27,'B',20,'23:44:13',NULL,0),
(171,24,27,'B',21,'23:44:51',NULL,0),
(172,24,26,'B',22,'23:46:42',NULL,0),
(173,26,7,'A',1,'12:34:33',NULL,0),
(174,26,7,'A',2,'12:35:08',NULL,0),
(175,27,27,'B',1,'12:35:17',NULL,0),
(176,27,27,'B',2,'12:35:40',NULL,0),
(177,28,6,'A',1,'12:22:48',NULL,0),
(178,28,20,'A',2,'12:23:44',NULL,0),
(179,28,7,'A',3,'12:25:18',NULL,0),
(180,28,7,'A',4,'12:32:32',NULL,0),
(181,28,7,'A',5,'12:42:56',NULL,0),
(182,28,20,'A',6,'12:45:50','2023-07-18 12:49:50',0),
(183,28,7,'A',7,'12:46:40',NULL,0),
(184,28,20,'A',8,'12:49:50',NULL,0),
(185,28,6,'A',9,'13:03:11','2023-07-18 14:32:30',0),
(186,28,22,'A',10,'13:03:22','2023-07-18 13:06:09',0),
(187,28,23,'A',11,'13:04:37','2023-07-18 13:07:13',0),
(188,28,24,'A',12,'13:04:55','2023-07-18 13:05:19',0),
(189,28,24,'A',13,'13:05:19','2023-07-18 13:05:55',0),
(190,28,24,'A',14,'13:05:55',NULL,0),
(191,28,22,'A',15,'13:06:09','2023-07-18 13:06:26',0),
(192,28,22,'A',16,'13:06:26','2023-07-18 13:07:39',0),
(193,28,23,'A',17,'13:07:13','2023-07-18 13:08:17',0),
(194,28,22,'A',18,'13:07:39',NULL,0),
(195,28,23,'A',19,'13:08:17','2023-07-18 13:09:24',0),
(196,28,23,'A',20,'13:09:24','2023-07-18 13:09:38',0),
(197,28,23,'A',21,'13:09:38',NULL,0),
(198,28,23,'A',22,'13:09:49',NULL,0),
(199,28,6,'A',23,'14:32:30','2023-07-18 14:33:02',0),
(200,28,6,'A',24,'14:33:02',NULL,0),
(201,29,26,'B',1,'14:56:20',NULL,0),
(202,29,26,'B',2,'14:57:08',NULL,0),
(203,29,26,'B',3,'14:57:18',NULL,0),
(204,29,26,'B',4,'14:57:32',NULL,0),
(205,29,26,'B',5,'15:01:36',NULL,0),
(206,28,6,'A',25,'15:03:14',NULL,0),
(207,29,26,'B',6,'15:08:47',NULL,0),
(208,29,26,'B',7,'15:09:53',NULL,0),
(209,29,26,'B',8,'15:11:14',NULL,0),
(210,28,6,'A',26,'15:12:07',NULL,0),
(211,29,26,'B',9,'15:12:23','2023-07-18 15:15:32',0),
(212,29,26,'B',10,'15:15:32',NULL,0),
(213,30,6,'A',1,'23:20:32',NULL,0),
(214,31,6,'A',1,'22:50:28',NULL,0),
(215,31,6,'A',2,'22:53:38',NULL,0),
(309,47,6,'A',1,'10:59:46',NULL,0),
(310,47,6,'A',2,'11:00:37',NULL,0),
(311,47,6,'A',3,'12:13:47',NULL,1),
(312,48,34,'C',1,'13:02:06',NULL,1),
(313,47,6,'A',4,'13:35:28',NULL,0),
(314,47,6,'A',5,'13:35:48',NULL,0),
(315,48,35,'C',2,'13:48:29',NULL,1),
(316,47,6,'A',6,'13:49:39',NULL,0),
(317,48,37,'C',3,'13:49:55',NULL,1),
(318,47,6,'A',7,'14:42:08',NULL,0),
(319,48,37,'C',4,'14:42:30',NULL,1),
(320,48,38,'C',5,'15:30:48',NULL,1),
(321,49,6,'A',1,'12:46:22',NULL,0);

/*Table structure for table `antrian_panggil_ulang` */

DROP TABLE IF EXISTS `antrian_panggil_ulang`;

CREATE TABLE `antrian_panggil_ulang` (
  `id_setting_layar` int(11) unsigned DEFAULT NULL,
  `id_antrian_panggil_detail` int(11) unsigned DEFAULT NULL,
  `tanggal_panggil_ulang` date DEFAULT curdate(),
  `waktu_panggil_ulang` time DEFAULT curtime()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `antrian_panggil_ulang` */

insert  into `antrian_panggil_ulang`(`id_setting_layar`,`id_antrian_panggil_detail`,`tanggal_panggil_ulang`,`waktu_panggil_ulang`) values 
(1,30,'2022-07-17','13:00:11'),
(1,30,'2022-07-17','13:02:15'),
(1,35,'2022-07-17','13:05:20'),
(1,35,'2022-07-17','13:05:50'),
(1,36,'2022-07-17','13:06:09'),
(1,49,'2022-07-24','11:28:03'),
(1,60,'2022-07-24','11:50:08'),
(1,61,'2022-07-24','11:51:02'),
(1,64,'2022-07-24','11:51:47'),
(1,77,'2023-07-13','14:44:28'),
(1,77,'2023-07-13','14:44:30'),
(1,77,'2023-07-13','14:44:31'),
(1,77,'2023-07-13','14:44:31'),
(2,82,'2023-07-14','10:45:02'),
(1,87,'2023-07-14','23:26:00'),
(1,87,'2023-07-14','23:28:30'),
(1,87,'2023-07-14','23:28:38'),
(1,87,'2023-07-14','23:28:46'),
(1,87,'2023-07-14','23:30:51'),
(1,87,'2023-07-14','23:31:42'),
(1,87,'2023-07-14','23:33:40'),
(1,88,'2023-07-14','23:33:50'),
(1,87,'2023-07-14','23:39:02'),
(1,88,'2023-07-14','23:42:15'),
(1,94,'2023-07-15','00:30:55'),
(1,95,'2023-07-15','00:40:32'),
(1,95,'2023-07-15','00:43:50'),
(1,96,'2023-07-15','00:46:16'),
(1,97,'2023-07-15','00:49:10'),
(1,97,'2023-07-15','00:50:20'),
(1,97,'2023-07-15','00:51:25'),
(1,100,'2023-07-15','18:48:04'),
(1,100,'2023-07-15','18:48:12'),
(1,100,'2023-07-15','18:48:29'),
(1,100,'2023-07-15','18:50:48'),
(1,100,'2023-07-15','18:50:59'),
(1,100,'2023-07-15','18:54:24'),
(1,101,'2023-07-15','18:54:38'),
(1,101,'2023-07-15','18:54:52'),
(1,100,'2023-07-15','19:02:13'),
(1,100,'2023-07-15','19:03:38'),
(1,101,'2023-07-15','19:03:51'),
(1,100,'2023-07-15','19:04:16'),
(1,103,'2023-07-15','20:38:10'),
(1,103,'2023-07-15','20:38:39'),
(1,103,'2023-07-15','20:41:14'),
(1,104,'2023-07-15','21:54:58'),
(1,107,'2023-07-15','22:07:41'),
(1,106,'2023-07-15','22:09:45'),
(1,104,'2023-07-15','22:10:00'),
(1,107,'2023-07-15','22:10:55'),
(1,104,'2023-07-15','22:14:27'),
(1,104,'2023-07-15','22:16:06'),
(1,104,'2023-07-15','22:16:30'),
(1,104,'2023-07-15','22:33:11'),
(1,105,'2023-07-15','22:33:25'),
(1,106,'2023-07-15','22:33:40'),
(1,104,'2023-07-15','22:40:42'),
(1,110,'2023-07-15','22:42:11'),
(1,111,'2023-07-15','22:42:59'),
(1,107,'2023-07-15','22:43:13'),
(1,108,'2023-07-15','22:56:29'),
(1,123,'2023-07-15','23:16:39'),
(1,122,'2023-07-15','23:16:50'),
(3,125,'2023-07-16','00:41:04'),
(3,125,'2023-07-16','00:41:45'),
(3,125,'2023-07-16','00:46:33'),
(3,125,'2023-07-16','00:46:45'),
(3,125,'2023-07-16','00:50:17'),
(3,125,'2023-07-16','00:51:22'),
(3,125,'2023-07-16','00:52:41'),
(3,124,'2023-07-16','00:54:02'),
(3,125,'2023-07-16','00:54:36'),
(3,124,'2023-07-16','00:54:47'),
(3,124,'2023-07-16','00:57:27'),
(3,128,'2023-07-16','01:21:31'),
(3,128,'2023-07-16','01:21:42'),
(3,137,'2023-07-16','01:21:53'),
(3,131,'2023-07-16','01:58:18'),
(3,143,'2023-07-16','01:58:28'),
(3,128,'2023-07-16','13:26:47'),
(3,128,'2023-07-16','18:17:18'),
(3,128,'2023-07-16','18:18:58'),
(3,140,'2023-07-16','18:19:11'),
(3,146,'2023-07-16','18:44:31'),
(3,147,'2023-07-16','19:42:30'),
(3,129,'2023-07-16','19:42:41'),
(3,160,'2023-07-16','22:57:43'),
(3,163,'2023-07-16','22:57:53'),
(3,165,'2023-07-16','23:17:40'),
(3,166,'2023-07-16','23:18:03'),
(3,174,'2023-07-17','12:35:30'),
(3,177,'2023-07-18','12:23:25'),
(3,177,'2023-07-18','12:31:53'),
(3,178,'2023-07-18','12:32:57'),
(3,185,'2023-07-18','14:13:41'),
(3,185,'2023-07-18','14:14:27'),
(3,211,'2023-07-18','15:15:19'),
(3,205,'2023-07-18','15:15:44'),
(3,213,'2023-07-19','23:21:16'),
(3,216,'2023-07-23','15:06:31'),
(3,216,'2023-07-23','15:06:48'),
(3,216,'2023-07-23','15:07:01'),
(3,222,'2023-07-23','15:25:05'),
(3,224,'2023-07-23','20:23:28'),
(3,228,'2023-07-23','20:28:17'),
(3,234,'2023-07-23','23:01:14'),
(3,234,'2023-07-23','23:01:27'),
(3,260,'2023-07-24','00:16:45'),
(3,260,'2023-07-24','00:16:57'),
(3,260,'2023-07-24','00:18:25'),
(3,260,'2023-07-24','10:33:42'),
(3,260,'2023-07-24','10:33:59'),
(3,267,'2023-07-24','10:50:59'),
(3,269,'2023-07-24','10:51:10'),
(3,268,'2023-07-24','10:51:24'),
(3,267,'2023-07-24','10:53:43'),
(3,271,'2023-07-24','10:55:18'),
(3,273,'2023-07-24','11:06:35'),
(3,284,'2023-07-24','11:59:46'),
(3,278,'2023-07-24','12:00:33'),
(4,296,'2023-07-24','21:06:18'),
(4,296,'2023-07-24','21:07:34'),
(4,294,'2023-07-24','21:36:50'),
(4,296,'2023-07-24','21:38:20'),
(3,291,'2023-07-24','21:38:37'),
(4,296,'2023-07-24','21:39:31'),
(4,296,'2023-07-24','21:44:06'),
(4,296,'2023-07-24','21:44:22'),
(4,296,'2023-07-24','21:44:42'),
(4,294,'2023-07-24','21:44:55'),
(4,296,'2023-07-24','21:46:48'),
(4,296,'2023-07-24','21:47:20'),
(4,297,'2023-07-24','21:47:27'),
(4,296,'2023-07-24','21:48:36'),
(4,296,'2023-07-24','21:49:22'),
(4,296,'2023-07-24','21:51:41'),
(4,296,'2023-07-24','21:53:28'),
(4,297,'2023-07-24','21:53:42'),
(4,296,'2023-07-24','21:54:55'),
(4,297,'2023-07-24','21:55:09'),
(4,296,'2023-07-24','21:57:15'),
(4,297,'2023-07-24','21:57:27'),
(4,296,'2023-07-24','21:58:04'),
(4,297,'2023-07-24','21:58:16'),
(4,297,'2023-07-24','22:00:22'),
(4,296,'2023-07-24','22:00:35'),
(4,296,'2023-07-24','22:01:36'),
(4,297,'2023-07-24','22:01:49'),
(4,296,'2023-07-24','22:04:15'),
(4,296,'2023-07-24','22:05:15'),
(4,297,'2023-07-24','22:05:28'),
(4,312,'2023-07-29','13:02:31'),
(4,312,'2023-07-29','13:04:16'),
(4,312,'2023-07-29','13:04:28'),
(4,312,'2023-07-29','13:05:00'),
(4,312,'2023-07-29','13:06:18'),
(4,312,'2023-07-29','13:07:03'),
(4,312,'2023-07-29','13:08:55'),
(4,312,'2023-07-29','13:24:48'),
(4,312,'2023-07-29','13:26:53'),
(4,312,'2023-07-29','13:26:54'),
(4,312,'2023-07-29','13:30:36'),
(4,312,'2023-07-29','13:30:53'),
(4,312,'2023-07-29','13:31:06'),
(4,312,'2023-07-29','13:31:37'),
(4,312,'2023-07-29','13:32:42'),
(4,312,'2023-07-29','13:32:58'),
(4,312,'2023-07-29','13:34:30'),
(4,315,'2023-07-29','13:49:18'),
(4,317,'2023-07-29','14:36:11'),
(4,317,'2023-07-29','14:36:58'),
(4,317,'2023-07-29','14:37:14'),
(4,317,'2023-07-29','14:38:53'),
(4,317,'2023-07-29','14:39:58'),
(4,317,'2023-07-29','14:40:15'),
(4,317,'2023-07-29','14:40:48'),
(4,319,'2023-07-29','14:55:11'),
(4,319,'2023-07-29','14:55:55'),
(4,319,'2023-07-29','14:56:08'),
(4,319,'2023-07-29','14:56:30'),
(4,319,'2023-07-29','14:57:13'),
(4,319,'2023-07-29','14:58:27'),
(4,319,'2023-07-29','14:58:43'),
(4,319,'2023-07-29','14:59:53'),
(4,319,'2023-07-29','15:01:13'),
(4,319,'2023-07-29','15:03:03'),
(4,319,'2023-07-29','15:20:52'),
(4,319,'2023-07-29','15:29:35');

/*Table structure for table `antrian_tujuan` */

DROP TABLE IF EXISTS `antrian_tujuan`;

CREATE TABLE `antrian_tujuan` (
  `id_antrian_tujuan` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nama_antrian_tujuan` varchar(255) NOT NULL,
  `nama_file` varchar(255) NOT NULL,
  `ip_addr` varchar(255) DEFAULT '',
  PRIMARY KEY (`id_antrian_tujuan`) USING BTREE,
  UNIQUE KEY `nama_poliklinik` (`nama_antrian_tujuan`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `antrian_tujuan` */

insert  into `antrian_tujuan`(`id_antrian_tujuan`,`nama_antrian_tujuan`,`nama_file`,`ip_addr`) values 
(17,'Loket 1','[\"loket.wav\",\"satu.wav\"]','192.168.1.181'),
(18,'Loket 2','[\"loket.wav\",\"dua.wav\"]','192.168.1.21'),
(19,'Loket 3','[\"loket.wav\",\"tiga.wav\"]',''),
(20,'Loket 4','[\"loket.wav\",\"empat.wav\"]',''),
(21,'Loket 5','[\"loket.wav\",\"lima.wav\"]',''),
(22,'Loket 6','[\"loket.wav\",\"enam.wav\"]',''),
(23,'Loket 7','[\"loket.wav\",\"tujuh.wav\"]',''),
(24,'Loket 8','[\"loket.wav\",\"delapan.wav\"]',''),
(25,'Bilik 1','[\"counter.wav\",\"satu.wav\"]','192.168.1.182'),
(26,'Bilik 2','[\"counter.wav\",\"dua.wav\"]',''),
(27,'Bilik 3','[\"counter.wav\",\"tiga.wav\"]',''),
(28,'Bilik 4','[\"counter.wav\",\"empat.wav\"]','');

/*Table structure for table `identitas` */

DROP TABLE IF EXISTS `identitas`;

CREATE TABLE `identitas` (
  `nama` varchar(255) DEFAULT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  `no_hp` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `file_logo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `identitas` */

insert  into `identitas`(`nama`,`alamat`,`no_hp`,`email`,`website`,`file_logo`) values 
('Jagowebdev Virtual Office','Perumahan Muria Indah Kudus','08561363962','info@jagowebdev.com','https://jagowebdev.com','logo_layar_monitor.png');

/*Table structure for table `menu` */

DROP TABLE IF EXISTS `menu`;

CREATE TABLE `menu` (
  `id_menu` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `nama_menu` varchar(50) NOT NULL,
  `class` varchar(50) DEFAULT NULL,
  `url` varchar(50) DEFAULT NULL,
  `id_module` smallint(5) unsigned DEFAULT NULL,
  `id_parent` smallint(5) unsigned DEFAULT NULL,
  `aktif` tinyint(1) NOT NULL DEFAULT 1,
  `new` tinyint(1) NOT NULL DEFAULT 0,
  `urut` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_menu`) USING BTREE,
  KEY `menu_module` (`id_module`) USING BTREE,
  KEY `menu_menu` (`id_parent`),
  CONSTRAINT `menu_menu` FOREIGN KEY (`id_parent`) REFERENCES `menu` (`id_menu`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `menu_module` FOREIGN KEY (`id_module`) REFERENCES `module` (`id_module`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT COMMENT='Tabel menu aplikasi';

/*Data for the table `menu` */

insert  into `menu`(`id_menu`,`nama_menu`,`class`,`url`,`id_module`,`id_parent`,`aktif`,`new`,`urut`) values 
(1,'User','fas fa-users','builtin/user',5,8,1,0,1),
(2,'Assign Role','fas fa-link','#',1,8,1,0,6),
(3,'User Role','fas fa-user-tag','builtin/user-role',7,2,1,0,2),
(4,'Module','fas fa-network-wired','builtin/module',2,8,1,0,4),
(6,'Menu','fas fa-clone','builtin/menu',1,8,1,0,2),
(7,'Menu Role','fas fa-folder-minus','builtin/menu-role',8,2,1,0,3),
(8,'Aplikasi','fas fa-globe','#',1,NULL,1,0,1),
(9,'Role','fas fa-briefcase','builtin/role',4,8,1,0,3),
(10,'Setting Website','fas fa-cog','builtin/setting-web',16,8,1,0,8),
(11,'Layout Setting','fas fa-brush','builtin/setting',15,8,1,0,9),
(23,'Setting Registrasi','fas fa-user-plus','setting-registrasi',34,8,1,0,7),
(36,'Module Permission','fas fa-shield-alt','builtin/permission',43,8,1,0,5),
(37,'Role Permission','fas fa-user-tag','builtin/role-permission',44,2,1,0,1),
(38,'Antrian','fas fa-users','antrian',72,NULL,1,0,3),
(39,'Layar','fas fa-tv','#',NULL,NULL,1,0,4),
(40,'Layar Ambil Antrian','fas fa-desktop','layar/antrian',73,39,1,0,1),
(41,'Ambil Antrian','fas fa-tasks','antrian-ambil',81,38,1,0,2),
(42,'Panggil Antrian','fas fa-volume-up','antrian-panggil',80,38,1,0,3),
(43,'Layar Monitor','fas fa-tv','layar/show-layar-monitor',73,39,1,0,2),
(44,'Identitas','far fa-hospital','identitas',75,NULL,1,0,2),
(45,'Setting Printer','fas fa-print','setting-printer',76,NULL,1,0,5),
(46,'Referensi Tujuan','fas fa-person-booth','tujuan',77,38,1,0,5),
(47,'Setting Layout','fas fa-palette','layar-monitor-setting-layout',79,39,1,0,4),
(48,'Rekap Antrian','fas fa-history','antrian-rekap',82,38,1,0,6),
(49,'Reset Antrian','fas fa-retweet','antrian-reset',83,38,1,0,4),
(50,'Setting Display','fas fa-cog','layar-monitor-setting',84,39,1,0,3),
(51,'Suara Awalan','fas fa-volume-up','awalan-panggil',85,NULL,1,0,6),
(52,'Group Antrian','fas fa-users-cog','antrian',72,38,1,0,1);

/*Table structure for table `menu_role` */

DROP TABLE IF EXISTS `menu_role`;

CREATE TABLE `menu_role` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `id_menu` smallint(5) unsigned NOT NULL,
  `id_role` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `module_role_module` (`id_menu`),
  KEY `module_role_role` (`id_role`),
  CONSTRAINT `menu_role_menu` FOREIGN KEY (`id_menu`) REFERENCES `menu` (`id_menu`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `menu_role_role` FOREIGN KEY (`id_role`) REFERENCES `role` (`id_role`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT COMMENT='Tabel hak akses dari menu aplikasi';

/*Data for the table `menu_role` */

insert  into `menu_role`(`id`,`id_menu`,`id_role`) values 
(6,2,1),
(7,3,1),
(8,4,1),
(9,6,1),
(19,1,1),
(20,1,2),
(23,8,1),
(25,7,1),
(29,9,1),
(30,10,1),
(32,11,1),
(64,23,1),
(75,36,1),
(77,37,1),
(78,38,1),
(79,39,1),
(80,40,1),
(81,41,1),
(82,42,1),
(83,43,1),
(84,44,1),
(85,45,1),
(86,46,1),
(87,47,1),
(88,48,1),
(89,8,2),
(90,11,2),
(91,41,2),
(92,42,2),
(93,38,2),
(94,49,1),
(95,50,1),
(96,51,1),
(97,52,1);

/*Table structure for table `module` */

DROP TABLE IF EXISTS `module`;

CREATE TABLE `module` (
  `id_module` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `nama_module` varchar(50) DEFAULT NULL,
  `judul_module` varchar(50) DEFAULT NULL,
  `id_module_status` tinyint(1) DEFAULT NULL,
  `login` enum('Y','N','R') NOT NULL DEFAULT 'Y',
  `deskripsi` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_module`),
  UNIQUE KEY `module_nama` (`nama_module`),
  KEY `module_module_status` (`id_module_status`),
  CONSTRAINT `module_module_status` FOREIGN KEY (`id_module_status`) REFERENCES `module_status` (`id_module_status`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC COMMENT='Tabel modul aplikasi';

/*Data for the table `module` */

insert  into `module`(`id_module`,`nama_module`,`judul_module`,`id_module_status`,`login`,`deskripsi`) values 
(1,'builtin/menu','Menu Manager',1,'Y','Administrasi Menu'),
(2,'builtin/module','Module Manager',1,'Y','Pengaturan Module'),
(3,'builtin/module-role','Assign Role ke Module',1,'Y','Assign Role ke Module'),
(4,'builtin/role','Role Manager',1,'Y','Pengaturan Role'),
(5,'builtin/user','User Manager',1,'Y','Pengaturan user'),
(6,'login','Login',1,'R','Login ke akun Anda'),
(7,'builtin/user-role','Assign Role ke User',1,'Y','Assign role ke user'),
(8,'builtin/menu-role','Menu - Role',1,'Y','Assign role ke menu'),
(15,'builtin/setting','Setting Layout',1,'Y','Web Setting'),
(16,'builtin/setting-web','Setting Web',1,'Y','Pengaturan website seperti nama web, logo, dll'),
(25,'home','Home',1,'Y','Home'),
(33,'register','Register Akun',1,'R','Register Akun'),
(34,'setting-registrasi','Setting Registrasi Akun',1,'Y','Setting Registrasi Akun'),
(35,'recovery','Reset Password',1,'R','Reset Password'),
(43,'builtin/permission','Permission',1,'Y','Permission'),
(44,'builtin/role-permission','Role Permission',1,'Y','Role Permission'),
(72,'antrian','Antrian',1,'Y','Antrian'),
(73,'layar','Layar',1,'N','Layar Antrian dan Monitor'),
(74,'longpolling','Long Polling',1,'N','Long Polling'),
(75,'identitas','Identitas',1,'Y','Identitas'),
(76,'setting-printer','Setting Printer',1,'Y','Setting Printer'),
(77,'tujuan','Tujuan',1,'Y','Tujuan Antrian'),
(79,'layar-monitor-setting-layout','Setting Layout Layar',1,'Y','Setting Layout Layar'),
(80,'antrian-panggil','Panggil Antrian',1,'Y','Panggil Antrian'),
(81,'antrian-ambil','Ambil Antrian',1,'Y','Ambil Antrian'),
(82,'antrian-rekap','Rekapitulasi Antrian',1,'Y','Rekapitulasi Antrian'),
(83,'antrian-reset','Reset Antrian',1,'Y','Reset Antrian'),
(84,'layar-monitor-setting','Setting Monitor Antrian',1,'Y','Setting Monitor Antrian'),
(85,'awalan-panggil','Suara Awalan Panggil Antrian',1,'Y','Suara Awalan Panggil Antrian');

/*Table structure for table `module_permission` */

DROP TABLE IF EXISTS `module_permission`;

CREATE TABLE `module_permission` (
  `id_module_permission` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `id_module` smallint(5) unsigned NOT NULL DEFAULT 0,
  `nama_permission` varchar(50) NOT NULL,
  `judul_permission` varchar(255) DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_module_permission`) USING BTREE,
  UNIQUE KEY `id_module_nama_permission` (`id_module`,`nama_permission`)
) ENGINE=InnoDB AUTO_INCREMENT=382 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `module_permission` */

insert  into `module_permission`(`id_module_permission`,`id_module`,`nama_permission`,`judul_permission`,`keterangan`) values 
(10,25,'create','Create Data','Hak akses untuk menambah data\r'),
(13,6,'create','Create Data','Hak akses untuk menambah data\r'),
(14,1,'create','Create Data','Hak akses untuk menambah data\r'),
(15,8,'create','Create Data','Hak akses untuk menambah data\r'),
(16,2,'create','Create Data','Hak akses untuk menambah data\r'),
(17,3,'create','Create Data','Hak akses untuk menambah data\r'),
(22,35,'create','Create Data','Hak akses untuk menambah data\r'),
(23,33,'create','Create Data','Hak akses untuk menambah data\r'),
(24,4,'create','Create Data','Hak akses untuk menambah data\r'),
(25,15,'create','Create Data','Hak akses untuk menambah data\r'),
(26,34,'create','Create Data','Hak akses untuk menambah data\r'),
(27,16,'create','Create Data','Hak akses untuk menambah data\r'),
(29,5,'create','Create Data','Hak akses untuk menambah data\r'),
(30,7,'create','Create Data','Hak akses untuk menambah data\r'),
(40,25,'delete_all','Delete All Data','Hak akses untuk menghapus semua data\r'),
(43,6,'delete_all','Delete All Data','Hak akses untuk menghapus semua data\r'),
(44,1,'delete_all','Delete All Data','Hak akses untuk menghapus semua data\r'),
(45,8,'delete_all','Delete All Data','Hak akses untuk menghapus semua data\r'),
(46,2,'delete_all','Delete All Data','Hak akses untuk menghapus semua data\r'),
(47,3,'delete_all','Delete All Data','Hak akses untuk menghapus semua data\r'),
(52,35,'delete_all','Delete All Data','Hak akses untuk menghapus semua data\r'),
(53,33,'delete_all','Delete All Data','Hak akses untuk menghapus semua data\r'),
(54,4,'delete_all','Delete All Data','Hak akses untuk menghapus semua data\r'),
(55,15,'delete_all','Delete All Data','Hak akses untuk menghapus semua data\r'),
(56,34,'delete_all','Delete All Data','Hak akses untuk menghapus semua data\r'),
(57,16,'delete_all','Delete All Data','Hak akses untuk menghapus semua data\r'),
(59,5,'delete_all','Delete All Data','Hak akses untuk menghapus semua data\r'),
(60,7,'delete_all','Delete All Data','Hak akses untuk menghapus semua data\r'),
(70,25,'read_all','Read All Data','Hak akses untuk membaca data home\r'),
(73,6,'read_all','Read All Data','Hak akses untuk membaca data login\r'),
(74,1,'read_all','Read All Data','Hak akses untuk membaca data menu\r'),
(75,8,'read_all','Read All Data','Hak akses untuk membaca data menu role\r'),
(76,2,'read_all','Read All Data','Hak akses untuk membaca data module\r'),
(77,3,'read_all','Read All Data','Hak akses untuk membaca data module role\r'),
(82,35,'read_all','Read All Data','Hak akses untuk membaca data recovery\r'),
(83,33,'read_all','Read All Data','Hak akses untuk membaca data register\r'),
(84,4,'read_all','Read All Data','Hak akses untuk membaca data role\r'),
(85,15,'read_all','Read All Data','Hak akses untuk membaca data setting\r'),
(86,34,'read_all','Read All Data','Hak akses untuk membaca data setting registrasi\r'),
(87,16,'read_all','Read All Data','Hak akses untuk membaca data setting web\r'),
(89,5,'read_all','Read All Data','Hak akses untuk membaca data user\r'),
(90,7,'read_all','Read All Data','Hak akses untuk membaca data user role\r'),
(100,25,'update_all','Update All Data','Hak akses untuk mengupdate semua data\r'),
(103,6,'update_all','Update All Data','Hak akses untuk mengupdate semua data\r'),
(104,1,'update_all','Update All Data','Hak akses untuk mengupdate semua data\r'),
(105,8,'update_all','Update All Data','Hak akses untuk mengupdate semua data\r'),
(106,2,'update_all','Update All Data','Hak akses untuk mengupdate semua data\r'),
(107,3,'update_all','Update All Data','Hak akses untuk mengupdate semua data\r'),
(112,35,'update_all','Update All Data','Hak akses untuk mengupdate semua data\r'),
(113,33,'update_all','Update All Data','Hak akses untuk mengupdate semua data\r'),
(114,4,'update_all','Update All Data','Hak akses untuk mengupdate semua data\r'),
(115,15,'update_all','Update All Data','Hak akses untuk mengupdate semua data\r'),
(116,34,'update_all','Update All Data','Hak akses untuk mengupdate semua data\r'),
(117,16,'update_all','Update All Data','Hak akses untuk mengupdate semua data\r'),
(119,5,'update_all','Update All Data','Hak akses untuk mengupdate semua data\r'),
(120,7,'update_all','Update All Data','Hak akses untuk mengupdate semua data\r'),
(125,43,'create','Create Data','Hak akses untuk membuat data'),
(126,43,'read_all','Read All Data','Hak akses untuk membaca semua data'),
(127,43,'update_all','Update All Data','Hak akses untuk mengupdate semua data'),
(128,43,'delete_all','Delete All Data','Hak akses untuk menghapus semua data'),
(129,44,'create','Create Data','Hak akses untuk membuat data'),
(130,44,'read_all','Read All Data','Hak akses untuk membaca semua data'),
(131,44,'update_all','Update All Data','Hak akses untuk mengupdate semua data'),
(132,44,'delete_all','Delete All Data','Hak akses untuk menghapus semua data'),
(133,5,'read_own','Read Own Data','Hak akses untuk membaca data miliknya sendiri'),
(134,5,'update_own','Update Own Data','Hak akses untuk mengupdate data miliknya sendiri'),
(135,5,'delete_own','Delete Own Data','Hak akses untuk menghapus data miliknya sendiri'),
(138,50,'read_all','Read All Data','Hak akses untuk membaca semua data'),
(139,50,'update_all','Update All Data','Hak akses untuk mengupdate semua data'),
(140,50,'delete_all','Delete All Data','Hak akses untuk menghapus semua data'),
(141,50,'read_own','Read Own Data','Hak akses untuk membaca data miliknya sendiri'),
(142,50,'update_own','Update Own Data','Hak akses untuk mengupdate data miliknya sendiri'),
(143,50,'delete_own','Delete Own Data','Hak akses untuk menghapus data miliknya sendiri'),
(152,53,'create','Create Data','Hak akses untuk membuat data'),
(153,53,'read_own','Read Own Data','Hak akses untuk membaca data miliknya sendiri'),
(154,53,'update_own','Update Own Data','Hak akses untuk mengupdate data miliknya sendiri'),
(155,53,'delete_own','Delete Own Data','Hak akses untuk menghapus data miliknya sendiri'),
(156,54,'create','Create Data','Hak akses untuk membuat data'),
(157,54,'read_own','Read Own Data','Hak akses untuk membaca data miliknya sendiri'),
(158,54,'update_own','Update Own Data','Hak akses untuk mengupdate data miliknya sendiri'),
(159,54,'delete_own','Delete Own Data','Hak akses untuk menghapus data miliknya sendiri'),
(160,55,'create','Create Data','Hak akses untuk membuat data'),
(161,55,'read_own','Read Own Data','Hak akses untuk membaca data miliknya sendiri'),
(162,55,'update_own','Update Own Data','Hak akses untuk mengupdate data miliknya sendiri'),
(163,55,'delete_own','Delete Own Data','Hak akses untuk menghapus data miliknya sendiri'),
(164,56,'create','Create Data','Hak akses untuk membuat data'),
(165,56,'read_all','Read All Data','Hak akses untuk membaca semua data'),
(166,56,'update_all','Update All Data','Hak akses untuk mengupdate semua data'),
(167,56,'delete_all','Delete All Data','Hak akses untuk menghapus semua data'),
(171,56,'read_own','Read Own Data','Hak akses untuk membaca data miliknya sendiri'),
(172,56,'update_own','Update Own Data','Hak akses untuk mengupdate data miliknya sendiri'),
(173,56,'delete_own','Delete Own Data','Hak akses untuk menghapus data miliknya sendiri'),
(185,57,'create','Create Data','Hak akses untuk membuat data'),
(186,57,'read_all','Read All Data','Hak akses untuk membaca semua data'),
(187,57,'update_all','Update All Data','Hak akses untuk mengupdate semua data'),
(188,57,'delete_all','Delete All Data','Hak akses untuk menghapus semua data'),
(193,60,'create','Create Data','Hak akses untuk membuat data'),
(194,60,'read_all','Read All Data','Hak akses untuk membaca semua data'),
(195,60,'update_all','Update All Data','Hak akses untuk mengupdate semua data'),
(196,60,'delete_all','Delete All Data','Hak akses untuk menghapus semua data'),
(197,61,'create','Create Data','Hak akses untuk membuat data'),
(198,61,'read_all','Read All Data','Hak akses untuk membaca semua data'),
(199,61,'update_all','Update All Data','Hak akses untuk mengupdate semua data'),
(200,61,'delete_all','Delete All Data','Hak akses untuk menghapus semua data'),
(201,62,'create','Create Data','Hak akses untuk membuat data'),
(202,62,'read_all','Read All Data','Hak akses untuk membaca semua data'),
(203,62,'update_all','Update All Data','Hak akses untuk mengupdate semua data'),
(204,62,'delete_all','Delete All Data','Hak akses untuk menghapus semua data'),
(205,63,'create','Create Data','Hak akses untuk membuat data'),
(206,63,'read_all','Read All Data','Hak akses untuk membaca semua data'),
(207,63,'update_all','Update All Data','Hak akses untuk mengupdate semua data'),
(208,63,'delete_all','Delete All Data','Hak akses untuk menghapus semua data'),
(213,65,'create','Create Data','Hak akses untuk membuat data'),
(214,65,'read_all','Read All Data','Hak akses untuk membaca semua data'),
(215,65,'update_all','Update All Data','Hak akses untuk mengupdate semua data'),
(216,65,'delete_all','Delete All Data','Hak akses untuk menghapus semua data'),
(217,66,'create','Create Data','Hak akses untuk membuat data'),
(218,66,'read_all','Read All Data','Hak akses untuk membaca semua data'),
(219,66,'update_all','Update All Data','Hak akses untuk mengupdate semua data'),
(220,66,'delete_all','Delete All Data','Hak akses untuk menghapus semua data'),
(221,67,'create','Create Data','Hak akses untuk membuat data'),
(222,67,'read_all','Read All Data','Hak akses untuk membaca semua data'),
(223,67,'update_all','Update All Data','Hak akses untuk mengupdate semua data'),
(224,67,'delete_all','Delete All Data','Hak akses untuk menghapus semua data'),
(227,68,'update_all','Update All Data','Hak akses untuk mengupdate semua data'),
(229,69,'create','Create Data','Hak akses untuk membuat data'),
(230,69,'read_all','Read All Data','Hak akses untuk membaca semua data'),
(231,69,'update_all','Update All Data','Hak akses untuk mengupdate semua data'),
(232,69,'delete_all','Delete All Data','Hak akses untuk menghapus semua data'),
(233,70,'create','Create Data','Hak akses untuk membuat data'),
(234,70,'read_all','Read All Data','Hak akses untuk membaca semua data'),
(235,70,'update_all','Update All Data','Hak akses untuk mengupdate semua data'),
(236,70,'delete_all','Delete All Data','Hak akses untuk menghapus semua data'),
(244,58,'create','Create Data','Hak akses untuk membuat data'),
(245,58,'read_all','Read All Data','Hak akses untuk membaca semua data'),
(246,58,'update_all','Update All Data','Hak akses untuk mengupdate semua data'),
(247,58,'delete_all','Delete All Data','Hak akses untuk menghapus semua data'),
(248,58,'read_own','Read Own Data','Hak akses untuk membaca data miliknya sendiri'),
(249,58,'update_own','Update Own Data','Hak akses untuk mengupdate data miliknya sendiri'),
(250,58,'delete_own','Delete Own Data','Hak akses untuk menghapus data miliknya sendiri'),
(258,71,'create','Create Data','Hak akses untuk membuat data'),
(259,71,'read_all','Read All Data','Hak akses untuk membaca semua data'),
(260,71,'update_all','Update All Data','Hak akses untuk mengupdate semua data'),
(261,71,'delete_all','Delete All Data','Hak akses untuk menghapus semua data'),
(262,71,'read_own','Read Own Data','Hak akses untuk membaca data miliknya sendiri'),
(263,71,'update_own','Update Own Data','Hak akses untuk mengupdate data miliknya sendiri'),
(264,71,'delete_own','Delete Own Data','Hak akses untuk menghapus data miliknya sendiri'),
(265,71,'read_test','Read_test','read_test'),
(308,64,'read_all','Read All Data','Hak akses untuk membaca semua data'),
(309,64,'update_all','Update All Data','Hak akses untuk mengupdate semua data'),
(310,64,'delete_all','Delete All Data','Hak akses untuk menghapus semua data'),
(311,64,'read_own','Read Own Data','Hak akses untuk membaca data miliknya sendiri'),
(312,64,'update_own','Update Own Data','Hak akses untuk mengupdate data miliknya sendiri'),
(313,64,'delete_own','Delete Own Data','Hak akses untuk menghapus data miliknya sendiri'),
(318,64,'create','create','create'),
(325,64,'send_email','send_email','KIrim email'),
(326,72,'create','Create Data','Hak akses untuk membuat data'),
(327,72,'read_all','Read All Data','Hak akses untuk membaca semua data'),
(328,72,'update_all','Update All Data','Hak akses untuk mengupdate semua data'),
(329,72,'delete_all','Delete All Data','Hak akses untuk menghapus semua data'),
(330,73,'create','Create Data','Hak akses untuk membuat data'),
(331,73,'read_all','Read All Data','Hak akses untuk membaca semua data'),
(332,73,'update_all','Update All Data','Hak akses untuk mengupdate semua data'),
(333,73,'delete_all','Delete All Data','Hak akses untuk menghapus semua data'),
(334,74,'create','Create Data','Hak akses untuk membuat data'),
(335,74,'read_all','Read All Data','Hak akses untuk membaca semua data'),
(336,74,'update_all','Update All Data','Hak akses untuk mengupdate semua data'),
(337,74,'delete_all','Delete All Data','Hak akses untuk menghapus semua data'),
(338,75,'create','Create Data','Hak akses untuk membuat data'),
(339,75,'read_all','Read All Data','Hak akses untuk membaca semua data'),
(340,75,'update_all','Update All Data','Hak akses untuk mengupdate semua data'),
(341,75,'delete_all','Delete All Data','Hak akses untuk menghapus semua data'),
(342,76,'create','Create Data','Hak akses untuk membuat data'),
(343,76,'read_all','Read All Data','Hak akses untuk membaca semua data'),
(344,76,'update_all','Update All Data','Hak akses untuk mengupdate semua data'),
(345,76,'delete_all','Delete All Data','Hak akses untuk menghapus semua data'),
(346,77,'create','Create Data','Hak akses untuk membuat data'),
(347,77,'read_all','Read All Data','Hak akses untuk membaca semua data'),
(348,77,'update_all','Update All Data','Hak akses untuk mengupdate semua data'),
(349,77,'delete_all','Delete All Data','Hak akses untuk menghapus semua data'),
(350,79,'create','Create Data','Hak akses untuk membuat data'),
(351,79,'read_all','Read All Data','Hak akses untuk membaca semua data'),
(352,79,'update_all','Update All Data','Hak akses untuk mengupdate semua data'),
(353,79,'delete_all','Delete All Data','Hak akses untuk menghapus semua data'),
(354,80,'create','Create Data','Hak akses untuk membuat data'),
(355,80,'read_all','Read All Data','Hak akses untuk membaca semua data'),
(356,80,'update_all','Update All Data','Hak akses untuk mengupdate semua data'),
(357,80,'delete_all','Delete All Data','Hak akses untuk menghapus semua data'),
(358,81,'create','Create Data','Hak akses untuk membuat data'),
(359,81,'read_all','Read All Data','Hak akses untuk membaca semua data'),
(360,81,'update_all','Update All Data','Hak akses untuk mengupdate semua data'),
(361,81,'delete_all','Delete All Data','Hak akses untuk menghapus semua data'),
(362,82,'create','Create Data','Hak akses untuk membuat data'),
(363,82,'read_all','Read All Data','Hak akses untuk membaca semua data'),
(364,82,'update_all','Update All Data','Hak akses untuk mengupdate semua data'),
(365,82,'delete_all','Delete All Data','Hak akses untuk menghapus semua data'),
(366,83,'create','Create Data','Hak akses untuk membuat data'),
(367,83,'read_all','Read All Data','Hak akses untuk membaca semua data'),
(368,83,'update_all','Update All Data','Hak akses untuk mengupdate semua data'),
(369,83,'delete_all','Delete All Data','Hak akses untuk menghapus semua data'),
(374,84,'create','Create Data','Hak akses untuk membuat data'),
(375,84,'read_all','Read All Data','Hak akses untuk membaca semua data'),
(376,84,'update_all','Update All Data','Hak akses untuk mengupdate semua data'),
(377,84,'delete_all','Delete All Data','Hak akses untuk menghapus semua data'),
(378,85,'create','Create Data','Hak akses untuk membuat data'),
(379,85,'read_all','Read All Data','Hak akses untuk membaca semua data'),
(380,85,'update_all','Update All Data','Hak akses untuk mengupdate semua data'),
(381,85,'delete_all','Delete All Data','Hak akses untuk menghapus semua data');

/*Table structure for table `module_role` */

DROP TABLE IF EXISTS `module_role`;

CREATE TABLE `module_role` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `id_module` smallint(5) unsigned NOT NULL,
  `id_role` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `module_role_module` (`id_module`),
  KEY `module_role_role` (`id_role`),
  CONSTRAINT `module_role_module` FOREIGN KEY (`id_module`) REFERENCES `module` (`id_module`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `module_role_role` FOREIGN KEY (`id_role`) REFERENCES `role` (`id_role`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC COMMENT='Tabel hak akses module aplikasi, module aplikasi boleh diakses oleh user yang mempunyai role apa saja';

/*Data for the table `module_role` */

insert  into `module_role`(`id`,`id_module`,`id_role`) values 
(1,3,1),
(2,8,1),
(3,4,1),
(5,2,1),
(6,1,1),
(7,7,1),
(26,15,1),
(27,15,2),
(28,16,1),
(38,25,1),
(39,25,2),
(68,5,1),
(69,5,2),
(106,34,1),
(114,43,1),
(115,44,1),
(147,72,1),
(148,73,1),
(149,74,1),
(150,75,1),
(151,76,1),
(152,77,1),
(153,79,1),
(154,80,1),
(155,81,1),
(156,82,1);

/*Table structure for table `module_status` */

DROP TABLE IF EXISTS `module_status`;

CREATE TABLE `module_status` (
  `id_module_status` tinyint(1) NOT NULL AUTO_INCREMENT,
  `nama_status` varchar(50) DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_module_status`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC COMMENT='Tabel status modul, seperti: aktif, non aktif, dalam perbaikan';

/*Data for the table `module_status` */

insert  into `module_status`(`id_module_status`,`nama_status`,`keterangan`) values 
(1,'Aktif',NULL),
(2,'Dalam Perbaikan','Hanya role developer yang dapat mengakses module dengan status ini'),
(3,'Non Aktif',NULL);

/*Table structure for table `role` */

DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
  `id_role` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `nama_role` varchar(50) NOT NULL,
  `judul_role` varchar(50) NOT NULL,
  `keterangan` varchar(50) NOT NULL,
  `id_module` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_role`),
  UNIQUE KEY `role_nama` (`nama_role`),
  KEY `role_module` (`id_module`),
  CONSTRAINT `role_module` FOREIGN KEY (`id_module`) REFERENCES `module` (`id_module`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC COMMENT='Tabel yang berisi daftar role, role ini mengatur bagaimana user mengakses module, role ini nantinya diassign ke user';

/*Data for the table `role` */

insert  into `role`(`id_role`,`nama_role`,`judul_role`,`keterangan`,`id_module`) values 
(1,'admin','Administrator','Administrator',5),
(2,'user','User','Pengguna umum',5),
(3,'webdev','Web Developer','Pengembang aplikasi',5),
(12,'Loket','Loket','Penjaga Loket',80);

/*Table structure for table `role_detail` */

DROP TABLE IF EXISTS `role_detail`;

CREATE TABLE `role_detail` (
  `id_role_detail` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `nama_role_detail` varchar(255) DEFAULT NULL,
  `judul_role_detail` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_role_detail`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

/*Data for the table `role_detail` */

insert  into `role_detail`(`id_role_detail`,`nama_role_detail`,`judul_role_detail`) values 
(1,'all','Boleh Akses Semua Data'),
(2,'no','Tidak Boleh Akses Semua Data'),
(3,'own','Hanya Data Miliknya Sendiri');

/*Table structure for table `role_module_permission` */

DROP TABLE IF EXISTS `role_module_permission`;

CREATE TABLE `role_module_permission` (
  `id_role` smallint(5) unsigned NOT NULL DEFAULT 0,
  `id_module_permission` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id_role`,`id_module_permission`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `role_module_permission` */

insert  into `role_module_permission`(`id_role`,`id_module_permission`) values 
(1,10),
(1,13),
(1,14),
(1,15),
(1,16),
(1,17),
(1,22),
(1,23),
(1,24),
(1,25),
(1,26),
(1,27),
(1,29),
(1,30),
(1,40),
(1,43),
(1,44),
(1,45),
(1,46),
(1,47),
(1,52),
(1,53),
(1,54),
(1,55),
(1,56),
(1,57),
(1,59),
(1,60),
(1,70),
(1,73),
(1,74),
(1,75),
(1,76),
(1,77),
(1,82),
(1,83),
(1,84),
(1,85),
(1,86),
(1,87),
(1,89),
(1,90),
(1,100),
(1,103),
(1,104),
(1,105),
(1,106),
(1,107),
(1,112),
(1,113),
(1,114),
(1,115),
(1,116),
(1,117),
(1,119),
(1,120),
(1,125),
(1,126),
(1,127),
(1,128),
(1,129),
(1,130),
(1,131),
(1,132),
(1,134),
(1,135),
(1,326),
(1,327),
(1,328),
(1,329),
(1,330),
(1,331),
(1,332),
(1,333),
(1,334),
(1,335),
(1,336),
(1,337),
(1,338),
(1,339),
(1,340),
(1,341),
(1,342),
(1,343),
(1,344),
(1,345),
(1,346),
(1,347),
(1,348),
(1,349),
(1,350),
(1,351),
(1,352),
(1,353),
(1,354),
(1,355),
(1,356),
(1,357),
(1,358),
(1,359),
(1,360),
(1,361),
(1,362),
(1,363),
(1,364),
(1,365),
(1,366),
(1,367),
(1,368),
(1,369),
(1,374),
(1,375),
(1,376),
(1,377),
(1,378),
(1,379),
(1,380),
(1,381),
(2,85),
(2,115),
(2,133),
(2,134),
(2,135),
(2,326),
(2,327),
(2,328),
(2,329),
(2,335),
(2,355),
(2,359),
(3,133),
(12,326),
(12,327),
(12,328),
(12,329),
(12,334),
(12,335),
(12,336),
(12,337),
(12,354),
(12,355),
(12,356),
(12,357),
(12,358),
(12,359),
(12,360),
(12,361);

/*Table structure for table `setting_app` */

DROP TABLE IF EXISTS `setting_app`;

CREATE TABLE `setting_app` (
  `param` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `setting_app` */

insert  into `setting_app`(`param`,`value`) values 
('using_printer','N');

/*Table structure for table `setting_app_tampilan` */

DROP TABLE IF EXISTS `setting_app_tampilan`;

CREATE TABLE `setting_app_tampilan` (
  `param` varchar(255) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`param`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Data for the table `setting_app_tampilan` */

insert  into `setting_app_tampilan`(`param`,`value`) values 
('color_scheme','purple'),
('sidebar_color','dark'),
('logo_background_color','dark'),
('font_family','poppins'),
('font_size','14.5');

/*Table structure for table `setting_app_user` */

DROP TABLE IF EXISTS `setting_app_user`;

CREATE TABLE `setting_app_user` (
  `id_user` int(11) unsigned NOT NULL,
  `param` varchar(255) NOT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Data for the table `setting_app_user` */

insert  into `setting_app_user`(`id_user`,`param`) values 
(2,'{\"color_scheme\":\"blue-dark\",\"sidebar_color\":\"dark\",\"logo_background_color\":\"default\",\"font_family\":\"open-sans\",\"font_size\":\"15\"}');

/*Table structure for table `setting_layar` */

DROP TABLE IF EXISTS `setting_layar`;

CREATE TABLE `setting_layar` (
  `id_setting_layar` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nama_setting` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id_setting_layar`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `setting_layar` */

insert  into `setting_layar`(`id_setting_layar`,`nama_setting`) values 
(3,'Loket'),
(4,'Bilik');

/*Table structure for table `setting_layar_detail` */

DROP TABLE IF EXISTS `setting_layar_detail`;

CREATE TABLE `setting_layar_detail` (
  `id_setting_layar` int(11) unsigned NOT NULL,
  `id_antrian_kategori` int(11) unsigned NOT NULL,
  `urut` tinyint(3) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `setting_layar_detail` */

insert  into `setting_layar_detail`(`id_setting_layar`,`id_antrian_kategori`,`urut`) values 
(3,3,1),
(3,9,2),
(3,10,3),
(4,11,1);

/*Table structure for table `setting_layar_layout` */

DROP TABLE IF EXISTS `setting_layar_layout`;

CREATE TABLE `setting_layar_layout` (
  `param` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`param`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `setting_layar_layout` */

insert  into `setting_layar_layout`(`param`,`value`) values 
('color_scheme','gradient'),
('font_family','poppins'),
('font_size','100'),
('jenis_video','folder'),
('link_video','public/videos/'),
('text_footer','JAM BUKA LAYANAN KAMI ADALAH PUKUL 07:00 s.d 21.00. TERIMA KASIH ATAS KUNJUNGAN ANDA . KAMI SENANTIASA MELAYANI SEPENUH HATI'),
('text_footer_mode','statis'),
('text_footer_speed','25');

/*Table structure for table `setting_printer` */

DROP TABLE IF EXISTS `setting_printer`;

CREATE TABLE `setting_printer` (
  `id_setting_printer` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nama_setting_printer` varchar(255) DEFAULT NULL,
  `alamat_server` varchar(255) DEFAULT NULL,
  `aktif` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id_setting_printer`),
  UNIQUE KEY `nama_setting_printer` (`nama_setting_printer`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

/*Data for the table `setting_printer` */

insert  into `setting_printer`(`id_setting_printer`,`nama_setting_printer`,`alamat_server`,`aktif`) values 
(1,'Printer Pengunjung','192.168.1.8',0),
(2,'Loket 1','192.168.1.17',1),
(3,'Loket 2','::1',1),
(4,'Loket 3','::1',1);

/*Table structure for table `setting_register` */

DROP TABLE IF EXISTS `setting_register`;

CREATE TABLE `setting_register` (
  `param` varchar(255) NOT NULL,
  `value` tinytext DEFAULT NULL,
  PRIMARY KEY (`param`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `setting_register` */

insert  into `setting_register`(`param`,`value`) values 
('enable','Y'),
('id_role','2'),
('metode_aktivasi','email');

/*Table structure for table `setting_web` */

DROP TABLE IF EXISTS `setting_web`;

CREATE TABLE `setting_web` (
  `param` varchar(255) NOT NULL,
  `value` tinytext DEFAULT NULL,
  PRIMARY KEY (`param`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `setting_web` */

insert  into `setting_web`(`param`,`value`) values 
('background_logo','transparent'),
('btn_login','btn-danger'),
('deskripsi_web','Apliaksi antrian professional berbasis web lengkap dengan suara.'),
('favicon','favicon.png'),
('footer_app','© {{YEAR}} <a href=\"https://jagowebdev.com\" target=\"_blank\">www.Jagowebdev.com</a>'),
('footer_login','© {{YEAR}} <a href=\"https://jagowebdev.com\" target=\"_blank\">Jagowebdev.com</a>'),
('judul_web','Aplikasi Antrian Jagowebdev'),
('logo_app','logo_aplikasi.png'),
('logo_login','logo_login.png'),
('logo_register','logo_register.png');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id_user` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `verified` tinyint(4) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `created` datetime NOT NULL DEFAULT curdate(),
  `avatar` varchar(255) NOT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT COMMENT='Tabel user untuk login';

/*Data for the table `user` */

insert  into `user`(`id_user`,`email`,`username`,`nama`,`password`,`verified`,`status`,`created`,`avatar`) values 
(1,'prawoto.hadi@gmail.com','admin','Agus Prawoto Hadi','$2y$10$luCbrAdrDWgxckIYfjQymeeN.6WuV656.MNUth8AxF94H8Mb.enmK',1,0,'2018-09-20 16:04:35','Agus Prawoto Hadi.png'),
(3,'user.administrasi@gmail.com','user','User Administrasi','$2y$10$n2hGjOQUW2EYRskCF2rgaOJR5w0dR3h8hqWln/5OXkAW2XT6vpujO',1,1,'2020-04-05 10:12:22','Ahmad Basuki.png'),
(5,'guest@gmail.com','guest','Guest','$2y$10$FjaeXtJ7f/vrOfCJuUW2GebEVuTgOEhlVpQ3jtY4BDGlfUaWsPz4G',1,1,'2022-02-14 00:00:00',''),
(7,'gibran@gmail.com','gibran','Loket 1','$2y$10$OI7Q09AJHvuAxqzH4b4rj.5AwKHFal6ama5k4hVsYWBZfynK5cZHS',1,1,'2023-07-16 00:00:00','');

/*Table structure for table `user_login_activity` */

DROP TABLE IF EXISTS `user_login_activity`;

CREATE TABLE `user_login_activity` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_user` int(10) unsigned NOT NULL,
  `id_activity` tinyint(4) NOT NULL,
  `time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_login_activity_user` (`id_user`),
  CONSTRAINT `user_login_activity_user` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Data for the table `user_login_activity` */

insert  into `user_login_activity`(`id`,`id_user`,`id_activity`,`time`) values 
(1,1,1,'2022-06-01 09:47:55'),
(2,1,1,'2022-06-01 09:50:16'),
(3,1,1,'2022-06-10 04:46:58'),
(4,1,1,'2022-07-03 05:50:22'),
(5,1,1,'2022-07-03 06:57:22'),
(6,1,1,'2022-07-03 17:38:44'),
(7,1,1,'2022-07-09 16:30:06'),
(8,1,1,'2022-07-11 05:48:28'),
(9,1,1,'2022-07-11 08:15:26'),
(10,1,1,'2022-07-12 05:09:28'),
(11,1,1,'2022-07-16 12:23:54'),
(12,1,1,'2022-07-17 05:02:44'),
(13,1,1,'2022-07-17 07:19:24'),
(14,1,1,'2022-07-17 12:40:23'),
(15,1,1,'2022-07-17 13:02:05'),
(16,1,1,'2023-07-13 14:42:17'),
(17,1,1,'2023-07-13 20:47:06'),
(18,1,1,'2023-07-14 10:39:26'),
(19,7,1,'2023-07-16 12:38:33'),
(20,7,1,'2023-07-16 12:42:45'),
(21,7,1,'2023-07-16 12:47:31'),
(22,7,1,'2023-07-16 13:00:19'),
(23,7,1,'2023-07-16 13:12:20'),
(24,7,1,'2023-07-16 18:17:11'),
(25,7,1,'2023-07-16 23:38:04'),
(26,1,1,'2023-07-16 23:40:21'),
(27,1,1,'2023-07-17 12:19:16'),
(28,7,1,'2023-07-17 12:29:19'),
(29,7,1,'2023-07-17 12:32:19'),
(30,1,1,'2023-07-17 12:32:48'),
(31,7,1,'2023-07-17 12:33:12'),
(32,1,1,'2023-07-17 12:33:38'),
(33,7,1,'2023-07-17 14:20:53'),
(34,1,1,'2023-07-17 14:25:39'),
(35,7,1,'2023-07-18 12:06:06'),
(36,1,1,'2023-07-18 12:06:35'),
(37,7,1,'2023-07-18 14:25:06'),
(38,1,1,'2023-07-19 21:45:14'),
(39,1,1,'2023-07-19 21:45:20'),
(40,1,1,'2023-07-21 22:16:41'),
(41,1,1,'2023-07-21 22:16:53'),
(42,1,1,'2023-07-21 22:55:51'),
(43,1,1,'2023-07-21 23:03:55'),
(44,7,1,'2023-07-23 14:02:32'),
(45,1,1,'2023-07-23 14:02:36'),
(46,1,1,'2023-07-23 20:08:29'),
(47,7,1,'2023-07-24 09:18:10'),
(48,1,1,'2023-07-24 09:18:14'),
(49,7,1,'2023-07-24 09:59:44'),
(50,7,1,'2023-07-24 10:11:11'),
(51,7,1,'2023-07-24 10:11:39'),
(52,1,1,'2023-07-24 20:42:38'),
(53,7,1,'2023-07-25 20:34:33'),
(54,1,1,'2023-07-25 20:34:43'),
(55,7,1,'2023-07-25 22:24:01'),
(56,7,1,'2023-07-25 22:26:29'),
(57,1,1,'2023-07-25 22:26:38'),
(58,7,1,'2023-07-25 22:26:53'),
(59,1,1,'2023-07-25 22:27:37'),
(60,1,1,'2023-07-25 22:40:21'),
(61,7,1,'2023-07-25 22:41:14'),
(62,1,1,'2023-07-25 22:43:42'),
(63,7,1,'2023-07-29 10:41:28'),
(64,1,1,'2023-07-29 10:41:34'),
(65,7,1,'2023-07-29 10:43:43'),
(66,1,1,'2023-07-29 10:44:56'),
(67,7,1,'2023-07-29 10:45:14'),
(68,1,1,'2023-07-29 10:58:04'),
(69,7,1,'2023-07-29 10:59:36'),
(70,1,1,'2023-07-29 11:00:49'),
(71,7,1,'2023-07-29 11:02:45'),
(72,1,1,'2023-07-29 12:06:06'),
(73,1,1,'2023-07-29 12:09:33'),
(74,7,1,'2023-08-02 12:43:46'),
(75,7,1,'2023-08-02 12:43:57'),
(76,1,1,'2023-08-02 12:44:08');

/*Table structure for table `user_login_activity_ref` */

DROP TABLE IF EXISTS `user_login_activity_ref`;

CREATE TABLE `user_login_activity_ref` (
  `id_activity` tinyint(4) unsigned NOT NULL AUTO_INCREMENT,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id_activity`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `user_login_activity_ref` */

/*Table structure for table `user_role` */

DROP TABLE IF EXISTS `user_role`;

CREATE TABLE `user_role` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `id_user` int(10) unsigned NOT NULL,
  `id_role` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `module_role_module` (`id_user`),
  KEY `module_role_role` (`id_role`),
  CONSTRAINT `user_role_user` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT COMMENT='Tabel yang berisi role yang dimili oleh masing masing user';

/*Data for the table `user_role` */

insert  into `user_role`(`id`,`id_user`,`id_role`) values 
(1,1,1),
(5,3,2),
(7,5,2),
(12,7,12);

/*Table structure for table `user_token` */

DROP TABLE IF EXISTS `user_token`;

CREATE TABLE `user_token` (
  `selector` varchar(255) CHARACTER SET latin1 NOT NULL,
  `token` varchar(255) CHARACTER SET latin1 NOT NULL,
  `action` enum('register','remember','recovery','activation') CHARACTER SET latin1 NOT NULL,
  `id_user` int(10) unsigned NOT NULL,
  `created` datetime NOT NULL,
  `expires` datetime NOT NULL,
  PRIMARY KEY (`selector`),
  KEY `user_token_user` (`id_user`),
  CONSTRAINT `user_token_user` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `user_token` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
