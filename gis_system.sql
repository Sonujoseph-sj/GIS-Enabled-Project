-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 31, 2023 at 10:50 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gis_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `district`
--

CREATE TABLE `district` (
  `id` int(11) NOT NULL,
  `dist_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `district`
--

INSERT INTO `district` (`id`, `dist_name`) VALUES
(1, 'Thiruvananthapuram'),
(2, 'Kollam'),
(3, 'Pathanamthitta'),
(4, 'Alappuzha'),
(5, 'Kottayam'),
(6, 'Idukki'),
(7, 'Ernakulam'),
(8, 'Thrissur'),
(9, 'Palakkad'),
(10, 'Malappuram'),
(11, 'Kozhikkodu'),
(12, 'Wayanad'),
(13, 'Kannur'),
(14, 'Kasargod');

-- --------------------------------------------------------

--
-- Table structure for table `hospitals`
--

CREATE TABLE `hospitals` (
  `id` int(11) NOT NULL,
  `hospital_name` varchar(200) NOT NULL,
  `place_id` int(11) NOT NULL,
  `hospital_rate` int(11) NOT NULL,
  `c_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `c_by` int(11) NOT NULL,
  `u_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `u_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hotels`
--

CREATE TABLE `hotels` (
  `id` int(11) NOT NULL,
  `hotel_name` varchar(255) NOT NULL,
  `hotel_rate` int(11) NOT NULL,
  `place_id` int(11) NOT NULL,
  `h_image` blob NOT NULL,
  `c_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hotels`
--

INSERT INTO `hotels` (`id`, `hotel_name`, `hotel_rate`, `place_id`, `h_image`, `c_at`) VALUES
(1, 'The Heritage Hotel', 4, 2, 0x686f74656c312e6a7067, '2023-03-23 05:14:43'),
(2, 'The Old Courtyard Hotel', 5, 2, 0x686f74656c332e6a7067, '2023-03-23 05:14:51'),
(3, 'Green Bay Homestay', 4, 2, 0x686f74656c342e6a7067, '2023-03-23 05:15:00');

-- --------------------------------------------------------

--
-- Table structure for table `images`
--

CREATE TABLE `images` (
  `id` int(11) NOT NULL,
  `place_id` int(11) NOT NULL,
  `image` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `images`
--

INSERT INTO `images` (`id`, `place_id`, `image`) VALUES
(1, 2, 0x666f72746b6f6368692e6a7067),
(2, 2, 0x666f72746b6f6368692e6a7067),
(3, 3, 0x3731373939323237385f333366306232656536655f622e6a7067),
(4, 4, 0x6e3273383865626f7965383330357a703279313176653770366463665f457175696e6f78202d20436f70792e6a7067),
(5, 2, 0x666b6f636869322e6a7067),
(6, 2, 0x666b6f636869332e6a7067),
(7, 2, 0x666b6f636869342e6a7067);

-- --------------------------------------------------------

--
-- Table structure for table `places`
--

CREATE TABLE `places` (
  `id` int(11) NOT NULL,
  `place_name` varchar(200) NOT NULL,
  `address` varchar(255) NOT NULL,
  `dist_id` int(11) NOT NULL,
  `description` varchar(255) NOT NULL,
  `latitude` float NOT NULL,
  `longitude` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `places`
--

INSERT INTO `places` (`id`, `place_name`, `address`, `dist_id`, `description`, `latitude`, `longitude`) VALUES
(2, 'Fort Kochi beach', 'Kochi,Ernakulam', 7, 'A very beautiful Fort Kochi beach is located on the western coast of India and is often known as the \'Queen of the Arabian Sea\'...', 9.9637, 76.2375),
(3, 'Marine Drive', 'kochi,Ernakulam..', 7, 'Marine Drive is among the most popular destinations in Kochi.', 9.9772, 76.2773),
(4, 'Wonderla Kochi ', 'Kochi, Ernakulam\r\n', 7, 'Wonderla is the largest chain of amusement parks in India. It is owned and operated by Wonderla Holidays Limited', 10.026, 76.3928),
(5, 'Munnar', 'Munnar,Idukki', 6, 'Munnar is situated in Kannan Devan village in Devikulam Taluk, Idukki District.', 10.0889, 77.0595);

-- --------------------------------------------------------

--
-- Table structure for table `pump`
--

CREATE TABLE `pump` (
  `id` int(11) NOT NULL,
  `pump_name` varchar(100) NOT NULL,
  `place_id` int(11) NOT NULL,
  `hospital_rate` int(11) NOT NULL,
  `c_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `c_by` int(11) NOT NULL,
  `u_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `u_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `place_id` int(11) NOT NULL,
  `review` varchar(200) NOT NULL,
  `rate` int(11) NOT NULL,
  `c_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`id`, `user_id`, `place_id`, `review`, `rate`, `c_at`) VALUES
(1, 6, 2, 'Beautiful place', 4, '2023-03-23 06:37:59'),
(6, 3, 2, 'good', 4, '2023-03-23 07:24:20'),
(8, 3, 2, 'kollaam', 4, '2023-03-23 09:48:50');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL,
  `status` int(11) NOT NULL,
  `token` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password`, `status`, `token`) VALUES
(2, 'admin', 'admin', 'admin@gmail.com', '21232f297a57a5a743894a0e4a801fc3', 0, '0'),
(3, 'Monisha', 'M', 'monishamohandas.13@gmail.com', '71a50f268eb0e1ba002c1381212b9cca', 1, '15b6883b9eadf5e6f9eaec8d979c8887e63829048df5ae3ae3149a093e525c5e'),
(4, 'monisha', 'm', 'monisha@gmail.com', '68d03c79ce1717fb2b4c06f0f66c3af5', 1, '0'),
(5, 'Sonu', 'Joseph', 'sonu@gmail.com', '371ab955fdc11c44c980779c3135b155', 1, '0'),
(6, 'Safna', 'K A', 'ka.safnas@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', 1, 'de2e036e6934ba9a5fa2574b4e3042d820ee576a682f0458d9ed5f29bb784a97');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `district`
--
ALTER TABLE `district`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hospitals`
--
ALTER TABLE `hospitals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `place_id` (`place_id`),
  ADD KEY `c_by` (`c_by`),
  ADD KEY `u_by` (`u_by`);

--
-- Indexes for table `hotels`
--
ALTER TABLE `hotels`
  ADD PRIMARY KEY (`id`),
  ADD KEY `place_id` (`place_id`);

--
-- Indexes for table `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `place_id` (`place_id`);

--
-- Indexes for table `places`
--
ALTER TABLE `places`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dist_id` (`dist_id`);

--
-- Indexes for table `pump`
--
ALTER TABLE `pump`
  ADD PRIMARY KEY (`id`),
  ADD KEY `place_id` (`place_id`),
  ADD KEY `c_by` (`c_by`),
  ADD KEY `u_by` (`u_by`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `place_id` (`place_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `district`
--
ALTER TABLE `district`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `hospitals`
--
ALTER TABLE `hospitals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hotels`
--
ALTER TABLE `hotels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `images`
--
ALTER TABLE `images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `places`
--
ALTER TABLE `places`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `pump`
--
ALTER TABLE `pump`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `hospitals`
--
ALTER TABLE `hospitals`
  ADD CONSTRAINT `hospitals_ibfk_1` FOREIGN KEY (`place_id`) REFERENCES `places` (`id`),
  ADD CONSTRAINT `hospitals_ibfk_2` FOREIGN KEY (`c_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `hospitals_ibfk_3` FOREIGN KEY (`u_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `hotels`
--
ALTER TABLE `hotels`
  ADD CONSTRAINT `hotels_ibfk_1` FOREIGN KEY (`place_id`) REFERENCES `places` (`id`);

--
-- Constraints for table `images`
--
ALTER TABLE `images`
  ADD CONSTRAINT `images_ibfk_1` FOREIGN KEY (`place_id`) REFERENCES `places` (`id`),
  ADD CONSTRAINT `images_ibfk_2` FOREIGN KEY (`place_id`) REFERENCES `places` (`id`),
  ADD CONSTRAINT `images_ibfk_3` FOREIGN KEY (`place_id`) REFERENCES `places` (`id`);

--
-- Constraints for table `places`
--
ALTER TABLE `places`
  ADD CONSTRAINT `places_ibfk_1` FOREIGN KEY (`dist_id`) REFERENCES `district` (`id`);

--
-- Constraints for table `pump`
--
ALTER TABLE `pump`
  ADD CONSTRAINT `pump_ibfk_1` FOREIGN KEY (`place_id`) REFERENCES `places` (`id`),
  ADD CONSTRAINT `pump_ibfk_2` FOREIGN KEY (`c_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `pump_ibfk_3` FOREIGN KEY (`u_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`place_id`) REFERENCES `places` (`id`),
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
