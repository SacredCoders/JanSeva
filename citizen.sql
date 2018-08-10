-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Aug 10, 2018 at 10:46 AM
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
-- Database: `citizen`
--

-- --------------------------------------------------------

--
-- Table structure for table `applied_schemes`
--

DROP TABLE IF EXISTS `applied_schemes`;
CREATE TABLE IF NOT EXISTS `applied_schemes` (
  `app_id` varchar(20) NOT NULL,
  `contact_no` varchar(20) NOT NULL,
  `link` varchar(20) NOT NULL,
  `dept_id` varchar(20) NOT NULL,
  `status` varchar(5) NOT NULL,
  PRIMARY KEY (`app_id`),
  KEY `dept_id` (`dept_id`),
  KEY `contact_no` (`contact_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `applied_schemes`
--

INSERT INTO `applied_schemes` (`app_id`, `contact_no`, `link`, `dept_id`, `status`) VALUES
('1', '8237772146', 'url', '1', '1');

-- --------------------------------------------------------

--
-- Table structure for table `citizen_details`
--

DROP TABLE IF EXISTS `citizen_details`;
CREATE TABLE IF NOT EXISTS `citizen_details` (
  `contact_no` varchar(20) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `secondname` varchar(50) NOT NULL,
  `DOB` date NOT NULL,
  `sex` varchar(10) NOT NULL,
  `address` varchar(150) NOT NULL,
  `city` varchar(20) NOT NULL,
  `pincode` varchar(10) NOT NULL,
  `members_per_family` int(3) NOT NULL,
  `no_of_earnings` int(3) NOT NULL,
  `salary` decimal(20,2) NOT NULL,
  `password` varchar(30) NOT NULL,
  PRIMARY KEY (`contact_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `citizen_details`
--

INSERT INTO `citizen_details` (`contact_no`, `firstname`, `secondname`, `DOB`, `sex`, `address`, `city`, `pincode`, `members_per_family`, `no_of_earnings`, `salary`, `password`) VALUES
('6775026761', 'nishant', 'nimbalkar', '2018-08-08', 'male', 'shiv krupa apt', 'thane', '421503', 5, 2, '750000.00', 'hashed'),
('7775026761', 'nishant', 'nimbalkar', '2018-08-08', 'male', 'shiv krupa apt', 'thane', '421503', 5, 2, '750000.00', 'hashed'),
('8237772146', 'nishant', 'nimbalkar', '2018-08-08', 'male', 'shiv krupa apt', 'thane', '421503', 5, 2, '750000.00', ''),
('9775026761', 'nishant', 'nimbalkar', '2018-08-08', 'male', 'shiv krupa apt', 'thane', '421503', 5, 2, '750000.00', 'hashed');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `applied_schemes`
--
ALTER TABLE `applied_schemes`
  ADD CONSTRAINT `applied_schemes_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `super_admin`.`department` (`dept_id`),
  ADD CONSTRAINT `applied_schemes_ibfk_2` FOREIGN KEY (`contact_no`) REFERENCES `citizen_details` (`contact_no`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
