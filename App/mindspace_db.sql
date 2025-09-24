-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 24, 2025 at 08:14 AM
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
(11, '2025_09_22_080516_change_phone_number_to_string_in_users_table', 4);

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
(5, 'App\\Models\\User', 2, 'auth_token', 'c2a85b36bb0ee861f4c29b4dc34b4937efe325dd7d4d44a5584d4356a42f2445', '[\"*\"]', NULL, NULL, '2025-09-23 23:22:04', '2025-09-23 23:22:04');

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
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
