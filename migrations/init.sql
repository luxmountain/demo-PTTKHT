SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;


CREATE TABLE `tbladmin` (
  `tblMemberid` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tblcontract` (
  `id` int NOT NULL,
  `salary` float DEFAULT NULL,
  `startdate` date DEFAULT NULL,
  `enddate` date DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `tblRacerid` int DEFAULT NULL,
  `tblTeamid` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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

CREATE TABLE `tblracer` (
  `id` int NOT NULL,
  `nationality` varchar(255) DEFAULT NULL,
  `shirtnumber` tinyint DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `tblMemberid` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tblregister` (
  `id` int NOT NULL,
  `dateregistered` date DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `position` tinyint DEFAULT NULL,
  `timedone` time(6) DEFAULT NULL,
  `points` int DEFAULT NULL,
  `tblContractid` int DEFAULT NULL,
  `tblStageid` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tblseason` (
  `id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `totalpoints` int DEFAULT NULL,
  `startdate` date DEFAULT NULL,
  `enddate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tblstage` (
  `id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `roadmap` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `tblSeasonid` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tblstatteaminseason` (
  `teamrank` tinyint DEFAULT NULL,
  `totalpoints` int DEFAULT NULL,
  `tblTeamid` int DEFAULT NULL,
  `tblSeasonid` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tblstatteaminstage` (
  `teamrank` tinyint DEFAULT NULL,
  `totalpoints` int DEFAULT NULL,
  `tblTeamid` int DEFAULT NULL,
  `tblStageid` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tblteam` (
  `id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `nation` varchar(255) DEFAULT NULL,
  `totalpoints` int DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbluser` (
  `tblMemberid` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


ALTER TABLE `tbladmin`
  ADD PRIMARY KEY (`tblMemberid`);

ALTER TABLE `tblcontract`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tblRacerid` (`tblRacerid`),
  ADD KEY `tblTeamid` (`tblTeamid`);

ALTER TABLE `tblmember`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

ALTER TABLE `tblracer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tblMemberid` (`tblMemberid`);

ALTER TABLE `tblregister`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tblContractid` (`tblContractid`),
  ADD KEY `tblStageid` (`tblStageid`);

ALTER TABLE `tblseason`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `tblstage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tblSeasonid` (`tblSeasonid`);

ALTER TABLE `tblstatteaminseason`
  ADD KEY `tblTeamid` (`tblTeamid`),
  ADD KEY `tblSeasonid` (`tblSeasonid`);

ALTER TABLE `tblstatteaminstage`
  ADD KEY `tblTeamid` (`tblTeamid`),
  ADD KEY `tblStageid` (`tblStageid`);

ALTER TABLE `tblteam`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `tbluser`
  ADD PRIMARY KEY (`tblMemberid`);


ALTER TABLE `tblcontract`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tblmember`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tblracer`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tblregister`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tblseason`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tblstage`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tblteam`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;


ALTER TABLE `tbladmin`
  ADD CONSTRAINT `tbladmin_ibfk_1` FOREIGN KEY (`tblMemberid`) REFERENCES `tblmember` (`id`);

ALTER TABLE `tblcontract`
  ADD CONSTRAINT `tblcontract_ibfk_1` FOREIGN KEY (`tblRacerid`) REFERENCES `tblracer` (`id`),
  ADD CONSTRAINT `tblcontract_ibfk_2` FOREIGN KEY (`tblTeamid`) REFERENCES `tblteam` (`id`);

ALTER TABLE `tblracer`
  ADD CONSTRAINT `tblracer_ibfk_1` FOREIGN KEY (`tblMemberid`) REFERENCES `tblmember` (`id`);

ALTER TABLE `tblregister`
  ADD CONSTRAINT `tblregister_ibfk_1` FOREIGN KEY (`tblContractid`) REFERENCES `tblcontract` (`id`),
  ADD CONSTRAINT `tblregister_ibfk_2` FOREIGN KEY (`tblStageid`) REFERENCES `tblstage` (`id`);

ALTER TABLE `tblstage`
  ADD CONSTRAINT `tblstage_ibfk_1` FOREIGN KEY (`tblSeasonid`) REFERENCES `tblseason` (`id`);

ALTER TABLE `tblstatteaminseason`
  ADD CONSTRAINT `tblstatteaminseason_ibfk_1` FOREIGN KEY (`tblTeamid`) REFERENCES `tblteam` (`id`),
  ADD CONSTRAINT `tblstatteaminseason_ibfk_2` FOREIGN KEY (`tblSeasonid`) REFERENCES `tblseason` (`id`);

ALTER TABLE `tblstatteaminstage`
  ADD CONSTRAINT `tblstatteaminstage_ibfk_1` FOREIGN KEY (`tblTeamid`) REFERENCES `tblteam` (`id`),
  ADD CONSTRAINT `tblstatteaminstage_ibfk_2` FOREIGN KEY (`tblStageid`) REFERENCES `tblstage` (`id`);

ALTER TABLE `tbluser`
  ADD CONSTRAINT `tbluser_ibfk_1` FOREIGN KEY (`tblMemberid`) REFERENCES `tblmember` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
