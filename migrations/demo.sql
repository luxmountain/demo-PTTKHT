-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 21, 2025 at 11:44 AM
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
-- Table structure for table `tbladmin`
--

CREATE TABLE `tbladmin` (
  `tblMemberid` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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

-- --------------------------------------------------------

--
-- Table structure for table `tblstatteaminseason`
--

CREATE TABLE `tblstatteaminseason` (
  `totalpoints` int DEFAULT NULL,
  `tblTeamid` int DEFAULT NULL,
  `tblSeasonid` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblstatteaminstage`
--

CREATE TABLE `tblstatteaminstage` (
  `totalpoints` int DEFAULT NULL,
  `tblTeamid` int DEFAULT NULL,
  `tblStageid` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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

-- --------------------------------------------------------

--
-- Table structure for table `tbluser`
--

CREATE TABLE `tbluser` (
  `tblMemberid` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
  ADD KEY `tblTeamid` (`tblTeamid`),
  ADD KEY `tblSeasonid` (`tblSeasonid`);

--
-- Indexes for table `tblstatteaminstage`
--
ALTER TABLE `tblstatteaminstage`
  ADD KEY `tblTeamid` (`tblTeamid`),
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
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblmember`
--
ALTER TABLE `tblmember`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblracer`
--
ALTER TABLE `tblracer`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblregister`
--
ALTER TABLE `tblregister`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblseason`
--
ALTER TABLE `tblseason`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblstage`
--
ALTER TABLE `tblstage`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblteam`
--
ALTER TABLE `tblteam`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

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
