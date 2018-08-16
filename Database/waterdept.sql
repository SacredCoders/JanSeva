-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Aug 16, 2018 at 07:42 PM
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
  `appId` varchar(50) NOT NULL,
  `empId` varchar(50) NOT NULL,
  `dateOfCreation` datetime NOT NULL,
  `dateOfDeletion` datetime DEFAULT NULL,
  `lastModified` datetime NOT NULL,
  `applicationStatus` varchar(150) NOT NULL,
  PRIMARY KEY (`appId`),
  KEY `empId` (`empId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `chats`
--

DROP TABLE IF EXISTS `chats`;
CREATE TABLE IF NOT EXISTS `chats` (
  `contactNo` varchar(50) NOT NULL,
  `message` text NOT NULL,
  `time` datetime NOT NULL,
  KEY `contactNo` (`contactNo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `designation_name`
--

DROP TABLE IF EXISTS `designation_name`;
CREATE TABLE IF NOT EXISTS `designation_name` (
  `designationId` varchar(50) NOT NULL,
  `designationName` varchar(100) NOT NULL,
  PRIMARY KEY (`designationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `document`
--

DROP TABLE IF EXISTS `document`;
CREATE TABLE IF NOT EXISTS `document` (
  `documentId` int(50) NOT NULL AUTO_INCREMENT,
  `documentName` varchar(100) NOT NULL,
  PRIMARY KEY (`documentId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
CREATE TABLE IF NOT EXISTS `employee` (
  `empId` varchar(50) NOT NULL,
  `firstName` varchar(100) NOT NULL,
  `lastName` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `talukaId` int(50) NOT NULL,
  `designationId` varchar(50) NOT NULL,
  `isBlocked` varchar(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`empId`),
  KEY `designationId` (`designationId`),
  KEY `talukaId` (`talukaId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `required_documents`
--

DROP TABLE IF EXISTS `required_documents`;
CREATE TABLE IF NOT EXISTS `required_documents` (
  `scId` varchar(50) NOT NULL,
  `documentId` int(50) NOT NULL,
  KEY `scId` (`scId`),
  KEY `documentId` (`documentId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `required_eligibility_age`
--

DROP TABLE IF EXISTS `required_eligibility_age`;
CREATE TABLE IF NOT EXISTS `required_eligibility_age` (
  `scId` varchar(50) NOT NULL,
  `min` int(50) NOT NULL,
  `max` int(50) NOT NULL,
  KEY `scId` (`scId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `required_eligibility_caste`
--

DROP TABLE IF EXISTS `required_eligibility_caste`;
CREATE TABLE IF NOT EXISTS `required_eligibility_caste` (
  `scId` varchar(50) NOT NULL,
  `casteId` int(50) NOT NULL,
  KEY `scId` (`scId`),
  KEY `casteId` (`casteId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `required_eligibility_district`
--

DROP TABLE IF EXISTS `required_eligibility_district`;
CREATE TABLE IF NOT EXISTS `required_eligibility_district` (
  `scId` varchar(50) NOT NULL,
  `districtId` int(50) NOT NULL,
  KEY `scId` (`scId`),
  KEY `districtId` (`districtId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `required_eligibility_occupation`
--

DROP TABLE IF EXISTS `required_eligibility_occupation`;
CREATE TABLE IF NOT EXISTS `required_eligibility_occupation` (
  `scId` varchar(50) NOT NULL,
  `occupationId` int(50) NOT NULL,
  KEY `scId` (`scId`),
  KEY `occupationId` (`occupationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `required_eligibility_religion`
--

DROP TABLE IF EXISTS `required_eligibility_religion`;
CREATE TABLE IF NOT EXISTS `required_eligibility_religion` (
  `scId` varchar(50) NOT NULL,
  `religionId` int(50) NOT NULL,
  KEY `scId` (`scId`),
  KEY `religionId` (`religionId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `required_eligibility_salary`
--

DROP TABLE IF EXISTS `required_eligibility_salary`;
CREATE TABLE IF NOT EXISTS `required_eligibility_salary` (
  `scId` varchar(50) NOT NULL,
  `min` int(50) NOT NULL,
  `max` int(50) DEFAULT NULL,
  KEY `scId` (`scId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `required_eligibility_sex`
--

DROP TABLE IF EXISTS `required_eligibility_sex`;
CREATE TABLE IF NOT EXISTS `required_eligibility_sex` (
  `scId` varchar(50) NOT NULL,
  `sex` varchar(10) DEFAULT NULL,
  KEY `scId` (`scId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `schemes`
--

DROP TABLE IF EXISTS `schemes`;
CREATE TABLE IF NOT EXISTS `schemes` (
  `scId` varchar(50) NOT NULL,
  `schemeName` varchar(100) NOT NULL,
  `startDate` date NOT NULL,
  `endDate` date NOT NULL,
  `schemeDescription` text NOT NULL,
  `dateOfCreation` datetime NOT NULL,
  `dateOfDeletion` datetime DEFAULT NULL,
  `isDelete` varchar(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`scId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `application_assigned`
--
ALTER TABLE `application_assigned`
  ADD CONSTRAINT `application_assigned_ibfk_1` FOREIGN KEY (`empId`) REFERENCES `employee` (`empId`) ON DELETE CASCADE,
  ADD CONSTRAINT `application_assigned_ibfk_2` FOREIGN KEY (`appId`) REFERENCES `citizens`.`applied_schemes` (`appId`) ON DELETE CASCADE;

--
-- Constraints for table `chats`
--
ALTER TABLE `chats`
  ADD CONSTRAINT `chats_ibfk_1` FOREIGN KEY (`contactNo`) REFERENCES `citizens`.`citizen_details` (`contactNo`) ON DELETE CASCADE;

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`designationId`) REFERENCES `designation_name` (`designationId`) ON DELETE CASCADE,
  ADD CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`talukaId`) REFERENCES `superadmin`.`pin_taluka_rel` (`talukaId`) ON DELETE CASCADE;

--
-- Constraints for table `required_documents`
--
ALTER TABLE `required_documents`
  ADD CONSTRAINT `required_documents_ibfk_1` FOREIGN KEY (`scId`) REFERENCES `schemes` (`scId`) ON DELETE CASCADE,
  ADD CONSTRAINT `required_documents_ibfk_2` FOREIGN KEY (`documentId`) REFERENCES `document` (`documentId`) ON DELETE CASCADE;

--
-- Constraints for table `required_eligibility_age`
--
ALTER TABLE `required_eligibility_age`
  ADD CONSTRAINT `required_eligibility_age_ibfk_1` FOREIGN KEY (`scId`) REFERENCES `schemes` (`scId`) ON DELETE CASCADE;

--
-- Constraints for table `required_eligibility_caste`
--
ALTER TABLE `required_eligibility_caste`
  ADD CONSTRAINT `required_eligibility_caste_ibfk_1` FOREIGN KEY (`scId`) REFERENCES `schemes` (`scId`) ON DELETE CASCADE,
  ADD CONSTRAINT `required_eligibility_caste_ibfk_2` FOREIGN KEY (`casteId`) REFERENCES `superadmin`.`caste` (`casteId`) ON DELETE CASCADE;

--
-- Constraints for table `required_eligibility_district`
--
ALTER TABLE `required_eligibility_district`
  ADD CONSTRAINT `required_eligibility_district_ibfk_1` FOREIGN KEY (`scId`) REFERENCES `schemes` (`scId`) ON DELETE CASCADE,
  ADD CONSTRAINT `required_eligibility_district_ibfk_2` FOREIGN KEY (`districtId`) REFERENCES `superadmin`.`district_name` (`districtId`) ON DELETE CASCADE;

--
-- Constraints for table `required_eligibility_occupation`
--
ALTER TABLE `required_eligibility_occupation`
  ADD CONSTRAINT `required_eligibility_occupation_ibfk_1` FOREIGN KEY (`scId`) REFERENCES `schemes` (`scId`) ON DELETE CASCADE,
  ADD CONSTRAINT `required_eligibility_occupation_ibfk_2` FOREIGN KEY (`occupationId`) REFERENCES `superadmin`.`occupation` (`occupationId`) ON DELETE CASCADE;

--
-- Constraints for table `required_eligibility_religion`
--
ALTER TABLE `required_eligibility_religion`
  ADD CONSTRAINT `required_eligibility_religion_ibfk_1` FOREIGN KEY (`scId`) REFERENCES `schemes` (`scId`) ON DELETE CASCADE,
  ADD CONSTRAINT `required_eligibility_religion_ibfk_2` FOREIGN KEY (`religionId`) REFERENCES `superadmin`.`religion` (`religionId`) ON DELETE CASCADE;

--
-- Constraints for table `required_eligibility_salary`
--
ALTER TABLE `required_eligibility_salary`
  ADD CONSTRAINT `required_eligibility_salary_ibfk_1` FOREIGN KEY (`scId`) REFERENCES `schemes` (`scId`) ON DELETE CASCADE;

--
-- Constraints for table `required_eligibility_sex`
--
ALTER TABLE `required_eligibility_sex`
  ADD CONSTRAINT `required_eligibility_sex_ibfk_1` FOREIGN KEY (`scId`) REFERENCES `schemes` (`scId`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
