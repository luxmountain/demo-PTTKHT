-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 27, 2025 at 07:26 AM
-- Server version: 8.0.42
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `demo`
--

-- --------------------------------------------------------

--
-- Table structure for table `backup_tblstatteaminseason`
--

CREATE TABLE `backup_tblstatteaminseason` (
  `totalpoints` int DEFAULT NULL,
  `tblTeamid` int DEFAULT NULL,
  `tblSeasonid` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `backup_tblstatteaminseason`
--

INSERT INTO `backup_tblstatteaminseason` (`totalpoints`, `tblTeamid`, `tblSeasonid`) VALUES
(201, 2, 2),
(202, 3, 3),
(203, 4, 4),
(204, 5, 5),
(205, 6, 1),
(206, 7, 2),
(207, 8, 3),
(208, 9, 4),
(209, 10, 5),
(210, 1, 1),
(211, 2, 2),
(212, 3, 3),
(213, 4, 4),
(214, 5, 5),
(215, 6, 1),
(216, 7, 2),
(217, 8, 3),
(218, 9, 4),
(219, 10, 5),
(220, 1, 1),
(221, 2, 2),
(222, 3, 3),
(223, 4, 4),
(224, 5, 5),
(225, 6, 1),
(226, 7, 2),
(227, 8, 3),
(228, 9, 4),
(229, 10, 5),
(230, 1, 1),
(231, 2, 2),
(232, 3, 3),
(233, 4, 4),
(234, 5, 5),
(235, 6, 1),
(236, 7, 2),
(237, 8, 3),
(238, 9, 4),
(239, 10, 5),
(240, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `backup_tblstatteaminstage`
--

CREATE TABLE `backup_tblstatteaminstage` (
  `totalpoints` int DEFAULT NULL,
  `tblTeamid` int DEFAULT NULL,
  `tblStageid` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `backup_tblstatteaminstage`
--

INSERT INTO `backup_tblstatteaminstage` (`totalpoints`, `tblTeamid`, `tblStageid`) VALUES
(101, 2, 2),
(102, 3, 3),
(103, 4, 4),
(104, 5, 5),
(105, 6, 6),
(106, 7, 7),
(107, 8, 8),
(108, 9, 9),
(109, 10, 10),
(110, 1, 11),
(111, 2, 12),
(112, 3, 13),
(113, 4, 14),
(114, 5, 15),
(115, 6, 16),
(116, 7, 17),
(117, 8, 18),
(118, 9, 19),
(119, 10, 20),
(120, 1, 21),
(121, 2, 22),
(122, 3, 23),
(123, 4, 24),
(124, 5, 25),
(125, 6, 26),
(126, 7, 27),
(127, 8, 28),
(128, 9, 29),
(129, 10, 30),
(130, 1, 1),
(131, 2, 2),
(132, 3, 3),
(133, 4, 4),
(134, 5, 5),
(135, 6, 6),
(136, 7, 7),
(137, 8, 8),
(138, 9, 9),
(139, 10, 10),
(140, 1, 11);

-- --------------------------------------------------------

--
-- Table structure for table `tbladmin`
--

CREATE TABLE `tbladmin` (
  `tblMemberid` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tbladmin`
--

INSERT INTO `tbladmin` (`tblMemberid`) VALUES
(21),
(22),
(23),
(24),
(25),
(26),
(27),
(28),
(29),
(30);

-- --------------------------------------------------------

--
-- Table structure for table `tblcontract`
--

CREATE TABLE `tblcontract` (
  `id` int NOT NULL,
  `salary` float DEFAULT NULL,
  `startdate` date DEFAULT NULL,
  `enddate` date DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `tblRacerid` int DEFAULT NULL,
  `tblTeamid` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tblcontract`
--

INSERT INTO `tblcontract` (`id`, `salary`, `startdate`, `enddate`, `status`, `tblRacerid`, `tblTeamid`) VALUES
(1, 4010, '2023-01-02', '2023-12-31', 1, 2, 3),
(2, 4020, '2023-01-03', '2023-12-31', 1, 3, 3),
(3, 4030, '2023-01-04', '2023-12-31', 1, 4, 4),
(4, 4040, '2023-01-05', '2023-12-31', 1, 5, 5),
(5, 4050, '2023-01-06', '2023-12-31', 1, 6, 6),
(6, 4060, '2023-01-07', '2023-12-31', 1, 7, 7),
(7, 4070, '2023-01-08', '2023-12-31', 1, 8, 8),
(8, 4080, '2023-01-09', '2023-12-31', 1, 9, 9),
(9, 4090, '2023-01-10', '2023-12-31', 1, 10, 10),
(10, 4100, '2023-01-11', '2023-12-31', 1, 11, 1),
(11, 4110, '2023-01-12', '2023-12-31', 1, 12, 2),
(12, 4120, '2023-01-13', '2023-12-31', 1, 13, 3),
(13, 4130, '2023-01-14', '2023-12-31', 1, 14, 4),
(14, 4140, '2023-01-15', '2023-12-31', 1, 15, 5),
(15, 4150, '2023-01-16', '2023-12-31', 1, 16, 6),
(16, 4160, '2023-01-17', '2023-12-31', 1, 17, 7),
(17, 4170, '2023-01-18', '2023-12-31', 1, 18, 8),
(18, 4180, '2023-01-19', '2023-12-31', 1, 19, 9),
(19, 4190, '2023-01-20', '2023-12-31', 1, 20, 10),
(20, 4200, '2023-01-21', '2023-12-31', 1, 21, 1),
(21, 4210, '2023-01-22', '2023-12-31', 1, 22, 1),
(22, 4220, '2023-01-23', '2023-12-31', 1, 23, 3),
(23, 4230, '2023-01-24', '2023-12-31', 1, 24, 4),
(24, 4240, '2023-01-25', '2023-12-31', 1, 25, 5),
(25, 4250, '2023-01-26', '2023-12-31', 1, 26, 6),
(26, 4260, '2023-01-27', '2023-12-31', 1, 27, 7),
(27, 4270, '2023-01-28', '2023-12-31', 1, 28, 8),
(28, 4280, '2023-01-01', '2023-12-31', 1, 29, 9),
(29, 4290, '2023-01-02', '2023-12-31', 1, 30, 10),
(30, 4300, '2023-01-03', '2023-12-31', 1, 1, 1),
(31, 4310, '2023-01-04', '2023-12-31', 1, 2, 4),
(32, 4320, '2023-01-05', '2023-12-31', 1, 3, 3),
(33, 4330, '2023-01-06', '2023-12-31', 1, 4, 4),
(34, 4340, '2023-01-07', '2023-12-31', 1, 5, 5),
(35, 4350, '2023-01-08', '2023-12-31', 1, 6, 6),
(36, 4360, '2023-01-09', '2023-12-31', 1, 7, 7),
(37, 4370, '2023-01-10', '2023-12-31', 1, 8, 8),
(38, 4380, '2023-01-11', '2023-12-31', 1, 9, 9),
(39, 4390, '2023-01-12', '2023-12-31', 1, 10, 10),
(40, 4400, '2023-01-13', '2023-12-31', 1, 11, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tblmember`
--

CREATE TABLE `tblmember` (
  `id` int NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phonenumber` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tblmember`
--

INSERT INTO `tblmember` (`id`, `username`, `name`, `password`, `dob`, `address`, `email`, `phonenumber`) VALUES
(1, 'user1', 'Member 1', '123', '1990-01-02', 'City 1', 'user1@mail.com', '0900000001'),
(2, 'user2', 'Member 2', '123', '1990-01-03', 'City 2', 'user2@mail.com', '0900000002'),
(3, 'user3', 'Member 3', '123', '1990-01-04', 'City 3', 'user3@mail.com', '0900000003'),
(4, 'user4', 'Member 4', '123', '1990-01-05', 'City 4', 'user4@mail.com', '0900000004'),
(5, 'user5', 'Member 5', '123', '1990-01-06', 'City 5', 'user5@mail.com', '0900000005'),
(6, 'user6', 'Member 6', '123', '1990-01-07', 'City 6', 'user6@mail.com', '0900000006'),
(7, 'user7', 'Member 7', '123', '1990-01-08', 'City 7', 'user7@mail.com', '0900000007'),
(8, 'user8', 'Member 8', '123', '1990-01-09', 'City 8', 'user8@mail.com', '0900000008'),
(9, 'user9', 'Member 9', '123', '1990-01-10', 'City 9', 'user9@mail.com', '0900000009'),
(10, 'user10', 'Member 10', '123', '1990-01-11', 'City 10', 'user10@mail.com', '0900000010'),
(11, 'user11', 'Member 11', '123', '1990-01-12', 'City 11', 'user11@mail.com', '0900000011'),
(12, 'user12', 'Member 12', '123', '1990-01-13', 'City 12', 'user12@mail.com', '0900000012'),
(13, 'user13', 'Member 13', '123', '1990-01-14', 'City 13', 'user13@mail.com', '0900000013'),
(14, 'user14', 'Member 14', '123', '1990-01-15', 'City 14', 'user14@mail.com', '0900000014'),
(15, 'user15', 'Member 15', '123', '1990-01-16', 'City 15', 'user15@mail.com', '0900000015'),
(16, 'user16', 'Member 16', '123', '1990-01-17', 'City 16', 'user16@mail.com', '0900000016'),
(17, 'user17', 'Member 17', '123', '1990-01-18', 'City 17', 'user17@mail.com', '0900000017'),
(18, 'user18', 'Member 18', '123', '1990-01-19', 'City 18', 'user18@mail.com', '0900000018'),
(19, 'user19', 'Member 19', '123', '1990-01-20', 'City 19', 'user19@mail.com', '0900000019'),
(20, 'user20', 'Member 20', '123', '1990-01-21', 'City 20', 'user20@mail.com', '0900000020'),
(21, 'user21', 'Member 21', '123', '1990-01-22', 'City 21', 'user21@mail.com', '0900000021'),
(22, 'user22', 'Member 22', '123', '1990-01-23', 'City 22', 'user22@mail.com', '0900000022'),
(23, 'user23', 'Member 23', '123', '1990-01-24', 'City 23', 'user23@mail.com', '0900000023'),
(24, 'user24', 'Member 24', '123', '1990-01-25', 'City 24', 'user24@mail.com', '0900000024'),
(25, 'user25', 'Member 25', '123', '1990-01-26', 'City 25', 'user25@mail.com', '0900000025'),
(26, 'user26', 'Member 26', '123', '1990-01-27', 'City 26', 'user26@mail.com', '0900000026'),
(27, 'user27', 'Member 27', '123', '1990-01-28', 'City 27', 'user27@mail.com', '0900000027'),
(28, 'user28', 'Member 28', '123', '1990-01-01', 'City 28', 'user28@mail.com', '0900000028'),
(29, 'user29', 'Member 29', '123', '1990-01-02', 'City 29', 'user29@mail.com', '0900000029'),
(30, 'user30', 'Member 30', '123', '1990-01-03', 'City 30', 'user30@mail.com', '0900000030'),
(31, 'user31', 'Member 31', '123', '1990-01-04', 'City 31', 'user31@mail.com', '0900000031'),
(32, 'user32', 'Member 32', '123', '1990-01-05', 'City 32', 'user32@mail.com', '0900000032'),
(33, 'user33', 'Member 33', '123', '1990-01-06', 'City 33', 'user33@mail.com', '0900000033'),
(34, 'user34', 'Member 34', '123', '1990-01-07', 'City 34', 'user34@mail.com', '0900000034'),
(35, 'user35', 'Member 35', '123', '1990-01-08', 'City 35', 'user35@mail.com', '0900000035'),
(36, 'user36', 'Member 36', '123', '1990-01-09', 'City 36', 'user36@mail.com', '0900000036'),
(37, 'user37', 'Member 37', '123', '1990-01-10', 'City 37', 'user37@mail.com', '0900000037'),
(38, 'user38', 'Member 38', '123', '1990-01-11', 'City 38', 'user38@mail.com', '0900000038'),
(39, 'user39', 'Member 39', '123', '1990-01-12', 'City 39', 'user39@mail.com', '0900000039'),
(40, 'user40', 'Member 40', '123', '1990-01-13', 'City 40', 'user40@mail.com', '0900000040'),
(41, 'user41', 'Member 41', '123', '1990-01-14', 'City 41', 'user41@mail.com', '0900000041'),
(42, 'user42', 'Member 42', '123', '1990-01-15', 'City 42', 'user42@mail.com', '0900000042'),
(43, 'user43', 'Member 43', '123', '1990-01-16', 'City 43', 'user43@mail.com', '0900000043'),
(44, 'user44', 'Member 44', '123', '1990-01-17', 'City 44', 'user44@mail.com', '0900000044'),
(45, 'user45', 'Member 45', '123', '1990-01-18', 'City 45', 'user45@mail.com', '0900000045'),
(46, 'user46', 'Member 46', '123', '1990-01-19', 'City 46', 'user46@mail.com', '0900000046'),
(47, 'user47', 'Member 47', '123', '1990-01-20', 'City 47', 'user47@mail.com', '0900000047'),
(48, 'user48', 'Member 48', '123', '1990-01-21', 'City 48', 'user48@mail.com', '0900000048'),
(49, 'user49', 'Member 49', '123', '1990-01-22', 'City 49', 'user49@mail.com', '0900000049'),
(50, 'user50', 'Member 50', '123', '1990-01-23', 'City 50', 'user50@mail.com', '0900000050'),
(51, 'user51', 'Member 51', '123', '1990-01-24', 'City 51', 'user51@mail.com', '0900000051'),
(52, 'user52', 'Member 52', '123', '1990-01-25', 'City 52', 'user52@mail.com', '0900000052'),
(53, 'user53', 'Member 53', '123', '1990-01-26', 'City 53', 'user53@mail.com', '0900000053'),
(54, 'user54', 'Member 54', '123', '1990-01-27', 'City 54', 'user54@mail.com', '0900000054'),
(55, 'user55', 'Member 55', '123', '1990-01-28', 'City 55', 'user55@mail.com', '0900000055'),
(56, 'user56', 'Member 56', '123', '1990-01-01', 'City 56', 'user56@mail.com', '0900000056'),
(57, 'user57', 'Member 57', '123', '1990-01-02', 'City 57', 'user57@mail.com', '0900000057'),
(58, 'user58', 'Member 58', '123', '1990-01-03', 'City 58', 'user58@mail.com', '0900000058'),
(59, 'user59', 'Member 59', '123', '1990-01-04', 'City 59', 'user59@mail.com', '0900000059'),
(60, 'user60', 'Member 60', '123', '1990-01-05', 'City 60', 'user60@mail.com', '0900000060');

-- --------------------------------------------------------

--
-- Table structure for table `tblracer`
--

CREATE TABLE `tblracer` (
  `id` int NOT NULL,
  `nationality` varchar(255) DEFAULT NULL,
  `shirtnumber` tinyint DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `tblMemberid` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tblracer`
--

INSERT INTO `tblracer` (`id`, `nationality`, `shirtnumber`, `status`, `tblMemberid`) VALUES
(1, 'USA', 2, 1, 1),
(2, 'France', 3, 1, 2),
(3, 'Korea', 4, 1, 3),
(4, 'Japan', 5, 1, 4),
(5, 'Italy', 6, 1, 5),
(6, 'Spain', 7, 1, 6),
(7, 'Germany', 8, 1, 7),
(8, 'UK', 9, 1, 8),
(9, 'Canada', 10, 1, 9),
(10, 'Vietnam', 11, 1, 10),
(11, 'USA', 12, 1, 11),
(12, 'France', 13, 1, 12),
(13, 'Korea', 14, 1, 13),
(14, 'Japan', 15, 1, 14),
(15, 'Italy', 16, 1, 15),
(16, 'Spain', 17, 1, 16),
(17, 'Germany', 18, 1, 17),
(18, 'UK', 19, 1, 18),
(19, 'Canada', 20, 1, 19),
(20, 'Vietnam', 21, 1, 20),
(21, 'USA', 22, 1, 21),
(22, 'France', 23, 1, 22),
(23, 'Korea', 24, 1, 23),
(24, 'Japan', 25, 1, 24),
(25, 'Italy', 26, 1, 25),
(26, 'Spain', 27, 1, 26),
(27, 'Germany', 28, 1, 27),
(28, 'UK', 29, 1, 28),
(29, 'Canada', 30, 1, 29),
(30, 'Vietnam', 31, 1, 30);

-- --------------------------------------------------------

--
-- Table structure for table `tblregister`
--

CREATE TABLE `tblregister` (
  `id` int NOT NULL,
  `dateregistered` date DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `laps_completed` smallint UNSIGNED DEFAULT NULL,
  `timedone` time(6) DEFAULT NULL,
  `tblContractid` int DEFAULT NULL,
  `tblStageid` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tblregister`
--

INSERT INTO `tblregister` (`id`, `dateregistered`, `status`, `laps_completed`, `timedone`, `tblContractid`, `tblStageid`) VALUES
(1, '2023-03-02', 1, 0, '01:01:01.000000', 2, 2),
(2, '2023-03-03', 1, 0, '01:02:02.000000', 3, 3),
(3, '2023-03-04', 1, 0, '01:03:03.000000', 4, 4),
(4, '2023-03-05', 1, 0, '01:04:04.000000', 5, 5),
(5, '2023-03-06', 1, 0, '01:05:05.000000', 6, 6),
(6, '2023-03-07', 1, 0, '01:06:06.000000', 7, 7),
(7, '2023-03-08', 1, 0, '01:07:07.000000', 8, 8),
(8, '2023-03-09', 1, 0, '01:08:08.000000', 9, 9),
(9, '2023-03-10', 1, 0, '01:09:09.000000', 10, 10),
(10, '2023-03-11', 1, 10, '01:10:10.000000', 11, 11),
(11, '2023-03-12', 1, 0, '01:11:11.000000', 12, 12),
(12, '2023-03-13', 1, 0, '01:12:12.000000', 13, 13),
(13, '2023-03-14', 1, 0, '01:13:13.000000', 14, 14),
(14, '2023-03-15', 1, 0, '01:14:14.000000', 15, 15),
(15, '2023-03-16', 1, 0, '01:15:15.000000', 16, 16),
(16, '2023-03-17', 1, 0, '01:16:16.000000', 17, 17),
(17, '2023-03-18', 1, 0, '01:17:17.000000', 18, 18),
(18, '2023-03-19', 1, 0, '01:18:18.000000', 19, 19),
(19, '2023-03-20', 1, 0, '01:19:19.000000', 20, 20),
(20, '2023-03-21', 1, 0, '01:20:20.000000', 21, 21),
(21, '2023-03-22', 1, 0, '01:21:21.000000', 22, 22),
(22, '2023-03-23', 1, 0, '01:22:22.000000', 23, 23),
(23, '2023-03-24', 1, 0, '01:23:23.000000', 24, 24),
(24, '2023-03-25', 1, 10, '01:24:24.000000', 25, 25),
(25, '2023-03-26', 1, 0, '01:25:25.000000', 26, 26),
(26, '2023-03-27', 1, 0, '01:26:26.000000', 27, 27),
(27, '2023-03-28', 1, 0, '01:27:27.000000', 28, 28),
(28, '2023-03-01', 1, 0, '01:28:28.000000', 29, 29),
(29, '2023-03-02', 1, 0, '01:29:29.000000', 30, 30),
(30, '2023-03-03', 1, 0, '01:30:30.000000', 31, 1),
(31, '2023-03-04', 1, 0, '01:31:31.000000', 32, 2),
(32, '2023-03-05', 1, 0, '01:32:32.000000', 33, 3),
(33, '2023-03-06', 1, 0, '01:33:33.000000', 34, 4),
(34, '2023-03-07', 1, 0, '01:34:34.000000', 35, 5),
(35, '2023-03-08', 1, 0, '01:35:35.000000', 36, 6),
(36, '2023-03-09', 1, 0, '01:36:36.000000', 37, 7),
(37, '2023-03-10', 1, 0, '01:37:37.000000', 38, 8),
(38, '2023-03-11', 1, 0, '01:38:38.000000', 39, 9),
(39, '2023-03-12', 1, 0, '01:39:39.000000', 40, 10),
(40, '2023-03-13', 1, 10, '01:40:40.000000', 1, 11),
(41, '2023-03-14', 1, 0, '01:41:41.000000', 2, 12),
(42, '2023-03-15', 1, 0, '01:42:42.000000', 3, 13),
(43, '2023-03-16', 1, 0, '01:43:43.000000', 4, 14),
(44, '2023-03-17', 1, 0, '01:44:44.000000', 5, 15),
(45, '2023-03-18', 1, 0, '01:45:45.000000', 6, 16),
(46, '2023-03-19', 1, 0, '01:46:46.000000', 7, 17),
(47, '2023-03-20', 1, 0, '01:47:47.000000', 8, 18),
(48, '2023-03-21', 1, 0, '01:48:48.000000', 9, 19),
(49, '2023-03-22', 1, 0, '01:49:49.000000', 10, 20),
(50, '2023-03-23', 1, 0, '01:50:50.000000', 11, 21),
(51, '2023-03-24', 1, 0, '01:51:51.000000', 12, 22),
(52, '2023-03-25', 1, 0, '01:52:52.000000', 13, 23),
(53, '2023-03-26', 1, 0, '01:53:53.000000', 14, 24),
(54, '2023-03-27', 1, 8, '01:54:54.000000', 15, 25),
(55, '2023-03-28', 1, 0, '01:55:55.000000', 16, 26),
(56, '2023-03-01', 1, 0, '01:56:56.000000', 17, 27),
(57, '2023-03-02', 1, 0, '01:57:57.000000', 18, 28),
(58, '2023-03-03', 1, 0, '01:58:58.000000', 19, 29),
(59, '2023-03-04', 1, 0, '01:00:00.000000', 20, 30),
(60, '2023-03-05', 1, 0, '01:01:01.000000', 21, 1),
(61, '2023-03-06', 1, 0, '01:02:02.000000', 22, 2),
(62, '2023-03-07', 1, 0, '01:03:03.000000', 23, 3),
(63, '2023-03-08', 1, 0, '01:04:04.000000', 24, 4),
(64, '2023-03-09', 1, 0, '01:05:05.000000', 25, 5),
(65, '2023-03-10', 1, 0, '01:06:06.000000', 26, 6),
(66, '2023-03-11', 1, 0, '01:07:07.000000', 27, 7),
(67, '2023-03-12', 1, 0, '01:08:08.000000', 28, 8),
(68, '2023-03-13', 1, 0, '01:09:09.000000', 29, 9),
(69, '2023-03-14', 1, 0, '01:10:10.000000', 30, 10),
(70, '2023-03-15', 1, 10, '01:11:11.000000', 31, 11),
(71, '2023-03-16', 1, 0, '01:12:12.000000', 32, 12),
(72, '2023-03-17', 1, 0, '01:13:13.000000', 33, 13),
(73, '2023-03-18', 1, 0, '01:14:14.000000', 34, 14),
(74, '2023-03-19', 1, 0, '01:15:15.000000', 35, 15),
(75, '2023-03-20', 1, 0, '01:16:16.000000', 36, 16),
(76, '2023-03-21', 1, 0, '01:17:17.000000', 37, 17),
(77, '2023-03-22', 1, 0, '01:18:18.000000', 38, 18),
(78, '2023-03-23', 1, 0, '01:19:19.000000', 39, 19),
(79, '2023-03-24', 1, 0, '01:20:20.000000', 40, 20),
(80, '2023-03-25', 1, 0, '01:21:21.000000', 1, 21),
(81, '2023-03-26', 1, 0, '01:22:22.000000', 2, 22),
(82, '2023-03-27', 1, 0, '01:23:23.000000', 3, 23),
(83, '2023-03-28', 1, 0, '01:24:24.000000', 4, 24),
(84, '2023-03-01', 1, 10, '01:25:25.000000', 5, 25),
(85, '2023-03-02', 1, 0, '01:26:26.000000', 6, 26),
(86, '2023-03-03', 1, 0, '01:27:27.000000', 7, 27),
(87, '2023-03-04', 1, 0, '01:28:28.000000', 8, 28),
(88, '2023-03-05', 1, 0, '01:29:29.000000', 9, 29),
(89, '2023-03-06', 1, 0, '01:30:30.000000', 10, 30),
(90, '2023-03-07', 1, 0, '01:31:31.000000', 11, 1),
(91, '2023-03-08', 1, 0, '01:32:32.000000', 12, 2),
(92, '2023-03-09', 1, 0, '01:33:33.000000', 13, 3),
(93, '2023-03-10', 1, 0, '01:34:34.000000', 14, 4),
(94, '2023-03-11', 1, 0, '01:35:35.000000', 15, 5),
(95, '2023-03-12', 1, 0, '01:36:36.000000', 16, 6),
(96, '2023-03-13', 1, 0, '01:37:37.000000', 17, 7),
(97, '2023-03-14', 1, 0, '01:38:38.000000', 18, 8),
(98, '2023-03-15', 1, 0, '01:39:39.000000', 19, 9),
(99, '2023-03-16', 1, 0, '01:40:40.000000', 20, 10),
(100, '2023-03-17', 1, 1, '01:41:41.000000', 21, 11),
(101, '2023-03-18', 1, 0, '01:42:42.000000', 22, 12),
(102, '2023-03-19', 1, 0, '01:43:43.000000', 23, 13),
(103, '2023-03-20', 1, 0, '01:44:44.000000', 24, 14),
(104, '2023-03-21', 1, 0, '01:45:45.000000', 25, 15),
(105, '2023-03-22', 1, 0, '01:46:46.000000', 26, 16),
(106, '2023-03-23', 1, 0, '01:47:47.000000', 27, 17),
(107, '2023-03-24', 1, 0, '01:48:48.000000', 28, 18),
(108, '2023-03-25', 1, 0, '01:49:49.000000', 29, 19),
(109, '2023-03-26', 1, 0, '01:50:50.000000', 30, 20),
(110, '2023-03-27', 1, 0, '01:51:51.000000', 31, 21),
(111, '2023-03-28', 1, 0, '01:52:52.000000', 32, 22),
(112, '2023-03-01', 1, 0, '01:53:53.000000', 33, 23),
(113, '2023-03-02', 1, 0, '01:54:54.000000', 34, 24),
(114, '2023-03-03', 1, 9, '01:55:55.000000', 35, 25),
(115, '2023-03-04', 1, 0, '01:56:56.000000', 36, 26),
(116, '2023-03-05', 1, 0, '01:57:57.000000', 37, 27),
(117, '2023-03-06', 1, 0, '01:58:58.000000', 38, 28),
(118, '2023-03-07', 1, 0, '01:00:00.000000', 39, 29),
(119, '2023-03-08', 1, 0, '01:01:01.000000', 40, 30),
(120, '2023-03-09', 1, 0, '01:02:02.000000', 1, 1),
(121, '2023-02-03', 1, 9, '16:07:05.000000', 40, 31),
(122, '2023-02-03', 1, 10, '13:06:53.000000', 39, 31);

-- --------------------------------------------------------

--
-- Table structure for table `tblseason`
--

CREATE TABLE `tblseason` (
  `id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `totalpoints` int DEFAULT NULL,
  `startdate` date DEFAULT NULL,
  `enddate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tblseason`
--

INSERT INTO `tblseason` (`id`, `name`, `year`, `totalpoints`, `startdate`, `enddate`) VALUES
(1, 'Season 2020', 2020, 500, '2020-01-01', '2020-12-31'),
(2, 'Season 2021', 2021, 520, '2021-01-01', '2021-12-31'),
(3, 'Season 2022', 2022, 540, '2022-01-01', '2022-12-31'),
(4, 'Season 2023', 2023, 560, '2023-01-01', '2023-12-31'),
(5, 'Hoa Sen', 2024, 580, '2024-01-01', '2024-12-31');

-- --------------------------------------------------------

--
-- Table structure for table `tblstage`
--

CREATE TABLE `tblstage` (
  `id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `roadmap` varchar(255) DEFAULT NULL,
  `total_laps` smallint UNSIGNED NOT NULL DEFAULT '0',
  `status` tinyint(1) DEFAULT NULL,
  `tblSeasonid` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tblstage`
--

INSERT INTO `tblstage` (`id`, `name`, `date`, `location`, `description`, `roadmap`, `total_laps`, `status`, `tblSeasonid`) VALUES
(1, 'Stage 1', '2023-02-02', 'Danang', 'Desc 1', 'Road 1', 10, 1, 2),
(2, 'Stage 2', '2023-02-03', 'Saigon', 'Desc 2', 'Road 2', 10, 1, 3),
(3, 'Stage 3', '2023-02-04', 'Hue', 'Desc 3', 'Road 3', 10, 1, 4),
(4, 'Stage 4', '2023-02-05', 'Nha Trang', 'Desc 4', 'Road 4', 10, 1, 5),
(5, 'Stage 5', '2023-02-06', 'Hai Phong', 'Desc 5', 'Road 5', 10, 1, 1),
(6, 'Stage 6', '2023-02-07', 'London', 'Desc 6', 'Road 6', 10, 1, 2),
(7, 'Stage 7', '2023-02-08', 'Paris', 'Desc 7', 'Road 7', 10, 1, 3),
(8, 'Stage 8', '2023-02-09', 'Tokyo', 'Desc 8', 'Road 8', 10, 1, 4),
(9, 'Stage 9', '2023-02-10', 'LA', 'Desc 9', 'Road 9', 10, 1, 5),
(10, 'Stage 10', '2023-02-11', 'Hanoi', 'Desc 10', 'Road 10', 10, 1, 1),
(11, 'Stage 11', '2023-02-12', 'Danang', 'Desc 11', 'Road 11', 10, 1, 2),
(12, 'Stage 12', '2023-02-13', 'Saigon', 'Desc 12', 'Road 12', 10, 1, 3),
(13, 'Stage 13', '2023-02-14', 'Hue', 'Desc 13', 'Road 13', 10, 1, 4),
(14, 'Stage 14', '2023-02-15', 'Nha Trang', 'Desc 14', 'Road 14', 10, 1, 5),
(15, 'Stage 15', '2023-02-16', 'Hai Phong', 'Desc 15', 'Road 15', 10, 1, 1),
(16, 'Stage 16', '2023-02-17', 'London', 'Desc 16', 'Road 16', 10, 1, 2),
(17, 'Stage 17', '2023-02-18', 'Paris', 'Desc 17', 'Road 17', 10, 1, 3),
(18, 'Stage 18', '2023-02-19', 'Tokyo', 'Desc 18', 'Road 18', 10, 1, 4),
(19, 'Stage 19', '2023-02-20', 'LA', 'Desc 19', 'Road 19', 10, 1, 5),
(20, 'Stage 20', '2023-02-21', 'Hanoi', 'Desc 20', 'Road 20', 10, 1, 1),
(21, 'Stage 21', '2023-02-22', 'Danang', 'Desc 21', 'Road 21', 10, 1, 2),
(22, 'Stage 22', '2023-02-23', 'Saigon', 'Desc 22', 'Road 22', 10, 1, 3),
(23, 'Stage 23', '2023-02-24', 'Hue', 'Desc 23', 'Road 23', 10, 1, 4),
(24, 'Stage 24', '2023-02-25', 'Nha Trang', 'Desc 24', 'Road 24', 10, 1, 5),
(25, 'Stage 25', '2023-02-26', 'Hai Phong', 'Desc 25', 'Road 25', 10, 1, 1),
(26, 'Stage 26', '2023-02-27', 'London', 'Desc 26', 'Road 26', 10, 1, 2),
(27, 'Stage 27', '2023-02-28', 'Paris', 'Desc 27', 'Road 27', 10, 1, 3),
(28, 'Stage 28', '2023-02-01', 'Tokyo', 'Desc 28', 'Road 28', 10, 1, 4),
(29, 'Stage 29', '2023-02-02', 'LA', 'Desc 29', 'Road 29', 10, 1, 5),
(30, 'Stage 30', '2023-02-03', 'Hanoi', 'Desc 30', 'Road 30', 10, 1, 1),
(31, 'Ha Noi Final', '2025-02-03', 'Ha Noi', 'Best Race In Vietnam', 'Ha Noi', 10, 1, 5);

-- --------------------------------------------------------

--
-- Table structure for table `tblstatteaminseason`
--

CREATE TABLE `tblstatteaminseason` (
  `totalpoints` int DEFAULT NULL,
  `tblTeamid` int DEFAULT NULL,
  `tblSeasonid` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tblstatteaminseason`
--

INSERT INTO `tblstatteaminseason` (`totalpoints`, `tblTeamid`, `tblSeasonid`) VALUES
(150, 1, 1),
(145, 1, 2),
(160, 2, 2),
(155, 2, 3),
(140, 3, 3),
(165, 3, 4),
(170, 4, 4),
(175, 4, 5),
(135, 5, 5),
(180, 5, 1),
(125, 6, 1),
(185, 6, 2),
(190, 7, 2),
(195, 7, 3),
(200, 8, 3),
(205, 8, 4),
(210, 9, 4),
(215, 9, 5),
(220, 10, 5),
(225, 10, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tblstatteaminstage`
--

CREATE TABLE `tblstatteaminstage` (
  `totalpoints` int DEFAULT NULL,
  `tblTeamid` int DEFAULT NULL,
  `tblStageid` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tblstatteaminstage`
--

INSERT INTO `tblstatteaminstage` (`totalpoints`, `tblTeamid`, `tblStageid`) VALUES
(25, 1, 1),
(30, 2, 2),
(28, 3, 3),
(32, 4, 4),
(27, 5, 5),
(35, 6, 6),
(29, 7, 7),
(31, 8, 8),
(26, 9, 9),
(33, 10, 10),
(24, 1, 11),
(36, 2, 12),
(34, 3, 13),
(30, 4, 14),
(28, 5, 15),
(32, 6, 16),
(29, 7, 17),
(31, 8, 18),
(27, 9, 19),
(35, 10, 20),
(33, 1, 21),
(26, 2, 22),
(30, 3, 23),
(34, 4, 24),
(28, 5, 25),
(32, 6, 26),
(29, 7, 27),
(31, 8, 28),
(27, 9, 29),
(35, 10, 30),
(40, 1, 31);

-- --------------------------------------------------------

--
-- Table structure for table `tblteam`
--

CREATE TABLE `tblteam` (
  `id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `nation` varchar(255) DEFAULT NULL,
  `totalpoints` int DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tblteam`
--

INSERT INTO `tblteam` (`id`, `name`, `description`, `nation`, `totalpoints`, `status`) VALUES
(1, 'Team 1', 'Description 1', 'USA', 101, 1),
(2, 'Team 2', 'Description 2', 'France', 102, 1),
(3, 'Team 3', 'Description 3', 'Korea', 103, 1),
(4, 'Team 4', 'Description 4', 'Japan', 104, 1),
(5, 'Team 5', 'Description 5', 'Italy', 105, 1),
(6, 'Team 6', 'Description 6', 'Spain', 106, 1),
(7, 'Team 7', 'Description 7', 'Germany', 107, 1),
(8, 'Team 8', 'Description 8', 'UK', 108, 1),
(9, 'Team 9', 'Description 9', 'Canada', 109, 1),
(10, 'Team 10', 'Description 10', 'Vietnam', 110, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbluser`
--

CREATE TABLE `tbluser` (
  `tblMemberid` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tbluser`
--

INSERT INTO `tbluser` (`tblMemberid`) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12),
(13),
(14),
(15),
(16),
(17),
(18),
(19),
(20);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbladmin`
--
ALTER TABLE `tbladmin`
  ADD PRIMARY KEY (`tblMemberid`);

--
-- Indexes for table `tblcontract`
--
ALTER TABLE `tblcontract`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tblRacerid` (`tblRacerid`),
  ADD KEY `tblTeamid` (`tblTeamid`);

--
-- Indexes for table `tblmember`
--
ALTER TABLE `tblmember`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `tblracer`
--
ALTER TABLE `tblracer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tblMemberid` (`tblMemberid`);

--
-- Indexes for table `tblregister`
--
ALTER TABLE `tblregister`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tblContractid` (`tblContractid`),
  ADD KEY `tblStageid` (`tblStageid`);

--
-- Indexes for table `tblseason`
--
ALTER TABLE `tblseason`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblstage`
--
ALTER TABLE `tblstage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tblSeasonid` (`tblSeasonid`);

--
-- Indexes for table `tblstatteaminseason`
--
ALTER TABLE `tblstatteaminseason`
  ADD UNIQUE KEY `uq_stat_team_season` (`tblTeamid`,`tblSeasonid`),
  ADD KEY `tblSeasonid` (`tblSeasonid`);

--
-- Indexes for table `tblstatteaminstage`
--
ALTER TABLE `tblstatteaminstage`
  ADD UNIQUE KEY `uq_stat_team_stage` (`tblTeamid`,`tblStageid`),
  ADD KEY `tblStageid` (`tblStageid`);

--
-- Indexes for table `tblteam`
--
ALTER TABLE `tblteam`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbluser`
--
ALTER TABLE `tbluser`
  ADD PRIMARY KEY (`tblMemberid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tblcontract`
--
ALTER TABLE `tblcontract`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `tblmember`
--
ALTER TABLE `tblmember`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `tblracer`
--
ALTER TABLE `tblracer`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `tblregister`
--
ALTER TABLE `tblregister`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=123;

--
-- AUTO_INCREMENT for table `tblseason`
--
ALTER TABLE `tblseason`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tblstage`
--
ALTER TABLE `tblstage`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `tblteam`
--
ALTER TABLE `tblteam`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tbladmin`
--
ALTER TABLE `tbladmin`
  ADD CONSTRAINT `tbladmin_ibfk_1` FOREIGN KEY (`tblMemberid`) REFERENCES `tblmember` (`id`);

--
-- Constraints for table `tblcontract`
--
ALTER TABLE `tblcontract`
  ADD CONSTRAINT `tblcontract_ibfk_1` FOREIGN KEY (`tblRacerid`) REFERENCES `tblracer` (`id`),
  ADD CONSTRAINT `tblcontract_ibfk_2` FOREIGN KEY (`tblTeamid`) REFERENCES `tblteam` (`id`);

--
-- Constraints for table `tblracer`
--
ALTER TABLE `tblracer`
  ADD CONSTRAINT `tblracer_ibfk_1` FOREIGN KEY (`tblMemberid`) REFERENCES `tblmember` (`id`);

--
-- Constraints for table `tblregister`
--
ALTER TABLE `tblregister`
  ADD CONSTRAINT `tblregister_ibfk_1` FOREIGN KEY (`tblContractid`) REFERENCES `tblcontract` (`id`),
  ADD CONSTRAINT `tblregister_ibfk_2` FOREIGN KEY (`tblStageid`) REFERENCES `tblstage` (`id`);

--
-- Constraints for table `tblstage`
--
ALTER TABLE `tblstage`
  ADD CONSTRAINT `tblstage_ibfk_1` FOREIGN KEY (`tblSeasonid`) REFERENCES `tblseason` (`id`);

--
-- Constraints for table `tblstatteaminseason`
--
ALTER TABLE `tblstatteaminseason`
  ADD CONSTRAINT `tblstatteaminseason_ibfk_1` FOREIGN KEY (`tblTeamid`) REFERENCES `tblteam` (`id`),
  ADD CONSTRAINT `tblstatteaminseason_ibfk_2` FOREIGN KEY (`tblSeasonid`) REFERENCES `tblseason` (`id`);

--
-- Constraints for table `tblstatteaminstage`
--
ALTER TABLE `tblstatteaminstage`
  ADD CONSTRAINT `tblstatteaminstage_ibfk_1` FOREIGN KEY (`tblTeamid`) REFERENCES `tblteam` (`id`),
  ADD CONSTRAINT `tblstatteaminstage_ibfk_2` FOREIGN KEY (`tblStageid`) REFERENCES `tblstage` (`id`);

--
-- Constraints for table `tbluser`
--
ALTER TABLE `tbluser`
  ADD CONSTRAINT `tbluser_ibfk_1` FOREIGN KEY (`tblMemberid`) REFERENCES `tblmember` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
