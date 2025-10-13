-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 13, 2025 at 04:15 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mindspace_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `activity_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `activity_logs`
--

INSERT INTO `activity_logs` (`id`, `user_id`, `activity_type`, `ip_address`, `user_agent`, `created_at`, `updated_at`) VALUES
(54, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-05 05:12:46', '2025-10-05 05:12:46'),
(55, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-05 05:12:55', '2025-10-05 05:12:55'),
(56, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-05 05:12:55', '2025-10-05 05:12:55'),
(57, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-05 07:20:28', '2025-10-05 07:20:28'),
(58, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-05 07:20:28', '2025-10-05 07:20:28'),
(59, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-05 07:33:35', '2025-10-05 07:33:35'),
(60, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-05 07:33:35', '2025-10-05 07:33:35'),
(61, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-05 21:36:56', '2025-10-05 21:36:56'),
(62, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-05 21:36:56', '2025-10-05 21:36:56'),
(63, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-06 00:05:33', '2025-10-06 00:05:33'),
(64, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-06 00:05:33', '2025-10-06 00:05:33'),
(65, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-06 00:33:44', '2025-10-06 00:33:44'),
(66, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-06 00:33:44', '2025-10-06 00:33:44'),
(67, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-10-06 00:34:04', '2025-10-06 00:34:04'),
(68, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-10-06 00:34:04', '2025-10-06 00:34:04'),
(69, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-06 00:47:17', '2025-10-06 00:47:17'),
(70, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-06 00:47:17', '2025-10-06 00:47:17'),
(71, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-06 00:52:18', '2025-10-06 00:52:18'),
(72, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-06 00:52:18', '2025-10-06 00:52:18'),
(73, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-06 00:55:11', '2025-10-06 00:55:11'),
(74, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-06 00:55:11', '2025-10-06 00:55:11'),
(75, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-06 01:06:03', '2025-10-06 01:06:03'),
(76, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-06 01:06:03', '2025-10-06 01:06:03'),
(77, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-06 04:26:31', '2025-10-06 04:26:31'),
(78, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-06 04:26:31', '2025-10-06 04:26:31'),
(79, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-06 05:15:48', '2025-10-06 05:15:48'),
(80, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-06 05:15:48', '2025-10-06 05:15:48'),
(81, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-06 05:20:22', '2025-10-06 05:20:22'),
(82, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-06 05:20:22', '2025-10-06 05:20:22'),
(83, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-07 17:27:31', '2025-10-07 17:27:31'),
(84, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-07 17:27:31', '2025-10-07 17:27:31'),
(85, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-07 18:20:22', '2025-10-07 18:20:22'),
(86, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-07 18:20:22', '2025-10-07 18:20:22'),
(87, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-07 18:28:59', '2025-10-07 18:28:59'),
(88, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-07 18:28:59', '2025-10-07 18:28:59'),
(89, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-07 18:42:17', '2025-10-07 18:42:17'),
(90, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-07 18:42:17', '2025-10-07 18:42:17'),
(91, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-07 18:50:54', '2025-10-07 18:50:54'),
(92, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-07 18:50:54', '2025-10-07 18:50:54'),
(93, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 16:49:56', '2025-10-08 16:49:56'),
(94, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 16:49:56', '2025-10-08 16:49:56'),
(95, 9, 'login', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', '2025-10-08 17:07:09', '2025-10-08 17:07:09'),
(96, 9, 'login', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', '2025-10-08 17:07:17', '2025-10-08 17:07:17'),
(97, 9, 'login', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', '2025-10-08 17:07:17', '2025-10-08 17:07:17'),
(98, 9, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 17:20:53', '2025-10-08 17:20:53'),
(99, 9, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 17:20:53', '2025-10-08 17:20:53'),
(100, 9, 'login', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', '2025-10-08 17:21:05', '2025-10-08 17:21:05'),
(101, 9, 'login', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', '2025-10-08 17:21:05', '2025-10-08 17:21:05'),
(102, 9, 'login', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', '2025-10-08 17:22:17', '2025-10-08 17:22:17'),
(103, 9, 'login', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', '2025-10-08 17:22:17', '2025-10-08 17:22:17'),
(104, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', '2025-10-08 17:23:31', '2025-10-08 17:23:31'),
(105, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', '2025-10-08 17:23:31', '2025-10-08 17:23:31'),
(106, 9, 'login', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', '2025-10-08 17:23:45', '2025-10-08 17:23:45'),
(107, 9, 'login', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', '2025-10-08 17:23:45', '2025-10-08 17:23:45'),
(108, 9, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 17:28:27', '2025-10-08 17:28:27'),
(109, 9, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 17:28:27', '2025-10-08 17:28:27'),
(110, 9, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 17:38:51', '2025-10-08 17:38:51'),
(111, 9, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 17:38:51', '2025-10-08 17:38:51'),
(112, 9, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 17:42:56', '2025-10-08 17:42:56'),
(113, 9, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 17:42:57', '2025-10-08 17:42:57'),
(114, 9, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 17:49:35', '2025-10-08 17:49:35'),
(115, 9, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 17:49:35', '2025-10-08 17:49:35'),
(116, 9, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 18:05:23', '2025-10-08 18:05:23'),
(117, 9, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 18:05:23', '2025-10-08 18:05:23'),
(118, 9, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 18:08:43', '2025-10-08 18:08:43'),
(119, 9, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 18:08:43', '2025-10-08 18:08:43'),
(120, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 18:14:46', '2025-10-08 18:14:46'),
(121, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 18:14:46', '2025-10-08 18:14:46'),
(122, 9, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 18:24:25', '2025-10-08 18:24:25'),
(123, 9, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 18:24:25', '2025-10-08 18:24:25'),
(124, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 18:24:38', '2025-10-08 18:24:38'),
(125, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 18:24:38', '2025-10-08 18:24:38'),
(126, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 18:37:40', '2025-10-08 18:37:40'),
(127, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 18:37:40', '2025-10-08 18:37:40'),
(128, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 18:42:31', '2025-10-08 18:42:31'),
(129, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 18:42:31', '2025-10-08 18:42:31'),
(130, 9, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 18:42:48', '2025-10-08 18:42:48'),
(131, 9, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 18:42:48', '2025-10-08 18:42:48'),
(132, 10, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 20:11:25', '2025-10-08 20:11:25'),
(133, 10, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 20:11:37', '2025-10-08 20:11:37'),
(134, 10, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 20:11:37', '2025-10-08 20:11:37'),
(135, 9, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 20:16:37', '2025-10-08 20:16:37'),
(136, 9, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 20:16:37', '2025-10-08 20:16:37'),
(137, 10, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 20:19:39', '2025-10-08 20:19:39'),
(138, 10, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 20:19:39', '2025-10-08 20:19:39'),
(139, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 20:20:10', '2025-10-08 20:20:10'),
(140, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-08 20:20:10', '2025-10-08 20:20:10'),
(141, 8, 'login', '127.0.0.1', 'Dart/3.8 (dart:io)', '2025-10-12 18:59:54', '2025-10-12 18:59:54'),
(142, 8, 'login', '127.0.0.1', 'Dart/3.8 (dart:io)', '2025-10-12 18:59:54', '2025-10-12 18:59:54'),
(143, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 20:21:56', '2025-10-12 20:21:56'),
(144, 8, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 20:21:56', '2025-10-12 20:21:56'),
(145, 9, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 21:03:38', '2025-10-12 21:03:38'),
(146, 9, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 21:03:39', '2025-10-12 21:03:39');

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `id` bigint UNSIGNED NOT NULL,
  `client_id` bigint UNSIGNED NOT NULL,
  `therapist_id` bigint UNSIGNED NOT NULL,
  `availability_id` bigint UNSIGNED NOT NULL,
  `appointment_time` datetime NOT NULL,
  `status` enum('scheduled','completed','cancelled','no_show') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'scheduled',
  `client_notes` text COLLATE utf8mb4_unicode_ci,
  `therapist_notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `availabilities`
--

CREATE TABLE `availabilities` (
  `id` bigint UNSIGNED NOT NULL,
  `therapist_id` bigint UNSIGNED NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `chat_messages`
--

CREATE TABLE `chat_messages` (
  `id` bigint UNSIGNED NOT NULL,
  `appointment_id` bigint UNSIGNED NOT NULL,
  `sender_id` bigint UNSIGNED NOT NULL,
  `receiver_id` bigint UNSIGNED NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000001_create_cache_table', 1),
(2, '2025_09_15_050824_create_users_table', 1),
(3, '2025_09_15_051049_create_therapist_profiles_table', 1),
(4, '2025_09_15_053359_create_availabilites_table', 1),
(5, '2025_09_15_053421_create_appointments_table', 1),
(6, '2025_09_15_053438_create_transactions_table', 1),
(7, '2025_09_15_053449_create_reviews_table', 1),
(8, '2025_09_15_053507_create_chat_messages_table', 1),
(9, '2025_09_22_060015_create_sessions_table', 2),
(10, '2025_09_22_080147_create_personal_access_tokens_table', 3),
(11, '2025_09_22_080516_change_phone_number_to_string_in_users_table', 4),
(12, '2025_09_24_090450_create_activity_logs_table', 5),
(13, '2025_09_29_000001_change_birth_date_to_text_in_users_table', 6),
(14, '2025_09_29_000002_change_phone_number_to_text_in_users_table', 7),
(15, '2025_10_05_093146_add_profilepicture_column_to_users', 8),
(16, '2025_10_05_120139_decrypt_email_column_in_users_table', 9),
(17, '2025_10_08_010918_create_therapist_profiles_table', 10),
(18, '2025_10_08_233056_create_therapist_availabilities_table', 11);

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'auth_token', '8b9e3e149d1b820c4d146dcd44a8296c988fe4004624cb0dd240b8f0f5b962f9', '[\"*\"]', NULL, NULL, '2025-09-22 01:05:45', '2025-09-22 01:05:45'),
(2, 'App\\Models\\User', 2, 'auth_token', '2f3cb6a54b3aecc0c2daa3b4c0a074527c9577035cbe219f5d8583df558191f3', '[\"*\"]', NULL, NULL, '2025-09-23 21:12:45', '2025-09-23 21:12:45'),
(3, 'App\\Models\\User', 2, 'auth_token', 'a0422947c615abd8104a1f73d893d027c697aa2805f899428b4a9ad6166a391a', '[\"*\"]', NULL, NULL, '2025-09-23 23:11:17', '2025-09-23 23:11:17'),
(4, 'App\\Models\\User', 2, 'auth_token', 'b8a6891e9d7131bc8f5b650f65961cd22d3ea1021b38fc20a152bfc971533f9f', '[\"*\"]', NULL, NULL, '2025-09-23 23:20:19', '2025-09-23 23:20:19'),
(5, 'App\\Models\\User', 2, 'auth_token', 'c2a85b36bb0ee861f4c29b4dc34b4937efe325dd7d4d44a5584d4356a42f2445', '[\"*\"]', NULL, NULL, '2025-09-23 23:22:04', '2025-09-23 23:22:04'),
(6, 'App\\Models\\User', 2, 'auth_token', 'bba6f6a1b99a2c61203fca17e16414073c49a11627779e477bc624f9cae71fc1', '[\"*\"]', NULL, NULL, '2025-09-24 01:29:22', '2025-09-24 01:29:22'),
(7, 'App\\Models\\User', 2, 'auth_token', 'ad599874dd033a35c69768eb67cde7ccbf9baddd98dcd809ed85e1aa16e66de0', '[\"*\"]', NULL, NULL, '2025-09-24 01:30:31', '2025-09-24 01:30:31'),
(8, 'App\\Models\\User', 2, 'auth_token', '60684f26c256976aaffaa097d1a876abaeaaeff3e1b7d446f0a28bde6cc68545', '[\"*\"]', NULL, NULL, '2025-09-24 01:36:47', '2025-09-24 01:36:47'),
(9, 'App\\Models\\User', 2, 'auth_token', '68d2706da00823f422770cd1178b62c98003e1ab5d8e905748e8d8bbb3026851', '[\"*\"]', NULL, NULL, '2025-09-24 01:41:30', '2025-09-24 01:41:30'),
(10, 'App\\Models\\User', 2, 'auth_token', 'ba7829b98414c57004f3d2244e68502908016cfd17ef2f693be5c35267c92eb7', '[\"*\"]', '2025-09-24 01:57:33', NULL, '2025-09-24 01:57:32', '2025-09-24 01:57:33'),
(11, 'App\\Models\\User', 2, 'auth_token', 'f467d45b8d66a2e377bc6b8d04a2970c87bd933c64d160b511658a47240db201', '[\"*\"]', '2025-09-24 02:02:01', NULL, '2025-09-24 02:02:00', '2025-09-24 02:02:01'),
(12, 'App\\Models\\User', 2, 'auth_token', 'cb9874b2c1f46c65c0939150bf8ee0bf567b781396834089eca69f7adbd857ea', '[\"*\"]', '2025-09-24 02:13:04', NULL, '2025-09-24 02:13:04', '2025-09-24 02:13:04'),
(13, 'App\\Models\\User', 2, 'auth_token', 'b13b2abe04c45f0a14f43811baaf9c778241a31847fbd6d5873810b76c3b5623', '[\"*\"]', '2025-09-24 19:24:14', NULL, '2025-09-24 19:24:13', '2025-09-24 19:24:14'),
(14, 'App\\Models\\User', 2, 'auth_token', '6553c1d73b78a9f290326c12773b2aba58fb96ee5feb6b10fb37a193eb42826e', '[\"*\"]', '2025-09-24 19:28:43', NULL, '2025-09-24 19:28:42', '2025-09-24 19:28:43'),
(15, 'App\\Models\\User', 2, 'auth_token', '987ff559e3d78e88f482aebc2f600d9b8a197f1a1922e8864531f7d425e219d5', '[\"*\"]', '2025-09-24 19:30:18', NULL, '2025-09-24 19:30:17', '2025-09-24 19:30:18'),
(16, 'App\\Models\\User', 2, 'auth_token', 'dc091a0b9df31f6728fa315e6fa57b802c66bc1ab1c0c454f9f3aec7269eae69', '[\"*\"]', '2025-09-24 19:30:57', NULL, '2025-09-24 19:30:57', '2025-09-24 19:30:57'),
(17, 'App\\Models\\User', 2, 'auth_token', '173149cb3c98215856aa928628f3328a1bb23ad9f46ac5339f977e241efe9c3f', '[\"*\"]', '2025-09-24 19:31:31', NULL, '2025-09-24 19:31:30', '2025-09-24 19:31:31'),
(18, 'App\\Models\\User', 2, 'auth_token', '8a39569bc056418d8656223cb783a4eed5430e3d29292e3fdcfc3e5d356a0e91', '[\"*\"]', '2025-09-24 19:34:08', NULL, '2025-09-24 19:34:07', '2025-09-24 19:34:08'),
(19, 'App\\Models\\User', 2, 'auth_token', 'b5ed4bc41f1df8b76cc65360807f6380f676d20c962fa78ea1f67a9987c1de49', '[\"*\"]', '2025-09-24 19:34:49', NULL, '2025-09-24 19:34:49', '2025-09-24 19:34:49'),
(20, 'App\\Models\\User', 2, 'auth_token', '1083af4fd6ebdb8f86f1f3ff697191772e7ae65e279b9f1a781344f13079dba1', '[\"*\"]', '2025-09-24 19:35:54', NULL, '2025-09-24 19:35:53', '2025-09-24 19:35:54'),
(21, 'App\\Models\\User', 2, 'auth_token', 'c34aa22dd1e82f2154d54b3d9a6626ae7e9bc387c8fcc6b05916c619268143f7', '[\"*\"]', '2025-09-24 22:19:37', NULL, '2025-09-24 22:19:37', '2025-09-24 22:19:37'),
(22, 'App\\Models\\User', 2, 'auth_token', '9764ba2634d686767a0c13cc661d5c211028839f7fd28f07ea77b6ba4c2ac293', '[\"*\"]', NULL, NULL, '2025-09-24 22:35:40', '2025-09-24 22:35:40'),
(23, 'App\\Models\\User', 2, 'auth_token', 'a28e77904683c9062c36b5b59e9f43a6e1327e67c7ef96841453761d807b629e', '[\"*\"]', NULL, NULL, '2025-09-24 22:36:02', '2025-09-24 22:36:02'),
(24, 'App\\Models\\User', 2, 'auth_token', 'f94601be4848efedf1e9a85c52700bdfe2c7a2aae6f682d54223ab6995613534', '[\"*\"]', NULL, NULL, '2025-09-24 22:36:28', '2025-09-24 22:36:28'),
(25, 'App\\Models\\User', 2, 'auth_token', '12bbac0178a0fae9ea83b26008f9704133f0ae036f7023544c3839cff4f592b3', '[\"*\"]', '2025-09-24 23:14:27', NULL, '2025-09-24 23:14:18', '2025-09-24 23:14:27'),
(26, 'App\\Models\\User', 3, 'auth_token', 'bb8c3ee42dc52f4ca6838a0268e8a75ca611c71015e198614f2133229041b207', '[\"*\"]', NULL, NULL, '2025-09-24 23:16:09', '2025-09-24 23:16:09'),
(38, 'App\\Models\\User', 5, 'auth_token', 'e2d46ccbfa790f58c596fda8c567390df698c1836c1ea09762bd6de5cab96c29', '[\"*\"]', NULL, NULL, '2025-10-01 19:47:38', '2025-10-01 19:47:38'),
(39, 'App\\Models\\User', 5, 'auth_token', 'fdcc4f7bbfb86fba607a4c7bb83b5ab7eec3777c936ab00473844f39266874c3', '[\"*\"]', '2025-10-01 19:56:09', NULL, '2025-10-01 19:47:47', '2025-10-01 19:56:09'),
(40, 'App\\Models\\User', 6, 'auth_token', 'f19052c104fed4c648acbfadd998e8487817602e84142c87189020bbc912454e', '[\"*\"]', NULL, NULL, '2025-10-01 19:59:57', '2025-10-01 19:59:57'),
(41, 'App\\Models\\User', 6, 'auth_token', 'e4c673477160654236c60a95d6bb7e4d0fb13233f9cf815cd239fddf64ca0efd', '[\"*\"]', '2025-10-01 20:10:02', NULL, '2025-10-01 20:00:10', '2025-10-01 20:10:02'),
(42, 'App\\Models\\User', 5, 'auth_token', '2483e57bafde8844597b70c1e3fb97fa1a061b293659c4e3d519692458863045', '[\"*\"]', '2025-10-05 02:26:17', NULL, '2025-10-05 02:24:55', '2025-10-05 02:26:17'),
(45, 'App\\Models\\User', 8, 'auth_token', 'e1f96ebf8e067884e1d228fa5c28e1799863745c280d561fb526a3ef45670f35', '[\"*\"]', NULL, NULL, '2025-10-05 05:12:46', '2025-10-05 05:12:46'),
(46, 'App\\Models\\User', 8, 'auth_token', '5b359a71852e2d6511b8e62cc365f999472b28306b2f008c268cc7e97cc7258e', '[\"*\"]', '2025-10-05 07:15:40', NULL, '2025-10-05 05:12:55', '2025-10-05 07:15:40'),
(47, 'App\\Models\\User', 8, 'auth_token', '90156bc91656c5ce91fe8e515068d641bd8b6de27304516c6798066734cbf579', '[\"*\"]', '2025-10-05 07:20:29', NULL, '2025-10-05 07:20:28', '2025-10-05 07:20:29'),
(48, 'App\\Models\\User', 8, 'auth_token', 'bbac554bd1b77b06a56da2b8753ab2f9137957fe6fdb846408796ccdc9c69cb2', '[\"*\"]', '2025-10-05 07:35:15', NULL, '2025-10-05 07:33:35', '2025-10-05 07:35:15'),
(49, 'App\\Models\\User', 8, 'auth_token', '1dfdc71a36011fb224eb98f0eae291c00c147984fc1448b04252ec0d16ce0824', '[\"*\"]', '2025-10-05 21:38:47', NULL, '2025-10-05 21:36:56', '2025-10-05 21:38:47'),
(50, 'App\\Models\\User', 8, 'auth_token', 'e790d53b8df903e7c5f360326be68a6177fcc636cdc8cddeae6c6764bf4e4834', '[\"*\"]', '2025-10-06 00:05:33', NULL, '2025-10-06 00:05:33', '2025-10-06 00:05:33'),
(51, 'App\\Models\\User', 8, 'auth_token', '0764f8f7aa17cc70a7e2bb7eaef0bd6e31e0f0ea897672ec4d3698141b1b0e7a', '[\"*\"]', '2025-10-06 00:33:44', NULL, '2025-10-06 00:33:44', '2025-10-06 00:33:44'),
(52, 'App\\Models\\User', 8, 'auth_token', 'fd6d2d087cbe69cd60e255624102db4b01fec4b7593ad056801d8d9b767da460', '[\"*\"]', '2025-10-06 00:44:05', NULL, '2025-10-06 00:34:04', '2025-10-06 00:44:05'),
(53, 'App\\Models\\User', 8, 'auth_token', 'f955a9749883ad31de2c85fd303cc5fc98ad2029d5bd1c32645e29404945e125', '[\"*\"]', '2025-10-06 00:52:01', NULL, '2025-10-06 00:47:17', '2025-10-06 00:52:01'),
(54, 'App\\Models\\User', 8, 'auth_token', '5434c415fb01720017a169c07a882a4487e17b9dd1dcf80430a79eae7541834b', '[\"*\"]', '2025-10-06 00:52:22', NULL, '2025-10-06 00:52:18', '2025-10-06 00:52:22'),
(55, 'App\\Models\\User', 8, 'auth_token', '5049f76e2865d03dce250c5b42a5a2ccc4f7063decfee4ce50f9abecb825ca02', '[\"*\"]', '2025-10-06 00:55:16', NULL, '2025-10-06 00:55:11', '2025-10-06 00:55:16'),
(56, 'App\\Models\\User', 8, 'auth_token', '84d8ddac376847c044005bc77b5899483d32c622cc6b519a87adeef1456e5ac1', '[\"*\"]', '2025-10-06 01:06:04', NULL, '2025-10-06 01:06:03', '2025-10-06 01:06:04'),
(57, 'App\\Models\\User', 8, 'auth_token', '9abec4eaf970760a5a69ea9beee0fd96521f9097ceceb3d2c6b40b10a54e3755', '[\"*\"]', '2025-10-06 05:15:22', NULL, '2025-10-06 04:26:31', '2025-10-06 05:15:22'),
(58, 'App\\Models\\User', 8, 'auth_token', '4cf16ee5be73673e10918cc81001511c0254761ccf6a555fc17b20bf113ac05e', '[\"*\"]', '2025-10-06 05:20:01', NULL, '2025-10-06 05:15:48', '2025-10-06 05:20:01'),
(59, 'App\\Models\\User', 8, 'auth_token', '4f7259340b5b8469eaa0abb9d405b9bce3f88d83c61d89c491ec511abb4decfe', '[\"*\"]', '2025-10-06 07:20:16', NULL, '2025-10-06 05:20:22', '2025-10-06 07:20:16'),
(60, 'App\\Models\\User', 8, 'auth_token', 'd758a1d44e289ebf91dc4bfbcf5d981e5d59d26c8d6b06d2d12d7fc31d839097', '[\"*\"]', '2025-10-07 17:27:32', NULL, '2025-10-07 17:27:31', '2025-10-07 17:27:32'),
(61, 'App\\Models\\User', 8, 'auth_token', '34ec041e11c5818b45fe415fd5d7e70a3004c85ebfdfff830e5961a21d8ee0ff', '[\"*\"]', '2025-10-07 18:20:23', NULL, '2025-10-07 18:20:22', '2025-10-07 18:20:23'),
(62, 'App\\Models\\User', 8, 'auth_token', '7834cd53cd86eeb4dff64de2791c331f15d2db7afde181112e3543cf2c665a96', '[\"*\"]', '2025-10-07 18:29:51', NULL, '2025-10-07 18:28:59', '2025-10-07 18:29:51'),
(63, 'App\\Models\\User', 8, 'auth_token', 'd085f51acf96461c038a6a388f3cb1d9ede8de363c0a30841493e4588ca4bc00', '[\"*\"]', '2025-10-07 18:43:16', NULL, '2025-10-07 18:42:17', '2025-10-07 18:43:16'),
(64, 'App\\Models\\User', 8, 'auth_token', '215fd8ca35491b63af3fa45d81568bf6ccbdb428749326620f0296afee4d1e4d', '[\"*\"]', '2025-10-07 18:58:25', NULL, '2025-10-07 18:50:54', '2025-10-07 18:58:25'),
(65, 'App\\Models\\User', 8, 'auth_token', '645ddb392cf31d009808e4ecb120b6c22a3187e6736f9836b9d93fab6eb160e3', '[\"*\"]', '2025-10-08 17:05:27', NULL, '2025-10-08 16:49:56', '2025-10-08 17:05:27'),
(66, 'App\\Models\\User', 9, 'auth_token', '828ea62bc6f5aeb3e8c79ce94ab4ee84fb8b9b78e0adf4b2919993d0f991d0a8', '[\"*\"]', NULL, NULL, '2025-10-08 17:07:09', '2025-10-08 17:07:09'),
(67, 'App\\Models\\User', 9, 'auth_token', '880c721782966e630cf74b47fad134124c904392c5d1f418a042b6cbb37b1d33', '[\"*\"]', '2025-10-08 17:07:18', NULL, '2025-10-08 17:07:17', '2025-10-08 17:07:18'),
(68, 'App\\Models\\User', 9, 'auth_token', 'b536dfcea8fd3ad8715cb2e418eab78d482f0e869fb4c4f6ad09af6c0bb4c680', '[\"*\"]', NULL, NULL, '2025-10-08 17:20:53', '2025-10-08 17:20:53'),
(69, 'App\\Models\\User', 9, 'auth_token', '424eaf43a94552cf92dab01c4755f2baa5cb7a4ef10e0c122c35ceb460933909', '[\"*\"]', NULL, NULL, '2025-10-08 17:21:05', '2025-10-08 17:21:05'),
(70, 'App\\Models\\User', 9, 'auth_token', '10669337874236be280db4b3bd4132177003affe06647cfe3a5cfafe2f8c4dd7', '[\"*\"]', NULL, NULL, '2025-10-08 17:22:17', '2025-10-08 17:22:17'),
(71, 'App\\Models\\User', 8, 'auth_token', 'd468cd374462b8135ffdb2c39cc601e0e3d14d7ee3923ed74e871f60ef79172a', '[\"*\"]', '2025-10-08 17:23:32', NULL, '2025-10-08 17:23:31', '2025-10-08 17:23:32'),
(72, 'App\\Models\\User', 9, 'auth_token', 'f191b12ab30ea0c2b399ad5608b9a33e3927806f68403b565fd29af2d69d0f3c', '[\"*\"]', NULL, NULL, '2025-10-08 17:23:45', '2025-10-08 17:23:45'),
(73, 'App\\Models\\User', 9, 'auth_token', '9e848d74a678fb0c62187a629d7a3ebadfe0e6ae1ac9c29ae9e7fdf4afbbb3d3', '[\"*\"]', NULL, NULL, '2025-10-08 17:28:27', '2025-10-08 17:28:27'),
(74, 'App\\Models\\User', 9, 'auth_token', '8b8a4b49efebe332412bfc66196806f841c3655e680e8557fba8b964727d3170', '[\"*\"]', NULL, NULL, '2025-10-08 17:38:51', '2025-10-08 17:38:51'),
(75, 'App\\Models\\User', 9, 'auth_token', 'dfafb206069954087c344126be303649ed74930859399ac326f89b10373c16c4', '[\"*\"]', NULL, NULL, '2025-10-08 17:42:57', '2025-10-08 17:42:57'),
(76, 'App\\Models\\User', 9, 'auth_token', '96c6ba8309bc04baa66f18af6b39f29d345502b5ccbcb29e26e6952e65559fd4', '[\"*\"]', '2025-10-08 17:49:39', NULL, '2025-10-08 17:49:35', '2025-10-08 17:49:39'),
(77, 'App\\Models\\User', 9, 'auth_token', '0a85eddae946312f09d66c3011d0cd528f89510be9048919097de8b019fe0f11', '[\"*\"]', '2025-10-08 18:07:45', NULL, '2025-10-08 18:05:23', '2025-10-08 18:07:45'),
(78, 'App\\Models\\User', 9, 'auth_token', '2e222babb023c97680d23827c779e07c750d9d66ee9d38716629e80b4e398ce4', '[\"*\"]', '2025-10-08 18:14:20', NULL, '2025-10-08 18:08:43', '2025-10-08 18:14:20'),
(79, 'App\\Models\\User', 8, 'auth_token', 'af340f4700323de9824e4e61478ba7c0e17be1931ebeca1415fad9c52e6447e7', '[\"*\"]', '2025-10-08 18:15:14', NULL, '2025-10-08 18:14:46', '2025-10-08 18:15:14'),
(80, 'App\\Models\\User', 9, 'auth_token', '07c92d2d118f314f741b3c9dff6da8b0dde16749637276754f96691df316a720', '[\"*\"]', '2025-10-08 18:24:28', NULL, '2025-10-08 18:24:25', '2025-10-08 18:24:28'),
(81, 'App\\Models\\User', 8, 'auth_token', '21e9e54f912a9de0b496bab12ea252aeaa1bfac43e83c0d314ed0f4cc3f1fe5b', '[\"*\"]', '2025-10-08 18:27:12', NULL, '2025-10-08 18:24:38', '2025-10-08 18:27:12'),
(82, 'App\\Models\\User', 8, 'auth_token', 'ab6edca952503d34a78732553d56f81ddfe4e5275b7c1db6a239340caf6298c1', '[\"*\"]', '2025-10-08 18:37:53', NULL, '2025-10-08 18:37:40', '2025-10-08 18:37:53'),
(83, 'App\\Models\\User', 8, 'auth_token', '1f55f3a24e6c159f53fcc074b24963ca53cf888d86b8747a0e144afed9418531', '[\"*\"]', '2025-10-08 18:42:37', NULL, '2025-10-08 18:42:31', '2025-10-08 18:42:37'),
(84, 'App\\Models\\User', 9, 'auth_token', '690f53f5014cf53b83192f462cfd7929f6e264f6ed9cb134b2c53401cdbefbf5', '[\"*\"]', '2025-10-08 18:42:53', NULL, '2025-10-08 18:42:48', '2025-10-08 18:42:53'),
(85, 'App\\Models\\User', 10, 'auth_token', 'facf03f3d123f202d69f26327c61a784d0c9e60f940e7c8b31fd54571bbbc2ec', '[\"*\"]', NULL, NULL, '2025-10-08 20:11:25', '2025-10-08 20:11:25'),
(86, 'App\\Models\\User', 10, 'auth_token', '683ce64eb1686e9ce237a7a90a12424cf633d2eada0b6f79cf6e4eeaed4028f6', '[\"*\"]', '2025-10-08 20:16:08', NULL, '2025-10-08 20:11:37', '2025-10-08 20:16:08'),
(87, 'App\\Models\\User', 9, 'auth_token', '56938b161df574f249be882486501e79ee047846de352c51c4900a293df4f1c3', '[\"*\"]', '2025-10-08 20:19:03', NULL, '2025-10-08 20:16:37', '2025-10-08 20:19:03'),
(88, 'App\\Models\\User', 10, 'auth_token', '29881b50f7976a029334b762fd890549916747a8157577188e46d991144a6550', '[\"*\"]', '2025-10-08 20:19:55', NULL, '2025-10-08 20:19:39', '2025-10-08 20:19:55'),
(89, 'App\\Models\\User', 8, 'auth_token', 'd03293e396e036240be2f978b07c5cfd0b05fe66b5a5f0f24c91f6e2c298ea9e', '[\"*\"]', '2025-10-08 20:20:27', NULL, '2025-10-08 20:20:10', '2025-10-08 20:20:27'),
(90, 'App\\Models\\User', 8, 'auth_token', '3f2cc6c7a2c19cf540a71424bcaca3b44450233edf80f65e471a0cd7d35216c5', '[\"*\"]', '2025-10-12 19:00:08', NULL, '2025-10-12 18:59:54', '2025-10-12 19:00:08'),
(91, 'App\\Models\\User', 8, 'auth_token', '73884a8638cc49f84e5041b332f988f484132110df83dda9df78f75b3d57a86d', '[\"*\"]', '2025-10-12 20:22:10', NULL, '2025-10-12 20:21:56', '2025-10-12 20:22:10'),
(92, 'App\\Models\\User', 9, 'auth_token', '779296809fd06b9f23d503afa7115e253b81ead11a7163f1fd4f8cc5e4ef6d94', '[\"*\"]', '2025-10-12 21:03:48', NULL, '2025-10-12 21:03:39', '2025-10-12 21:03:48');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` bigint UNSIGNED NOT NULL,
  `appointment_id` bigint UNSIGNED NOT NULL,
  `client_id` bigint UNSIGNED NOT NULL,
  `therapist_id` bigint UNSIGNED NOT NULL,
  `rating` tinyint UNSIGNED NOT NULL COMMENT 'Rating from 1 to 5',
  `comment` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `therapist_availabilities`
--

CREATE TABLE `therapist_availabilities` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `day_of_week` tinyint NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `therapist_availabilities`
--

INSERT INTO `therapist_availabilities` (`id`, `user_id`, `day_of_week`, `start_time`, `end_time`, `created_at`, `updated_at`) VALUES
(9, 10, 1, '09:00:00', '12:00:00', '2025-10-08 20:16:08', '2025-10-08 20:16:08'),
(10, 10, 1, '14:00:00', '16:00:00', '2025-10-08 20:16:08', '2025-10-08 20:16:08'),
(13, 8, 1, '09:00:00', '12:00:00', '2025-10-12 20:22:10', '2025-10-12 20:22:10'),
(14, 8, 2, '00:00:00', '04:00:00', '2025-10-12 20:22:10', '2025-10-12 20:22:10');

-- --------------------------------------------------------

--
-- Table structure for table `therapist_profiles`
--

CREATE TABLE `therapist_profiles` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `profile_picture_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `education_history` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `hourly_rate` int UNSIGNED NOT NULL,
  `experience_years` tinyint UNSIGNED NOT NULL,
  `specializations` json NOT NULL,
  `problem_areas` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `therapist_profiles`
--

INSERT INTO `therapist_profiles` (`id`, `user_id`, `profile_picture_path`, `education_history`, `hourly_rate`, `experience_years`, `specializations`, `problem_areas`, `created_at`, `updated_at`) VALUES
(6, 8, 'storage/therapist_pictures/MgmOl7xzyYkdAmcvB4CAsLCyccFs4kr7Vl5IOg2P.png', 'S1 Psikologi Unpad', 200000, 8, '[\"Klinis Dewasa\", \"Klinis Anak dan Remaja\"]', 'Kecemasan', '2025-10-08 17:05:27', '2025-10-08 17:05:27');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint UNSIGNED NOT NULL,
  `appointment_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL COMMENT 'The user who paid',
  `amount` decimal(8,2) NOT NULL,
  `status` enum('pending','paid','failed','refunded') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `payment_gateway_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `full_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `birth_date` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` enum('pria','wanita') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `flyer` enum('yes','no') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `category` enum('Umum','Mahasiswa Aktif Unpad','Dosen / Tenaga Kependidikan Unpad') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Umum',
  `role` enum('klien','psikolog','admin') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'klien',
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `profile_picture` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `full_name`, `email`, `email_verified_at`, `created_at`, `updated_at`, `birth_date`, `gender`, `phone_number`, `password`, `flyer`, `category`, `role`, `remember_token`, `profile_picture`) VALUES
(8, 'castreld', 'eyJpdiI6ImpleUtMM2RoY1hoeGVaWVZ0eGdvakE9PSIsInZhbHVlIjoiM2owVFNHa0dEeG1MRFg5Zm5YN0VvSkZMKzVIMjdZZ0hndGFkMTlQRDZaaz0iLCJtYWMiOiI1NTI0YTlhMjhlMDQzM2M5YjI3Mzk0Mjg0NjBlM2JkMTVjMDYzODllYWYzZjRjZGU4OTE5ZWUyOTcyZjA2ZDFkIiwidGFnIjoiIn0=', 'hulukotak@gmail.com', NULL, '2025-10-05 05:12:46', '2025-10-08 18:14:20', 'eyJpdiI6IjhUSm80Yi9LaG9zMmdzWlMwclBhT1E9PSIsInZhbHVlIjoiSDIyQjgydmxkK29sQ210SEdQQzdEQT09IiwibWFjIjoiYmQ2NzgzNWZjNGZiNzJkNmQxYTY0N2ViODk3YWM4ZjIxMGYwNjdmOTZiMmM1MTk0ZTY0OTQ4ZGM0ZTZiYjYyMyIsInRhZyI6IiJ9', 'pria', 'eyJpdiI6ImxrZWw0SDlwVlA4cnQ3UlJhdzhlc0E9PSIsInZhbHVlIjoiZXVJbWE0K0FBd3NzNW81YUNQMGRFdz09IiwibWFjIjoiYjA2N2RmNzI2NzE2MjE4OTExNzZjNmVlZGJmYWIwZWYzOGM4ZDVhZjJmNTFkYjUxZWZiOWQ2ZDI4M2E3NDQxNCIsInRhZyI6IiJ9', '$2y$12$AELMm.mBHhlqfyKabyMlOuDMWRIqvIDCdL1LNhuJy2WdIkijPol4O', 'no', 'Umum', 'psikolog', NULL, 'storage/profilepictures/1759888700_8.png'),
(9, 'admin', 'eyJpdiI6ImpWdkpWdXFrclh0RGIwOVFCbm5sQ3c9PSIsInZhbHVlIjoiMXJKU1B4aW1aSWhQK2c5QlVac0JqZz09IiwibWFjIjoiNzU4NWYyNGFhNmE1ZDNjNmVkMTMwYjg0NzMyMTQ3ODM4ODE5ZjJkZTQwNDdjMTc1YjM0NGUyZjFmZDU5Zjk0YiIsInRhZyI6IiJ9', 'admin@gmail.com', NULL, '2025-10-08 17:07:09', '2025-10-08 17:07:09', 'eyJpdiI6ImxTZnBYWTJSTUlhWVdZZ1NMc3ZETXc9PSIsInZhbHVlIjoia3BXYlAwVGEvK04xNmxzKzd2SmZOUT09IiwibWFjIjoiMDY4OTA5M2Q0ZWY1NTY2MTk5NTAzZDY3MTc3YjgyMjUyYjI4NjI2ZTkxOGQ0MDc4YTNiYmM4NDYxNjk3ZmJhMyIsInRhZyI6IiJ9', 'pria', 'eyJpdiI6IlNkSys4K29ob2h6UmtERzIvUlEya0E9PSIsInZhbHVlIjoidzFhVjJUb0ptVVpmT2Y3WnpvR2NDdz09IiwibWFjIjoiNjZjMjMzOGYzNzFiMjU2Njg1OGYzMGRlZWMzYWJjODY0MzRjNTRjMzM3NDQxMjcxMGRiODU3OTU1YjVlZWIwNiIsInRhZyI6IiJ9', '$2y$12$zAE5doa64TXNcOTGodgfp.HyP0Hm/typwAmCAEmyFX4LQ0ZXL1yrS', 'no', 'Umum', 'admin', NULL, 'storage/profilepictures/man_placeholder.png'),
(10, 'testing_wanita', 'eyJpdiI6Ik1yMGIxRGgvWWZLRmJYcCtUdlJEYXc9PSIsInZhbHVlIjoibzVMcjI5K2VjcHlONit1MzhBeHJIUT09IiwibWFjIjoiZGIxMzY5Mzg1M2RiNjI2ZDc5MDg4MTA4ZmUwY2JlYzU5ZTJkYzEzYmVkMDkzM2U5N2FjODBkMmM5OGJlODY0MiIsInRhZyI6IiJ9', 'testingwanita@gmail.com', NULL, '2025-10-08 20:11:25', '2025-10-08 20:11:25', 'eyJpdiI6ImhVSFhnQUVKR3FIdGNabmROcWhyV0E9PSIsInZhbHVlIjoiRDArK0haTm1FWStjd1NzNDN6OFgyQT09IiwibWFjIjoiZjRlMmUxNzg4OWZjMDI4ZjkxMmRmZDk5MDc2ZTZiNzlkNmJiYTA5ZWVmOGI4MzEyNTI5Mjk3MWJlMDdiOTQ2MSIsInRhZyI6IiJ9', 'wanita', 'eyJpdiI6IkdOTjIyVG1UUGlzQ2RqVTB5bWR1MWc9PSIsInZhbHVlIjoiMnc3M0tVZE9ZTDNLOVVMd2JZR255QT09IiwibWFjIjoiNGMyNmMwYjUxMzE3MzlkYmRmOTAwNTdmZGJmYTMyOTBiNjUzNzA4YjE4M2JkNmM5OTc3YzUyMjljYTJmOTk3ZSIsInRhZyI6IiJ9', '$2y$12$/G3DOcPI2OErY4udmUBHbexqiZfw5kgpcDP1XoI9/nAuWy8zqbHlu', 'yes', 'Umum', 'klien', NULL, 'storage/profilepictures/woman_placeholder.png');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `activity_logs_user_id_foreign` (`user_id`);

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `appointments_client_id_foreign` (`client_id`),
  ADD KEY `appointments_therapist_id_foreign` (`therapist_id`),
  ADD KEY `appointments_availability_id_foreign` (`availability_id`);

--
-- Indexes for table `availabilities`
--
ALTER TABLE `availabilities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `availabilities_therapist_id_foreign` (`therapist_id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `chat_messages`
--
ALTER TABLE `chat_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `chat_messages_appointment_id_foreign` (`appointment_id`),
  ADD KEY `chat_messages_sender_id_foreign` (`sender_id`),
  ADD KEY `chat_messages_receiver_id_foreign` (`receiver_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reviews_appointment_id_foreign` (`appointment_id`),
  ADD KEY `reviews_client_id_foreign` (`client_id`),
  ADD KEY `reviews_therapist_id_foreign` (`therapist_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `therapist_availabilities`
--
ALTER TABLE `therapist_availabilities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `therapist_availabilities_user_id_foreign` (`user_id`);

--
-- Indexes for table `therapist_profiles`
--
ALTER TABLE `therapist_profiles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `therapist_profiles_user_id_unique` (`user_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transactions_appointment_id_foreign` (`appointment_id`),
  ADD KEY `transactions_user_id_foreign` (`user_id`),
  ADD KEY `transactions_payment_gateway_id_index` (`payment_gateway_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=147;

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `availabilities`
--
ALTER TABLE `availabilities`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chat_messages`
--
ALTER TABLE `chat_messages`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `therapist_availabilities`
--
ALTER TABLE `therapist_availabilities`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `therapist_profiles`
--
ALTER TABLE `therapist_profiles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `activity_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_availability_id_foreign` FOREIGN KEY (`availability_id`) REFERENCES `availabilities` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `appointments_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `appointments_therapist_id_foreign` FOREIGN KEY (`therapist_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `availabilities`
--
ALTER TABLE `availabilities`
  ADD CONSTRAINT `availabilities_therapist_id_foreign` FOREIGN KEY (`therapist_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `chat_messages`
--
ALTER TABLE `chat_messages`
  ADD CONSTRAINT `chat_messages_appointment_id_foreign` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `chat_messages_receiver_id_foreign` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `chat_messages_sender_id_foreign` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_appointment_id_foreign` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_therapist_id_foreign` FOREIGN KEY (`therapist_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `therapist_availabilities`
--
ALTER TABLE `therapist_availabilities`
  ADD CONSTRAINT `therapist_availabilities_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `therapist_profiles`
--
ALTER TABLE `therapist_profiles`
  ADD CONSTRAINT `therapist_profiles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_appointment_id_foreign` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transactions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
