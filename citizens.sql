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
-- Database: `citizens`
--

-- --------------------------------------------------------

--
-- Table structure for table `applied_schemes`
--

DROP TABLE IF EXISTS `applied_schemes`;
CREATE TABLE IF NOT EXISTS `applied_schemes` (
  `appId` varchar(20) NOT NULL,
  `contactNo` varchar(20) NOT NULL,
  `date` date NOT NULL,
  `link` varchar(20) NOT NULL,
  `status` varchar(5) NOT NULL,
  PRIMARY KEY (`appId`),
  KEY `contactNo` (`contactNo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `citizen_details`
--

DROP TABLE IF EXISTS `citizen_details`;
CREATE TABLE IF NOT EXISTS `citizen_details` (
  `contactNo` varchar(20) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `secondname` varchar(50) NOT NULL,
  `dob` date NOT NULL,
  `sex` varchar(10) NOT NULL,
  `address` varchar(150) NOT NULL,
  `city` varchar(20) NOT NULL,
  `caste` varchar(15) NOT NULL,
  `religion` varchar(15) NOT NULL,
  `pincode` varchar(10) NOT NULL,
  `occupation` varchar(15) NOT NULL,
  `membersPerFamily` int(3) NOT NULL,
  `noOfEarnings` int(3) NOT NULL,
  `salary` decimal(20,2) NOT NULL,
  `password` varchar(30) NOT NULL,
  PRIMARY KEY (`contactNo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `citizen_details_temp`
--

DROP TABLE IF EXISTS `citizen_details_temp`;
CREATE TABLE IF NOT EXISTS `citizen_details_temp` (
  `contactNo` varchar(20) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `secondname` varchar(50) NOT NULL,
  `dob` date NOT NULL,
  `sex` varchar(10) NOT NULL,
  `address` varchar(150) NOT NULL,
  `city` varchar(20) NOT NULL,
  `caste` varchar(15) NOT NULL,
  `religion` varchar(15) NOT NULL,
  `pincode` varchar(10) NOT NULL,
  `occupation` varchar(15) NOT NULL,
  `membersPerFamily` int(3) NOT NULL,
  `noOfEarnings` int(3) NOT NULL,
  `salary` decimal(20,2) NOT NULL,
  `password` varchar(30) NOT NULL,
  `time` time NOT NULL,
  `otp` int(10) NOT NULL,
  PRIMARY KEY (`contactNo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `applied_schemes`
--
ALTER TABLE `applied_schemes`
  ADD CONSTRAINT `applied_schemes_ibfk_1` FOREIGN KEY (`contactNo`) REFERENCES `citizen_details` (`contactNo`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
