-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 07, 2025 at 06:02 AM
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
(151, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 22:09:03', '2025-10-12 22:09:03'),
(152, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 22:09:12', '2025-10-12 22:09:12'),
(153, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 22:09:12', '2025-10-12 22:09:12'),
(154, 12, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 22:10:17', '2025-10-12 22:10:17'),
(155, 12, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 22:10:25', '2025-10-12 22:10:25'),
(156, 12, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 22:10:25', '2025-10-12 22:10:25'),
(157, 13, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 22:11:03', '2025-10-12 22:11:03'),
(158, 13, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 22:11:10', '2025-10-12 22:11:10'),
(159, 13, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 22:11:10', '2025-10-12 22:11:10'),
(160, 14, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 22:11:43', '2025-10-12 22:11:43'),
(161, 14, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 22:12:01', '2025-10-12 22:12:01'),
(162, 14, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 22:12:01', '2025-10-12 22:12:01'),
(163, 14, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 22:14:47', '2025-10-12 22:14:47'),
(164, 14, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 22:14:47', '2025-10-12 22:14:47'),
(165, 14, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 22:29:22', '2025-10-12 22:29:22'),
(166, 14, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 22:29:22', '2025-10-12 22:29:22'),
(167, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 22:49:04', '2025-10-12 22:49:04'),
(168, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 22:49:15', '2025-10-12 22:49:15'),
(169, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 22:49:15', '2025-10-12 22:49:15'),
(170, 16, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 22:54:43', '2025-10-12 22:54:43'),
(171, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 22:54:52', '2025-10-12 22:54:52'),
(172, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 22:54:52', '2025-10-12 22:54:52'),
(173, 16, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 22:55:22', '2025-10-12 22:55:22'),
(174, 16, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 22:55:22', '2025-10-12 22:55:22'),
(175, 17, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 23:05:47', '2025-10-12 23:05:47'),
(176, 17, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 23:06:01', '2025-10-12 23:06:01'),
(177, 17, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 23:06:01', '2025-10-12 23:06:01'),
(178, 17, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 23:06:23', '2025-10-12 23:06:23'),
(179, 17, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 23:06:23', '2025-10-12 23:06:23'),
(180, 14, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 23:09:25', '2025-10-12 23:09:25'),
(181, 14, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 23:09:25', '2025-10-12 23:09:25'),
(182, 13, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 23:31:11', '2025-10-12 23:31:11'),
(183, 13, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-12 23:31:11', '2025-10-12 23:31:11'),
(184, 13, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-13 00:02:03', '2025-10-13 00:02:03'),
(185, 13, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-13 00:02:03', '2025-10-13 00:02:03'),
(186, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-13 00:14:21', '2025-10-13 00:14:21'),
(187, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-13 00:14:21', '2025-10-13 00:14:21'),
(188, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-13 00:27:20', '2025-10-13 00:27:20'),
(189, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-13 00:27:20', '2025-10-13 00:27:20'),
(190, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-13 00:32:41', '2025-10-13 00:32:41'),
(191, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-13 00:32:41', '2025-10-13 00:32:41'),
(192, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-13 01:02:48', '2025-10-13 01:02:48'),
(193, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-13 01:02:48', '2025-10-13 01:02:48'),
(194, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 06:42:16', '2025-10-14 06:42:16'),
(195, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 06:42:16', '2025-10-14 06:42:16'),
(196, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 06:43:04', '2025-10-14 06:43:04'),
(197, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 06:43:04', '2025-10-14 06:43:04'),
(198, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 06:43:15', '2025-10-14 06:43:15'),
(199, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 06:43:15', '2025-10-14 06:43:15'),
(200, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 07:07:03', '2025-10-14 07:07:03'),
(201, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 07:07:03', '2025-10-14 07:07:03'),
(202, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 07:07:43', '2025-10-14 07:07:43'),
(203, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 07:07:43', '2025-10-14 07:07:43'),
(204, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 07:24:47', '2025-10-14 07:24:47'),
(205, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 07:24:47', '2025-10-14 07:24:47'),
(206, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 08:19:33', '2025-10-14 08:19:33'),
(207, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 08:19:33', '2025-10-14 08:19:33'),
(208, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 08:28:20', '2025-10-14 08:28:20'),
(209, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 08:28:20', '2025-10-14 08:28:20'),
(210, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 08:30:07', '2025-10-14 08:30:07'),
(211, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 08:30:07', '2025-10-14 08:30:07'),
(212, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 08:44:05', '2025-10-14 08:44:05'),
(213, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 08:44:05', '2025-10-14 08:44:05'),
(214, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 08:44:11', '2025-10-14 08:44:11'),
(215, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 08:44:11', '2025-10-14 08:44:11'),
(216, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 08:44:19', '2025-10-14 08:44:19'),
(217, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 08:44:19', '2025-10-14 08:44:19'),
(218, 14, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 08:44:45', '2025-10-14 08:44:45'),
(219, 14, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 08:44:45', '2025-10-14 08:44:45'),
(220, 14, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 08:44:58', '2025-10-14 08:44:58'),
(221, 14, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 08:44:58', '2025-10-14 08:44:58'),
(222, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 08:45:17', '2025-10-14 08:45:17'),
(223, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 08:45:17', '2025-10-14 08:45:17'),
(224, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 08:49:23', '2025-10-14 08:49:23'),
(225, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 08:49:23', '2025-10-14 08:49:23'),
(226, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 08:50:14', '2025-10-14 08:50:14'),
(227, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 08:50:14', '2025-10-14 08:50:14'),
(228, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 08:55:14', '2025-10-14 08:55:14'),
(229, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 08:55:14', '2025-10-14 08:55:14'),
(230, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 09:01:52', '2025-10-14 09:01:52'),
(231, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 09:01:52', '2025-10-14 09:01:52'),
(232, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 09:02:44', '2025-10-14 09:02:44'),
(233, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 09:02:44', '2025-10-14 09:02:44'),
(234, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 09:16:30', '2025-10-14 09:16:30'),
(235, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 09:16:30', '2025-10-14 09:16:30'),
(236, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 09:17:31', '2025-10-14 09:17:31'),
(237, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 09:17:31', '2025-10-14 09:17:31'),
(238, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 09:24:59', '2025-10-14 09:24:59'),
(239, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 09:24:59', '2025-10-14 09:24:59'),
(240, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 09:33:45', '2025-10-14 09:33:45'),
(241, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 09:33:45', '2025-10-14 09:33:45'),
(242, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 09:46:47', '2025-10-14 09:46:47'),
(243, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 09:46:47', '2025-10-14 09:46:47'),
(244, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 09:52:16', '2025-10-14 09:52:16'),
(245, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 09:52:16', '2025-10-14 09:52:16'),
(246, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 09:53:29', '2025-10-14 09:53:29'),
(247, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 09:53:29', '2025-10-14 09:53:29'),
(248, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 10:09:30', '2025-10-14 10:09:30'),
(249, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 10:09:30', '2025-10-14 10:09:30'),
(250, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 10:14:00', '2025-10-14 10:14:00'),
(251, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 10:14:00', '2025-10-14 10:14:00'),
(252, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 10:16:26', '2025-10-14 10:16:26'),
(253, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 10:16:26', '2025-10-14 10:16:26'),
(254, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 10:34:54', '2025-10-14 10:34:54'),
(255, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 10:34:54', '2025-10-14 10:34:54'),
(256, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 10:42:39', '2025-10-14 10:42:39'),
(257, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 10:42:39', '2025-10-14 10:42:39'),
(258, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 10:43:24', '2025-10-14 10:43:24'),
(259, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 10:43:24', '2025-10-14 10:43:24'),
(260, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 10:48:48', '2025-10-14 10:48:48'),
(261, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 10:48:48', '2025-10-14 10:48:48'),
(262, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 10:57:25', '2025-10-14 10:57:25'),
(263, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 10:57:25', '2025-10-14 10:57:25'),
(264, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 11:02:37', '2025-10-14 11:02:37'),
(265, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 11:02:37', '2025-10-14 11:02:37'),
(266, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 11:11:24', '2025-10-14 11:11:24'),
(267, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 11:11:24', '2025-10-14 11:11:24'),
(268, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 11:11:44', '2025-10-14 11:11:44'),
(269, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 11:11:44', '2025-10-14 11:11:44'),
(270, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 11:12:42', '2025-10-14 11:12:42'),
(271, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 11:12:42', '2025-10-14 11:12:42'),
(272, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 11:13:02', '2025-10-14 11:13:02'),
(273, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 11:13:02', '2025-10-14 11:13:02'),
(274, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 11:19:26', '2025-10-14 11:19:26'),
(275, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 11:19:26', '2025-10-14 11:19:26'),
(276, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 11:25:15', '2025-10-14 11:25:15'),
(277, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 11:25:15', '2025-10-14 11:25:15'),
(278, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 11:27:14', '2025-10-14 11:27:14'),
(279, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 11:27:14', '2025-10-14 11:27:14'),
(280, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 18:47:15', '2025-10-14 18:47:15'),
(281, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 18:47:15', '2025-10-14 18:47:15'),
(282, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 19:52:35', '2025-10-14 19:52:35'),
(283, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 19:52:35', '2025-10-14 19:52:35'),
(284, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 20:04:54', '2025-10-14 20:04:54'),
(285, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 20:04:54', '2025-10-14 20:04:54'),
(286, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 20:10:46', '2025-10-14 20:10:46'),
(287, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 20:10:46', '2025-10-14 20:10:46'),
(288, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 20:13:34', '2025-10-14 20:13:34'),
(289, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 20:13:34', '2025-10-14 20:13:34'),
(290, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 20:35:49', '2025-10-14 20:35:49'),
(291, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 20:35:49', '2025-10-14 20:35:49'),
(292, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 20:48:04', '2025-10-14 20:48:04'),
(293, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 20:48:04', '2025-10-14 20:48:04'),
(294, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 20:53:28', '2025-10-14 20:53:28'),
(295, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 20:53:28', '2025-10-14 20:53:28'),
(296, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 21:14:07', '2025-10-14 21:14:07'),
(297, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 21:14:07', '2025-10-14 21:14:07'),
(298, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 21:18:56', '2025-10-14 21:18:56'),
(299, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 21:18:56', '2025-10-14 21:18:56'),
(300, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 21:19:25', '2025-10-14 21:19:25'),
(301, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 21:19:25', '2025-10-14 21:19:25'),
(302, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 21:31:35', '2025-10-14 21:31:35'),
(303, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 21:31:35', '2025-10-14 21:31:35'),
(304, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 21:35:17', '2025-10-14 21:35:17'),
(305, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 21:35:17', '2025-10-14 21:35:17'),
(306, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 21:47:35', '2025-10-14 21:47:35'),
(307, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 21:47:35', '2025-10-14 21:47:35'),
(308, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 21:53:24', '2025-10-14 21:53:24'),
(309, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 21:53:24', '2025-10-14 21:53:24'),
(310, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 21:58:59', '2025-10-14 21:58:59'),
(311, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 21:58:59', '2025-10-14 21:58:59'),
(312, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 22:12:58', '2025-10-14 22:12:58'),
(313, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 22:12:58', '2025-10-14 22:12:58'),
(314, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-15 01:31:37', '2025-10-15 01:31:37'),
(315, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-15 01:31:37', '2025-10-15 01:31:37'),
(316, 14, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-15 01:34:09', '2025-10-15 01:34:09'),
(317, 14, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-15 01:34:09', '2025-10-15 01:34:09'),
(321, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-15 01:56:18', '2025-10-15 01:56:18'),
(322, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-15 01:56:18', '2025-10-15 01:56:18'),
(323, 19, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-15 02:02:01', '2025-10-15 02:02:01'),
(324, 19, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-15 02:02:18', '2025-10-15 02:02:18'),
(325, 19, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-15 02:02:18', '2025-10-15 02:02:18'),
(326, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-15 02:07:45', '2025-10-15 02:07:45'),
(327, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-15 02:07:45', '2025-10-15 02:07:45'),
(328, 19, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-15 02:08:25', '2025-10-15 02:08:25'),
(329, 19, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-15 02:08:25', '2025-10-15 02:08:25'),
(330, 14, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-15 02:10:58', '2025-10-15 02:10:58'),
(331, 14, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-15 02:10:58', '2025-10-15 02:10:58'),
(332, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-15 21:27:37', '2025-10-15 21:27:37'),
(333, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-15 21:27:37', '2025-10-15 21:27:37'),
(334, 14, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-15 21:39:25', '2025-10-15 21:39:25'),
(335, 14, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-15 21:39:25', '2025-10-15 21:39:25'),
(336, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-15 22:28:39', '2025-10-15 22:28:39'),
(337, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-15 22:28:39', '2025-10-15 22:28:39'),
(338, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-15 22:30:01', '2025-10-15 22:30:01'),
(339, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-15 22:30:01', '2025-10-15 22:30:01'),
(340, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-15 22:44:07', '2025-10-15 22:44:07'),
(341, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-15 22:44:07', '2025-10-15 22:44:07'),
(342, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-15 23:01:12', '2025-10-15 23:01:12'),
(343, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-15 23:01:12', '2025-10-15 23:01:12'),
(344, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-15 23:03:06', '2025-10-15 23:03:06'),
(345, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-15 23:03:06', '2025-10-15 23:03:06'),
(346, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-15 23:17:00', '2025-10-15 23:17:00'),
(347, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-15 23:17:00', '2025-10-15 23:17:00'),
(348, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-15 23:45:26', '2025-10-15 23:45:26'),
(349, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-15 23:45:26', '2025-10-15 23:45:26'),
(350, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-16 01:29:14', '2025-10-16 01:29:14'),
(351, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-16 01:29:14', '2025-10-16 01:29:14'),
(352, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-16 01:34:28', '2025-10-16 01:34:28'),
(353, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-16 01:34:28', '2025-10-16 01:34:28'),
(354, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 06:40:00', '2025-10-17 06:40:00'),
(355, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 06:40:00', '2025-10-17 06:40:00'),
(356, 15, 'login', '127.0.0.1', 'PostmanRuntime/7.47.1', '2025-10-17 07:04:13', '2025-10-17 07:04:13'),
(357, 15, 'login', '127.0.0.1', 'PostmanRuntime/7.47.1', '2025-10-17 07:04:13', '2025-10-17 07:04:13'),
(358, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 07:20:39', '2025-10-17 07:20:39'),
(359, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 07:20:39', '2025-10-17 07:20:39'),
(360, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 07:29:26', '2025-10-17 07:29:26'),
(361, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 07:29:26', '2025-10-17 07:29:26'),
(362, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 07:30:13', '2025-10-17 07:30:13'),
(363, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 07:30:13', '2025-10-17 07:30:13'),
(364, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 07:36:42', '2025-10-17 07:36:42'),
(365, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 07:36:42', '2025-10-17 07:36:42'),
(366, 15, 'login', '127.0.0.1', 'PostmanRuntime/7.47.1', '2025-10-17 07:40:14', '2025-10-17 07:40:14'),
(367, 15, 'login', '127.0.0.1', 'PostmanRuntime/7.47.1', '2025-10-17 07:40:14', '2025-10-17 07:40:14'),
(368, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 07:47:44', '2025-10-17 07:47:44'),
(369, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 07:47:44', '2025-10-17 07:47:44'),
(370, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 07:52:49', '2025-10-17 07:52:49'),
(371, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 07:52:49', '2025-10-17 07:52:49'),
(372, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 08:02:29', '2025-10-17 08:02:29'),
(373, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 08:02:29', '2025-10-17 08:02:29'),
(374, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 08:05:17', '2025-10-17 08:05:17'),
(375, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 08:05:17', '2025-10-17 08:05:17'),
(376, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 08:26:29', '2025-10-17 08:26:29'),
(377, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 08:26:29', '2025-10-17 08:26:29'),
(378, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 08:37:04', '2025-10-17 08:37:04'),
(379, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 08:37:04', '2025-10-17 08:37:04'),
(380, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 09:26:32', '2025-10-17 09:26:32'),
(381, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 09:26:32', '2025-10-17 09:26:32'),
(382, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 09:27:16', '2025-10-17 09:27:16'),
(383, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 09:27:16', '2025-10-17 09:27:16'),
(384, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 09:39:25', '2025-10-17 09:39:25'),
(385, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 09:39:25', '2025-10-17 09:39:25'),
(386, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 09:40:27', '2025-10-17 09:40:27'),
(387, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 09:40:27', '2025-10-17 09:40:27'),
(388, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 09:45:40', '2025-10-17 09:45:40'),
(389, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 09:45:40', '2025-10-17 09:45:40'),
(390, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 09:46:14', '2025-10-17 09:46:14'),
(391, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 09:46:14', '2025-10-17 09:46:14'),
(392, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 09:57:55', '2025-10-17 09:57:55'),
(393, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 09:57:55', '2025-10-17 09:57:55'),
(394, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 10:10:59', '2025-10-17 10:10:59'),
(395, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 10:10:59', '2025-10-17 10:10:59'),
(396, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 10:12:52', '2025-10-17 10:12:52'),
(397, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 10:12:52', '2025-10-17 10:12:52'),
(398, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 10:24:44', '2025-10-17 10:24:44'),
(399, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 10:24:44', '2025-10-17 10:24:44'),
(400, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 10:32:04', '2025-10-17 10:32:04'),
(401, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 10:32:04', '2025-10-17 10:32:04'),
(402, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 10:32:33', '2025-10-17 10:32:33'),
(403, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 10:32:33', '2025-10-17 10:32:33'),
(404, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 10:34:12', '2025-10-17 10:34:12'),
(405, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 10:34:12', '2025-10-17 10:34:12'),
(406, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 10:34:42', '2025-10-17 10:34:42'),
(407, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 10:34:42', '2025-10-17 10:34:42'),
(408, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 10:51:45', '2025-10-17 10:51:45'),
(409, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 10:51:45', '2025-10-17 10:51:45'),
(410, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 11:02:44', '2025-10-17 11:02:44'),
(411, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 11:02:44', '2025-10-17 11:02:44'),
(412, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 11:05:20', '2025-10-17 11:05:20'),
(413, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 11:05:20', '2025-10-17 11:05:20'),
(414, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 11:05:46', '2025-10-17 11:05:46'),
(415, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 11:05:46', '2025-10-17 11:05:46'),
(416, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 11:06:53', '2025-10-17 11:06:53'),
(417, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 11:06:53', '2025-10-17 11:06:53'),
(418, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 11:12:03', '2025-10-17 11:12:03'),
(419, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 11:12:03', '2025-10-17 11:12:03'),
(420, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 11:16:12', '2025-10-17 11:16:12'),
(421, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 11:16:12', '2025-10-17 11:16:12');
INSERT INTO `activity_logs` (`id`, `user_id`, `activity_type`, `ip_address`, `user_agent`, `created_at`, `updated_at`) VALUES
(422, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 11:17:32', '2025-10-17 11:17:32'),
(423, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 11:17:32', '2025-10-17 11:17:32'),
(424, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 11:17:54', '2025-10-17 11:17:54'),
(425, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 11:17:54', '2025-10-17 11:17:54'),
(426, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 11:28:42', '2025-10-17 11:28:42'),
(427, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 11:28:42', '2025-10-17 11:28:42'),
(428, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 11:29:33', '2025-10-17 11:29:33'),
(429, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 11:29:33', '2025-10-17 11:29:33'),
(430, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 11:33:38', '2025-10-17 11:33:38'),
(431, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 11:33:38', '2025-10-17 11:33:38'),
(432, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 11:35:54', '2025-10-17 11:35:54'),
(433, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 11:35:54', '2025-10-17 11:35:54'),
(434, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 19:25:17', '2025-10-17 19:25:17'),
(435, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 19:25:17', '2025-10-17 19:25:17'),
(436, 15, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 19:29:19', '2025-10-17 19:29:19'),
(437, 15, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 19:29:19', '2025-10-17 19:29:19'),
(438, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 19:46:14', '2025-10-17 19:46:14'),
(439, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 19:46:14', '2025-10-17 19:46:14'),
(440, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 19:49:06', '2025-10-17 19:49:06'),
(441, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 19:49:06', '2025-10-17 19:49:06'),
(442, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 19:53:58', '2025-10-17 19:53:58'),
(443, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 19:53:58', '2025-10-17 19:53:58'),
(444, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 20:07:05', '2025-10-17 20:07:05'),
(445, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 20:07:05', '2025-10-17 20:07:05'),
(446, 15, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 20:08:42', '2025-10-17 20:08:42'),
(447, 15, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 20:08:42', '2025-10-17 20:08:42'),
(448, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 20:09:10', '2025-10-17 20:09:10'),
(449, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 20:09:10', '2025-10-17 20:09:10'),
(450, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 20:14:03', '2025-10-17 20:14:03'),
(451, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 20:14:03', '2025-10-17 20:14:03'),
(452, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 22:22:44', '2025-10-17 22:22:44'),
(453, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 22:22:44', '2025-10-17 22:22:44'),
(454, 15, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 22:25:10', '2025-10-17 22:25:10'),
(455, 15, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 22:25:10', '2025-10-17 22:25:10'),
(456, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 22:26:01', '2025-10-17 22:26:01'),
(457, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 22:26:01', '2025-10-17 22:26:01'),
(458, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 22:26:31', '2025-10-17 22:26:31'),
(459, 15, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 22:26:32', '2025-10-17 22:26:32'),
(460, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 22:50:17', '2025-10-17 22:50:17'),
(461, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 22:50:17', '2025-10-17 22:50:17'),
(462, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 22:56:45', '2025-10-17 22:56:45'),
(463, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 22:56:45', '2025-10-17 22:56:45'),
(464, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 23:04:43', '2025-10-17 23:04:43'),
(465, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 23:04:43', '2025-10-17 23:04:43'),
(466, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 23:18:08', '2025-10-17 23:18:08'),
(467, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 23:18:08', '2025-10-17 23:18:08'),
(468, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 23:18:53', '2025-10-17 23:18:53'),
(469, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 23:18:53', '2025-10-17 23:18:53'),
(470, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 23:18:58', '2025-10-17 23:18:58'),
(471, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 23:18:58', '2025-10-17 23:18:58'),
(472, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 23:19:05', '2025-10-17 23:19:05'),
(473, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 23:19:05', '2025-10-17 23:19:05'),
(474, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 23:19:48', '2025-10-17 23:19:48'),
(475, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-17 23:19:48', '2025-10-17 23:19:48'),
(476, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 23:22:13', '2025-10-17 23:22:13'),
(477, 11, 'login', '127.0.0.1', 'Dart/3.9 (dart:io)', '2025-10-17 23:22:13', '2025-10-17 23:22:13'),
(478, 11, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-17 23:35:47', '2025-10-17 23:35:47'),
(479, 11, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-17 23:35:47', '2025-10-17 23:35:47'),
(480, 11, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-17 23:48:50', '2025-10-17 23:48:50'),
(481, 11, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-17 23:48:50', '2025-10-17 23:48:50'),
(482, 11, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 02:35:53', '2025-10-18 02:35:53'),
(483, 11, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 02:35:53', '2025-10-18 02:35:53'),
(484, 11, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 02:52:29', '2025-10-18 02:52:29'),
(485, 11, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 02:52:29', '2025-10-18 02:52:29'),
(486, 11, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 02:52:44', '2025-10-18 02:52:44'),
(487, 11, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 02:52:44', '2025-10-18 02:52:44'),
(488, 11, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 02:57:30', '2025-10-18 02:57:30'),
(489, 11, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 02:57:30', '2025-10-18 02:57:30'),
(490, 11, 'login', '192.168.100.7', 'Dart/3.9 (dart:io)', '2025-10-18 03:00:42', '2025-10-18 03:00:42'),
(491, 11, 'login', '192.168.100.7', 'Dart/3.9 (dart:io)', '2025-10-18 03:00:42', '2025-10-18 03:00:42'),
(492, 11, 'login', '192.168.100.7', 'Dart/3.9 (dart:io)', '2025-10-18 03:05:00', '2025-10-18 03:05:00'),
(493, 11, 'login', '192.168.100.7', 'Dart/3.9 (dart:io)', '2025-10-18 03:05:00', '2025-10-18 03:05:00'),
(494, 11, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 03:06:10', '2025-10-18 03:06:10'),
(495, 11, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 03:06:10', '2025-10-18 03:06:10'),
(496, 11, 'login', '192.168.100.7', 'Dart/3.9 (dart:io)', '2025-10-18 03:06:23', '2025-10-18 03:06:23'),
(497, 11, 'login', '192.168.100.7', 'Dart/3.9 (dart:io)', '2025-10-18 03:06:23', '2025-10-18 03:06:23'),
(498, 11, 'login', '192.168.100.7', 'Dart/3.9 (dart:io)', '2025-10-18 03:08:01', '2025-10-18 03:08:01'),
(499, 11, 'login', '192.168.100.7', 'Dart/3.9 (dart:io)', '2025-10-18 03:08:01', '2025-10-18 03:08:01'),
(500, 11, 'login', '192.168.100.7', 'Dart/3.9 (dart:io)', '2025-10-18 03:18:49', '2025-10-18 03:18:49'),
(501, 11, 'login', '192.168.100.7', 'Dart/3.9 (dart:io)', '2025-10-18 03:18:49', '2025-10-18 03:18:49'),
(502, 15, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 03:20:12', '2025-10-18 03:20:12'),
(503, 15, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 03:20:12', '2025-10-18 03:20:12'),
(504, 11, 'login', '192.168.100.7', 'Dart/3.9 (dart:io)', '2025-10-18 03:22:20', '2025-10-18 03:22:20'),
(505, 11, 'login', '192.168.100.7', 'Dart/3.9 (dart:io)', '2025-10-18 03:22:20', '2025-10-18 03:22:20'),
(506, 11, 'login', '192.168.100.7', 'Dart/3.9 (dart:io)', '2025-10-18 03:30:49', '2025-10-18 03:30:49'),
(507, 11, 'login', '192.168.100.7', 'Dart/3.9 (dart:io)', '2025-10-18 03:30:49', '2025-10-18 03:30:49'),
(508, 15, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 03:31:04', '2025-10-18 03:31:04'),
(509, 15, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 03:31:04', '2025-10-18 03:31:04'),
(510, 11, 'login', '192.168.100.7', 'Dart/3.9 (dart:io)', '2025-10-18 03:34:55', '2025-10-18 03:34:55'),
(511, 11, 'login', '192.168.100.7', 'Dart/3.9 (dart:io)', '2025-10-18 03:34:55', '2025-10-18 03:34:55'),
(512, 11, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 03:38:26', '2025-10-18 03:38:26'),
(513, 11, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 03:38:26', '2025-10-18 03:38:26'),
(514, 15, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 03:38:35', '2025-10-18 03:38:35'),
(515, 15, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 03:38:35', '2025-10-18 03:38:35'),
(516, 15, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 03:42:03', '2025-10-18 03:42:03'),
(517, 15, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 03:42:03', '2025-10-18 03:42:03'),
(518, 15, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 04:16:37', '2025-10-18 04:16:37'),
(519, 15, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 04:16:37', '2025-10-18 04:16:37'),
(520, 15, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 04:17:43', '2025-10-18 04:17:43'),
(521, 15, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 04:17:43', '2025-10-18 04:17:43'),
(522, 15, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 04:18:48', '2025-10-18 04:18:48'),
(523, 15, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 04:18:48', '2025-10-18 04:18:48'),
(524, 15, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 04:23:03', '2025-10-18 04:23:03'),
(525, 15, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 04:23:03', '2025-10-18 04:23:03'),
(526, 15, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 04:23:56', '2025-10-18 04:23:56'),
(527, 15, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 04:23:56', '2025-10-18 04:23:56'),
(528, 15, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 04:37:09', '2025-10-18 04:37:09'),
(529, 15, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 04:37:09', '2025-10-18 04:37:09'),
(530, 15, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 04:41:10', '2025-10-18 04:41:10'),
(531, 15, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 04:41:10', '2025-10-18 04:41:10'),
(532, 15, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 04:44:32', '2025-10-18 04:44:32'),
(533, 15, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 04:44:32', '2025-10-18 04:44:32'),
(534, 20, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 04:46:00', '2025-10-18 04:46:00'),
(535, 20, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 04:46:07', '2025-10-18 04:46:07'),
(536, 20, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 04:46:07', '2025-10-18 04:46:07'),
(537, 20, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 04:57:36', '2025-10-18 04:57:36'),
(538, 20, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 04:57:36', '2025-10-18 04:57:36'),
(539, 20, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 04:59:20', '2025-10-18 04:59:20'),
(540, 20, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 04:59:20', '2025-10-18 04:59:20'),
(541, 20, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 05:00:58', '2025-10-18 05:00:58'),
(542, 20, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 05:00:58', '2025-10-18 05:00:58'),
(543, 20, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 05:10:32', '2025-10-18 05:10:32'),
(544, 20, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 05:10:32', '2025-10-18 05:10:32'),
(545, 20, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 05:10:53', '2025-10-18 05:10:53'),
(546, 20, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-18 05:10:53', '2025-10-18 05:10:53'),
(547, 15, 'login', '127.0.0.1', 'PostmanRuntime/7.49.0', '2025-10-19 00:51:55', '2025-10-19 00:51:55'),
(548, 15, 'login', '127.0.0.1', 'PostmanRuntime/7.49.0', '2025-10-19 00:51:55', '2025-10-19 00:51:55'),
(549, 20, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-19 04:53:15', '2025-10-19 04:53:15'),
(550, 20, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-19 04:53:15', '2025-10-19 04:53:15'),
(551, 20, 'login', '10.143.133.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-19 18:35:59', '2025-10-19 18:35:59'),
(552, 20, 'login', '10.143.133.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-19 18:35:59', '2025-10-19 18:35:59'),
(553, 20, 'login', '10.143.133.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-19 18:46:47', '2025-10-19 18:46:47'),
(554, 20, 'login', '10.143.133.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-19 18:46:47', '2025-10-19 18:46:47'),
(555, 20, 'login', '10.143.133.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-19 18:55:06', '2025-10-19 18:55:06'),
(556, 20, 'login', '10.143.133.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-19 18:55:06', '2025-10-19 18:55:06'),
(557, 20, 'login', '10.143.133.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-19 18:59:27', '2025-10-19 18:59:27'),
(558, 20, 'login', '10.143.133.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-19 18:59:27', '2025-10-19 18:59:27'),
(559, 20, 'login', '10.143.133.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-19 19:03:59', '2025-10-19 19:03:59'),
(560, 20, 'login', '10.143.133.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-19 19:03:59', '2025-10-19 19:03:59'),
(561, 20, 'login', '10.143.133.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-19 19:24:00', '2025-10-19 19:24:00'),
(562, 20, 'login', '10.143.133.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-19 19:24:00', '2025-10-19 19:24:00'),
(563, 20, 'login', '10.143.133.214', 'Dart/3.9 (dart:io)', '2025-10-19 19:55:58', '2025-10-19 19:55:58'),
(564, 20, 'login', '10.143.133.214', 'Dart/3.9 (dart:io)', '2025-10-19 19:55:58', '2025-10-19 19:55:58'),
(565, 20, 'login', '10.143.133.214', 'Dart/3.9 (dart:io)', '2025-10-19 19:56:00', '2025-10-19 19:56:00'),
(566, 20, 'login', '10.143.133.214', 'Dart/3.9 (dart:io)', '2025-10-19 19:56:00', '2025-10-19 19:56:00'),
(567, 20, 'login', '10.143.133.214', 'Dart/3.9 (dart:io)', '2025-10-19 19:56:28', '2025-10-19 19:56:28'),
(568, 20, 'login', '10.143.133.214', 'Dart/3.9 (dart:io)', '2025-10-19 19:56:28', '2025-10-19 19:56:28'),
(569, 20, 'login', '10.143.133.214', 'Dart/3.9 (dart:io)', '2025-10-19 19:56:32', '2025-10-19 19:56:32'),
(570, 20, 'login', '10.143.133.214', 'Dart/3.9 (dart:io)', '2025-10-19 19:56:32', '2025-10-19 19:56:32'),
(571, 15, 'login', '10.143.133.214', 'Dart/3.9 (dart:io)', '2025-10-19 20:07:49', '2025-10-19 20:07:49'),
(572, 15, 'login', '10.143.133.214', 'Dart/3.9 (dart:io)', '2025-10-19 20:07:49', '2025-10-19 20:07:49'),
(573, 20, 'login', '10.143.133.214', 'Dart/3.9 (dart:io)', '2025-10-19 20:09:28', '2025-10-19 20:09:28'),
(574, 20, 'login', '10.143.133.214', 'Dart/3.9 (dart:io)', '2025-10-19 20:09:28', '2025-10-19 20:09:28'),
(575, 11, 'login', '10.143.133.25', 'Dart/3.9 (dart:io)', '2025-10-19 20:10:18', '2025-10-19 20:10:18'),
(576, 11, 'login', '10.143.133.25', 'Dart/3.9 (dart:io)', '2025-10-19 20:10:18', '2025-10-19 20:10:18'),
(577, 11, 'login', '10.143.133.25', 'Dart/3.9 (dart:io)', '2025-10-19 20:10:34', '2025-10-19 20:10:34'),
(578, 11, 'login', '10.143.133.25', 'Dart/3.9 (dart:io)', '2025-10-19 20:10:34', '2025-10-19 20:10:34'),
(579, 15, 'login', '10.143.133.214', 'Dart/3.9 (dart:io)', '2025-10-19 20:12:53', '2025-10-19 20:12:53'),
(580, 15, 'login', '10.143.133.214', 'Dart/3.9 (dart:io)', '2025-10-19 20:12:53', '2025-10-19 20:12:53'),
(581, 15, 'login', '10.143.133.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-19 20:27:13', '2025-10-19 20:27:13'),
(582, 15, 'login', '10.143.133.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-19 20:27:13', '2025-10-19 20:27:13'),
(583, 11, 'login', '10.143.133.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-19 20:41:50', '2025-10-19 20:41:50'),
(584, 11, 'login', '10.143.133.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-19 20:41:50', '2025-10-19 20:41:50'),
(585, 11, 'login', '10.143.133.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-19 20:48:29', '2025-10-19 20:48:29'),
(586, 11, 'login', '10.143.133.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-19 20:48:29', '2025-10-19 20:48:29'),
(587, 20, 'login', '10.143.133.25', 'Dart/3.9 (dart:io)', '2025-10-19 20:55:42', '2025-10-19 20:55:42'),
(588, 20, 'login', '10.143.133.25', 'Dart/3.9 (dart:io)', '2025-10-19 20:55:42', '2025-10-19 20:55:42'),
(589, 11, 'login', '10.143.133.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-19 21:00:09', '2025-10-19 21:00:09'),
(590, 11, 'login', '10.143.133.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-19 21:00:09', '2025-10-19 21:00:09'),
(591, 11, 'login', '10.178.156.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-19 21:33:05', '2025-10-19 21:33:05'),
(592, 11, 'login', '10.178.156.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-19 21:33:05', '2025-10-19 21:33:05'),
(593, 11, 'login', '10.178.156.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-19 22:24:01', '2025-10-19 22:24:01'),
(594, 11, 'login', '10.178.156.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-19 22:24:01', '2025-10-19 22:24:01'),
(595, 11, 'login', '10.178.156.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-21 16:57:15', '2025-10-21 16:57:15'),
(596, 11, 'login', '10.178.156.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-21 16:57:15', '2025-10-21 16:57:15'),
(597, 15, 'login', '10.178.156.214', 'Dart/3.9 (dart:io)', '2025-10-21 17:00:24', '2025-10-21 17:00:24'),
(598, 15, 'login', '10.178.156.214', 'Dart/3.9 (dart:io)', '2025-10-21 17:00:24', '2025-10-21 17:00:24'),
(599, 13, 'login', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', '2025-10-21 18:29:18', '2025-10-21 18:29:18'),
(600, 13, 'login', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', '2025-10-21 18:29:18', '2025-10-21 18:29:18'),
(601, 20, 'login', '10.178.156.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-21 18:44:52', '2025-10-21 18:44:52'),
(602, 20, 'login', '10.178.156.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-21 18:44:52', '2025-10-21 18:44:52'),
(603, 11, 'login', '10.178.156.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 00:11:00', '2025-10-22 00:11:00'),
(604, 11, 'login', '10.178.156.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 00:11:00', '2025-10-22 00:11:00'),
(605, 11, 'login', '10.178.156.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 00:11:25', '2025-10-22 00:11:25'),
(606, 11, 'login', '10.178.156.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 00:11:25', '2025-10-22 00:11:25'),
(607, 20, 'login', '10.178.156.214', 'Dart/3.9 (dart:io)', '2025-10-22 00:17:29', '2025-10-22 00:17:29'),
(608, 20, 'login', '10.178.156.214', 'Dart/3.9 (dart:io)', '2025-10-22 00:17:29', '2025-10-22 00:17:29'),
(609, 13, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 00:40:26', '2025-10-22 00:40:26'),
(610, 13, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 00:40:26', '2025-10-22 00:40:26'),
(611, 13, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 00:42:09', '2025-10-22 00:42:09'),
(612, 13, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 00:42:09', '2025-10-22 00:42:09'),
(613, 13, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 00:44:05', '2025-10-22 00:44:05'),
(614, 13, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 00:44:05', '2025-10-22 00:44:05'),
(615, 13, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 00:49:18', '2025-10-22 00:49:18'),
(616, 13, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 00:49:18', '2025-10-22 00:49:18'),
(617, 14, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 00:55:34', '2025-10-22 00:55:34'),
(618, 14, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 00:55:34', '2025-10-22 00:55:34'),
(619, 21, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 00:56:59', '2025-10-22 00:56:59'),
(620, 21, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 00:58:05', '2025-10-22 00:58:05'),
(621, 21, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 00:58:05', '2025-10-22 00:58:05'),
(622, 21, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 00:58:13', '2025-10-22 00:58:13'),
(623, 21, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 00:58:13', '2025-10-22 00:58:13'),
(624, 22, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 00:59:29', '2025-10-22 00:59:29'),
(625, 22, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 00:59:36', '2025-10-22 00:59:36'),
(626, 22, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 00:59:36', '2025-10-22 00:59:36'),
(627, 22, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 01:04:03', '2025-10-22 01:04:03'),
(628, 22, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 01:04:03', '2025-10-22 01:04:03'),
(629, 22, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 01:04:30', '2025-10-22 01:04:30'),
(630, 22, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 01:04:30', '2025-10-22 01:04:30'),
(631, 13, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 01:09:32', '2025-10-22 01:09:32'),
(632, 13, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 01:09:32', '2025-10-22 01:09:32'),
(633, 13, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 01:10:07', '2025-10-22 01:10:07'),
(634, 13, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 01:10:07', '2025-10-22 01:10:07'),
(635, 23, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 01:12:14', '2025-10-22 01:12:14'),
(636, 23, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 01:12:23', '2025-10-22 01:12:23'),
(637, 23, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 01:12:23', '2025-10-22 01:12:23'),
(638, 13, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 01:20:28', '2025-10-22 01:20:28'),
(639, 13, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 01:20:28', '2025-10-22 01:20:28'),
(640, 14, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 01:20:45', '2025-10-22 01:20:45'),
(641, 14, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 01:20:45', '2025-10-22 01:20:45'),
(642, 13, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 01:31:50', '2025-10-22 01:31:50'),
(643, 13, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 01:31:50', '2025-10-22 01:31:50'),
(644, 13, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 01:32:36', '2025-10-22 01:32:36'),
(645, 13, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 01:32:36', '2025-10-22 01:32:36'),
(646, 13, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 01:32:50', '2025-10-22 01:32:50'),
(647, 13, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 01:32:50', '2025-10-22 01:32:50'),
(648, 13, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 08:41:52', '2025-10-22 08:41:52'),
(649, 13, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 08:41:52', '2025-10-22 08:41:52'),
(650, 24, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 08:42:24', '2025-10-22 08:42:24'),
(651, 24, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 08:43:07', '2025-10-22 08:43:07'),
(652, 24, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 08:43:07', '2025-10-22 08:43:07'),
(653, 24, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 08:43:50', '2025-10-22 08:43:50'),
(654, 24, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-22 08:43:50', '2025-10-22 08:43:50'),
(655, 11, 'login', '10.178.156.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-23 02:52:54', '2025-10-23 02:52:54'),
(656, 11, 'login', '10.178.156.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-23 02:52:54', '2025-10-23 02:52:54'),
(657, 15, 'login', '10.178.156.214', 'Dart/3.9 (dart:io)', '2025-10-23 02:53:22', '2025-10-23 02:53:22'),
(658, 15, 'login', '10.178.156.214', 'Dart/3.9 (dart:io)', '2025-10-23 02:53:22', '2025-10-23 02:53:22'),
(659, 20, 'login', '10.178.156.214', 'Dart/3.9 (dart:io)', '2025-10-23 03:10:41', '2025-10-23 03:10:41'),
(660, 20, 'login', '10.178.156.214', 'Dart/3.9 (dart:io)', '2025-10-23 03:10:41', '2025-10-23 03:10:41'),
(661, 13, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-23 05:25:23', '2025-10-23 05:25:23'),
(662, 13, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-23 05:25:23', '2025-10-23 05:25:23'),
(663, 15, 'login', '10.178.156.214', 'Dart/3.9 (dart:io)', '2025-10-23 05:27:42', '2025-10-23 05:27:42'),
(664, 15, 'login', '10.178.156.214', 'Dart/3.9 (dart:io)', '2025-10-23 05:27:42', '2025-10-23 05:27:42'),
(665, 11, 'login', '10.178.156.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-23 05:27:53', '2025-10-23 05:27:53'),
(666, 11, 'login', '10.178.156.214', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-23 05:27:53', '2025-10-23 05:27:53'),
(667, 16, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-26 07:59:05', '2025-10-26 07:59:05'),
(668, 16, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-26 07:59:05', '2025-10-26 07:59:05'),
(669, 15, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-26 07:59:17', '2025-10-26 07:59:17'),
(670, 15, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-10-26 07:59:17', '2025-10-26 07:59:17'),
(671, 11, 'login', '192.168.100.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-07 01:55:05', '2025-11-07 01:55:05'),
(672, 11, 'login', '192.168.100.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-07 01:55:05', '2025-11-07 01:55:05'),
(673, 15, 'login', '192.168.100.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-07 01:56:27', '2025-11-07 01:56:27'),
(674, 15, 'login', '192.168.100.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-07 01:56:27', '2025-11-07 01:56:27'),
(675, 11, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-11-07 01:56:41', '2025-11-07 01:56:41'),
(676, 11, 'login', '192.168.100.13', 'Dart/3.9 (dart:io)', '2025-11-07 01:56:41', '2025-11-07 01:56:41'),
(677, 15, 'login', '192.168.100.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-07 04:05:36', '2025-11-07 04:05:36'),
(678, 15, 'login', '192.168.100.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-07 04:05:36', '2025-11-07 04:05:36'),
(679, 20, 'login', '192.168.100.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-07 05:25:33', '2025-11-07 05:25:33'),
(680, 20, 'login', '192.168.100.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-07 05:25:33', '2025-11-07 05:25:33'),
(681, 20, 'login', '192.168.100.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-07 05:47:03', '2025-11-07 05:47:03'),
(682, 20, 'login', '192.168.100.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-07 05:47:03', '2025-11-07 05:47:03');

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
  `duration_minutes` int NOT NULL DEFAULT '60',
  `status` enum('scheduled','completed','cancelled','no_show','pending_payment','payment_failed','pending_confirmation') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending_payment',
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
  `conversation_id` bigint UNSIGNED NOT NULL,
  `sender_id` bigint UNSIGNED NOT NULL,
  `receiver_id` bigint UNSIGNED NOT NULL,
  `message_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'text',
  `message` text COLLATE utf8mb4_unicode_ci,
  `file_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `original_file_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `chat_messages`
--

INSERT INTO `chat_messages` (`id`, `conversation_id`, `sender_id`, `receiver_id`, `message_type`, `message`, `file_path`, `original_file_name`, `read_at`, `created_at`, `updated_at`) VALUES
(165, 23, 20, 11, 'text', 'Halo, saya ingin memulai percakapan dengan Anda.', NULL, NULL, NULL, '2025-11-07 05:25:38', '2025-11-07 05:25:38'),
(166, 23, 11, 20, 'text', 'hai', NULL, NULL, NULL, '2025-11-07 05:25:51', '2025-11-07 05:25:51'),
(167, 23, 20, 11, 'text', 'halooo', NULL, NULL, NULL, '2025-11-07 05:25:59', '2025-11-07 05:25:59'),
(170, 23, 11, 20, 'text', 'nerd.png', NULL, NULL, NULL, '2025-11-07 05:47:51', '2025-11-07 05:47:51'),
(171, 23, 11, 20, 'text', 'nerd.png', NULL, NULL, NULL, '2025-11-07 05:58:40', '2025-11-07 05:58:40');

-- --------------------------------------------------------

--
-- Table structure for table `conversations`
--

CREATE TABLE `conversations` (
  `id` bigint UNSIGNED NOT NULL,
  `appointment_id` bigint UNSIGNED DEFAULT NULL,
  `user_one_id` bigint UNSIGNED NOT NULL,
  `user_two_id` bigint UNSIGNED NOT NULL,
  `status` enum('pending','accepted','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `session_status` enum('pending','accepted','rejected','active','ended') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `session_started_at` timestamp NULL DEFAULT NULL,
  `session_duration_minutes` int DEFAULT NULL,
  `initiator_id` bigint UNSIGNED NOT NULL COMMENT 'The user who sent the first message request',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `conversations`
--

INSERT INTO `conversations` (`id`, `appointment_id`, `user_one_id`, `user_two_id`, `status`, `session_status`, `session_started_at`, `session_duration_minutes`, `initiator_id`, `created_at`, `updated_at`) VALUES
(23, NULL, 11, 20, 'accepted', 'pending', NULL, NULL, 20, '2025-11-07 05:25:38', '2025-11-07 05:25:46');

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
(18, '2025_10_08_233056_create_therapist_availabilities_table', 11),
(19, '2025_10_15_000000_add_duration_minutes_to_appointments_table', 12),
(20, '2025_10_15_045655_modify_status_enum_in_appointments_table', 13),
(21, '2025_10_15_050140_fix_foreign_key_in_appointments_table', 14),
(22, '2025_10_17_164440_modify_client_notes_to_encrypted_in_appointments_table', 15),
(23, '2025_10_18_025846_add_pending_confirmation_to_appointments_status', 16),
(24, '2025_10_18_110210_create_conversations_table', 17),
(25, '2025_10_18_110211_add_conversation_id_to_chat_messages_table', 17),
(27, '2025_10_22_061459_add_session_fields_to_conversations_table', 18),
(28, '2025_11_07_103734_add_file_fields_to_chat_messages_table', 19);

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
(66, 'App\\Models\\User', 9, 'auth_token', '828ea62bc6f5aeb3e8c79ce94ab4ee84fb8b9b78e0adf4b2919993d0f991d0a8', '[\"*\"]', NULL, NULL, '2025-10-08 17:07:09', '2025-10-08 17:07:09'),
(67, 'App\\Models\\User', 9, 'auth_token', '880c721782966e630cf74b47fad134124c904392c5d1f418a042b6cbb37b1d33', '[\"*\"]', '2025-10-08 17:07:18', NULL, '2025-10-08 17:07:17', '2025-10-08 17:07:18'),
(68, 'App\\Models\\User', 9, 'auth_token', 'b536dfcea8fd3ad8715cb2e418eab78d482f0e869fb4c4f6ad09af6c0bb4c680', '[\"*\"]', NULL, NULL, '2025-10-08 17:20:53', '2025-10-08 17:20:53'),
(69, 'App\\Models\\User', 9, 'auth_token', '424eaf43a94552cf92dab01c4755f2baa5cb7a4ef10e0c122c35ceb460933909', '[\"*\"]', NULL, NULL, '2025-10-08 17:21:05', '2025-10-08 17:21:05'),
(70, 'App\\Models\\User', 9, 'auth_token', '10669337874236be280db4b3bd4132177003affe06647cfe3a5cfafe2f8c4dd7', '[\"*\"]', NULL, NULL, '2025-10-08 17:22:17', '2025-10-08 17:22:17'),
(72, 'App\\Models\\User', 9, 'auth_token', 'f191b12ab30ea0c2b399ad5608b9a33e3927806f68403b565fd29af2d69d0f3c', '[\"*\"]', NULL, NULL, '2025-10-08 17:23:45', '2025-10-08 17:23:45'),
(73, 'App\\Models\\User', 9, 'auth_token', '9e848d74a678fb0c62187a629d7a3ebadfe0e6ae1ac9c29ae9e7fdf4afbbb3d3', '[\"*\"]', NULL, NULL, '2025-10-08 17:28:27', '2025-10-08 17:28:27'),
(74, 'App\\Models\\User', 9, 'auth_token', '8b8a4b49efebe332412bfc66196806f841c3655e680e8557fba8b964727d3170', '[\"*\"]', NULL, NULL, '2025-10-08 17:38:51', '2025-10-08 17:38:51'),
(75, 'App\\Models\\User', 9, 'auth_token', 'dfafb206069954087c344126be303649ed74930859399ac326f89b10373c16c4', '[\"*\"]', NULL, NULL, '2025-10-08 17:42:57', '2025-10-08 17:42:57'),
(76, 'App\\Models\\User', 9, 'auth_token', '96c6ba8309bc04baa66f18af6b39f29d345502b5ccbcb29e26e6952e65559fd4', '[\"*\"]', '2025-10-08 17:49:39', NULL, '2025-10-08 17:49:35', '2025-10-08 17:49:39'),
(77, 'App\\Models\\User', 9, 'auth_token', '0a85eddae946312f09d66c3011d0cd528f89510be9048919097de8b019fe0f11', '[\"*\"]', '2025-10-08 18:07:45', NULL, '2025-10-08 18:05:23', '2025-10-08 18:07:45'),
(78, 'App\\Models\\User', 9, 'auth_token', '2e222babb023c97680d23827c779e07c750d9d66ee9d38716629e80b4e398ce4', '[\"*\"]', '2025-10-08 18:14:20', NULL, '2025-10-08 18:08:43', '2025-10-08 18:14:20'),
(80, 'App\\Models\\User', 9, 'auth_token', '07c92d2d118f314f741b3c9dff6da8b0dde16749637276754f96691df316a720', '[\"*\"]', '2025-10-08 18:24:28', NULL, '2025-10-08 18:24:25', '2025-10-08 18:24:28'),
(84, 'App\\Models\\User', 9, 'auth_token', '690f53f5014cf53b83192f462cfd7929f6e264f6ed9cb134b2c53401cdbefbf5', '[\"*\"]', '2025-10-08 18:42:53', NULL, '2025-10-08 18:42:48', '2025-10-08 18:42:53'),
(87, 'App\\Models\\User', 9, 'auth_token', '56938b161df574f249be882486501e79ee047846de352c51c4900a293df4f1c3', '[\"*\"]', '2025-10-08 20:19:03', NULL, '2025-10-08 20:16:37', '2025-10-08 20:19:03'),
(92, 'App\\Models\\User', 9, 'auth_token', '779296809fd06b9f23d503afa7115e253b81ead11a7163f1fd4f8cc5e4ef6d94', '[\"*\"]', '2025-10-12 21:03:48', NULL, '2025-10-12 21:03:39', '2025-10-12 21:03:48'),
(95, 'App\\Models\\User', 11, 'auth_token', '649d23aed6f82048799823c5bba68f3a78d3bd69b8d196a033a72662cc372da3', '[\"*\"]', NULL, NULL, '2025-10-12 22:09:03', '2025-10-12 22:09:03'),
(96, 'App\\Models\\User', 11, 'auth_token', 'b622a0a9f0b5797176598765a428a1495d436ae58827255f8487a3331198fc68', '[\"*\"]', '2025-10-12 22:09:13', NULL, '2025-10-12 22:09:12', '2025-10-12 22:09:13'),
(97, 'App\\Models\\User', 12, 'auth_token', '912d8dbf58d1674a250d716144f7f78c5cab6893956ab83256d872f093d8309b', '[\"*\"]', NULL, NULL, '2025-10-12 22:10:17', '2025-10-12 22:10:17'),
(98, 'App\\Models\\User', 12, 'auth_token', '609fbbabdd88eec364f6598a1b4ad0cc3851882bfeea828c81a7c2f5fe150267', '[\"*\"]', '2025-10-12 22:10:26', NULL, '2025-10-12 22:10:25', '2025-10-12 22:10:26'),
(99, 'App\\Models\\User', 13, 'auth_token', 'a708fa5b9f793658f34767a6836d53d206cfecc55717b5a01ebbe9f87a413230', '[\"*\"]', NULL, NULL, '2025-10-12 22:11:03', '2025-10-12 22:11:03'),
(100, 'App\\Models\\User', 13, 'auth_token', '63f93366c2ebcc69cd4129a223b7250b0e1a7e26754ca70ef66ed39b96c6dff0', '[\"*\"]', '2025-10-12 22:11:11', NULL, '2025-10-12 22:11:10', '2025-10-12 22:11:11'),
(101, 'App\\Models\\User', 14, 'auth_token', 'c4097e856b82e5fe3cf9e1449d214568e0aead165bed1fb6341de74786a77f76', '[\"*\"]', NULL, NULL, '2025-10-12 22:11:43', '2025-10-12 22:11:43'),
(102, 'App\\Models\\User', 14, 'auth_token', '6f53fb4924d4b00a5dd9e551096c0ea1aca5b6aab52875fd01e7267460abe4e8', '[\"*\"]', NULL, NULL, '2025-10-12 22:12:01', '2025-10-12 22:12:01'),
(103, 'App\\Models\\User', 14, 'auth_token', 'e0f081df85b98ceb31a77ee9a8b9f64ff6328bf147f9c3a8c2ed1eaa24624283', '[\"*\"]', NULL, NULL, '2025-10-12 22:14:47', '2025-10-12 22:14:47'),
(104, 'App\\Models\\User', 14, 'auth_token', '039952b7af03f99b4fae851fd2eb64248f74d1baded306fbdab0d55f12249811', '[\"*\"]', '2025-10-12 22:29:29', NULL, '2025-10-12 22:29:22', '2025-10-12 22:29:29'),
(105, 'App\\Models\\User', 15, 'auth_token', '04c8242cbc24edc1888f92b92b10d5f59770c2e8cb4ab88983b34132d66cf030', '[\"*\"]', NULL, NULL, '2025-10-12 22:49:04', '2025-10-12 22:49:04'),
(106, 'App\\Models\\User', 15, 'auth_token', 'fb439f5f20651aad1da19a3f36976af05f5596c29e305342127850766496791e', '[\"*\"]', '2025-10-12 22:54:03', NULL, '2025-10-12 22:49:15', '2025-10-12 22:54:03'),
(107, 'App\\Models\\User', 16, 'auth_token', '416aee703d7e5114587cca4b96db928c9e20a68721c22d3226f510fae64c85fd', '[\"*\"]', NULL, NULL, '2025-10-12 22:54:43', '2025-10-12 22:54:43'),
(108, 'App\\Models\\User', 15, 'auth_token', 'ae0d2b09886d9a24deb5e290a884cfb11bfde06675deed52cf11aa85df03a723', '[\"*\"]', '2025-10-12 22:55:10', NULL, '2025-10-12 22:54:52', '2025-10-12 22:55:10'),
(109, 'App\\Models\\User', 16, 'auth_token', 'eb3eb5766295b8c0529bf5053860725d6dfdc8a0b0ffb62bcdf88b5db4d4c2fb', '[\"*\"]', '2025-10-12 23:04:55', NULL, '2025-10-12 22:55:22', '2025-10-12 23:04:55'),
(110, 'App\\Models\\User', 17, 'auth_token', '92c2ae9cdd1613d9cd5782a111a87db11d1fd874d3ab6f280acaaa81e103db9f', '[\"*\"]', NULL, NULL, '2025-10-12 23:05:47', '2025-10-12 23:05:47'),
(111, 'App\\Models\\User', 17, 'auth_token', '72453cdf28e11c9dc33468de399310bf62f097eb958c3e2c7c3cd77e2b9511d0', '[\"*\"]', '2025-10-12 23:06:02', NULL, '2025-10-12 23:06:01', '2025-10-12 23:06:02'),
(112, 'App\\Models\\User', 17, 'auth_token', 'a3894e6a76dac80a8eadf738e023d005731a08486a5b4d884bdc690846f8969b', '[\"*\"]', '2025-10-12 23:09:13', NULL, '2025-10-12 23:06:23', '2025-10-12 23:09:13'),
(113, 'App\\Models\\User', 14, 'auth_token', 'acaae47708f06312aafbce44f6e7abb09dc525cf6500c395cf22b1cadfd34232', '[\"*\"]', '2025-10-12 23:10:26', NULL, '2025-10-12 23:09:25', '2025-10-12 23:10:26'),
(114, 'App\\Models\\User', 13, 'auth_token', '06648c41400d4f095ef10f971b6171a1648bde26176a73650a8694769957403b', '[\"*\"]', '2025-10-12 23:31:12', NULL, '2025-10-12 23:31:11', '2025-10-12 23:31:12'),
(115, 'App\\Models\\User', 13, 'auth_token', '827753001f94d1f5fcc7a567633b698f0d3b64cf19b5a8abbb5c3e74515f4e9c', '[\"*\"]', '2025-10-13 00:02:03', NULL, '2025-10-13 00:02:03', '2025-10-13 00:02:03'),
(116, 'App\\Models\\User', 11, 'auth_token', 'd3b3a973920676fe61de5157196fd9e6a63ab2f3305086025526197c83dea716', '[\"*\"]', '2025-10-13 00:14:22', NULL, '2025-10-13 00:14:21', '2025-10-13 00:14:22'),
(117, 'App\\Models\\User', 11, 'auth_token', 'c7756441b58f33122e307f0e557d7e44796ca178aae0fc83096a0d1ed9a522fd', '[\"*\"]', '2025-10-13 00:27:21', NULL, '2025-10-13 00:27:20', '2025-10-13 00:27:21'),
(118, 'App\\Models\\User', 11, 'auth_token', '6945c7229c5294c2ef87d33bdc4743cec0880b7f936479c40e7978b24710c199', '[\"*\"]', '2025-10-13 00:45:33', NULL, '2025-10-13 00:32:41', '2025-10-13 00:45:33'),
(119, 'App\\Models\\User', 11, 'auth_token', 'f4e19f72ccc60d1d2b50e180f1e6f514f8c97cc22e29031027a78597a9e638a3', '[\"*\"]', '2025-10-13 01:13:29', NULL, '2025-10-13 01:02:48', '2025-10-13 01:13:29'),
(120, 'App\\Models\\User', 11, 'auth_token', '918732d1b8c08e88778e4a3453fe1e945eb99e8dcc1835927da7c05d7e0c9702', '[\"*\"]', '2025-10-14 06:42:50', NULL, '2025-10-14 06:42:16', '2025-10-14 06:42:50'),
(121, 'App\\Models\\User', 11, 'auth_token', '1d57cd61d1bae2278884ad10b8605b0f1190792e0e17f038c6e9d707c6759fd3', '[\"*\"]', '2025-10-14 06:43:04', NULL, '2025-10-14 06:43:04', '2025-10-14 06:43:04'),
(122, 'App\\Models\\User', 11, 'auth_token', '48f2c45b113c1b99ab3bfe5fed273682a52effb55782bb9f1a7ea104ab581812', '[\"*\"]', '2025-10-14 06:43:15', NULL, '2025-10-14 06:43:15', '2025-10-14 06:43:15'),
(123, 'App\\Models\\User', 11, 'auth_token', 'e6f4088757963b2d732c3cda9c96d840a5ddddd230cc8b171535b9e1b74da56e', '[\"*\"]', '2025-10-14 07:07:26', NULL, '2025-10-14 07:07:03', '2025-10-14 07:07:26'),
(124, 'App\\Models\\User', 11, 'auth_token', '3faa4fbfaa8f111359c36c303a692eef036d98873e16be204ebabf5d8672103c', '[\"*\"]', '2025-10-14 07:12:42', NULL, '2025-10-14 07:07:43', '2025-10-14 07:12:42'),
(125, 'App\\Models\\User', 11, 'auth_token', '439beca5bb9c8b96ecec28613c6be8761bb81ae1d48abec00726e4d21459d8d2', '[\"*\"]', '2025-10-14 07:24:48', NULL, '2025-10-14 07:24:47', '2025-10-14 07:24:48'),
(126, 'App\\Models\\User', 11, 'auth_token', '0b393fb7cc605de67d09a13680edee2487f1b55c98146219cf37824b8b31eb4b', '[\"*\"]', '2025-10-14 08:20:10', NULL, '2025-10-14 08:19:33', '2025-10-14 08:20:10'),
(127, 'App\\Models\\User', 11, 'auth_token', 'd0ec0aa93655f04996a5a950f63c17a0d9a8abd74e0d194da8fba627660721d1', '[\"*\"]', '2025-10-14 08:28:43', NULL, '2025-10-14 08:28:20', '2025-10-14 08:28:43'),
(128, 'App\\Models\\User', 11, 'auth_token', '7bcd4a1e2e68c64457a79bf519953fde3db8ef8c6a8b010c071ddbda879862b0', '[\"*\"]', '2025-10-14 08:30:08', NULL, '2025-10-14 08:30:07', '2025-10-14 08:30:08'),
(129, 'App\\Models\\User', 11, 'auth_token', 'a0b3e99ac6e74d91ad33e55eb887181bdd6bbdb60d628dfe6207266f6bd23299', '[\"*\"]', '2025-10-14 08:44:06', NULL, '2025-10-14 08:44:05', '2025-10-14 08:44:06'),
(130, 'App\\Models\\User', 11, 'auth_token', 'bb1de59653ebe38ae325f4058896c1d0a6df123484aedf84affa850c3ba25238', '[\"*\"]', NULL, NULL, '2025-10-14 08:44:11', '2025-10-14 08:44:11'),
(131, 'App\\Models\\User', 11, 'auth_token', '60a05a808c42a306901b25ee2ad13955d03e1482418c1a6925036631c5706cad', '[\"*\"]', NULL, NULL, '2025-10-14 08:44:19', '2025-10-14 08:44:19'),
(132, 'App\\Models\\User', 14, 'auth_token', '69afad82baac19751403e4756d434ec9be073b1e9a483bcf990c993a17c6c085', '[\"*\"]', NULL, NULL, '2025-10-14 08:44:45', '2025-10-14 08:44:45'),
(133, 'App\\Models\\User', 14, 'auth_token', '1febeded8d87e5530ed2ef05985fc6256ef9199c119577e6791f703fc4a56312', '[\"*\"]', '2025-10-14 08:45:00', NULL, '2025-10-14 08:44:58', '2025-10-14 08:45:00'),
(134, 'App\\Models\\User', 11, 'auth_token', '4c689ce9ae45bb10d6414180750af49b278c1bcfaa944e4306f34b7677c58cc9', '[\"*\"]', '2025-10-14 08:45:21', NULL, '2025-10-14 08:45:17', '2025-10-14 08:45:21'),
(135, 'App\\Models\\User', 11, 'auth_token', '3bdb1cea65d465fdc22e2ff435b069ade2cf83a1a3e7841dea4565a3b5a37f78', '[\"*\"]', '2025-10-14 08:49:25', NULL, '2025-10-14 08:49:23', '2025-10-14 08:49:25'),
(136, 'App\\Models\\User', 11, 'auth_token', '25d1d897ff75a2a43d7845110a04243bc2e556608c0b577b4fc9f331e044dd09', '[\"*\"]', '2025-10-14 08:50:15', NULL, '2025-10-14 08:50:14', '2025-10-14 08:50:15'),
(137, 'App\\Models\\User', 11, 'auth_token', '0d47b214f2a814afd382de503bbd25e29a6e5fff030c08236b8b4dac6215f73f', '[\"*\"]', '2025-10-14 08:55:16', NULL, '2025-10-14 08:55:14', '2025-10-14 08:55:16'),
(138, 'App\\Models\\User', 11, 'auth_token', '5046b46369b4184229d2363f6f49b6806fd1cec817465388741d50ee102a8d2e', '[\"*\"]', '2025-10-14 09:01:53', NULL, '2025-10-14 09:01:52', '2025-10-14 09:01:53'),
(139, 'App\\Models\\User', 11, 'auth_token', '6a63ccff11740d0d23368b01984041fc252cb7e49e69dee9e3256ac027c6835f', '[\"*\"]', '2025-10-14 09:02:46', NULL, '2025-10-14 09:02:44', '2025-10-14 09:02:46'),
(140, 'App\\Models\\User', 11, 'auth_token', '1b177cffa5999122cc45496695854310643d97ecb4c580820beb60de6c45d01a', '[\"*\"]', '2025-10-14 09:16:31', NULL, '2025-10-14 09:16:30', '2025-10-14 09:16:31'),
(141, 'App\\Models\\User', 11, 'auth_token', '2c4726ddfbdc5fbee3139ecfe8150ba299732502e6a6328a885d48cb0573d296', '[\"*\"]', '2025-10-14 09:17:34', NULL, '2025-10-14 09:17:31', '2025-10-14 09:17:34'),
(142, 'App\\Models\\User', 11, 'auth_token', '2625d391109cf0fc379a3e0d21ea315877523e43c07c04d27c306ee868d1d09d', '[\"*\"]', '2025-10-14 09:25:17', NULL, '2025-10-14 09:24:59', '2025-10-14 09:25:17'),
(143, 'App\\Models\\User', 11, 'auth_token', 'c3c894f2be9cd6f2d02d01227c74c93385a789e4e97aeec7784a753470f0c45b', '[\"*\"]', '2025-10-14 09:33:47', NULL, '2025-10-14 09:33:45', '2025-10-14 09:33:47'),
(144, 'App\\Models\\User', 11, 'auth_token', 'c2d500e26ec354ba10c3a73cec38aa337fd8658c83bd06cd972f7f588801d39c', '[\"*\"]', '2025-10-14 09:46:49', NULL, '2025-10-14 09:46:47', '2025-10-14 09:46:49'),
(145, 'App\\Models\\User', 11, 'auth_token', '79c880e0a2c5f29d2974aa94231246dc72884496becf9e1665c1f461defc35a8', '[\"*\"]', '2025-10-14 09:52:17', NULL, '2025-10-14 09:52:16', '2025-10-14 09:52:17'),
(146, 'App\\Models\\User', 11, 'auth_token', '352639b8787751fe41279b71cd79cd6fed72a194af47f8ea8e723a7819c37c32', '[\"*\"]', '2025-10-14 09:53:30', NULL, '2025-10-14 09:53:29', '2025-10-14 09:53:30'),
(147, 'App\\Models\\User', 11, 'auth_token', '83c74817d817fb7a247099379484230d853be47836d6c59b35bafd723c67c586', '[\"*\"]', '2025-10-14 10:09:31', NULL, '2025-10-14 10:09:30', '2025-10-14 10:09:31'),
(148, 'App\\Models\\User', 11, 'auth_token', 'e2033cc53107c7137459b536f989d2d941a62264bd74be8afd2fca4c418087c0', '[\"*\"]', '2025-10-14 10:14:02', NULL, '2025-10-14 10:14:00', '2025-10-14 10:14:02'),
(149, 'App\\Models\\User', 11, 'auth_token', '03e1f310e2d07eda558fe894365efc19eccdefb60b52de231fc7c4d4142d151d', '[\"*\"]', '2025-10-14 10:16:27', NULL, '2025-10-14 10:16:26', '2025-10-14 10:16:27'),
(150, 'App\\Models\\User', 11, 'auth_token', '3d6d9a4f8f4002e7430dcd8fd7f66a57a3175c6ae2306f3f6f3fd6eefcc207e5', '[\"*\"]', '2025-10-14 10:34:55', NULL, '2025-10-14 10:34:54', '2025-10-14 10:34:55'),
(151, 'App\\Models\\User', 11, 'auth_token', 'b064d40cbf1153b326a8ac69f9fb79af56d0f9084e0e0c25692b4f860bbd0af2', '[\"*\"]', '2025-10-14 10:42:40', NULL, '2025-10-14 10:42:39', '2025-10-14 10:42:40'),
(152, 'App\\Models\\User', 11, 'auth_token', 'd968362b4383758c13988bf07f999e1e46c536c84ec9d5345ab5df752a9a5fae', '[\"*\"]', '2025-10-14 10:43:25', NULL, '2025-10-14 10:43:24', '2025-10-14 10:43:25'),
(153, 'App\\Models\\User', 11, 'auth_token', '7411077502ab2f1872fe4b70f7625596f02b624b5cedadea8cd38f6bf94de67d', '[\"*\"]', '2025-10-14 10:48:49', NULL, '2025-10-14 10:48:48', '2025-10-14 10:48:49'),
(154, 'App\\Models\\User', 11, 'auth_token', '3b31a15506e9894b7d9ed491e0c66a1a4a48b59685836d78e4202c88848e943c', '[\"*\"]', '2025-10-14 10:57:27', NULL, '2025-10-14 10:57:25', '2025-10-14 10:57:27'),
(155, 'App\\Models\\User', 11, 'auth_token', '38365cb8fa1b4d096762b2c8f4eaf51d1a07544e9982a60d436566e935dab458', '[\"*\"]', '2025-10-14 11:02:39', NULL, '2025-10-14 11:02:37', '2025-10-14 11:02:39'),
(156, 'App\\Models\\User', 11, 'auth_token', '97bbe9ed2cb19104aa68c97b4d50917d71b1c0bc631a24d71b56b107a7c71e5c', '[\"*\"]', '2025-10-14 11:11:26', NULL, '2025-10-14 11:11:24', '2025-10-14 11:11:26'),
(157, 'App\\Models\\User', 11, 'auth_token', '87b5f1450dd7d06ebeb3f3e778adb3f14c2b503a43b6db72120e20455732153f', '[\"*\"]', '2025-10-14 11:12:26', NULL, '2025-10-14 11:11:44', '2025-10-14 11:12:26'),
(158, 'App\\Models\\User', 11, 'auth_token', '44d6f12ff4b022d48c96ff1af146c96125e15536eda7a58a2942e901a3b8c618', '[\"*\"]', '2025-10-14 11:12:43', NULL, '2025-10-14 11:12:42', '2025-10-14 11:12:43'),
(159, 'App\\Models\\User', 11, 'auth_token', 'b2dd8a2a531fde798c135979e160fdf425489cc4be99e990d42d5bec444bd4df', '[\"*\"]', '2025-10-14 11:13:03', NULL, '2025-10-14 11:13:02', '2025-10-14 11:13:03'),
(160, 'App\\Models\\User', 11, 'auth_token', '89e226d2e0a6c98d51413ca633e6a21b3a6dd39f8bef288efddf14cb9b89a880', '[\"*\"]', '2025-10-14 11:19:28', NULL, '2025-10-14 11:19:26', '2025-10-14 11:19:28'),
(161, 'App\\Models\\User', 11, 'auth_token', '1d5e1f665c2de93d804c46ca9d3d7fc1e81e38b0a616923c25201de4e3895b60', '[\"*\"]', '2025-10-14 11:25:23', NULL, '2025-10-14 11:25:15', '2025-10-14 11:25:23'),
(162, 'App\\Models\\User', 11, 'auth_token', '184f9f3eea4e1e8a5ebb67a2ea37bcf39f5695c1fe06414a9c0cc050075feedb', '[\"*\"]', '2025-10-14 11:27:15', NULL, '2025-10-14 11:27:14', '2025-10-14 11:27:15'),
(163, 'App\\Models\\User', 11, 'auth_token', 'affce071ebd35b94abea440c17c3e8ff6b4b986560737ebe4c1e90ef752f3155', '[\"*\"]', '2025-10-14 18:47:17', NULL, '2025-10-14 18:47:15', '2025-10-14 18:47:17'),
(164, 'App\\Models\\User', 11, 'auth_token', '2d836bf31c012e80d5b7820683e5435c9710c9d4237eea8b4d35e509edacce12', '[\"*\"]', '2025-10-14 19:52:37', NULL, '2025-10-14 19:52:35', '2025-10-14 19:52:37'),
(165, 'App\\Models\\User', 11, 'auth_token', '55b0e4dff4712888eb978483631d8a066692ece80854ed425e60701703dbedf3', '[\"*\"]', '2025-10-14 20:04:55', NULL, '2025-10-14 20:04:54', '2025-10-14 20:04:55'),
(166, 'App\\Models\\User', 11, 'auth_token', 'b9aae32d9975a20e2e17920657bd702bda923ba59f9be3d0c930878f51cccf50', '[\"*\"]', '2025-10-14 20:10:47', NULL, '2025-10-14 20:10:46', '2025-10-14 20:10:47'),
(167, 'App\\Models\\User', 11, 'auth_token', '224c4a9c93aec4e31c7b9cad66e81efb2636ec8f01e4c6164b5e98a31290e722', '[\"*\"]', '2025-10-14 20:13:35', NULL, '2025-10-14 20:13:34', '2025-10-14 20:13:35'),
(168, 'App\\Models\\User', 11, 'auth_token', 'd5e2e501d8e8e480ec7b2a34b6dda018953cf33e97bd3a61094dd886e6a1e038', '[\"*\"]', '2025-10-14 20:35:51', NULL, '2025-10-14 20:35:49', '2025-10-14 20:35:51'),
(169, 'App\\Models\\User', 11, 'auth_token', '7a1e295c655ace220cf85addb5f8c3f344c6ce98ad649f6667517263e530e642', '[\"*\"]', '2025-10-14 20:48:06', NULL, '2025-10-14 20:48:04', '2025-10-14 20:48:06'),
(170, 'App\\Models\\User', 11, 'auth_token', 'fe439df09ed6ee81353078fc423405a15e0a1ed64faff467580e6c5ee574111f', '[\"*\"]', '2025-10-14 20:53:30', NULL, '2025-10-14 20:53:28', '2025-10-14 20:53:30'),
(171, 'App\\Models\\User', 11, 'auth_token', '60ac20a86f7a8fd912ac25de3b1388afad5e620156cccf066c2dbdabd5ecc872', '[\"*\"]', '2025-10-14 21:14:08', NULL, '2025-10-14 21:14:07', '2025-10-14 21:14:08'),
(172, 'App\\Models\\User', 11, 'auth_token', '51e7d653a7f9ec402c689a6134f950eb3d64b2ed56a6f87a11256bfcd8b326b7', '[\"*\"]', '2025-10-14 21:18:58', NULL, '2025-10-14 21:18:56', '2025-10-14 21:18:58'),
(173, 'App\\Models\\User', 11, 'auth_token', '226772c76abc1734cf15c33131f44e8f3f971288c39a6b67eefbe950bfc8e011', '[\"*\"]', '2025-10-14 21:19:27', NULL, '2025-10-14 21:19:25', '2025-10-14 21:19:27'),
(174, 'App\\Models\\User', 11, 'auth_token', 'b62f7a0dbabdca3eaeb3c7ecb73626861d4ef11bb5e715d0521ff3855c54ccc1', '[\"*\"]', '2025-10-14 21:31:36', NULL, '2025-10-14 21:31:35', '2025-10-14 21:31:36'),
(175, 'App\\Models\\User', 11, 'auth_token', '165154d9b69b12c6435b4abecb23de4d7f043f04e9b54e7fb5d093473be7a693', '[\"*\"]', '2025-10-14 21:39:32', NULL, '2025-10-14 21:35:17', '2025-10-14 21:39:32'),
(176, 'App\\Models\\User', 11, 'auth_token', '99d333ab70607104d288a9bced1bddee60755664f70483b976aa99ef3fbce8a7', '[\"*\"]', '2025-10-14 21:47:37', NULL, '2025-10-14 21:47:35', '2025-10-14 21:47:37'),
(177, 'App\\Models\\User', 11, 'auth_token', '9151524d698e5d13a6d409066a0e6c5124757c7eaa604da744468bf7e5142a84', '[\"*\"]', '2025-10-14 21:57:30', NULL, '2025-10-14 21:53:24', '2025-10-14 21:57:30'),
(178, 'App\\Models\\User', 11, 'auth_token', '1a740ebbbc668904c15f0dedaa5478424d4804441bc1865ac2fbb1be0e3b162f', '[\"*\"]', '2025-10-14 22:02:38', NULL, '2025-10-14 21:58:59', '2025-10-14 22:02:38'),
(179, 'App\\Models\\User', 11, 'auth_token', '4dd61899e58e651ba73248dac1e15d8c6eea25d92268aa9277c6c3343005fe8a', '[\"*\"]', '2025-10-14 23:08:28', NULL, '2025-10-14 22:12:58', '2025-10-14 23:08:28'),
(180, 'App\\Models\\User', 11, 'auth_token', 'f36e3e5fd8c96cb5d64ff4f26d62a8fde1f30534e73fd8081c72ef8294063f35', '[\"*\"]', '2025-10-15 01:33:28', NULL, '2025-10-15 01:31:37', '2025-10-15 01:33:28'),
(181, 'App\\Models\\User', 14, 'auth_token', '40ffcd66844db785227063b5fa579eda3e6daf585e7f3453f802100a74e49f0d', '[\"*\"]', '2025-10-15 01:34:45', NULL, '2025-10-15 01:34:09', '2025-10-15 01:34:45'),
(184, 'App\\Models\\User', 11, 'auth_token', 'da57f96fffc662b935cb4a70874efe1ab1dfb7e925bf4745bb275852ee23c828', '[\"*\"]', '2025-10-15 01:57:00', NULL, '2025-10-15 01:56:18', '2025-10-15 01:57:00'),
(185, 'App\\Models\\User', 19, 'auth_token', 'd09681a9ddae3e402d370ed1e5b6c35e080ef93779864de0edac21eb8b6dce61', '[\"*\"]', NULL, NULL, '2025-10-15 02:02:01', '2025-10-15 02:02:01'),
(186, 'App\\Models\\User', 19, 'auth_token', '387baf12e4b0dbcfea8b056b6c3201cb2e8876de80b0c0a86e3c28ecec75c7fc', '[\"*\"]', '2025-10-15 02:06:02', NULL, '2025-10-15 02:02:18', '2025-10-15 02:06:02'),
(187, 'App\\Models\\User', 15, 'auth_token', '61f5a65dcb2c6d81cc5511777a3e06cd7851f4a3f3989a49f6d3f012c0f83d35', '[\"*\"]', '2025-10-15 02:08:08', NULL, '2025-10-15 02:07:45', '2025-10-15 02:08:08'),
(188, 'App\\Models\\User', 19, 'auth_token', '945715a977097b2d0e7e7b06094cb8547e8dda679722850cf6ad67ddfcb16942', '[\"*\"]', '2025-10-15 02:10:32', NULL, '2025-10-15 02:08:25', '2025-10-15 02:10:32'),
(189, 'App\\Models\\User', 14, 'auth_token', '25b068b84d6bcc38865c5143d0f01f94c0a9444c255891a1111a1375d8301bcf', '[\"*\"]', '2025-10-15 02:11:58', NULL, '2025-10-15 02:10:58', '2025-10-15 02:11:58'),
(190, 'App\\Models\\User', 11, 'auth_token', 'e193c28547159769fde53d1da507f1dfa9dd217015cff8c30f03095e17e50e24', '[\"*\"]', '2025-10-15 21:28:05', NULL, '2025-10-15 21:27:37', '2025-10-15 21:28:05'),
(191, 'App\\Models\\User', 14, 'auth_token', 'ac285dc40df52c95ba6d041e2d6d955f8954547c35c86b67a6d91d0fe098a591', '[\"*\"]', '2025-10-15 21:39:27', NULL, '2025-10-15 21:39:25', '2025-10-15 21:39:27'),
(192, 'App\\Models\\User', 11, 'auth_token', 'a6a3af02abb0bde3938d1739edc8014a90dd1b84a3acf13ff3626a5b5b0730d8', '[\"*\"]', '2025-10-15 22:28:55', NULL, '2025-10-15 22:28:39', '2025-10-15 22:28:55'),
(193, 'App\\Models\\User', 15, 'auth_token', 'a385587bc65e65d8920dd9f206f54530710581b166696edb55ce30a6f6c755e5', '[\"*\"]', '2025-10-15 22:43:19', NULL, '2025-10-15 22:30:01', '2025-10-15 22:43:19'),
(194, 'App\\Models\\User', 15, 'auth_token', '67bd94344b0efdc406f9ace2ce5871cfc56cb37baba161bcf2087602b78f5543', '[\"*\"]', '2025-10-15 22:55:15', NULL, '2025-10-15 22:44:07', '2025-10-15 22:55:15'),
(195, 'App\\Models\\User', 15, 'auth_token', '9b6b0bc5391c34f1ad9f57ecd7eb961f8585cb78daa706a2e3d5def9198407c0', '[\"*\"]', '2025-10-15 23:01:13', NULL, '2025-10-15 23:01:12', '2025-10-15 23:01:13'),
(196, 'App\\Models\\User', 15, 'auth_token', 'ef3262c9ff5c9b5c672783ab284ea1c6686e4048cc29fa3936b1ab19082e7bc2', '[\"*\"]', '2025-10-15 23:03:07', NULL, '2025-10-15 23:03:06', '2025-10-15 23:03:07'),
(197, 'App\\Models\\User', 15, 'auth_token', 'fff6b4220d4102e6ea449ab3c5163279a6b5a24bbaf643268b129c2ea5012678', '[\"*\"]', '2025-10-15 23:17:01', NULL, '2025-10-15 23:17:00', '2025-10-15 23:17:01'),
(198, 'App\\Models\\User', 15, 'auth_token', 'd775cfdb4a007d8673bd5f208848b435642d56858b3afe43f288cea7f15c3dc4', '[\"*\"]', '2025-10-15 23:55:48', NULL, '2025-10-15 23:45:26', '2025-10-15 23:55:48'),
(199, 'App\\Models\\User', 11, 'auth_token', '5cb66d99088c1b72dca233321fb67721500d5465524595a5d2899340dbddb5cd', '[\"*\"]', '2025-10-16 01:34:11', NULL, '2025-10-16 01:29:14', '2025-10-16 01:34:11'),
(200, 'App\\Models\\User', 15, 'auth_token', '1f06df9bb8d6a9d17ec105f2af9c02f0bf5a46dd82195e9c2f079e2f4a3b157f', '[\"*\"]', '2025-10-16 01:35:01', NULL, '2025-10-16 01:34:28', '2025-10-16 01:35:01'),
(201, 'App\\Models\\User', 15, 'auth_token', '394eab95ea2f4c5cf58f3385c4962e40eae90e19605b914706c0e7d7650ea94d', '[\"*\"]', '2025-10-17 07:15:45', NULL, '2025-10-17 06:40:00', '2025-10-17 07:15:45'),
(202, 'App\\Models\\User', 15, 'auth_token', 'be05a684590b86a6832053f466e3ae7e9011bb956ce36f32f36babad63f24dd5', '[\"*\"]', '2025-10-17 07:37:45', NULL, '2025-10-17 07:04:13', '2025-10-17 07:37:45'),
(203, 'App\\Models\\User', 15, 'auth_token', 'ef458607019b29152cc4f8092fd75b4832c3cedec64488a66f9b1eb772d8311e', '[\"*\"]', '2025-10-17 07:20:40', NULL, '2025-10-17 07:20:39', '2025-10-17 07:20:40'),
(204, 'App\\Models\\User', 15, 'auth_token', 'a1b9d842d3baae8c5b51fe777ced42af6c020aeed2249ca7e10f560403de9ce9', '[\"*\"]', '2025-10-17 07:29:39', NULL, '2025-10-17 07:29:26', '2025-10-17 07:29:39'),
(205, 'App\\Models\\User', 15, 'auth_token', 'dd2866828ec8ce127052996675a6c098bac231cc701adff6b93a90111bc606ea', '[\"*\"]', '2025-10-17 07:30:14', NULL, '2025-10-17 07:30:13', '2025-10-17 07:30:14'),
(206, 'App\\Models\\User', 15, 'auth_token', '3fb06b17916966c58081cc709ddb42e1a05c5a6de91a6920222c76234ff403fd', '[\"*\"]', '2025-10-17 07:46:41', NULL, '2025-10-17 07:36:42', '2025-10-17 07:46:41'),
(207, 'App\\Models\\User', 15, 'auth_token', '8575685abb5811fddb99f6f25202edf9bea823ca1bbed8b01710290091d99599', '[\"*\"]', '2025-10-19 00:52:54', NULL, '2025-10-17 07:40:14', '2025-10-19 00:52:54'),
(208, 'App\\Models\\User', 15, 'auth_token', '5d31a72b8eb76844f7136c7527ee43fc1c2be0ec1f9c9173074eeaa12874caf5', '[\"*\"]', '2025-10-17 07:47:45', NULL, '2025-10-17 07:47:44', '2025-10-17 07:47:45'),
(209, 'App\\Models\\User', 15, 'auth_token', 'f44e016f4c9c90e8a5dd1043bea1dcd33b247c8f7b131c0bdf5e6780e1cfd123', '[\"*\"]', '2025-10-17 07:52:52', NULL, '2025-10-17 07:52:49', '2025-10-17 07:52:52'),
(210, 'App\\Models\\User', 15, 'auth_token', '32c10006bacc22e326a2c9b104933a4cbc2fc4095bf86cbb1332860eac3b1738', '[\"*\"]', '2025-10-17 08:02:30', NULL, '2025-10-17 08:02:29', '2025-10-17 08:02:30'),
(211, 'App\\Models\\User', 15, 'auth_token', '21d95cc8d8e706a72ceb103702c168c0da908cceb268e907739f16d7854f31f4', '[\"*\"]', '2025-10-17 08:25:49', NULL, '2025-10-17 08:05:17', '2025-10-17 08:25:49'),
(212, 'App\\Models\\User', 11, 'auth_token', 'b7b0209c8942a44e0970182b4b75f4a598ef82ca2992d30b2b0ce106c1571743', '[\"*\"]', '2025-10-17 08:28:16', NULL, '2025-10-17 08:26:29', '2025-10-17 08:28:16'),
(213, 'App\\Models\\User', 11, 'auth_token', '9b233e192a58579fd2916ff184f95687d16b63bf52eabcbafa05a27f3f67bcb2', '[\"*\"]', '2025-10-17 09:22:56', NULL, '2025-10-17 08:37:04', '2025-10-17 09:22:56'),
(214, 'App\\Models\\User', 15, 'auth_token', '7bd2240a7be8f7c2affe010d3eb5deb3e6f64bd9e137d4abaa2dc20c2cab6e1d', '[\"*\"]', '2025-10-17 09:26:34', NULL, '2025-10-17 09:26:32', '2025-10-17 09:26:34'),
(215, 'App\\Models\\User', 11, 'auth_token', '4fa5f93160f6f9e57e3214f491d1e0dc033b91809f9705366fe9372120d73cd1', '[\"*\"]', '2025-10-17 09:27:17', NULL, '2025-10-17 09:27:16', '2025-10-17 09:27:17'),
(216, 'App\\Models\\User', 11, 'auth_token', '81dd2cac32d8f1bad91f23234c343ee9750c5daf8f05b8bf87eb5dab6bc8a635', '[\"*\"]', '2025-10-17 09:39:27', NULL, '2025-10-17 09:39:25', '2025-10-17 09:39:27'),
(217, 'App\\Models\\User', 15, 'auth_token', '8e38ca2aa8c453d12581f858f661158e5a4e7ae6bf5f4a09857fb093317a547d', '[\"*\"]', '2025-10-17 09:45:30', NULL, '2025-10-17 09:40:27', '2025-10-17 09:45:30'),
(218, 'App\\Models\\User', 11, 'auth_token', 'edc4fb5e5cb2de883293b924f4b1b600efca95f387603d8a950fa4d3178b423c', '[\"*\"]', '2025-10-17 09:45:50', NULL, '2025-10-17 09:45:40', '2025-10-17 09:45:50'),
(219, 'App\\Models\\User', 15, 'auth_token', '95b8c064da2014efa6a25cd800e32b98bee759d2e6fb0481bda3ba83d240e679', '[\"*\"]', '2025-10-17 09:46:16', NULL, '2025-10-17 09:46:14', '2025-10-17 09:46:16'),
(220, 'App\\Models\\User', 15, 'auth_token', 'bedc5b955b8a0b0949af20d8c4496bd95b8f741f57f4135c0ef0ffcde3a51298', '[\"*\"]', '2025-10-17 09:58:41', NULL, '2025-10-17 09:57:55', '2025-10-17 09:58:41'),
(221, 'App\\Models\\User', 15, 'auth_token', '11818447bd4912da4851d879a47d8654ec69f216893f96fd6e004373f9e484bd', '[\"*\"]', '2025-10-17 10:12:31', NULL, '2025-10-17 10:10:59', '2025-10-17 10:12:31'),
(222, 'App\\Models\\User', 11, 'auth_token', 'efef94f45b4fd54475b7a2a6445113d2f18b13fa263f6a8107dfd99796d648be', '[\"*\"]', '2025-10-17 10:13:18', NULL, '2025-10-17 10:12:52', '2025-10-17 10:13:18'),
(223, 'App\\Models\\User', 11, 'auth_token', '5afa6da42e355d7a42b466c61d0fbc66173427e6d7c3b551004bd18d21b36bd2', '[\"*\"]', '2025-10-17 10:31:55', NULL, '2025-10-17 10:24:44', '2025-10-17 10:31:55'),
(224, 'App\\Models\\User', 15, 'auth_token', '46d612540f305fe82b631f3e2f265a01688e8d4ca760f0ae09f5a32944d773a2', '[\"*\"]', '2025-10-17 10:32:17', NULL, '2025-10-17 10:32:04', '2025-10-17 10:32:17'),
(225, 'App\\Models\\User', 11, 'auth_token', '765f18bbbf714ec58f743b2f25ffc3e59b8be6f3598f33e07574a7842660fe18', '[\"*\"]', '2025-10-17 10:32:55', NULL, '2025-10-17 10:32:33', '2025-10-17 10:32:55'),
(226, 'App\\Models\\User', 11, 'auth_token', 'abab60deb34b55307a0701e94e36f9f4388ed3f0ff628af626c22dda93bd3bea', '[\"*\"]', '2025-10-17 10:34:19', NULL, '2025-10-17 10:34:12', '2025-10-17 10:34:19'),
(227, 'App\\Models\\User', 15, 'auth_token', 'c72c295618c622fcf1415c69f226e55657367cb93351ccafc1f5265c398ce47b', '[\"*\"]', '2025-10-17 10:34:55', NULL, '2025-10-17 10:34:42', '2025-10-17 10:34:55'),
(228, 'App\\Models\\User', 11, 'auth_token', 'ea6fae6b6287c9d8628b655993366ca19327896afeef4fd427e1caeb9885a6d3', '[\"*\"]', '2025-10-17 10:52:22', NULL, '2025-10-17 10:51:45', '2025-10-17 10:52:22'),
(229, 'App\\Models\\User', 11, 'auth_token', '579a8105dcad4eebccd807cbe5e73db3f511be6776c74f3c17ee0005f07af623', '[\"*\"]', '2025-10-17 11:03:09', NULL, '2025-10-17 11:02:44', '2025-10-17 11:03:09'),
(230, 'App\\Models\\User', 11, 'auth_token', 'edf4cf0aa5c2a6f6c3a9b8563061aab39dea3944a28694f527ba6a0b1f72e669', '[\"*\"]', '2025-10-17 11:05:28', NULL, '2025-10-17 11:05:20', '2025-10-17 11:05:28'),
(231, 'App\\Models\\User', 11, 'auth_token', '54c71e9de69f3344ba862b0d7993f935c8943f88a1f79b2028f3c011293c0c9b', '[\"*\"]', '2025-10-17 11:05:57', NULL, '2025-10-17 11:05:46', '2025-10-17 11:05:57'),
(232, 'App\\Models\\User', 11, 'auth_token', '41f613c5f220931c074a5d5b396a2f4a689efdbc554dacdcaeb68074cbea1d2f', '[\"*\"]', '2025-10-17 11:07:04', NULL, '2025-10-17 11:06:53', '2025-10-17 11:07:04'),
(233, 'App\\Models\\User', 11, 'auth_token', '9dce4432630b7f33ecd74f9e393212124329606ce4a6053f0612b4dfc6be5a02', '[\"*\"]', '2025-10-17 11:12:22', NULL, '2025-10-17 11:12:03', '2025-10-17 11:12:22'),
(234, 'App\\Models\\User', 11, 'auth_token', 'df57b0da413d43a88d714bd2e3b5945486991fd37c5ec24d55d3915b070c5bbe', '[\"*\"]', '2025-10-17 11:16:36', NULL, '2025-10-17 11:16:12', '2025-10-17 11:16:36'),
(235, 'App\\Models\\User', 11, 'auth_token', 'cf4414943829e45074e074725cae87fee88f2f33cbe63f73cde7649e87a9dcf6', '[\"*\"]', '2025-10-17 11:17:33', NULL, '2025-10-17 11:17:32', '2025-10-17 11:17:33'),
(236, 'App\\Models\\User', 11, 'auth_token', 'a1f54e625c8890ff030016f0658d97dd96b9ff31ec53536fc56313df3569056d', '[\"*\"]', '2025-10-17 11:17:54', NULL, '2025-10-17 11:17:54', '2025-10-17 11:17:54'),
(237, 'App\\Models\\User', 11, 'auth_token', 'fbb4ba503bc65079f16b5c58c34643d2483b2aad38765c5ec75467a501b3e056', '[\"*\"]', '2025-10-17 11:28:42', NULL, '2025-10-17 11:28:42', '2025-10-17 11:28:42'),
(238, 'App\\Models\\User', 11, 'auth_token', '24083255014f77bb475901b45fb21363b40b66c56ee08dae091db7f1ec754f46', '[\"*\"]', '2025-10-17 11:29:34', NULL, '2025-10-17 11:29:33', '2025-10-17 11:29:34'),
(239, 'App\\Models\\User', 11, 'auth_token', '432524fcee48f9682b5855b78499fe155699d23b659b57c109db2c24bcc4c060', '[\"*\"]', NULL, NULL, '2025-10-17 11:33:38', '2025-10-17 11:33:38'),
(240, 'App\\Models\\User', 11, 'auth_token', 'e1ffe323ecbfe513ab92757f316939c53f3f9f0becc13c99cedd8e05d7c2f6a7', '[\"*\"]', '2025-10-17 19:21:52', NULL, '2025-10-17 11:35:54', '2025-10-17 19:21:52'),
(241, 'App\\Models\\User', 11, 'auth_token', 'cb535c2ed2447168c46b51a8f3cd5c3f086778a954566b545323d2fd8844492f', '[\"*\"]', '2025-10-17 19:25:21', NULL, '2025-10-17 19:25:17', '2025-10-17 19:25:21'),
(242, 'App\\Models\\User', 15, 'auth_token', '2d6412e1e47d9046c66dbddbf4ca79257250711e677dce45b62df367ed51accc', '[\"*\"]', '2025-10-17 19:29:36', NULL, '2025-10-17 19:29:19', '2025-10-17 19:29:36'),
(243, 'App\\Models\\User', 11, 'auth_token', '92cfdbf4fbb3b542598024430c9c7d207ac38d6a169a1aff9a126caef0e066a4', '[\"*\"]', '2025-10-17 19:46:15', NULL, '2025-10-17 19:46:14', '2025-10-17 19:46:15'),
(244, 'App\\Models\\User', 11, 'auth_token', 'a83b518ae560850f82789dd072b001e649e8563421bca13fdfd6f9be0664e57b', '[\"*\"]', '2025-10-17 19:49:51', NULL, '2025-10-17 19:49:06', '2025-10-17 19:49:51'),
(245, 'App\\Models\\User', 11, 'auth_token', 'd599e6c16c69bcac5ecb793815182d7b812213b868d1c59156a105b241c0902f', '[\"*\"]', '2025-10-17 19:56:31', NULL, '2025-10-17 19:53:58', '2025-10-17 19:56:31'),
(246, 'App\\Models\\User', 11, 'auth_token', '85b04d81d4891164306bdcb6bb0266df47091ec4d6669301f7d96ee5a1b358be', '[\"*\"]', '2025-10-17 20:08:24', NULL, '2025-10-17 20:07:05', '2025-10-17 20:08:24'),
(247, 'App\\Models\\User', 15, 'auth_token', '95de1af2b0fbe921ad545c8bfd3b63c617bd649bae162063b76a8cfa5cd8f7d7', '[\"*\"]', '2025-10-17 20:08:58', NULL, '2025-10-17 20:08:42', '2025-10-17 20:08:58'),
(248, 'App\\Models\\User', 11, 'auth_token', '5d9ecc64f69b1d2e14f7885aa3ba753d13519671044854f7bdb99b105b9c7913', '[\"*\"]', '2025-10-17 20:09:23', NULL, '2025-10-17 20:09:10', '2025-10-17 20:09:23'),
(249, 'App\\Models\\User', 11, 'auth_token', '0f12e0a874c1ed1290b012975325be4d0a54384d6862f1cb4b8db227031bae78', '[\"*\"]', '2025-10-17 20:14:03', NULL, '2025-10-17 20:14:03', '2025-10-17 20:14:03'),
(250, 'App\\Models\\User', 11, 'auth_token', '0006a1ad61dbfa44e64f340e29fb9c278e631292b64f35a9391e69e8cafa7950', '[\"*\"]', '2025-10-17 22:22:44', NULL, '2025-10-17 22:22:44', '2025-10-17 22:22:44'),
(251, 'App\\Models\\User', 15, 'auth_token', 'ae86ab4a431fe6e709c3c95cd519ad1c95c5c9659417a87fa94fcdffe1cce72c', '[\"*\"]', '2025-10-17 22:25:11', NULL, '2025-10-17 22:25:10', '2025-10-17 22:25:11'),
(252, 'App\\Models\\User', 15, 'auth_token', '7f003a3d84535b9d0df70ca7e284c52d459c8276cbb625a4543a2a6f9a9f8d97', '[\"*\"]', '2025-10-17 22:26:09', NULL, '2025-10-17 22:26:01', '2025-10-17 22:26:09'),
(253, 'App\\Models\\User', 15, 'auth_token', '93adf8de132c53c3b4da2cbc3e4c8405a60a98c1936f81306494a3b10f7827a1', '[\"*\"]', '2025-10-17 22:26:32', NULL, '2025-10-17 22:26:32', '2025-10-17 22:26:32'),
(254, 'App\\Models\\User', 11, 'auth_token', '60b35a338e56b3736ed5771d5d65e4305ad2e7a55b572f55e8bccb6db8dd2397', '[\"*\"]', '2025-10-17 22:50:19', NULL, '2025-10-17 22:50:17', '2025-10-17 22:50:19'),
(255, 'App\\Models\\User', 11, 'auth_token', '80f1270023e5c2ca1cc598ff1ee5f4b6df13fcfa2523924df5f40705eb52cb55', '[\"*\"]', '2025-10-17 22:56:46', NULL, '2025-10-17 22:56:45', '2025-10-17 22:56:46'),
(256, 'App\\Models\\User', 11, 'auth_token', 'b9be3462b69e49a2aedccbcddd5ac8bbc8dbeccf54051a5b10a433392313021f', '[\"*\"]', '2025-10-17 23:04:44', NULL, '2025-10-17 23:04:43', '2025-10-17 23:04:44'),
(257, 'App\\Models\\User', 11, 'auth_token', '7cda26a5667d9471099bf4bc65926f1c17a88bcf9cae6d4d72a15c8d0b80f5fd', '[\"*\"]', '2025-10-17 23:18:09', NULL, '2025-10-17 23:18:08', '2025-10-17 23:18:09'),
(258, 'App\\Models\\User', 11, 'auth_token', 'b493f96a9694e0b58da5b53a45dc42dcdad7017bcae07174259b11727e42e9cb', '[\"*\"]', NULL, NULL, '2025-10-17 23:18:53', '2025-10-17 23:18:53'),
(259, 'App\\Models\\User', 11, 'auth_token', '15593267a2c10063780238c3fb396d5f3de2dae9e707315140aa759fb65607eb', '[\"*\"]', NULL, NULL, '2025-10-17 23:18:58', '2025-10-17 23:18:58'),
(260, 'App\\Models\\User', 11, 'auth_token', '2c1bc0c968c9ab3ecc0d9fa27a381a7454983c1e21261a4120a97c0d38696d71', '[\"*\"]', NULL, NULL, '2025-10-17 23:19:05', '2025-10-17 23:19:05'),
(261, 'App\\Models\\User', 11, 'auth_token', '430faf6311e7c40877d12192c1fc0f32b923420c1db93c746beb0f5113af7e91', '[\"*\"]', '2025-10-17 23:20:04', NULL, '2025-10-17 23:19:48', '2025-10-17 23:20:04'),
(262, 'App\\Models\\User', 11, 'auth_token', 'bd5b6f7263e9c8fa411b8d6b4fd9d2cebb0ab27e797ebe5ed58e0c2c90731312', '[\"*\"]', '2025-10-17 23:23:47', NULL, '2025-10-17 23:22:13', '2025-10-17 23:23:47'),
(263, 'App\\Models\\User', 11, 'auth_token', '3346b22f2274ad84acabc5b0d0d4e17acf20b35b21d029ab06dbda446f4a9808', '[\"*\"]', '2025-10-17 23:36:20', NULL, '2025-10-17 23:35:47', '2025-10-17 23:36:20'),
(264, 'App\\Models\\User', 11, 'auth_token', '1aa44cf5a644c4205d8e0f766c1915de541b8abfa296ddab58ace24a05857ba2', '[\"*\"]', '2025-10-17 23:48:57', NULL, '2025-10-17 23:48:50', '2025-10-17 23:48:57'),
(265, 'App\\Models\\User', 11, 'auth_token', '23c630f0febdb5a007e8385855673a644a58121018a5035d343051098e87c370', '[\"*\"]', '2025-10-18 02:36:07', NULL, '2025-10-18 02:35:53', '2025-10-18 02:36:07'),
(266, 'App\\Models\\User', 11, 'auth_token', 'c142a51ae251f0bc3422039bb0eba13de4073ab350143c2651ae36361682459f', '[\"*\"]', '2025-10-18 02:52:34', NULL, '2025-10-18 02:52:29', '2025-10-18 02:52:34'),
(267, 'App\\Models\\User', 11, 'auth_token', '5bae685987923229071184d9b8919085e0f2cf164efe2d11955d9abd1e1aa2b3', '[\"*\"]', '2025-10-18 02:52:47', NULL, '2025-10-18 02:52:44', '2025-10-18 02:52:47'),
(268, 'App\\Models\\User', 11, 'auth_token', '35428899efcfff2ba838ffb01ff5771a2ed5108c1adb3c93ac54b3d979010f84', '[\"*\"]', '2025-10-18 02:58:57', NULL, '2025-10-18 02:57:30', '2025-10-18 02:58:57'),
(269, 'App\\Models\\User', 11, 'auth_token', '758cc335eef8de6054d248ccb144118c9edea246af27aa5bade490a758d167fc', '[\"*\"]', '2025-10-18 03:01:13', NULL, '2025-10-18 03:00:42', '2025-10-18 03:01:13'),
(270, 'App\\Models\\User', 11, 'auth_token', '60d322dedebd51745d22080cea9fc38829ba9d13cc01a7c0df19f2d773424b72', '[\"*\"]', '2025-10-18 03:05:00', NULL, '2025-10-18 03:05:00', '2025-10-18 03:05:00'),
(271, 'App\\Models\\User', 11, 'auth_token', 'c8a5fac4c8c9bab431c2123703609342b8e24b036e568d067a1b91f85a4368fb', '[\"*\"]', '2025-10-18 03:06:10', NULL, '2025-10-18 03:06:10', '2025-10-18 03:06:10'),
(272, 'App\\Models\\User', 11, 'auth_token', '96ca07ccd8e3f965afe3940540f955ec6401efdd656f2cb64de4c58db87a1165', '[\"*\"]', '2025-10-18 03:06:23', NULL, '2025-10-18 03:06:23', '2025-10-18 03:06:23'),
(273, 'App\\Models\\User', 11, 'auth_token', '8d23bc636c3555c5562d8a4d7cb903401d3848df1ffc4927f2c8c7425129d346', '[\"*\"]', '2025-10-18 03:08:02', NULL, '2025-10-18 03:08:01', '2025-10-18 03:08:02'),
(274, 'App\\Models\\User', 11, 'auth_token', '211418300c92960bde3988ab14874120bc9308d372bcaef84117aef677b6947e', '[\"*\"]', '2025-10-18 03:19:41', NULL, '2025-10-18 03:18:49', '2025-10-18 03:19:41'),
(275, 'App\\Models\\User', 15, 'auth_token', 'a567844fe82d0da39ba5d5e59d58eee670a20e5770e4fc2676bf0ab47d4301ef', '[\"*\"]', '2025-10-18 03:23:02', NULL, '2025-10-18 03:20:12', '2025-10-18 03:23:02'),
(276, 'App\\Models\\User', 11, 'auth_token', 'f741a483c064d8d30f0d8f87e897a5c370232f678c30f027f6acb1129f4bd7a9', '[\"*\"]', '2025-10-18 03:22:57', NULL, '2025-10-18 03:22:20', '2025-10-18 03:22:57'),
(277, 'App\\Models\\User', 11, 'auth_token', '294071e9391b9e6a7321077991ed58b3a6b83f4270cf02217371b068218858a8', '[\"*\"]', '2025-10-18 03:31:54', NULL, '2025-10-18 03:30:49', '2025-10-18 03:31:54'),
(278, 'App\\Models\\User', 15, 'auth_token', '9a10b8c8d255b02e798561229b2c087f101578432b9d8fbb54b399f85cd9a9bc', '[\"*\"]', '2025-10-18 03:34:07', NULL, '2025-10-18 03:31:04', '2025-10-18 03:34:07'),
(279, 'App\\Models\\User', 11, 'auth_token', '0df475675b53b2b1a6c1257dfc260cb9854f9d6c907d869c478da9c622db6d9a', '[\"*\"]', '2025-10-19 18:39:04', NULL, '2025-10-18 03:34:55', '2025-10-19 18:39:04'),
(280, 'App\\Models\\User', 11, 'auth_token', '8dbfd725b913593ef73d7b716a8c8d56a08a3cf21e9c38f0cc83540b0073e2f7', '[\"*\"]', '2025-10-18 03:38:26', NULL, '2025-10-18 03:38:26', '2025-10-18 03:38:26'),
(281, 'App\\Models\\User', 15, 'auth_token', 'e86296df4d512eff2c1627ca9a8d095516b51c07f3113e32187710171d99da8e', '[\"*\"]', '2025-10-18 03:38:53', NULL, '2025-10-18 03:38:35', '2025-10-18 03:38:53'),
(282, 'App\\Models\\User', 15, 'auth_token', '2087a4ba1e857a424090396f318a55bf10b3b7c79629ae66477c15d20723d467', '[\"*\"]', '2025-10-18 03:42:04', NULL, '2025-10-18 03:42:03', '2025-10-18 03:42:04'),
(283, 'App\\Models\\User', 15, 'auth_token', 'f028075715e92301114a8f7da0a9e1695c6af76569179626cfc266508d2e1be6', '[\"*\"]', '2025-10-18 04:16:39', NULL, '2025-10-18 04:16:37', '2025-10-18 04:16:39'),
(284, 'App\\Models\\User', 15, 'auth_token', '598cad2ff52734bc0bf06b98578ad620a104f0c44f05a14c4ffe350e7facd0f7', '[\"*\"]', '2025-10-18 04:17:48', NULL, '2025-10-18 04:17:43', '2025-10-18 04:17:48'),
(285, 'App\\Models\\User', 15, 'auth_token', '6ad493f3adf1bcf2dcfffd39081f03135723049d96f1babd305e908156fb9e7b', '[\"*\"]', '2025-10-18 04:18:59', NULL, '2025-10-18 04:18:48', '2025-10-18 04:18:59'),
(286, 'App\\Models\\User', 15, 'auth_token', 'e2b59c4273565833a06c7890de09a2e0f1304ee844e81ebfaa465523d5ca97d8', '[\"*\"]', '2025-10-18 04:23:04', NULL, '2025-10-18 04:23:03', '2025-10-18 04:23:04'),
(287, 'App\\Models\\User', 15, 'auth_token', '65e9164aeacf7dbb2771dfbe248e77551b332b8d0e901dae6fa6ae7be4224613', '[\"*\"]', '2025-10-18 04:24:01', NULL, '2025-10-18 04:23:56', '2025-10-18 04:24:01'),
(288, 'App\\Models\\User', 15, 'auth_token', '32f09eff14d1eaa0a754879cdf9ae216bbf2a77c9674d15af7dba4640b1f428a', '[\"*\"]', '2025-10-18 04:37:10', NULL, '2025-10-18 04:37:09', '2025-10-18 04:37:10'),
(289, 'App\\Models\\User', 15, 'auth_token', '61d9da8566a84d7c3bbf568a3184f729a7a8e0ace33d336cb21ef61e33137250', '[\"*\"]', '2025-10-18 04:41:13', NULL, '2025-10-18 04:41:10', '2025-10-18 04:41:13'),
(290, 'App\\Models\\User', 15, 'auth_token', '5b2641f7e5a977395418d30334f04b1c5e35556a1f467995db10ddf5e08d32c8', '[\"*\"]', '2025-10-18 04:45:13', NULL, '2025-10-18 04:44:32', '2025-10-18 04:45:13'),
(291, 'App\\Models\\User', 20, 'auth_token', 'ab72cf9185f56f4ecb3c60743b0608ed43c22c5bbaca12ca3cdd2f392e6821dc', '[\"*\"]', NULL, NULL, '2025-10-18 04:46:00', '2025-10-18 04:46:00'),
(292, 'App\\Models\\User', 20, 'auth_token', '0872b593bc84d4b4f48f896a61fb0592c48e9f90771ab47537ffed55bc7a2022', '[\"*\"]', '2025-10-18 04:46:09', NULL, '2025-10-18 04:46:07', '2025-10-18 04:46:09'),
(293, 'App\\Models\\User', 20, 'auth_token', 'ccbbda9b8e8f15170d2342c95dbdd8d856e6fb20ed7d3006f3cd7ef422d55913', '[\"*\"]', '2025-10-18 04:57:59', NULL, '2025-10-18 04:57:36', '2025-10-18 04:57:59'),
(294, 'App\\Models\\User', 20, 'auth_token', '27cc316452bff56440411fe618b3bb3974438ed49abc86e4092557fe1cfe4576', '[\"*\"]', '2025-10-18 04:59:25', NULL, '2025-10-18 04:59:20', '2025-10-18 04:59:25'),
(295, 'App\\Models\\User', 20, 'auth_token', 'b78d4d59dbc39a83da83fab75af80185ca6b99a9c0becb3e0d9dde2875a8815c', '[\"*\"]', '2025-10-18 05:09:49', NULL, '2025-10-18 05:00:58', '2025-10-18 05:09:49'),
(296, 'App\\Models\\User', 20, 'auth_token', 'e0edfc895c09f51a5cf8a16ef8265e732025e3296967f87de9a33d4efecef919', '[\"*\"]', '2025-10-18 05:10:46', NULL, '2025-10-18 05:10:32', '2025-10-18 05:10:46'),
(297, 'App\\Models\\User', 20, 'auth_token', '672599e637779422b20ed250eaad4c9e977d5c42cf816febe0952569e3e3581f', '[\"*\"]', '2025-10-19 04:52:48', NULL, '2025-10-18 05:10:53', '2025-10-19 04:52:48'),
(298, 'App\\Models\\User', 15, 'auth_token', '36acb069ae689c07d67c4674369fa45ebc6cee6d745bb137fbb82742fceb7b2a', '[\"*\"]', NULL, NULL, '2025-10-19 00:51:56', '2025-10-19 00:51:56'),
(299, 'App\\Models\\User', 20, 'auth_token', '6a8ff58a467a32be6ef7d7217b65e4332a190bf240338774271682294d841dbb', '[\"*\"]', '2025-10-19 20:07:41', NULL, '2025-10-19 04:53:15', '2025-10-19 20:07:41'),
(300, 'App\\Models\\User', 20, 'auth_token', 'a8b065ac6643af1da2fa69c54b3cae5caf125dec87d51669d4bff6866ddfe31f', '[\"*\"]', '2025-10-19 18:45:33', NULL, '2025-10-19 18:35:59', '2025-10-19 18:45:33'),
(301, 'App\\Models\\User', 20, 'auth_token', '5721f713b21019a432b26f086b17cb50aba65fdcff982e28464e17a67455abe9', '[\"*\"]', '2025-10-19 18:54:21', NULL, '2025-10-19 18:46:47', '2025-10-19 18:54:21'),
(302, 'App\\Models\\User', 20, 'auth_token', '67ac3a022e4c51c6b5e30a26f78317afab1682af31c61a8a295d1a73107ed91c', '[\"*\"]', '2025-10-19 18:58:18', NULL, '2025-10-19 18:55:06', '2025-10-19 18:58:18'),
(303, 'App\\Models\\User', 20, 'auth_token', '6e249e482f0335675b633d233a8ab2df23be9eebd18e035772b01d787214cf5c', '[\"*\"]', '2025-10-19 19:03:03', NULL, '2025-10-19 18:59:27', '2025-10-19 19:03:03'),
(304, 'App\\Models\\User', 20, 'auth_token', 'bdade24b1477045430ed7c14546c17444313786b722904720c42f5ae1e6c4081', '[\"*\"]', '2025-10-19 19:15:19', NULL, '2025-10-19 19:03:59', '2025-10-19 19:15:19');
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(305, 'App\\Models\\User', 20, 'auth_token', '132d96be1c0311c118b4267c5905fc800cf6b700ade8a6416ccb61cbf316ca60', '[\"*\"]', '2025-10-19 19:31:25', NULL, '2025-10-19 19:24:00', '2025-10-19 19:31:25'),
(306, 'App\\Models\\User', 20, 'auth_token', '2d609f93cb79f1e717da3175674d144cb0a0d8e7a5f59bd7f21b01b90761b66f', '[\"*\"]', NULL, NULL, '2025-10-19 19:55:58', '2025-10-19 19:55:58'),
(307, 'App\\Models\\User', 20, 'auth_token', 'd84d4179225a1f6a0e3489f0e952835c3451db2294d0c64e72a7ca77f3aaca5a', '[\"*\"]', NULL, NULL, '2025-10-19 19:56:00', '2025-10-19 19:56:00'),
(308, 'App\\Models\\User', 20, 'auth_token', '19ebe78a442e910de388e558473fbeac90ddbcca31cb7afb41174503f3fc2548', '[\"*\"]', NULL, NULL, '2025-10-19 19:56:28', '2025-10-19 19:56:28'),
(309, 'App\\Models\\User', 20, 'auth_token', 'adb4824c0866808ed7a9ab2f68c113b918fc36a73ec9e8dd5429611125d72a89', '[\"*\"]', NULL, NULL, '2025-10-19 19:56:32', '2025-10-19 19:56:32'),
(310, 'App\\Models\\User', 15, 'auth_token', '51d49e6dedb00c2a1ca300d95d56e736351348c6b90f1674747ab22d40fdfb5c', '[\"*\"]', '2025-10-19 20:09:16', NULL, '2025-10-19 20:07:49', '2025-10-19 20:09:16'),
(311, 'App\\Models\\User', 20, 'auth_token', '83470456716f443e89f25ea46bc018f70bccbc41ca22558199f7d2aab47c0c16', '[\"*\"]', '2025-10-19 20:12:30', NULL, '2025-10-19 20:09:28', '2025-10-19 20:12:30'),
(312, 'App\\Models\\User', 11, 'auth_token', '7646cafd0d9b5faa03f807addc50a188b18b67d677f1381958aa0307be3742c8', '[\"*\"]', '2025-10-19 20:10:19', NULL, '2025-10-19 20:10:18', '2025-10-19 20:10:19'),
(313, 'App\\Models\\User', 11, 'auth_token', 'efa0ec43299c229e98d0fe1146d82c6cc10b9bf2a80bfc27e1481b483e2b4749', '[\"*\"]', '2025-10-19 20:55:19', NULL, '2025-10-19 20:10:34', '2025-10-19 20:55:19'),
(314, 'App\\Models\\User', 15, 'auth_token', '282796d223551da704484dc2f9300b945c80720bc78da559f8be7d03fd49a1a2', '[\"*\"]', '2025-10-21 17:00:11', NULL, '2025-10-19 20:12:53', '2025-10-21 17:00:11'),
(315, 'App\\Models\\User', 15, 'auth_token', '6cf07f8651af0d054184772e6a78d525b77c14d5e839a987bbac30a273a4c3a4', '[\"*\"]', '2025-10-19 20:28:00', NULL, '2025-10-19 20:27:13', '2025-10-19 20:28:00'),
(316, 'App\\Models\\User', 11, 'auth_token', 'e3c0cfc195e10a9c2d4981d9d400b55a0cd74aa45e2e9438526c480edf1a4e0c', '[\"*\"]', '2025-10-19 20:43:21', NULL, '2025-10-19 20:41:50', '2025-10-19 20:43:21'),
(317, 'App\\Models\\User', 11, 'auth_token', '5785b958f460f1f9aa4e8980533bd5619203f4ba3befe3fdc6aa020eb25203f0', '[\"*\"]', '2025-10-19 20:50:56', NULL, '2025-10-19 20:48:29', '2025-10-19 20:50:56'),
(318, 'App\\Models\\User', 20, 'auth_token', 'c82a03b7d681f9ffb3b137003ee3cb9219cf99b1a470275f983f5557b6e2f1fc', '[\"*\"]', '2025-10-23 05:31:26', NULL, '2025-10-19 20:55:42', '2025-10-23 05:31:26'),
(319, 'App\\Models\\User', 11, 'auth_token', 'c9131ebe2e1ba3578dc28f51152cdf95d79b05e2aa40a12a45fca8776f3c9d70', '[\"*\"]', '2025-10-19 21:13:52', NULL, '2025-10-19 21:00:09', '2025-10-19 21:13:52'),
(320, 'App\\Models\\User', 11, 'auth_token', 'ae0830d442ae10dd7cad575b92d55dcedcd2f0fc96f8410a2982e71e1f25cf41', '[\"*\"]', '2025-10-19 21:34:37', NULL, '2025-10-19 21:33:05', '2025-10-19 21:34:37'),
(321, 'App\\Models\\User', 11, 'auth_token', '0e2af47d5209898675846e3c0ea3707364c51ae52bf84825c456134cd9013de7', '[\"*\"]', '2025-10-19 22:24:46', NULL, '2025-10-19 22:24:01', '2025-10-19 22:24:46'),
(322, 'App\\Models\\User', 11, 'auth_token', '4ad3feff20b03bb6c53312c50db2aa5fe687c3443aacb36586b52b908628a72d', '[\"*\"]', '2025-10-21 17:02:13', NULL, '2025-10-21 16:57:15', '2025-10-21 17:02:13'),
(323, 'App\\Models\\User', 15, 'auth_token', '08c84872d93189f3fe603b5ed720a8d0c80c65f0c48ca793de4b79575ad01926', '[\"*\"]', '2025-10-22 09:00:44', NULL, '2025-10-21 17:00:24', '2025-10-22 09:00:44'),
(324, 'App\\Models\\User', 13, 'auth_token', 'b8585fe655903ca70703c3ba9120e1894d64cd2e48a2ce59511e00e74933a4ae', '[\"*\"]', NULL, NULL, '2025-10-21 18:29:18', '2025-10-21 18:29:18'),
(325, 'App\\Models\\User', 20, 'auth_token', '90e85f8b21373a36bf6d28683d9fbcc48d562a00ec15306b8a2a793206a69008', '[\"*\"]', '2025-10-21 18:45:01', NULL, '2025-10-21 18:44:52', '2025-10-21 18:45:01'),
(326, 'App\\Models\\User', 11, 'auth_token', 'add36072905390172bc50721424b6e29c43ef85d1a6a37b8ae4ea75f66fe11b3', '[\"*\"]', '2025-10-22 00:11:03', NULL, '2025-10-22 00:11:00', '2025-10-22 00:11:03'),
(327, 'App\\Models\\User', 11, 'auth_token', '08b26e8a5374d2bbe1db5dce4f44a999158c677db06d75f20eef2e0eb8b26744', '[\"*\"]', '2025-10-22 08:59:37', NULL, '2025-10-22 00:11:25', '2025-10-22 08:59:37'),
(328, 'App\\Models\\User', 20, 'auth_token', '1eb48ed7114b35f55db404e5d68d603144c8ab005d4c5c9f2f2b9b6a23756127', '[\"*\"]', '2025-10-23 02:51:04', NULL, '2025-10-22 00:17:29', '2025-10-23 02:51:04'),
(329, 'App\\Models\\User', 13, 'auth_token', 'ce579a700bac2d1adfc1c0491d55ca5947f9f94a7a2f998116dd834366a4713a', '[\"*\"]', NULL, NULL, '2025-10-22 00:40:26', '2025-10-22 00:40:26'),
(330, 'App\\Models\\User', 13, 'auth_token', '8e2c5e4632880176d9670b9301fce5915d0e032f9b2d529c569b0742e0d8e61f', '[\"*\"]', NULL, NULL, '2025-10-22 00:42:09', '2025-10-22 00:42:09'),
(331, 'App\\Models\\User', 13, 'auth_token', '1b786842933af7ead87006b72137ad432128e04c28d03c4dd96c895c69847e03', '[\"*\"]', NULL, NULL, '2025-10-22 00:44:05', '2025-10-22 00:44:05'),
(332, 'App\\Models\\User', 13, 'auth_token', '624de019acd30dc725780b5b20431cf4e685eda2997a17129cc02a7360bdb5cb', '[\"*\"]', '2025-10-22 00:50:38', NULL, '2025-10-22 00:49:18', '2025-10-22 00:50:38'),
(333, 'App\\Models\\User', 14, 'auth_token', 'e3bfee506266b93d0a4c33b8874b904c7c18c77f212751b4d42a671932905c3f', '[\"*\"]', NULL, NULL, '2025-10-22 00:55:34', '2025-10-22 00:55:34'),
(334, 'App\\Models\\User', 21, 'auth_token', 'b1b33c60fdcb8babc3a52bf4a8beea55ad8209cc7c611cc32d9a827c4b9d4473', '[\"*\"]', NULL, NULL, '2025-10-22 00:56:59', '2025-10-22 00:56:59'),
(335, 'App\\Models\\User', 21, 'auth_token', '1d4b9d01603cbc640643da8a70ed9ff1b9499abf081e45089f7a66764f953050', '[\"*\"]', NULL, NULL, '2025-10-22 00:58:05', '2025-10-22 00:58:05'),
(336, 'App\\Models\\User', 21, 'auth_token', '16e2c0e43bf61fc39f98b21be0248c949fa373c3459d47d5cc3eda342fb83032', '[\"*\"]', NULL, NULL, '2025-10-22 00:58:13', '2025-10-22 00:58:13'),
(337, 'App\\Models\\User', 22, 'auth_token', '015bb06a4f7c3963c4ba445320a629fa686a1e838853c077dbaf0cf28cdb2e23', '[\"*\"]', NULL, NULL, '2025-10-22 00:59:29', '2025-10-22 00:59:29'),
(338, 'App\\Models\\User', 22, 'auth_token', '3b50d31fb58841d317a6a60ca0a879258d50813efb7f7d1253a35cddcd189609', '[\"*\"]', NULL, NULL, '2025-10-22 00:59:36', '2025-10-22 00:59:36'),
(339, 'App\\Models\\User', 22, 'auth_token', '95f04c1677a8a9faefd2de425c92ad30574c2c5ff9debc15d84fa1eedf16bf2a', '[\"*\"]', NULL, NULL, '2025-10-22 01:04:03', '2025-10-22 01:04:03'),
(340, 'App\\Models\\User', 22, 'auth_token', 'f41a6bb7eb353a55763ad576b0c61d63f76529e74acfbe495437e05b69856ce6', '[\"*\"]', NULL, NULL, '2025-10-22 01:04:30', '2025-10-22 01:04:30'),
(341, 'App\\Models\\User', 13, 'auth_token', '7150ae30436e0c49de5e45e969868e9a1d151e3994bd5cf7264cbfb031ffa570', '[\"*\"]', NULL, NULL, '2025-10-22 01:09:32', '2025-10-22 01:09:32'),
(342, 'App\\Models\\User', 13, 'auth_token', 'a48a35c0bddbc0ef8038e80bf87c9ccafb0232fbb064d72a941e898f64c35b92', '[\"*\"]', NULL, NULL, '2025-10-22 01:10:07', '2025-10-22 01:10:07'),
(343, 'App\\Models\\User', 23, 'auth_token', '5fc928ce3372fbce6545527ce5f02adebe16334e7af9ba48895f4ee6384660e8', '[\"*\"]', NULL, NULL, '2025-10-22 01:12:14', '2025-10-22 01:12:14'),
(344, 'App\\Models\\User', 23, 'auth_token', '3865a1ea70b91c278cc2cc0947bd17465e2154e40844bad6ebd0961bb0049501', '[\"*\"]', NULL, NULL, '2025-10-22 01:12:23', '2025-10-22 01:12:23'),
(345, 'App\\Models\\User', 13, 'auth_token', '83f4c5341cce124582cbee2cbc77dda44edda5c9fb2a31c61d0b9675d14b0fa6', '[\"*\"]', NULL, NULL, '2025-10-22 01:20:28', '2025-10-22 01:20:28'),
(346, 'App\\Models\\User', 14, 'auth_token', '70c1129e3f708531289177a8cb858473cc75be8182e8128bc12789550e57be60', '[\"*\"]', NULL, NULL, '2025-10-22 01:20:45', '2025-10-22 01:20:45'),
(347, 'App\\Models\\User', 13, 'auth_token', 'c94aad80900f2817c6f9173d6d1640dafb68a52a368a4c133055d2511b3437c3', '[\"*\"]', NULL, NULL, '2025-10-22 01:31:50', '2025-10-22 01:31:50'),
(348, 'App\\Models\\User', 13, 'auth_token', 'd5b425470c093bc7e58dc20a2b3eccdfd4004e6e2a11ade174edf158b30c7ac4', '[\"*\"]', NULL, NULL, '2025-10-22 01:32:36', '2025-10-22 01:32:36'),
(349, 'App\\Models\\User', 13, 'auth_token', '3c0a59c500a96ba5a22165e6d822c962055413bd31c3c65d2e42fbae7a317a63', '[\"*\"]', NULL, NULL, '2025-10-22 01:32:50', '2025-10-22 01:32:50'),
(350, 'App\\Models\\User', 13, 'auth_token', 'bdb3b955caaecca5a249f3eb7a486e757e9fcd1984518620244476120719b76a', '[\"*\"]', NULL, NULL, '2025-10-22 08:41:52', '2025-10-22 08:41:52'),
(351, 'App\\Models\\User', 24, 'auth_token', '561111836a82774ab564a6c3d64777e7a96acdcc3342eddaa1eab39731872c65', '[\"*\"]', NULL, NULL, '2025-10-22 08:42:24', '2025-10-22 08:42:24'),
(352, 'App\\Models\\User', 24, 'auth_token', 'dfbefec9633b2f2bbc7cce76f7835f2594e5351c1ea06fa605d294c52262e915', '[\"*\"]', NULL, NULL, '2025-10-22 08:43:07', '2025-10-22 08:43:07'),
(353, 'App\\Models\\User', 24, 'auth_token', 'db053a6db560ce1e1747b8f5070f565999f0dc63966cdad2fed5342c0e7dbc8f', '[\"*\"]', '2025-10-22 08:44:50', NULL, '2025-10-22 08:43:50', '2025-10-22 08:44:50'),
(354, 'App\\Models\\User', 11, 'auth_token', 'd6b81067f354892dabd7795ff6647077ba14acbc748f7af61af3ffc4a6ac524b', '[\"*\"]', '2025-10-23 03:23:08', NULL, '2025-10-23 02:52:54', '2025-10-23 03:23:08'),
(355, 'App\\Models\\User', 15, 'auth_token', 'd09dd6e4a97c647eaa8da1014a0f235a874719bd46814af5dded5a9a1fdfc0cd', '[\"*\"]', '2025-10-23 03:20:49', NULL, '2025-10-23 02:53:22', '2025-10-23 03:20:49'),
(356, 'App\\Models\\User', 20, 'auth_token', 'a0a11dc3a7c5aa7e7cb4a388b2e68e3331da14583b91f2494cc9589062f45957', '[\"*\"]', '2025-10-23 05:25:02', NULL, '2025-10-23 03:10:41', '2025-10-23 05:25:02'),
(357, 'App\\Models\\User', 13, 'auth_token', 'edff48afc9f2f62779bedaea4ca522dc40f971069dc57d5e810ee3f66e8afc3d', '[\"*\"]', NULL, NULL, '2025-10-23 05:25:23', '2025-10-23 05:25:23'),
(358, 'App\\Models\\User', 15, 'auth_token', '3b69cf141c91b391a927a155a54d8986169108f27ae3595b169d9e8d57695437', '[\"*\"]', '2025-10-26 07:58:55', NULL, '2025-10-23 05:27:42', '2025-10-26 07:58:55'),
(359, 'App\\Models\\User', 11, 'auth_token', '6088bbaec7f08633986176798907e88e30a07f9ba3fda2ec6aa55bc5fc7f175d', '[\"*\"]', '2025-10-23 05:34:10', NULL, '2025-10-23 05:27:53', '2025-10-23 05:34:10'),
(360, 'App\\Models\\User', 16, 'auth_token', '86f8ddb5ac360eb286b6c9d54e069c03b3eaf1c6edd061f0bcd45e9ff66e1eb9', '[\"*\"]', '2025-10-26 07:59:06', NULL, '2025-10-26 07:59:05', '2025-10-26 07:59:06'),
(361, 'App\\Models\\User', 15, 'auth_token', '67c1c4bed1ecb520889e3e5deeb948c500c2abb35378748e790c1e6e48155399', '[\"*\"]', '2025-11-07 01:56:13', NULL, '2025-10-26 07:59:17', '2025-11-07 01:56:13'),
(362, 'App\\Models\\User', 11, 'auth_token', '243bc6a8a80ef72db7ca90f3ae2c6b7247812adbe501c1dc5973e17ac029def3', '[\"*\"]', '2025-11-07 01:56:08', NULL, '2025-11-07 01:55:05', '2025-11-07 01:56:08'),
(363, 'App\\Models\\User', 15, 'auth_token', '6b06e317771189320ec05ab8daf8b1bfb1e5703a1cf3bb0c2e0e6f65d113f26b', '[\"*\"]', '2025-11-07 03:35:22', NULL, '2025-11-07 01:56:27', '2025-11-07 03:35:22'),
(364, 'App\\Models\\User', 11, 'auth_token', '2713f5cc149b608c6f09ba6c7568a9c0e632ea3b1d51f07a8ef4a071bd6a56d9', '[\"*\"]', '2025-11-07 05:58:40', NULL, '2025-11-07 01:56:41', '2025-11-07 05:58:40'),
(365, 'App\\Models\\User', 15, 'auth_token', '921a6b1bf4827ec3593a791bcf66865bb9d6d00726b13712f6f19a2d8a4eeea2', '[\"*\"]', '2025-11-07 05:25:01', NULL, '2025-11-07 04:05:36', '2025-11-07 05:25:01'),
(366, 'App\\Models\\User', 20, 'auth_token', 'b12fa90e0532ec6ab682e337264bb9c5b2e5c4e100bbd85443f354328dd2d200', '[\"*\"]', '2025-11-07 05:25:59', NULL, '2025-11-07 05:25:33', '2025-11-07 05:25:59'),
(367, 'App\\Models\\User', 20, 'auth_token', 'ec4f0366ed6fe1913826096759cad3e018b66f1733657f9a3188598d1e3a03b3', '[\"*\"]', '2025-11-07 05:58:35', NULL, '2025-11-07 05:47:03', '2025-11-07 05:58:35');

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

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('XMDehI4mRY7f5Q710UV5r7dTtxQxrzWpVrGisDqS', NULL, '192.168.100.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNW1laFlYUDg5MEQzQURqVzdBdDNZZWVXYTdOVnhxOHAzQ3RLcmdYbiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6OTI6Imh0dHA6Ly8xOTIuMTY4LjEwMC4xMzo4MDAwL21pZHRyYW5zL2NoZWNrb3V0P3NuYXBfdG9rZW49ZTE1YjQ1OWUtYjYwZC00Y2FiLTg0ZjktOTZlMDJhYjdkZGJjIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1762493112);

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
(27, 16, 1, '09:00:00', '12:00:00', '2025-10-12 23:04:55', '2025-10-12 23:04:55'),
(28, 16, 1, '12:30:00', '15:00:00', '2025-10-12 23:04:55', '2025-10-12 23:04:55'),
(29, 16, 2, '09:00:00', '12:00:00', '2025-10-12 23:04:55', '2025-10-12 23:04:55'),
(30, 16, 2, '12:30:00', '15:30:00', '2025-10-12 23:04:55', '2025-10-12 23:04:55'),
(31, 16, 3, '09:00:00', '12:00:00', '2025-10-12 23:04:55', '2025-10-12 23:04:55'),
(32, 16, 3, '12:30:00', '15:30:00', '2025-10-12 23:04:55', '2025-10-12 23:04:55'),
(33, 16, 4, '09:00:00', '12:30:00', '2025-10-12 23:04:55', '2025-10-12 23:04:55'),
(34, 16, 4, '12:30:00', '15:30:00', '2025-10-12 23:04:55', '2025-10-12 23:04:55'),
(35, 16, 5, '09:00:00', '11:00:00', '2025-10-12 23:04:55', '2025-10-12 23:04:55'),
(36, 16, 5, '01:00:00', '03:30:00', '2025-10-12 23:04:55', '2025-10-12 23:04:55'),
(37, 17, 1, '09:00:00', '15:00:00', '2025-10-12 23:09:13', '2025-10-12 23:09:13'),
(38, 17, 2, '09:00:00', '15:00:00', '2025-10-12 23:09:13', '2025-10-12 23:09:13'),
(39, 17, 3, '09:00:00', '15:00:00', '2025-10-12 23:09:13', '2025-10-12 23:09:13'),
(40, 17, 4, '09:00:00', '15:00:00', '2025-10-12 23:09:13', '2025-10-12 23:09:13'),
(41, 17, 5, '09:00:00', '15:00:00', '2025-10-12 23:09:13', '2025-10-12 23:09:13'),
(42, 17, 6, '09:00:00', '15:00:00', '2025-10-12 23:09:13', '2025-10-12 23:09:13'),
(43, 17, 7, '09:00:00', '15:00:00', '2025-10-12 23:09:13', '2025-10-12 23:09:13'),
(54, 19, 1, '09:00:00', '12:00:00', '2025-10-15 02:10:32', '2025-10-15 02:10:32'),
(55, 15, 1, '09:00:00', '12:00:00', '2025-10-23 05:30:22', '2025-10-23 05:30:22'),
(56, 15, 1, '13:00:00', '16:00:00', '2025-10-23 05:30:22', '2025-10-23 05:30:22'),
(57, 15, 2, '09:00:00', '12:00:00', '2025-10-23 05:30:22', '2025-10-23 05:30:22'),
(58, 15, 2, '13:00:00', '16:00:00', '2025-10-23 05:30:22', '2025-10-23 05:30:22'),
(59, 15, 3, '09:00:00', '12:00:00', '2025-10-23 05:30:22', '2025-10-23 05:30:22'),
(60, 15, 3, '13:00:00', '16:00:00', '2025-10-23 05:30:22', '2025-10-23 05:30:22'),
(61, 15, 4, '09:00:00', '12:00:00', '2025-10-23 05:30:22', '2025-10-23 05:30:22'),
(62, 15, 4, '13:00:00', '16:00:00', '2025-10-23 05:30:22', '2025-10-23 05:30:22'),
(63, 15, 5, '09:00:00', '11:00:00', '2025-10-23 05:30:22', '2025-10-23 05:30:22'),
(64, 15, 5, '14:00:00', '15:00:00', '2025-10-23 05:30:22', '2025-10-23 05:30:22');

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
(8, 15, 'storage/therapist_pictures/eqrogmjy1UT6LhgOy1VWGqwmor8XSso2O8W0tN1L.png', 'S1 Psikologi Polman', 350000, 5, '[\"Klinis Dewasa\"]', 'Kecemasan', '2025-10-12 22:53:49', '2025-10-12 22:53:49'),
(9, 16, 'storage/therapist_pictures/sV86NIEjVlfPWc94YyTh7rfQXucz3jkvHCXAkF1r.png', 'S2 Psikologi Polman', 300000, 7, '[\"Klinis Anak dan Remaja\"]', 'Depresi', '2025-10-12 23:04:55', '2025-10-12 23:04:55'),
(10, 17, 'storage/therapist_pictures/dzt6tck1yz6wzikHWwXWIk3MmHJUSOqHqt0tuaBk.png', 'S3 Psikologi Polman', 400000, 9, '[\"Klinis Pendidikan\"]', 'Hubungan', '2025-10-12 23:09:13', '2025-10-12 23:09:13'),
(11, 19, 'storage/therapist_pictures/5RWK1ONmvn8sEZDUbjUlE7PJyR48ADe8KbBoYMoP.png', 'S1 Psikologi Unpad', 300000, 3, '[\"Klinis Dewasa\", \"Klinis Pendidikan\"]', 'Kecemasan, Deptesi, Hubungan', '2025-10-15 02:10:32', '2025-10-15 02:10:32');

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
(11, 'castreld', 'Firaas Raihansyah Rizqullah', 'hulukotak@gmail.com', NULL, '2025-10-12 22:09:03', '2025-10-18 03:22:44', 'eyJpdiI6IkREUEpSRkpJSnVOZHVXRWhxeEdDQVE9PSIsInZhbHVlIjoiMVhNa1lpOEl1eFZicmtkK1NDQXArQT09IiwibWFjIjoiOWJmMWFiMGY4ZjZjMGMxYmFlNGYyMDY0MjNlNGY1MGQ4NTMxNWE3MTE1Njg5ODc0NzJjZTM4MTEyYjNiYzA5MSIsInRhZyI6IiJ9', 'pria', 'eyJpdiI6IjVPR3Q3Y2FWRE1iTWRzL29yVEhmMkE9PSIsInZhbHVlIjoiSFJFYU0vQmdiUTB4M0FMVkJTdkpJQT09IiwibWFjIjoiNTQ5OGM2MmU1MjE5MWEzYmNiMDgyNGQzNzM3ODY1OGNmNTg2NWM2MWM1N2M4ZmRhYTBhNDgxNDZmZWZkYzA2MiIsInRhZyI6IiJ9', '$2y$12$FjZFkT.6hiIVCB9ikaDWwe.lDT6sPJVLwYxDoJc4p/YxL4tKYH4Fi', 'no', 'Umum', 'klien', NULL, 'storage/profilepictures/1760782964_11.jpg'),
(12, 'wanitauser', 'Wanita User', 'wanitauser@gmail.com', NULL, '2025-10-12 22:10:17', '2025-10-12 22:10:17', 'eyJpdiI6IlpSa0J5bVJpSVlRVTBBRU91WXR2dlE9PSIsInZhbHVlIjoiVU5wZHltR20zNzdiOHNrN3daZlhOUT09IiwibWFjIjoiODMyZTI1ZGY2NjNjYjQ0ZjI4YjFjMjU3MmI1NmQyYjcwYTVhYjQ0ODFiMWZjZDRjNGZiZWRlMGE4MTMzNGZmZCIsInRhZyI6IiJ9', 'wanita', 'eyJpdiI6Ik9CNHhuaGUzS3JtWUwrRERRM3RqcHc9PSIsInZhbHVlIjoiY1pWazFaTjA4d0hMUTVEMkFyKzJIUT09IiwibWFjIjoiODZiYTFjNmQzOGU1MWNhZDhmYTk5YzY1ZGNjZDVhY2IzODJkYTJmOGUwMjZlNGEwMmIwNjQ4MTg4NGVjNDJmZCIsInRhZyI6IiJ9', '$2y$12$zeAXVuRiaHWAGSu9HhEiTe0T2YzmqynteSE6UOzvtQGq1jiWmdaBK', 'yes', 'Umum', 'klien', NULL, 'storage/profilepictures/woman_placeholder.png'),
(13, 'priauser', 'Pria User', 'priauser@gmail.com', NULL, '2025-10-12 22:11:03', '2025-10-22 00:50:39', 'eyJpdiI6IjBDbTNnQkhJRHI5R0prVm0xVk90UUE9PSIsInZhbHVlIjoiQ1V2NWZBaEtvYWM2Ry9SUVpHTHhUZz09IiwibWFjIjoiOGFjNDljNmE1MjZmMzVkYjA1YzA5NjgyZjZmYmMwYjNiZjRhNTNlYTJmNmVhOTY4ZDM5ZGZiYzRiNGFlNDA2MCIsInRhZyI6IiJ9', 'pria', 'eyJpdiI6IklPQmQvdFNsY0EyRmdNL2dIT1VoM2c9PSIsInZhbHVlIjoiY1FpaUFWWTREUzdhWWdoYnJoM0ltUT09IiwibWFjIjoiNTgyMzVjYjFlZDJhODZhNjFkMzBiMWEwN2MwMGYyNmM4ODdhZmZkOTE2M2IxMWM5YmY2MmE0ZGM1OTRmMDE3YiIsInRhZyI6IiJ9', '$2y$12$MYcJoSRM8ax2zMOVZOtBiOP7gHKSueFLNt2/s9fXMTwTySTXAe7c2', 'yes', 'Umum', 'klien', NULL, 'storage/profilepictures/man_placeholder.png'),
(14, 'admin', 'Admin', 'admin@gmail.com', NULL, '2025-10-12 22:11:43', '2025-10-12 23:10:26', 'eyJpdiI6ImF5bE9VRWZZMDdxV3h2MGtZTEVHYWc9PSIsInZhbHVlIjoiTFFGTldYSW8vbEhuMFBOV0dFVDB1QT09IiwibWFjIjoiNjFiYzRhNGM2N2Q2ZTRlNmM5ZDUzYmJkYzczODk1OWU1NmUxODhhMzQ1ZjA1N2QwNzFjZjU1OWE0OTMwMTRhMCIsInRhZyI6IiJ9', 'pria', 'eyJpdiI6ImQxVGVtUGd6UEpOOEZ1dlpvcFlqY2c9PSIsInZhbHVlIjoiclB5ZTJQbWsyaVgvRkQ5eUYwVS9hUT09IiwibWFjIjoiMjZhN2IxZTllOWRjMDUzMWFkMjY1M2E0MWU1ZjQwMmFjZmI4Y2RlM2JkNDdjZGY2YTViYWNkZTllN2Q5M2NmMSIsInRhZyI6IiJ9', '$2y$12$28mfa4KG3dNakr6vUiKw3uliCbiN/YA.fvtnvHXvuxW03lGF1aN8S', 'yes', 'Umum', 'admin', NULL, 'storage/profilepictures/1760335826_14.png'),
(15, 'psikologuser1', 'Psikolog User 1', 'psikologuser1@gmail.com', NULL, '2025-10-12 22:49:04', '2025-10-12 23:09:38', 'eyJpdiI6IjVyaXNZNWxmZGJuUzYrb1N4OXhtU2c9PSIsInZhbHVlIjoiMlJUbFppcEoyVG9DSGhHSitHQzhTQT09IiwibWFjIjoiYTlhZGYxNWFjOGI1ZDdmMjdkZDQwMDY3MDA0MWRiNWE1OWMzNGQxZTYwNzcyN2E5YTNkMTE1ZmExOGM5NzhkNCIsInRhZyI6IiJ9', 'wanita', 'eyJpdiI6IklSMGE3c3IvaGVZamM4cGU2SENzeGc9PSIsInZhbHVlIjoiOHBjUXdiVGFuUFlLaXlhbS84clI5UT09IiwibWFjIjoiYTA5OWMyNWVhMjY4YjZkOTc5ZjNhOGViY2YxN2E2NzNhZGIxYmYwM2MwNTc4OGZlZjk1MDVjMmE1OWM4ZDdkNyIsInRhZyI6IiJ9', '$2y$12$i9MBbROyUf6cpKnmJDXaT.KCbr2E004s8fHjGp6bid3RjSCAJgXHy', 'yes', 'Dosen / Tenaga Kependidikan Unpad', 'psikolog', NULL, 'storage/profilepictures/woman_placeholder.png'),
(16, 'psikologuser2', 'Psikolog User 2', 'psikologuser2@gmail.com', NULL, '2025-10-12 22:54:43', '2025-10-12 23:09:40', 'eyJpdiI6InhWK28vM1F0aURMbWdablVWU1JtMEE9PSIsInZhbHVlIjoicW0rVGZUL3pnWXRGTFVoS3MvV0swdz09IiwibWFjIjoiMWFjZGU3MGI5NjEzNDJjMWM4NDgzNWYwODhjMWU3YWI5ZTQwYzQ0Zjg2M2E2NzhmODRjYjUyOWJiMDRjZmY5ZSIsInRhZyI6IiJ9', 'pria', 'eyJpdiI6IkhJTFllUjlMV2FFbEtzK25zSlNpYlE9PSIsInZhbHVlIjoiN0xRZnUvY1JKTkJ0d2U0eTkyVmNEZz09IiwibWFjIjoiZDk2NTFlZTQ5OWJhM2VhOGQwN2M4ZTcwYzFlNGMwOTc1Y2IzNzI4Mzc2MDg5OWNmZDNhMmM2ZmY5ZGYwZTNiZCIsInRhZyI6IiJ9', '$2y$12$kmTs3RwTIbTqSHRABtwxaeS5l3s49pAiIjmcAz7O7lyOiJobuSVmG', 'yes', 'Dosen / Tenaga Kependidikan Unpad', 'psikolog', NULL, 'storage/profilepictures/man_placeholder.png'),
(17, 'psikologuser3', 'Psikolog User 3', 'psikologuser3@gmail.com', NULL, '2025-10-12 23:05:47', '2025-10-12 23:09:41', 'eyJpdiI6InQ5Vlg5V2kzWTdCM2N6QXg4ZmJJb2c9PSIsInZhbHVlIjoiOFBuNFBsa29QeURTcWUyT2RDSU9SZz09IiwibWFjIjoiMDA4ZDcyNjQ4MjA2MGRjMmRjNTk0YjgyMWE1MjcxMWY4NzZlODdkZTkxMDhmN2NjZmUwZjE0ZjYyZGY2NzgzOCIsInRhZyI6IiJ9', 'wanita', 'eyJpdiI6IjQybWN2Kys3enB1M0NiMkVlT3hwUnc9PSIsInZhbHVlIjoiZ1RkckhncXJjeU8rVmNZRWlKQzE4UT09IiwibWFjIjoiZTE2YTA1YTZkMzZlNTU2NGQ3M2Q2NWI0NGExM2UxZTlhODUzZmMyNjRhMGNhOWFlZmNhMmIxMGJjNTBlZTBjMiIsInRhZyI6IiJ9', '$2y$12$A9jvG2CZPjQ83t7QwXsLQOBE5srZq2YHpqRFFUms7xSpcZr0Gkqo6', 'yes', 'Dosen / Tenaga Kependidikan Unpad', 'psikolog', NULL, 'storage/profilepictures/woman_placeholder.png'),
(19, 'usertesting', 'User Testing', 'usertesting@gmail.com', NULL, '2025-10-15 02:02:01', '2025-10-15 02:11:58', 'eyJpdiI6InpxeUp6SE5aTWR3OVBTbFMvUTNIVHc9PSIsInZhbHVlIjoiZjFraXc2VVhWSnZRUnhGa25rbUVqZz09IiwibWFjIjoiMDAxYTY5OTI0MTAzNjQzOTZkZjQ1OWE4Yzc5MjUxNTZhZWQ4NzAyZjAyNzc4NjM0NjE4YjE2NzVmNjdmOWE3OCIsInRhZyI6IiJ9', 'pria', 'eyJpdiI6ImM4N212MUlGNzBUNXVZUDNuRUNxT3c9PSIsInZhbHVlIjoiRVBMbjk2QVFlT3dDakR5bTREQldMQT09IiwibWFjIjoiODg2ZTQ5ZDBlNmVlMTc4NzlmNjdjZWFlNDg4NDM2Y2YxMjc5Yjk0NDc4Nzg5NWZiOWRjMDU4MzVhNjcwZTEzYiIsInRhZyI6IiJ9', '$2y$12$mtMIO44xE0tB57CYlXwRUuEOUEYFsk0VdDPcBft.Hsn7FbI5Yw/M.', 'yes', 'Umum', 'psikolog', NULL, 'storage/profilepictures/man_placeholder.png'),
(20, 'chattesting', 'Chat Testing', 'chattesting@gmail.com', NULL, '2025-10-18 04:46:00', '2025-10-18 04:46:00', 'eyJpdiI6InBIWUlpWTJrRTZuMkRoWDY0SHljaXc9PSIsInZhbHVlIjoiT0ZhNEM1YWR2cVpvUldDSzlMeFRMdz09IiwibWFjIjoiMWNjNTM4M2M3MDY2OWFjNTFjZDY5NjY3YmM0YWJkYjQ2ODRhMTE2OTQyOTI1YzQ4ZWYzZGEzOGVjNjRlNjJlZCIsInRhZyI6IiJ9', 'wanita', 'eyJpdiI6Ink4dU1hNkFMOTVYOGhpWkNTekdYS0E9PSIsInZhbHVlIjoiUTlqOFl5R21keVRXQm9pQlU1M0t2Zz09IiwibWFjIjoiZmQzMTIxODFiODU5YThkYWM0ZTNjYjIzNTAyN2UyNWE0NzQ1YmY3NjBhMDU5YmQxN2U1ZjE1Y2EyNmNhNTY3YSIsInRhZyI6IiJ9', '$2y$12$y9E58kdOGStvKVVcUUoMtOjlM2GcqOsctPavF881wEOt2UWHMHaUK', 'yes', 'Umum', 'klien', NULL, 'storage/profilepictures/woman_placeholder.png'),
(21, 'ss', 'ss', 'ss@gmail.com', NULL, '2025-10-22 00:56:59', '2025-10-22 00:56:59', 'eyJpdiI6IkxaNTFtK0pXL3pCU0VNZG9zaThpUVE9PSIsInZhbHVlIjoiMjd2aVRxNHZPTjlsYkRWQ3libW1iUT09IiwibWFjIjoiYmM2YWE3MTIwZjhiNDQ5NzFmZDZhNmI3YmQxMjVjMDk4MDJkMGFkYzkwMGFjYzNjMTU4Njc3ODJiNzhhZGNjOCIsInRhZyI6IiJ9', 'pria', 'eyJpdiI6IlJFeGFZeFkrR1RYcHdWM3NVTENicWc9PSIsInZhbHVlIjoiOWZWUUhNSE1ZUGtzbzk0OVdtbW0vdz09IiwibWFjIjoiOWUwZTQzNzI0NmMwMTBlMDhkOThiZDhkYTJlZGE3NzdhMGQ4Yzk1ODFiZDgzNDAwYTUwNjU0YmJmYjI1OGNiYyIsInRhZyI6IiJ9', '$2y$12$xsCxStQDVQp083qKbLQ26.OV7QOz6xZUm.iiQNsHm4R91q1Vbkqtq', 'yes', 'Dosen / Tenaga Kependidikan Unpad', 'klien', NULL, 'storage/profilepictures/man_placeholder.png'),
(22, 'aa', 'aa', 'aa@gmail.com', NULL, '2025-10-22 00:59:29', '2025-10-22 00:59:29', 'eyJpdiI6IitYWURTRmFpdFR0Q3BMSG05T2lhdFE9PSIsInZhbHVlIjoicElERTJrdzltYUlscUJhdUsySGV3QT09IiwibWFjIjoiZDU0NTI5MzA3YWVjZmU2ZmEyODYzNzI2NGE3MzI5ODFhMjc0NDcyMmQxYjc4YjdhOGEwMWE1YWZlZGU5ZDhiYSIsInRhZyI6IiJ9', 'pria', 'eyJpdiI6IllCMnMvQWpnU3RqU0JUNHBpbDd2Q2c9PSIsInZhbHVlIjoiMnFRdDNJZWJnWmx3VDZTYlZaOE85UT09IiwibWFjIjoiMDgxNjdhMmFlN2NhY2JmNzQ0YmFkMWQzNDE3ODc1ZmJiM2JiYmRhNTdkYmU4NjRiODY4ODk4YzYxNGIxYjUzNiIsInRhZyI6IiJ9', '$2y$12$AXhhrGRWNgCl3GQT41cyKeNEtjpzSq23oUobQLGUzlrjPdHeNnuJe', 'yes', 'Dosen / Tenaga Kependidikan Unpad', 'klien', NULL, 'storage/profilepictures/man_placeholder.png'),
(23, 'qwerty', 'qwerty', 'qwerty@qwerty.com', NULL, '2025-10-22 01:12:14', '2025-10-22 01:12:14', 'eyJpdiI6InNWZnllNktCQ3FwUzhLbFhCeHo0YWc9PSIsInZhbHVlIjoiUVFWdU45NmZTdWNSbzhIZmZRbjVEUT09IiwibWFjIjoiOGQ0NmQzNDBiZjU2MzdhYjk1ODE2OGZjZjY0NjQ0OWRhMGFhOTYxM2QzMGE2MDUxNWE4OGY1MDRjZTk2ZTQ1NSIsInRhZyI6IiJ9', 'pria', 'eyJpdiI6Ik45Ym9ZRGI1b09xU29tS2NrTDRwTmc9PSIsInZhbHVlIjoiV2JBQThGbFliY1NBb2QwVzBwbTNkZz09IiwibWFjIjoiYjMwMTAyOTA5MDA4YzZhYTZiYjA2NjIxZGU4YzlhMDIxMzUyOTI3Y2Q0YjA3NWI3M2E5OWY3ZDQwNGQxNDM4NCIsInRhZyI6IiJ9', '$2y$12$xEprKti3xaDY8MVNgTg/J.OhrjbzTj1l29tVtGxx.4fI/uJvEnvVS', 'yes', 'Umum', 'klien', NULL, 'storage/profilepictures/man_placeholder.png'),
(24, 'qq', 'qq', 'qq@qq.com', NULL, '2025-10-22 08:42:24', '2025-10-22 08:44:50', 'eyJpdiI6IkZIUEZpakJFR0pxdEFHWTQxdlM2Vmc9PSIsInZhbHVlIjoiNGNmQVVEMm8zb2ZFU2MzaDlPQVpQUT09IiwibWFjIjoiODc2OTk0ZjdkMmI2NDM5NDJlOTg2NGNhYzdmYjFiYjQ4MzYwZTFhNDMxNzdhYWQyZDA2Zjg5ZmMwNDMwMjM4MCIsInRhZyI6IiJ9', 'pria', 'eyJpdiI6InF6UWZ6eFNKV3pJOHVSTkhYR0MzSnc9PSIsInZhbHVlIjoiRGE0Z21YTFlkQk0xZDQ0WlhoNWRMZz09IiwibWFjIjoiMzM1OTFjMWE0MTQxOGZlMmJlZGRjNWRmYWRmZDMxMWExNWJmNjlhMDRlZTAyZmIzMmRjZjBmNTIyMGU4YWU2NCIsInRhZyI6IiJ9', '$2y$12$eHF2/fGtQ9tRHi.gfpQBE.OKbfcWU6PMbUMvNdmBBNJhJV9FQnnoK', 'yes', 'Umum', 'klien', NULL, 'storage/profilepictures/1761122690_24.jpg');

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
  ADD KEY `chat_messages_sender_id_foreign` (`sender_id`),
  ADD KEY `chat_messages_receiver_id_foreign` (`receiver_id`),
  ADD KEY `chat_messages_conversation_id_foreign` (`conversation_id`);

--
-- Indexes for table `conversations`
--
ALTER TABLE `conversations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `conversations_user_one_id_user_two_id_unique` (`user_one_id`,`user_two_id`),
  ADD KEY `conversations_user_two_id_foreign` (`user_two_id`),
  ADD KEY `conversations_initiator_id_foreign` (`initiator_id`),
  ADD KEY `conversations_appointment_id_foreign` (`appointment_id`);

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=683;

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `availabilities`
--
ALTER TABLE `availabilities`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chat_messages`
--
ALTER TABLE `chat_messages`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=172;

--
-- AUTO_INCREMENT for table `conversations`
--
ALTER TABLE `conversations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=368;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `therapist_availabilities`
--
ALTER TABLE `therapist_availabilities`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `therapist_profiles`
--
ALTER TABLE `therapist_profiles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

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
  ADD CONSTRAINT `appointments_availability_id_foreign` FOREIGN KEY (`availability_id`) REFERENCES `therapist_availabilities` (`id`) ON DELETE CASCADE,
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
  ADD CONSTRAINT `chat_messages_conversation_id_foreign` FOREIGN KEY (`conversation_id`) REFERENCES `conversations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `chat_messages_receiver_id_foreign` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `chat_messages_sender_id_foreign` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `conversations`
--
ALTER TABLE `conversations`
  ADD CONSTRAINT `conversations_appointment_id_foreign` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `conversations_initiator_id_foreign` FOREIGN KEY (`initiator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `conversations_user_one_id_foreign` FOREIGN KEY (`user_one_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `conversations_user_two_id_foreign` FOREIGN KEY (`user_two_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

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
