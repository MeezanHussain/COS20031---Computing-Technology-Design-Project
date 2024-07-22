-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: ictstu-db1.cc.swin.edu.au
-- Generation Time: Jul 22, 2024 at 08:51 AM
-- Server version: 5.5.68-MariaDB
-- PHP Version: 7.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cos20031_56_db`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`cos20031_56`@`%.swin.edu.au` PROCEDURE `insert_into_score` (IN `p_EndID` INT)   BEGIN
  DECLARE end_state BOOLEAN;

  -- Check the EndState of the given EndID
  SELECT `EndState` INTO end_state FROM `End` WHERE `EndID` = p_EndID;

  -- If EndState is TRUE, insert into Score table
  IF end_state THEN
    INSERT INTO `Score` (`EndID`) VALUES (p_EndID);
  ELSE
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot insert EndID with EndState = FALSE into Score table';
  END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Archer`
--

CREATE TABLE `Archer` (
  `ArcherID` int(11) NOT NULL,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `DOB` date NOT NULL,
  `Gender` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Archer`
--

INSERT INTO `Archer` (`ArcherID`, `FirstName`, `LastName`, `DOB`, `Gender`) VALUES
(14, 'Jane', 'Miller', '1978-07-23', 'Male'),
(15, 'Alex', 'Davis', '1999-01-12', 'Male'),
(16, 'John', 'Williams', '2004-05-30', 'Male'),
(17, 'Sophia', 'Williams', '1999-07-29', 'Female'),
(18, 'Olivia', 'Martinez', '1971-01-10', 'Female'),
(19, 'Katie', 'Brown', '1975-07-29', 'Male'),
(20, 'Sophia', 'Williams', '1984-04-30', 'Female'),
(21, 'Luke', 'Williams', '1980-07-14', 'Female'),
(22, 'Katie', 'Martinez', '1989-10-24', 'Male'),
(23, 'Alex', 'Davis', '1983-09-29', 'Female'),
(24, 'Olivia', 'Jones', '2007-04-23', 'Female'),
(25, 'Luke', 'Brown', '1992-03-14', 'Male'),
(26, 'Luke', 'Davis', '2017-05-21', 'Female'),
(27, 'Jane', 'Martinez', '1980-01-25', 'Male'),
(28, 'Luke', 'Garcia', '1988-02-20', 'Male'),
(29, 'Alex', 'Jones', '2016-09-06', 'Female'),
(30, 'Jane', 'Brown', '2022-04-26', 'Female'),
(31, 'Jane', 'Garcia', '2009-12-19', 'Male'),
(32, 'Sophia', 'Johnson', '2016-01-18', 'Female'),
(33, 'Sophia', 'Martinez', '1975-03-07', 'Female'),
(34, 'Chris', 'Doe', '2005-07-10', 'Female'),
(35, 'John', 'Brown', '2021-11-19', 'Male'),
(36, 'John', 'Miller', '2000-11-28', 'Male'),
(37, 'Luke', 'Doe', '1976-03-11', 'Female'),
(38, 'John', 'Williams', '2006-09-06', 'Male'),
(39, 'Alex', 'Miller', '2003-08-06', 'Female'),
(40, 'Sophia', 'Miller', '2003-09-14', 'Male'),
(41, 'Luke', 'Johnson', '2001-03-14', 'Male'),
(42, 'Alex', 'Garcia', '2005-04-06', 'Male'),
(43, 'Emily', 'Doe', '1972-01-15', 'Female'),
(44, 'Sophia', 'Garcia', '2008-01-19', 'Female'),
(45, 'Emily', 'Brown', '2011-04-29', 'Female'),
(46, 'Alex', 'Williams', '1986-11-29', 'Male'),
(47, 'John', 'Miller', '1971-05-28', 'Male'),
(48, 'Emily', 'Smith', '1979-01-20', 'Male'),
(49, 'Sophia', 'Martinez', '1974-05-15', 'Male'),
(50, 'John', 'Miller', '2009-05-19', 'Male'),
(51, 'Luke', 'Brown', '1975-01-24', 'Male'),
(52, 'Luke', 'Williams', '1991-01-04', 'Female'),
(53, 'Olivia', 'Martinez', '1998-10-08', 'Male'),
(54, 'Chris', 'Johnson', '2016-10-06', 'Male'),
(55, 'Mike', 'Williams', '1994-09-08', 'Male'),
(56, 'Luke', 'Martinez', '1985-09-17', 'Female'),
(57, 'Luke', 'Davis', '1974-03-17', 'Female'),
(58, 'Mike', 'Garcia', '1998-08-06', 'Female'),
(59, 'Mike', 'Johnson', '1996-11-26', 'Female'),
(60, 'Alex', 'Garcia', '2012-06-25', 'Male'),
(61, 'Emily', 'Williams', '1982-12-14', 'Female'),
(62, 'John', 'Garcia', '2007-01-09', 'Female'),
(63, 'Luke', 'Garcia', '1982-01-11', 'Female');

-- --------------------------------------------------------

--
-- Table structure for table `Competition`
--

CREATE TABLE `Competition` (
  `CompetitionID` int(11) NOT NULL,
  `CompetitionName` varchar(100) NOT NULL,
  `StartDate` date NOT NULL,
  `EndDate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Competition`
--

INSERT INTO `Competition` (`CompetitionID`, `CompetitionName`, `StartDate`, `EndDate`) VALUES
(1, 'Arrow Masters Challenge', '2024-06-01', '2024-06-02'),
(2, 'Golden Bow Tournament', '2024-07-10', '2024-07-12'),
(3, 'Eagle Eye Archery Cup', '2024-08-15', '2024-08-17'),
(4, 'Luminous Arrow Championship', '2024-09-05', '2024-09-07'),
(5, 'Forest Archer\'s Rally', '2024-10-01', '2024-10-03'),
(6, 'Shadowstrike Invitational', '2024-11-20', '2024-11-22');

-- --------------------------------------------------------

--
-- Table structure for table `Competitive`
--

CREATE TABLE `Competitive` (
  `StagingID` int(11) NOT NULL,
  `CompetitionID` int(11) NOT NULL,
  `DivisionID` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Division`
--

CREATE TABLE `Division` (
  `DivisionID` varchar(5) NOT NULL,
  `DivisionName` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Division`
--

INSERT INTO `Division` (`DivisionID`, `DivisionName`) VALUES
('50+F', '50+ Female'),
('50+M', '50+ Male'),
('60+F', '60+ Female'),
('60+M', '60+ Male'),
('70+F', '70+ Female'),
('70+M', '70+ Male'),
('FO', 'Female Open'),
('MO', 'Male Open'),
('U14F', 'Under 14 Female'),
('U14M', 'Under 14 Male'),
('U16F', 'Under 16 Female'),
('U16M', 'Under 16 Male'),
('U18F', 'Under 18 Female'),
('U18M', 'Under 18 Male'),
('U21F', 'Under 21 Female'),
('U21M', 'Under 21 Male');

-- --------------------------------------------------------

--
-- Table structure for table `End`
--

CREATE TABLE `End` (
  `EndID` int(11) NOT NULL,
  `Arrow1` int(11) DEFAULT NULL,
  `Arrow2` int(11) DEFAULT NULL,
  `Arrow3` int(11) DEFAULT NULL,
  `Arrow4` int(11) DEFAULT NULL,
  `Arrow5` int(11) DEFAULT NULL,
  `Arrow6` int(11) DEFAULT NULL,
  `EndState` tinyint(1) AS (
    CASE
      WHEN Arrow1 IS NOT NULL AND Arrow2 IS NOT NULL AND Arrow3 IS NOT NULL AND Arrow4 IS NOT NULL AND Arrow5 IS NOT NULL AND Arrow6 IS NOT NULL
      THEN TRUE
      ELSE FALSE
    END) VIRTUAL,
  `TotalScore` int(11) AS (
    COALESCE(Arrow1, 0) + COALESCE(Arrow2, 0) + COALESCE(Arrow3, 0) + COALESCE(Arrow4, 0) + COALESCE(Arrow5, 0) + COALESCE(Arrow6, 0)) VIRTUAL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `End`
--

INSERT INTO `End` (`EndID`, `Arrow1`, `Arrow2`, `Arrow3`, `Arrow4`, `Arrow5`, `Arrow6`) VALUES
(152, 9, 10, 10, 10, 6, 5),
(153, 6, 1, 0, 1, 4, 3),
(154, 8, 8, 8, 9, 9, 3),
(155, 7, 5, 6, 7, 10, 9),
(156, 8, 2, 5, 0, 7, 1),
(157, 4, 6, 1, 1, 2, 5),
(158, 4, 5, 7, 3, 8, 7),
(159, 5, 7, 1, 7, 7, 5),
(160, 1, 4, 0, 1, 0, 5),
(161, 10, 1, 10, 2, 3, 8),
(162, 2, 8, 2, 5, 8, 6),
(163, 7, 3, 6, 10, 2, 2),
(164, 10, 10, 6, 6, 0, 9),
(165, 3, 7, 9, 6, 6, 0),
(166, 3, 3, 4, 1, 9, 1),
(167, 8, 2, 5, 5, 3, 7),
(168, 1, 4, 10, 7, 8, 10),
(169, 5, 9, 6, 9, 6, 9),
(170, 1, 5, 5, 7, 9, 2),
(171, 10, 4, 9, 9, 1, 10),
(172, 2, 5, 1, 3, 4, 1),
(173, 2, 5, 2, 8, 6, 6),
(174, 9, 2, 9, 6, 6, 2),
(175, 7, 10, 8, 10, 2, 8),
(176, 2, 7, 4, 2, 2, 5),
(177, 7, 9, 0, 5, 0, 7),
(178, 2, 3, 6, 8, 8, 10),
(179, 7, 6, 10, 7, 6, 7),
(180, 7, 2, 1, 9, 0, 3),
(181, 4, 0, 4, 3, 8, 4),
(182, 2, 7, 9, 7, 8, 8),
(183, 1, 9, 1, 4, 8, 5),
(184, 8, 0, 7, 8, 3, 6),
(185, 1, 10, 3, 4, 0, 7),
(186, 4, 5, 1, 7, 1, 3),
(187, 3, 9, 5, 9, 10, 6),
(188, 2, 9, 2, 3, 3, 0),
(189, 9, 5, 8, 4, 9, 8),
(190, 2, 5, 4, 4, 9, 4),
(191, 8, 10, 1, 2, 6, 0),
(192, 4, 10, 2, 2, 3, 2),
(193, 5, 3, 10, 6, 7, 2),
(194, 9, 10, 4, 10, 6, 6),
(195, 7, 1, 10, 1, 6, 8),
(196, 4, 5, 7, 7, 5, 9),
(197, 0, 1, 7, 10, 10, 5),
(198, 1, 8, 6, 3, 6, 3),
(199, 7, 4, 5, 4, 5, 8),
(200, 9, 2, 9, 7, 5, 10),
(201, 0, 0, 1, 10, 7, 0),
(202, 1, 2, 3, 4, 5, 6);

-- --------------------------------------------------------

--
-- Table structure for table `Equipment`
--

CREATE TABLE `Equipment` (
  `EquipmentID` varchar(10) NOT NULL,
  `Types` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Equipment`
--

INSERT INTO `Equipment` (`EquipmentID`, `Types`) VALUES
('C', 'Compound'),
('CB', 'Compound Barebow'),
('L', 'Longbow'),
('R', 'Recurve'),
('RC', 'Recurve Barebow');

-- --------------------------------------------------------

--
-- Table structure for table `Ranges`
--

CREATE TABLE `Ranges` (
  `RangeID` varchar(2) NOT NULL,
  `Range` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Ranges`
--

INSERT INTO `Ranges` (`RangeID`, `Range`) VALUES
('5E', 5),
('6E', 6);

-- --------------------------------------------------------

--
-- Table structure for table `Round`
--

CREATE TABLE `Round` (
  `RoundID` int(11) NOT NULL,
  `RoundName` varchar(100) NOT NULL,
  `Distance` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Round`
--

INSERT INTO `Round` (`RoundID`, `RoundName`, `Distance`) VALUES
(1, 'Melbourne', 70),
(2, 'Long Melbourne', 30),
(3, 'Short Melbourne', 50),
(4, 'Sydney', 20),
(5, 'Long Sydney', 90),
(6, 'Short Sydney', 40),
(7, 'Brisbane', 60),
(8, 'Long Brisbane', 10),
(9, 'Short Brisbane', 20),
(10, 'Perth', 90),
(11, 'Long Perth', 30),
(12, 'Short Perth', 70),
(13, 'Adelaide', 40),
(14, 'Long Adelaide', 50),
(15, 'Short Adelaide', 60),
(16, 'Canberra', 10),
(17, 'Long Canberra', 20),
(18, 'Short Canberra', 90),
(19, 'Hobart', 30),
(20, 'Long Hobart', 70),
(21, 'Short Hobart', 40),
(22, 'Darwin', 50),
(23, 'Long Darwin', 60),
(24, 'Short Darwin', 10);

-- --------------------------------------------------------

--
-- Stand-in structure for view `RoundView`
-- (See below for the actual view)
--
CREATE TABLE `RoundView` (
`RoundID` int(11)
,`RoundName` varchar(100)
,`Distance` varchar(12)
);

-- --------------------------------------------------------

--
-- Table structure for table `Score`
--

CREATE TABLE `Score` (
  `ScoreID` int(11) NOT NULL,
  `EndID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Score`
--

INSERT INTO `Score` (`ScoreID`, `EndID`) VALUES
(149, 152),
(150, 153),
(151, 154),
(152, 155),
(153, 156),
(154, 157),
(155, 158),
(156, 159),
(157, 160),
(158, 161),
(159, 162),
(160, 163),
(161, 164),
(162, 165),
(163, 166),
(164, 167),
(165, 168),
(166, 169),
(167, 170),
(168, 171),
(169, 172),
(170, 173),
(171, 174),
(172, 175),
(173, 176),
(174, 177),
(175, 178),
(176, 179),
(177, 180),
(178, 181),
(179, 182),
(180, 183),
(181, 184),
(182, 185),
(183, 186),
(184, 187),
(185, 188),
(186, 189),
(187, 190),
(188, 191),
(189, 192),
(190, 193),
(191, 194),
(192, 195),
(193, 196),
(194, 197),
(195, 198),
(196, 199),
(197, 200),
(198, 201),
(199, 202);

-- --------------------------------------------------------

--
-- Table structure for table `Staging`
--

CREATE TABLE `Staging` (
  `StagingID` int(11) NOT NULL,
  `ArcherID` int(11) NOT NULL,
  `EquipmentID` varchar(10) NOT NULL,
  `ScoreID` int(11) DEFAULT NULL,
  `RoundID` int(11) NOT NULL,
  `RangeID` varchar(2) NOT NULL,
  `StageDate` date NOT NULL,
  `StageTime` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Staging`
--

INSERT INTO `Staging` (`StagingID`, `ArcherID`, `EquipmentID`, `ScoreID`, `RoundID`, `RangeID`, `StageDate`, `StageTime`) VALUES
(140, 27, 'L', 199, 1, '6E', '2024-05-26', '22:41:11');

-- --------------------------------------------------------

--
-- Structure for view `RoundView`
--
DROP TABLE IF EXISTS `RoundView`;

CREATE ALGORITHM=UNDEFINED DEFINER=`cos20031_56`@`%.swin.edu.au` SQL SECURITY DEFINER VIEW `RoundView`  AS SELECT `Round`.`RoundID` AS `RoundID`, `Round`.`RoundName` AS `RoundName`, concat(`Round`.`Distance`,'m') AS `Distance` FROM `Round` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Archer`
--
ALTER TABLE `Archer`
  ADD PRIMARY KEY (`ArcherID`),
  ADD KEY `idx_archer_dob` (`DOB`),
  ADD KEY `idx_archer_gender` (`Gender`);

--
-- Indexes for table `Competition`
--
ALTER TABLE `Competition`
  ADD PRIMARY KEY (`CompetitionID`),
  ADD KEY `idx_competition_startdate` (`StartDate`),
  ADD KEY `idx_competition_enddate` (`EndDate`);

--
-- Indexes for table `Competitive`
--
ALTER TABLE `Competitive`
  ADD PRIMARY KEY (`StagingID`,`CompetitionID`,`DivisionID`),
  ADD KEY `idx_competitive_stagingid` (`StagingID`),
  ADD KEY `idx_competitive_competitionid` (`CompetitionID`),
  ADD KEY `idx_competitive_divisionid` (`DivisionID`);

--
-- Indexes for table `Division`
--
ALTER TABLE `Division`
  ADD PRIMARY KEY (`DivisionID`);

--
-- Indexes for table `End`
--
ALTER TABLE `End`
  ADD PRIMARY KEY (`EndID`);

--
-- Indexes for table `Equipment`
--
ALTER TABLE `Equipment`
  ADD PRIMARY KEY (`EquipmentID`);

--
-- Indexes for table `Ranges`
--
ALTER TABLE `Ranges`
  ADD PRIMARY KEY (`RangeID`);

--
-- Indexes for table `Round`
--
ALTER TABLE `Round`
  ADD PRIMARY KEY (`RoundID`),
  ADD KEY `idx_round_distance` (`Distance`);

--
-- Indexes for table `Score`
--
ALTER TABLE `Score`
  ADD PRIMARY KEY (`ScoreID`),
  ADD KEY `idx_score_endid` (`EndID`);

--
-- Indexes for table `Staging`
--
ALTER TABLE `Staging`
  ADD PRIMARY KEY (`StagingID`),
  ADD KEY `idx_staging_archerid` (`ArcherID`),
  ADD KEY `idx_staging_equipmentid` (`EquipmentID`),
  ADD KEY `idx_staging_scoreid` (`ScoreID`),
  ADD KEY `idx_staging_roundid` (`RoundID`),
  ADD KEY `idx_staging_rangeid` (`RangeID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Archer`
--
ALTER TABLE `Archer`
  MODIFY `ArcherID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `Competition`
--
ALTER TABLE `Competition`
  MODIFY `CompetitionID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `End`
--
ALTER TABLE `End`
  MODIFY `EndID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=203;

--
-- AUTO_INCREMENT for table `Round`
--
ALTER TABLE `Round`
  MODIFY `RoundID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `Score`
--
ALTER TABLE `Score`
  MODIFY `ScoreID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=200;

--
-- AUTO_INCREMENT for table `Staging`
--
ALTER TABLE `Staging`
  MODIFY `StagingID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=141;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Competitive`
--
ALTER TABLE `Competitive`
  ADD CONSTRAINT `Competitive_ibfk_1` FOREIGN KEY (`StagingID`) REFERENCES `Staging` (`StagingID`),
  ADD CONSTRAINT `Competitive_ibfk_2` FOREIGN KEY (`CompetitionID`) REFERENCES `Competition` (`CompetitionID`),
  ADD CONSTRAINT `Competitive_ibfk_3` FOREIGN KEY (`DivisionID`) REFERENCES `Division` (`DivisionID`);

--
-- Constraints for table `Score`
--
ALTER TABLE `Score`
  ADD CONSTRAINT `Score_ibfk_1` FOREIGN KEY (`EndID`) REFERENCES `End` (`EndID`);

--
-- Constraints for table `Staging`
--
ALTER TABLE `Staging`
  ADD CONSTRAINT `Staging_ibfk_5` FOREIGN KEY (`RangeID`) REFERENCES `Ranges` (`RangeID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Staging_ibfk_1` FOREIGN KEY (`ArcherID`) REFERENCES `Archer` (`ArcherID`),
  ADD CONSTRAINT `Staging_ibfk_2` FOREIGN KEY (`EquipmentID`) REFERENCES `Equipment` (`EquipmentID`),
  ADD CONSTRAINT `Staging_ibfk_3` FOREIGN KEY (`ScoreID`) REFERENCES `Score` (`ScoreID`),
  ADD CONSTRAINT `Staging_ibfk_4` FOREIGN KEY (`RoundID`) REFERENCES `Round` (`RoundID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
