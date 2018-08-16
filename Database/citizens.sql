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
-- Database: `citizens`
--

-- --------------------------------------------------------

--
-- Table structure for table `announcement`
--

DROP TABLE IF EXISTS `announcement`;
CREATE TABLE IF NOT EXISTS `announcement` (
  `deptId` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `message` varchar(50) NOT NULL,
  `link` varchar(100) DEFAULT NULL,
  `dateOfCreation` date NOT NULL,
  KEY `deptId` (`deptId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `applied_schemes`
--

DROP TABLE IF EXISTS `applied_schemes`;
CREATE TABLE IF NOT EXISTS `applied_schemes` (
  `appId` varchar(50) NOT NULL,
  `contactNo` varchar(50) NOT NULL,
  `scId` varchar(50) NOT NULL,
  `deptId` varchar(50) NOT NULL,
  PRIMARY KEY (`appId`),
  KEY `deptId` (`deptId`),
  KEY `contactNo` (`contactNo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `citizen_details`
--

DROP TABLE IF EXISTS `citizen_details`;
CREATE TABLE IF NOT EXISTS `citizen_details` (
  `contactNo` varchar(50) NOT NULL,
  `firstName` varchar(100) NOT NULL,
  `lastName` varchar(100) NOT NULL,
  `dob` date NOT NULL,
  `sex` varchar(100) NOT NULL,
  `address` varchar(150) NOT NULL,
  `city` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `caste` varchar(100) NOT NULL,
  `religion` varchar(100) NOT NULL,
  `pincode` varchar(100) NOT NULL,
  `occupation` varchar(100) NOT NULL,
  `membersPerFamily` int(10) NOT NULL,
  `noOfEarnings` int(10) NOT NULL,
  `salary` decimal(30,2) NOT NULL,
  `dateOfCreation` datetime NOT NULL,
  `dateOfDeletion` datetime DEFAULT NULL,
  `isDelete` varchar(20) NOT NULL DEFAULT '0',
  `isBlocked` varchar(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`contactNo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `citizen_verification`
--

DROP TABLE IF EXISTS `citizen_verification`;
CREATE TABLE IF NOT EXISTS `citizen_verification` (
  `contactNo` varchar(50) NOT NULL,
  `timeCounter` time NOT NULL,
  `otp` int(20) NOT NULL,
  KEY `contactNo` (`contactNo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
CREATE TABLE IF NOT EXISTS `notification` (
  `contactNo` varchar(50) NOT NULL,
  `appId` varchar(50) NOT NULL,
  `deptId` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `message` varchar(50) NOT NULL,
  `dateOfCreation` date NOT NULL,
  KEY `appId` (`appId`),
  KEY `contactNo` (`contactNo`),
  KEY `deptId` (`deptId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `subscription`
--

DROP TABLE IF EXISTS `subscription`;
CREATE TABLE IF NOT EXISTS `subscription` (
  `contactNo` varchar(50) NOT NULL,
  `deptId` varchar(50) NOT NULL,
  KEY `contactNo` (`contactNo`),
  KEY `deptId` (`deptId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `announcement`
--
ALTER TABLE `announcement`
  ADD CONSTRAINT `announcement_ibfk_1` FOREIGN KEY (`deptId`) REFERENCES `superadmin`.`department` (`deptId`) ON DELETE CASCADE;

--
-- Constraints for table `applied_schemes`
--
ALTER TABLE `applied_schemes`
  ADD CONSTRAINT `applied_schemes_ibfk_1` FOREIGN KEY (`deptId`) REFERENCES `superadmin`.`department` (`deptId`) ON DELETE CASCADE,
  ADD CONSTRAINT `applied_schemes_ibfk_2` FOREIGN KEY (`contactNo`) REFERENCES `citizen_details` (`contactNo`) ON DELETE CASCADE;

--
-- Constraints for table `citizen_verification`
--
ALTER TABLE `citizen_verification`
  ADD CONSTRAINT `citizen_verification_ibfk_1` FOREIGN KEY (`contactNo`) REFERENCES `citizen_details` (`contactNo`) ON DELETE CASCADE;

--
-- Constraints for table `notification`
--
ALTER TABLE `notification`
  ADD CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`appId`) REFERENCES `applied_schemes` (`appId`) ON DELETE CASCADE,
  ADD CONSTRAINT `notification_ibfk_2` FOREIGN KEY (`contactNo`) REFERENCES `citizen_details` (`contactNo`) ON DELETE CASCADE,
  ADD CONSTRAINT `notification_ibfk_3` FOREIGN KEY (`deptId`) REFERENCES `superadmin`.`department` (`deptId`) ON DELETE CASCADE;

--
-- Constraints for table `subscription`
--
ALTER TABLE `subscription`
  ADD CONSTRAINT `subscription_ibfk_1` FOREIGN KEY (`contactNo`) REFERENCES `citizen_details` (`contactNo`) ON DELETE CASCADE,
  ADD CONSTRAINT `subscription_ibfk_2` FOREIGN KEY (`deptId`) REFERENCES `superadmin`.`department` (`deptId`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
