-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 14, 2025 at 01:48 PM
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
(199, 11, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-14 06:43:15', '2025-10-14 06:43:15');

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
(122, 'App\\Models\\User', 11, 'auth_token', '48f2c45b113c1b99ab3bfe5fed273682a52effb55782bb9f1a7ea104ab581812', '[\"*\"]', '2025-10-14 06:43:15', NULL, '2025-10-14 06:43:15', '2025-10-14 06:43:15');

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
(17, 15, 1, '09:00:00', '12:00:00', '2025-10-12 22:53:49', '2025-10-12 22:53:49'),
(18, 15, 1, '13:00:00', '16:00:00', '2025-10-12 22:53:49', '2025-10-12 22:53:49'),
(19, 15, 2, '09:00:00', '12:00:00', '2025-10-12 22:53:49', '2025-10-12 22:53:49'),
(20, 15, 2, '13:00:00', '16:00:00', '2025-10-12 22:53:49', '2025-10-12 22:53:49'),
(21, 15, 3, '09:00:00', '12:00:00', '2025-10-12 22:53:49', '2025-10-12 22:53:49'),
(22, 15, 3, '13:00:00', '16:00:00', '2025-10-12 22:53:49', '2025-10-12 22:53:49'),
(23, 15, 4, '09:00:00', '12:00:00', '2025-10-12 22:53:49', '2025-10-12 22:53:49'),
(24, 15, 4, '13:00:00', '16:00:00', '2025-10-12 22:53:49', '2025-10-12 22:53:49'),
(25, 15, 5, '09:00:00', '11:00:00', '2025-10-12 22:53:49', '2025-10-12 22:53:49'),
(26, 15, 5, '14:00:00', '15:00:00', '2025-10-12 22:53:49', '2025-10-12 22:53:49'),
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
(43, 17, 7, '09:00:00', '15:00:00', '2025-10-12 23:09:13', '2025-10-12 23:09:13');

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
(10, 17, 'storage/therapist_pictures/dzt6tck1yz6wzikHWwXWIk3MmHJUSOqHqt0tuaBk.png', 'S3 Psikologi Polman', 400000, 9, '[\"Klinis Pendidikan\"]', 'Hubungan', '2025-10-12 23:09:13', '2025-10-12 23:09:13');

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
(11, 'castreld', 'Firaas Raihansyah Rizqullah', 'hulukotak@gmail.com', NULL, '2025-10-12 22:09:03', '2025-10-13 01:02:57', 'eyJpdiI6IkREUEpSRkpJSnVOZHVXRWhxeEdDQVE9PSIsInZhbHVlIjoiMVhNa1lpOEl1eFZicmtkK1NDQXArQT09IiwibWFjIjoiOWJmMWFiMGY4ZjZjMGMxYmFlNGYyMDY0MjNlNGY1MGQ4NTMxNWE3MTE1Njg5ODc0NzJjZTM4MTEyYjNiYzA5MSIsInRhZyI6IiJ9', 'pria', 'eyJpdiI6IjVPR3Q3Y2FWRE1iTWRzL29yVEhmMkE9PSIsInZhbHVlIjoiSFJFYU0vQmdiUTB4M0FMVkJTdkpJQT09IiwibWFjIjoiNTQ5OGM2MmU1MjE5MWEzYmNiMDgyNGQzNzM3ODY1OGNmNTg2NWM2MWM1N2M4ZmRhYTBhNDgxNDZmZWZkYzA2MiIsInRhZyI6IiJ9', '$2y$12$N/o/5SNFQT6Qa1cFaur4LuRoadbNJci6HYbEu.3vJ70Bqe1jiYaZm', 'yes', 'Umum', 'klien', NULL, 'storage/profilepictures/1760342577_11.png'),
(12, 'wanitauser', 'Wanita User', 'wanitauser@gmail.com', NULL, '2025-10-12 22:10:17', '2025-10-12 22:10:17', 'eyJpdiI6IlpSa0J5bVJpSVlRVTBBRU91WXR2dlE9PSIsInZhbHVlIjoiVU5wZHltR20zNzdiOHNrN3daZlhOUT09IiwibWFjIjoiODMyZTI1ZGY2NjNjYjQ0ZjI4YjFjMjU3MmI1NmQyYjcwYTVhYjQ0ODFiMWZjZDRjNGZiZWRlMGE4MTMzNGZmZCIsInRhZyI6IiJ9', 'wanita', 'eyJpdiI6Ik9CNHhuaGUzS3JtWUwrRERRM3RqcHc9PSIsInZhbHVlIjoiY1pWazFaTjA4d0hMUTVEMkFyKzJIUT09IiwibWFjIjoiODZiYTFjNmQzOGU1MWNhZDhmYTk5YzY1ZGNjZDVhY2IzODJkYTJmOGUwMjZlNGEwMmIwNjQ4MTg4NGVjNDJmZCIsInRhZyI6IiJ9', '$2y$12$zeAXVuRiaHWAGSu9HhEiTe0T2YzmqynteSE6UOzvtQGq1jiWmdaBK', 'yes', 'Umum', 'klien', NULL, 'storage/profilepictures/woman_placeholder.png'),
(13, 'priauser', 'Pria User', 'priauser@gmail.com', NULL, '2025-10-12 22:11:03', '2025-10-12 22:11:03', 'eyJpdiI6ImwrZ3J0UmFZODhBNm5KWHJyQ0NwaXc9PSIsInZhbHVlIjoidHFBOWMwem5IcTYyOEcwM1d3UGtGZz09IiwibWFjIjoiOWM3NzI4M2NhZTMxYjAxYTgzZjRhZGVmMTM1MWU2YzVmMDU1YjU0OWM4ZGEyOTFjMGVlOGE0OTcxYzkzZjk4OCIsInRhZyI6IiJ9', 'pria', 'eyJpdiI6IklPQmQvdFNsY0EyRmdNL2dIT1VoM2c9PSIsInZhbHVlIjoiY1FpaUFWWTREUzdhWWdoYnJoM0ltUT09IiwibWFjIjoiNTgyMzVjYjFlZDJhODZhNjFkMzBiMWEwN2MwMGYyNmM4ODdhZmZkOTE2M2IxMWM5YmY2MmE0ZGM1OTRmMDE3YiIsInRhZyI6IiJ9', '$2y$12$MYcJoSRM8ax2zMOVZOtBiOP7gHKSueFLNt2/s9fXMTwTySTXAe7c2', 'yes', 'Umum', 'klien', NULL, 'storage/profilepictures/man_placeholder.png'),
(14, 'admin', 'Admin', 'admin@gmail.com', NULL, '2025-10-12 22:11:43', '2025-10-12 23:10:26', 'eyJpdiI6ImF5bE9VRWZZMDdxV3h2MGtZTEVHYWc9PSIsInZhbHVlIjoiTFFGTldYSW8vbEhuMFBOV0dFVDB1QT09IiwibWFjIjoiNjFiYzRhNGM2N2Q2ZTRlNmM5ZDUzYmJkYzczODk1OWU1NmUxODhhMzQ1ZjA1N2QwNzFjZjU1OWE0OTMwMTRhMCIsInRhZyI6IiJ9', 'pria', 'eyJpdiI6ImQxVGVtUGd6UEpOOEZ1dlpvcFlqY2c9PSIsInZhbHVlIjoiclB5ZTJQbWsyaVgvRkQ5eUYwVS9hUT09IiwibWFjIjoiMjZhN2IxZTllOWRjMDUzMWFkMjY1M2E0MWU1ZjQwMmFjZmI4Y2RlM2JkNDdjZGY2YTViYWNkZTllN2Q5M2NmMSIsInRhZyI6IiJ9', '$2y$12$28mfa4KG3dNakr6vUiKw3uliCbiN/YA.fvtnvHXvuxW03lGF1aN8S', 'yes', 'Umum', 'admin', NULL, 'storage/profilepictures/1760335826_14.png'),
(15, 'psikologuser1', 'Psikolog User 1', 'psikologuser1@gmail.com', NULL, '2025-10-12 22:49:04', '2025-10-12 23:09:38', 'eyJpdiI6IjVyaXNZNWxmZGJuUzYrb1N4OXhtU2c9PSIsInZhbHVlIjoiMlJUbFppcEoyVG9DSGhHSitHQzhTQT09IiwibWFjIjoiYTlhZGYxNWFjOGI1ZDdmMjdkZDQwMDY3MDA0MWRiNWE1OWMzNGQxZTYwNzcyN2E5YTNkMTE1ZmExOGM5NzhkNCIsInRhZyI6IiJ9', 'wanita', 'eyJpdiI6IklSMGE3c3IvaGVZamM4cGU2SENzeGc9PSIsInZhbHVlIjoiOHBjUXdiVGFuUFlLaXlhbS84clI5UT09IiwibWFjIjoiYTA5OWMyNWVhMjY4YjZkOTc5ZjNhOGViY2YxN2E2NzNhZGIxYmYwM2MwNTc4OGZlZjk1MDVjMmE1OWM4ZDdkNyIsInRhZyI6IiJ9', '$2y$12$i9MBbROyUf6cpKnmJDXaT.KCbr2E004s8fHjGp6bid3RjSCAJgXHy', 'yes', 'Dosen / Tenaga Kependidikan Unpad', 'psikolog', NULL, 'storage/profilepictures/woman_placeholder.png'),
(16, 'psikologuser2', 'Psikolog User 2', 'psikologuser2@gmail.com', NULL, '2025-10-12 22:54:43', '2025-10-12 23:09:40', 'eyJpdiI6InhWK28vM1F0aURMbWdablVWU1JtMEE9PSIsInZhbHVlIjoicW0rVGZUL3pnWXRGTFVoS3MvV0swdz09IiwibWFjIjoiMWFjZGU3MGI5NjEzNDJjMWM4NDgzNWYwODhjMWU3YWI5ZTQwYzQ0Zjg2M2E2NzhmODRjYjUyOWJiMDRjZmY5ZSIsInRhZyI6IiJ9', 'pria', 'eyJpdiI6IkhJTFllUjlMV2FFbEtzK25zSlNpYlE9PSIsInZhbHVlIjoiN0xRZnUvY1JKTkJ0d2U0eTkyVmNEZz09IiwibWFjIjoiZDk2NTFlZTQ5OWJhM2VhOGQwN2M4ZTcwYzFlNGMwOTc1Y2IzNzI4Mzc2MDg5OWNmZDNhMmM2ZmY5ZGYwZTNiZCIsInRhZyI6IiJ9', '$2y$12$kmTs3RwTIbTqSHRABtwxaeS5l3s49pAiIjmcAz7O7lyOiJobuSVmG', 'yes', 'Dosen / Tenaga Kependidikan Unpad', 'psikolog', NULL, 'storage/profilepictures/man_placeholder.png'),
(17, 'psikologuser3', 'Psikolog User 3', 'psikologuser3@gmail.com', NULL, '2025-10-12 23:05:47', '2025-10-12 23:09:41', 'eyJpdiI6InQ5Vlg5V2kzWTdCM2N6QXg4ZmJJb2c9PSIsInZhbHVlIjoiOFBuNFBsa29QeURTcWUyT2RDSU9SZz09IiwibWFjIjoiMDA4ZDcyNjQ4MjA2MGRjMmRjNTk0YjgyMWE1MjcxMWY4NzZlODdkZTkxMDhmN2NjZmUwZjE0ZjYyZGY2NzgzOCIsInRhZyI6IiJ9', 'wanita', 'eyJpdiI6IjQybWN2Kys3enB1M0NiMkVlT3hwUnc9PSIsInZhbHVlIjoiZ1RkckhncXJjeU8rVmNZRWlKQzE4UT09IiwibWFjIjoiZTE2YTA1YTZkMzZlNTU2NGQ3M2Q2NWI0NGExM2UxZTlhODUzZmMyNjRhMGNhOWFlZmNhMmIxMGJjNTBlZTBjMiIsInRhZyI6IiJ9', '$2y$12$A9jvG2CZPjQ83t7QwXsLQOBE5srZq2YHpqRFFUms7xSpcZr0Gkqo6', 'yes', 'Dosen / Tenaga Kependidikan Unpad', 'psikolog', NULL, 'storage/profilepictures/woman_placeholder.png');

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=200;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=123;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `therapist_availabilities`
--
ALTER TABLE `therapist_availabilities`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `therapist_profiles`
--
ALTER TABLE `therapist_profiles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

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
