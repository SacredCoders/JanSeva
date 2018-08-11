-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Aug 11, 2018 at 04:32 PM
-- Server version: 5.7.21
-- PHP Version: 5.6.35

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `waterdept`
--

-- --------------------------------------------------------

--
-- Table structure for table `application_assigned`
--

DROP TABLE IF EXISTS `application_assigned`;
CREATE TABLE IF NOT EXISTS `application_assigned` (
  `eId` varchar(20) NOT NULL,
  `appId` varchar(20) NOT NULL,
  KEY `eId` (`eId`),
  KEY `appId` (`appId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

DROP TABLE IF EXISTS `documents`;
CREATE TABLE IF NOT EXISTS `documents` (
  `fileId` varchar(20) NOT NULL,
  `appId` varchar(20) NOT NULL,
  `filepath` varchar(50) NOT NULL,
  `description` varchar(20) NOT NULL,
  PRIMARY KEY (`fileId`),
  KEY `appId` (`appId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
CREATE TABLE IF NOT EXISTS `employee` (
  `eId` varchar(20) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `secondname` varchar(50) NOT NULL,
  `zone` varchar(15) NOT NULL,
  `designation` varchar(10) NOT NULL,
  `city` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`eId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `record`
--

DROP TABLE IF EXISTS `record`;
CREATE TABLE IF NOT EXISTS `record` (
  `scId` varchar(20) NOT NULL,
  `contactNo` varchar(20) NOT NULL,
  KEY `scId` (`scId`),
  KEY `contactNo` (`contactNo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `schemes`
--

DROP TABLE IF EXISTS `schemes`;
CREATE TABLE IF NOT EXISTS `schemes` (
  `scId` varchar(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `duration` varchar(20) NOT NULL,
  `document` varchar(15) NOT NULL,
  `eligibility` varchar(10) NOT NULL,
  PRIMARY KEY (`scId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `application_assigned`
--
ALTER TABLE `application_assigned`
  ADD CONSTRAINT `application_assigned_ibfk_1` FOREIGN KEY (`eId`) REFERENCES `employee` (`eId`) ON DELETE CASCADE,
  ADD CONSTRAINT `application_assigned_ibfk_2` FOREIGN KEY (`appId`) REFERENCES `citizens`.`applied_schemes` (`appId`) ON DELETE CASCADE;

--
-- Constraints for table `documents`
--
ALTER TABLE `documents`
  ADD CONSTRAINT `documents_ibfk_1` FOREIGN KEY (`appId`) REFERENCES `citizens`.`applied_schemes` (`appId`) ON DELETE CASCADE;

--
-- Constraints for table `record`
--
ALTER TABLE `record`
  ADD CONSTRAINT `record_ibfk_1` FOREIGN KEY (`scId`) REFERENCES `schemes` (`scId`) ON DELETE CASCADE,
  ADD CONSTRAINT `record_ibfk_2` FOREIGN KEY (`contactNo`) REFERENCES `citizens`.`citizen_details` (`contactNo`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
