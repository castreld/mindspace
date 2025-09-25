-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 25, 2025 at 06:10 AM
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
(1, 2, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-24 02:13:04', '2025-09-24 02:13:04'),
(2, 2, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-24 19:24:13', '2025-09-24 19:24:13'),
(3, 2, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-24 19:28:42', '2025-09-24 19:28:42'),
(4, 2, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-24 19:30:17', '2025-09-24 19:30:17'),
(5, 2, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-24 19:30:57', '2025-09-24 19:30:57'),
(6, 2, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-24 19:31:30', '2025-09-24 19:31:30'),
(7, 2, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-24 19:34:07', '2025-09-24 19:34:07'),
(8, 2, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-24 19:34:49', '2025-09-24 19:34:49'),
(9, 2, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-24 19:35:53', '2025-09-24 19:35:53'),
(10, 2, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-24 22:19:37', '2025-09-24 22:19:37'),
(11, 2, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-24 22:19:37', '2025-09-24 22:19:37'),
(12, 2, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-24 22:35:40', '2025-09-24 22:35:40'),
(13, 2, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-24 22:35:40', '2025-09-24 22:35:40'),
(14, 2, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-24 22:36:02', '2025-09-24 22:36:02'),
(15, 2, 'login', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-09-24 22:36:02', '2025-09-24 22:36:02'),
(16, 2, 'login', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-24 22:36:28', '2025-09-24 22:36:28'),
(17, 2, 'login', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', '2025-09-24 22:36:28', '2025-09-24 22:36:28');

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
(12, '2025_09_24_090450_create_activity_logs_table', 5);

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
(24, 'App\\Models\\User', 2, 'auth_token', 'f94601be4848efedf1e9a85c52700bdfe2c7a2aae6f682d54223ab6995613534', '[\"*\"]', NULL, NULL, '2025-09-24 22:36:28', '2025-09-24 22:36:28');

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
('KZKjt1zdlIW1WvQ9i857zXyIzz32FpvRe1gI743j', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQ3NSa1ZsQjJTQmY5d2twQXNzUGU2Y2Ntbk9WVFlmQVFKaXhpWUV1WSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1758521337);

-- --------------------------------------------------------

--
-- Table structure for table `therapist_profiles`
--

CREATE TABLE `therapist_profiles` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `specialization` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bio` text COLLATE utf8mb4_unicode_ci,
  `experience_years` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `hourly_rate` decimal(8,2) DEFAULT NULL,
  `profile_picture_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `birth_date` date NOT NULL,
  `gender` enum('pria','wanita') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `flyer` enum('yes','no') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `category` enum('Umum','Mahasiswa Aktif Unpad','Dosen / Tenaga Kependidikan Unpad') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Umum',
  `role` enum('klien','psikolog','admin') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'klien',
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `full_name`, `email`, `email_verified_at`, `created_at`, `updated_at`, `birth_date`, `gender`, `phone_number`, `password`, `flyer`, `category`, `role`, `remember_token`) VALUES
(1, 'castreld', 'Firaas Raihansyah Rizqullah', 'hulukotak@gmail.com', NULL, '2025-09-22 01:05:45', '2025-09-22 01:05:45', '2008-01-10', 'pria', '082130304142', '$2y$12$jx74iMjwz3CeK2VBjGExVOKcBXsV0vIWPqNFIa4fP02rvPSviTcKi', 'yes', 'Mahasiswa Aktif Unpad', 'klien', NULL),
(2, 'usertesting', 'User Testing', 'usertesting@gmail.com', NULL, '2025-09-23 21:12:45', '2025-09-23 21:12:45', '1990-09-12', 'pria', '081234567890', '$2y$12$0sGyf3j0cOvTBTQdve3Ilepp.q1VjTz4LE2iu6H4trg/fNTGmFVmq', 'no', 'Umum', 'klien', NULL);

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
-- Indexes for table `therapist_profiles`
--
ALTER TABLE `therapist_profiles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `therapist_profiles_user_id_foreign` (`user_id`);

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

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
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `therapist_profiles`
--
ALTER TABLE `therapist_profiles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
