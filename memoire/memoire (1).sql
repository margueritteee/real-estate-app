-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 16, 2024 at 04:23 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `memoire`
--

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `adressid` int(11) NOT NULL,
  `adressname` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`adressid`, `adressname`) VALUES
(1, 'Aïn El Ibel'),
(2, 'Aïn Maabed'),
(3, 'Aïn Oussara'),
(4, 'Birine'),
(5, 'Charef'),
(6, 'Dar Chioukh'),
(7, 'Djelfa'),
(8, 'El Idrissia'),
(9, 'Faidh El Botma'),
(10, 'Hassi Bahbah'),
(11, 'Hassi El Euch'),
(12, 'Messaad'),
(13, 'M\'Liliha'),
(14, 'Moudjebara'),
(15, 'Zaafrane');

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `adminid` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`adminid`, `username`, `password`) VALUES
(1, 'admin', 'admin'),
(6, 'Bouragba immoblier', 'bouragba'),
(7, 'Khayma immoblier', 'khayma'),
(8, 'Nouila immoblier', 'nouila'),
(9, 'Ouanouki agence', 'ouanouki');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`) VALUES
(1, 'garage'),
(3, 'land'),
(4, 'houses'),
(5, 'villas'),
(6, 'apartments');

-- --------------------------------------------------------

--
-- Table structure for table `post_table`
--

CREATE TABLE `post_table` (
  `id` int(11) NOT NULL,
  `title` varchar(30) NOT NULL,
  `description` varchar(300) NOT NULL,
  `category_name` varchar(30) NOT NULL,
  `address` varchar(30) NOT NULL,
  `number` varchar(20) NOT NULL,
  `price` varchar(30) NOT NULL,
  `img` varchar(200) NOT NULL,
  `rooms_number` int(20) NOT NULL,
  `author` varchar(50) NOT NULL,
  `commune` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `post_table`
--

INSERT INTO `post_table` (`id`, `title`, `description`, `category_name`, `address`, `number`, `price`, `img`, `rooms_number`, `author`, `commune`) VALUES
(17, 'Cozy 3-bedroom home', 'Cozy 3-bedroom home with a private courtyard, blending traditional style and modern comfort. Ideal l', 'houses', 'Cite Ben Jerma', '0696867754', '7000000DA', '41.jpg', 3, 'admin', 'Djelfa'),
(19, 'garage for sale', 'garage offering ample space and functionality. Ideal for car enthusiasts, hobbyists, or as additional storage space', 'garage', 'cite ibn badis', '0688996767', '200000DA', 'Clean-Garage-Ideas-2-e1440756730403-1-1024x768.jpg', 0, 'Bouragba immoblier', 'Aïn Oussara'),
(20, 'Elegant Luxury villa', 'experience the epitome of luxury living in this exquisite villa ', 'villas', 'city buaafia', '0699087723', '22000000DA', '295090917.jpg', 13, 'Khayma immoblier', 'Hassi Bahbah');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `userid` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `number` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userid`, `username`, `email`, `number`, `password`) VALUES
(1, 'maggie', '', '0696854625', '1234'),
(2, 'hako', '', '0699072545', '1234'),
(3, 'adem', '', '079989899', '1234'),
(4, 'kadi', '', '079988998', '1234'),
(6, 'baraa', '', '069988987', '1234'),
(7, 'manal', 'manal@gmail.com', '0788543411', '1234');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`adressid`);

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`adminid`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `post_table`
--
ALTER TABLE `post_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `adressid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `adminid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `post_table`
--
ALTER TABLE `post_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `userid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
