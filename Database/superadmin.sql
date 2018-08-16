-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Aug 16, 2018 at 07:43 PM
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
-- Database: `superadmin`
--

-- --------------------------------------------------------

--
-- Table structure for table `caste`
--

DROP TABLE IF EXISTS `caste`;
CREATE TABLE IF NOT EXISTS `caste` (
  `casteId` int(50) NOT NULL AUTO_INCREMENT,
  `casteName` varchar(100) NOT NULL,
  PRIMARY KEY (`casteId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
CREATE TABLE IF NOT EXISTS `department` (
  `deptId` varchar(50) NOT NULL,
  `deptName` varchar(100) NOT NULL,
  `description` varchar(256) NOT NULL,
  `server` varchar(50) NOT NULL,
  PRIMARY KEY (`deptId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `district_name`
--

DROP TABLE IF EXISTS `district_name`;
CREATE TABLE IF NOT EXISTS `district_name` (
  `districtId` int(50) NOT NULL AUTO_INCREMENT,
  `districtName` varchar(50) NOT NULL,
  PRIMARY KEY (`districtId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `occupation`
--

DROP TABLE IF EXISTS `occupation`;
CREATE TABLE IF NOT EXISTS `occupation` (
  `occupationId` int(50) NOT NULL AUTO_INCREMENT,
  `occupationName` varchar(100) NOT NULL,
  PRIMARY KEY (`occupationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pin_taluka_rel`
--

DROP TABLE IF EXISTS `pin_taluka_rel`;
CREATE TABLE IF NOT EXISTS `pin_taluka_rel` (
  `pincode` varchar(100) NOT NULL,
  `talukaId` int(50) NOT NULL,
  PRIMARY KEY (`pincode`),
  KEY `talukaId` (`talukaId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `religion`
--

DROP TABLE IF EXISTS `religion`;
CREATE TABLE IF NOT EXISTS `religion` (
  `religionId` int(50) NOT NULL AUTO_INCREMENT,
  `religionName` varchar(100) NOT NULL,
  PRIMARY KEY (`religionId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `taluka_district_rel`
--

DROP TABLE IF EXISTS `taluka_district_rel`;
CREATE TABLE IF NOT EXISTS `taluka_district_rel` (
  `talukaId` int(50) NOT NULL,
  `districtId` int(50) NOT NULL,
  KEY `districtId` (`districtId`),
  KEY `talukaId` (`talukaId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `taluka_name`
--

DROP TABLE IF EXISTS `taluka_name`;
CREATE TABLE IF NOT EXISTS `taluka_name` (
  `talukaId` int(50) NOT NULL AUTO_INCREMENT,
  `talukaName` varchar(50) NOT NULL,
  PRIMARY KEY (`talukaId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `pin_taluka_rel`
--
ALTER TABLE `pin_taluka_rel`
  ADD CONSTRAINT `pin_taluka_rel_ibfk_1` FOREIGN KEY (`talukaId`) REFERENCES `taluka_name` (`talukaId`) ON DELETE CASCADE;

--
-- Constraints for table `taluka_district_rel`
--
ALTER TABLE `taluka_district_rel`
  ADD CONSTRAINT `taluka_district_rel_ibfk_1` FOREIGN KEY (`districtId`) REFERENCES `district_name` (`districtId`) ON DELETE CASCADE,
  ADD CONSTRAINT `taluka_district_rel_ibfk_2` FOREIGN KEY (`talukaId`) REFERENCES `taluka_name` (`talukaId`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
