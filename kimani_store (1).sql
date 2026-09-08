-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 08, 2026 at 10:08 AM
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
-- Database: `kimani_store`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin_actions_log`
--

CREATE TABLE `admin_actions_log` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `action_type` varchar(60) NOT NULL,
  `target_type` enum('user','listing','report','ticket') NOT NULL DEFAULT 'user',
  `target_id` int(11) NOT NULL,
  `detail` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auctions`
--

CREATE TABLE `auctions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `category` varchar(100) NOT NULL,
  `condition` varchar(50) NOT NULL DEFAULT 'Brand New',
  `start_price` decimal(15,2) NOT NULL DEFAULT 0.00,
  `current_bid` decimal(15,2) NOT NULL DEFAULT 0.00,
  `reserve_price` decimal(15,2) NOT NULL DEFAULT 0.00,
  `min_increment` decimal(15,2) NOT NULL DEFAULT 100.00,
  `buy_now_price` decimal(15,2) NOT NULL DEFAULT 0.00,
  `location` varchar(150) DEFAULT NULL,
  `images` text DEFAULT NULL,
  `duration_days` int(3) NOT NULL DEFAULT 7,
  `ends_at` datetime NOT NULL,
  `status` enum('active','ended','cancelled','sold') NOT NULL DEFAULT 'active',
  `winner_id` int(11) DEFAULT NULL,
  `winning_bid` decimal(15,2) DEFAULT NULL,
  `winner_notified` tinyint(1) NOT NULL DEFAULT 0,
  `bid_count` int(11) NOT NULL DEFAULT 0,
  `watch_count` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auctions`
--

INSERT INTO `auctions` (`id`, `user_id`, `title`, `description`, `category`, `condition`, `start_price`, `current_bid`, `reserve_price`, `min_increment`, `buy_now_price`, `location`, `images`, `duration_days`, `ends_at`, `status`, `winner_id`, `winning_bid`, `winner_notified`, `bid_count`, `watch_count`, `created_at`) VALUES
(1, 6, 'fFHWENFHMHWDC', 'SDCHMCUSDHCDJSKC DSCHDSU HC', 'Electronics', 'Parts Only', 3322.00, 3322.00, 213.00, 100.00, 333.00, 'Kutus, Kirinyaga', '[]', 7, '2026-04-01 12:11:05', 'ended', NULL, NULL, 0, 0, 0, '2026-03-25 11:11:05');

-- --------------------------------------------------------

--
-- Table structure for table `auction_bids`
--

CREATE TABLE `auction_bids` (
  `id` int(11) NOT NULL,
  `auction_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `is_winning` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auction_watchlist`
--

CREATE TABLE `auction_watchlist` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `auction_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `barter_offers`
--

CREATE TABLE `barter_offers` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `offer_title` varchar(150) NOT NULL,
  `offer_description` text DEFAULT NULL,
  `want_title` varchar(150) NOT NULL,
  `want_description` text DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` enum('active','closed','expired') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `business_profiles`
--

CREATE TABLE `business_profiles` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `business_name` varchar(255) NOT NULL,
  `category` varchar(100) DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `is_verified` enum('yes','no') DEFAULT 'no',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('pending','active','inactive') NOT NULL DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `business_profiles`
--

INSERT INTO `business_profiles` (`id`, `user_id`, `business_name`, `category`, `phone`, `email`, `location`, `description`, `logo`, `is_verified`, `created_at`, `status`) VALUES
(1, 17, 'Online store', 'Other', '+254798171482', 'ngigidancan227@gmail.com', 'NAIROBI', '', NULL, 'no', '2026-04-16 19:46:25', 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `slug`, `description`, `image`, `created_at`) VALUES
(1, 'Electronics', 'electronics', NULL, NULL, '2026-03-15 17:07:27'),
(2, 'Fashion', 'fashion', NULL, NULL, '2026-03-15 17:07:27'),
(3, 'Home & Garden', 'home-garden', NULL, NULL, '2026-03-15 17:07:27'),
(4, 'Transportation', 'transport', NULL, NULL, '2026-03-15 17:07:27'),
(5, 'Services', 'services', NULL, NULL, '2026-03-15 17:07:27'),
(53, 'Home & Kitchen', 'home-kitchen', 'Furniture, appliances and household items', NULL, '2026-03-15 17:12:31'),
(54, 'Beauty & Personal Care', 'beauty', 'Skincare, makeup, hair and wellness products', NULL, '2026-03-15 17:12:31'),
(55, 'Vehicles & Transport', 'vehicles', 'Cars, bikes, spare parts and transport services', NULL, '2026-03-15 17:12:31'),
(56, 'Groceries & Food', 'groceries', 'Fresh food, packaged items and drinks', NULL, '2026-03-15 17:12:31'),
(57, 'Phones & Accessories', 'phones', 'Smartphones, chargers and mobile accessories', NULL, '2026-03-15 17:12:31'),
(58, 'Baby & Kids', 'baby-kids', 'Baby products, toys and children clothing', NULL, '2026-03-15 17:12:31'),
(59, 'Books & Stationery', 'books', 'Books, notebooks and office supplies', NULL, '2026-03-15 17:12:31'),
(60, 'Agriculture & Farming', 'agriculture', 'Seeds, tools and farming equipment', NULL, '2026-03-15 17:12:31'),
(61, 'Sports & Outdoors', 'sports', 'Gym equipment, bikes and outdoor gear', NULL, '2026-03-15 17:12:31'),
(62, 'hyu', 'hyu', 'drrddd', NULL, '2026-03-28 17:09:55');

-- --------------------------------------------------------

--
-- Table structure for table `deliveries`
--

CREATE TABLE `deliveries` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `delivery_requests`
--

CREATE TABLE `delivery_requests` (
  `id` int(11) NOT NULL,
  `sender_id` int(11) DEFAULT NULL,
  `pickup_location` varchar(255) DEFAULT NULL,
  `dropoff_location` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `status` enum('pending','accepted','completed') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `flash_sales`
--

CREATE TABLE `flash_sales` (
  `id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL COMMENT 'Must be an admin user (users.is_admin=1)',
  `icon` varchar(10) DEFAULT '?️',
  `title` varchar(255) NOT NULL,
  `original_price` decimal(10,2) NOT NULL,
  `sale_price` decimal(10,2) NOT NULL,
  `stock_total` int(11) NOT NULL DEFAULT 100,
  `stock_sold` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `ends_at` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `listings`
--

CREATE TABLE `listings` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('pending','active','sold','expired','rejected','flagged') NOT NULL DEFAULT 'active',
  `admin_note` varchar(255) DEFAULT NULL,
  `flag_count` int(11) NOT NULL DEFAULT 0,
  `category` varchar(50) DEFAULT NULL,
  `condition` varchar(20) DEFAULT 'New',
  `stock` int(11) DEFAULT 1,
  `images` text DEFAULT NULL,
  `type` enum('product','service') NOT NULL DEFAULT 'product',
  `sku` varchar(50) DEFAULT NULL,
  `rate_type` varchar(30) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `service_icon` varchar(255) DEFAULT NULL COMMENT 'Profile photo/icon for service listings',
  `quantity` int(11) NOT NULL DEFAULT 1,
  `attributes` text DEFAULT NULL,
  `negotiable` tinyint(1) NOT NULL DEFAULT 0,
  `views` int(11) NOT NULL DEFAULT 0,
  `contact_phone` varchar(20) DEFAULT NULL COMMENT 'Optional seller phone — only stored when seller explicitly consented',
  `contact_whatsapp` varchar(20) DEFAULT NULL,
  `listing_status` varchar(255) NOT NULL DEFAULT 'trending',
  `original_price` decimal(10,2) DEFAULT 0.00,
  `delivery` varchar(255) DEFAULT NULL,
  `pickup` varchar(255) DEFAULT NULL,
  `phone_consent` varchar(255) DEFAULT NULL,
  `main_photo` varchar(255) DEFAULT NULL,
  `listing_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `listings`
--

INSERT INTO `listings` (`id`, `user_id`, `title`, `description`, `price`, `location`, `created_at`, `status`, `admin_note`, `flag_count`, `category`, `condition`, `stock`, `images`, `type`, `sku`, `rate_type`, `image`, `service_icon`, `quantity`, `attributes`, `negotiable`, `views`, `contact_phone`, `contact_whatsapp`, `listing_status`, `original_price`, `delivery`, `pickup`, `phone_consent`, `main_photo`, `listing_id`) VALUES
(1, 6, '2ee', '24242', 33222.00, 'Kutus, Kirinyaga Central, Kirinyaga County, Kenya', '2026-03-20 21:25:56', 'active', NULL, 0, 'Electronics', 'second_hand', 1, '[\"uploads\\/listings\\/lst_69bdbb6419694.png\"]', 'product', NULL, NULL, NULL, NULL, 1, NULL, 0, 0, NULL, NULL, 'featured', 0.00, '', '', '', '', 0),
(2, 6, '2ee', '24242', 33222.00, 'Kutus, Kirinyaga Central, Kirinyaga County, Kenya', '2026-03-20 21:26:11', 'active', NULL, 0, 'Electronics', 'second_hand', 1, '[\"uploads\\/listings\\/lst_69bdbb73c51a9.png\"]', 'product', NULL, NULL, NULL, NULL, 1, NULL, 0, 0, NULL, NULL, 'trending', 0.00, '', '', '', '', 0),
(3, 6, '250% Transparent Body Wave 13x4 Lace Front Brazilian Hair', 'Body wave frontal brazilian hair', 8500.00, 'Kutus, Kirinyaga Central, Kirinyaga County, Kenya', '2026-03-21 13:44:48', 'active', NULL, 0, 'Fashion', 'new', 1, '[\"uploads\\/listings\\/lst_69bea0d03731f.png\"]', 'product', NULL, NULL, NULL, NULL, 1, NULL, 0, 0, NULL, NULL, 'trending', 0.00, '', '', '', '', 0),
(4, 6, '250% Transparent Body Wave 13x4 Lace Front Brazilian Hair', 'Body wave frontal brazilian hair', 8500.00, 'Kutus, Kirinyaga Central, Kirinyaga County, Kenya', '2026-03-21 13:53:03', 'active', NULL, 0, 'Fashion', 'new', 1, '[\"uploads\\/listings\\/lst_69bea2bf7547e.png\"]', 'product', NULL, NULL, NULL, NULL, 1, NULL, 0, 0, NULL, NULL, 'trending', 0.00, '', '', '', '', 0),
(5, 6, 'Lambognius', 'ysgyislhusfgaiushfjudsafhbhsydg', 29000000.00, 'Kutus, Mwea East, Kenya', '2026-03-21 20:08:48', 'active', NULL, 0, 'Vehicles', 'new', 1, '[\"uploads\\/listings\\/lst_69befad0333cb.png\"]', 'product', NULL, NULL, NULL, NULL, 1, NULL, 0, 0, NULL, NULL, 'trending', 0.00, '', '', '', '', 0),
(6, 3, 'grtdtrrtd', 'rydrtdrydyrd', 99999999.99, 'Kirinyaga Central, Kenya', '2026-03-21 20:34:25', 'active', NULL, 0, 'Electronics', 'second_hand', 1, '[\"uploads\\/listings\\/lst_69bf00d11b3d8.png\"]', 'product', NULL, NULL, NULL, NULL, 1, NULL, 0, 0, NULL, NULL, 'trending', 0.00, '', '', '', '', 0),
(7, 3, 'huftftd', 'tfftuftu', 2562.00, 'Kutus, Mwea East, Kenya', '2026-03-22 00:02:41', 'active', NULL, 0, 'Toys', 'second_hand', 1, '[\"uploads\\/listings\\/lst_69bf31a148906.png\"]', 'product', NULL, NULL, NULL, NULL, 1, NULL, 0, 0, NULL, NULL, 'trending', 0.00, '', '', '', '', 0),
(8, 3, 'huftftd', 'tfftuftu', 2562.00, 'Kirinyaga Central, Kenya', '2026-03-22 00:21:49', 'active', NULL, 0, 'Toys', 'second_hand', 1, '[\"uploads\\/listings\\/lst_69bf361dac431.png\"]', 'product', NULL, NULL, NULL, NULL, 1, NULL, 0, 0, NULL, NULL, 'trending', 0.00, '', '', '', '', 0),
(9, 3, 'huftftd', 'tfftuftu', 2562.00, 'Kutus, Mwea East, Kenya', '2026-03-22 00:50:00', 'active', NULL, 0, 'Toys', 'new', 1, '[\"uploads\\/listings\\/lst_69bf3cb8190f0.png\"]', 'product', NULL, NULL, NULL, NULL, 1, NULL, 0, 0, NULL, NULL, 'trending', 0.00, '', '', '', '', 0),
(10, 3, 'huftftd', 'tfftuftu', 256255.00, 'Kutus, Mwea East, Kenya', '2026-03-22 00:50:34', 'active', NULL, 0, 'Toys', 'new', 1, '[\"uploads\\/listings\\/lst_69bf3cda687ab.png\"]', 'product', NULL, NULL, NULL, NULL, 1, NULL, 0, 0, NULL, NULL, 'trending', 0.00, '', '', '', '', 0),
(11, 3, 'jnjnjnjnjknjn', 'fdfgvryfuvty', 55535.00, 'Kutus, Mwea East, Kenya', '2026-03-22 01:05:06', 'active', NULL, 0, 'Food & Beverage', 'new', 4, '[\"uploads\\/listings\\/lst_69bf40420846f.png\",\"uploads\\/listings\\/lst_69bf404208979.png\",\"uploads\\/listings\\/lst_69bf404208edb.png\"]', 'product', NULL, NULL, NULL, NULL, 4, '{\"Warranty\":\"2\",\"Engine Size\":\"4\"}', 1, 0, NULL, NULL, 'trending', 0.00, '', '', '', '', 0),
(12, 3, 'FTRYRYUTD', 'FYGDYIDTYUY', 55450.00, 'T7DRTYIDTY', '2026-03-22 16:08:04', 'rejected', 'Removed by admin via report review.', 0, 'Moving', 'New', 1, NULL, 'service', NULL, 'Per Hour', NULL, NULL, 1, NULL, 1, 0, NULL, NULL, 'trending', 0.00, '', '', '', '', 0),
(13, 17, 'CJ SALON', 'brazilian hair styles', 1500.00, 'kutus', '2026-03-22 16:09:41', 'active', NULL, 0, 'Beauty & Salon', 'New', 1, NULL, 'service', NULL, 'Per Project', NULL, NULL, 1, NULL, 1, 0, '0798171482', NULL, 'trending', 0.00, '', '', '', '', 0),
(14, 9, 'huppycow', 'not now right paw', 4539.00, 'Kutus, Mwea East, Kenya', '2026-03-23 23:54:59', 'active', NULL, 0, 'Sports', 'second_hand', 3, '[\"uploads\\/listings\\/lst_69c1d2d3dfe48.png\"]', 'product', NULL, NULL, NULL, NULL, 3, '[]', 1, 0, '0743458753', NULL, 'trending', 0.00, '', '', '', '', 0),
(15, 9, 'huppycow', 'not now right paw', 4539.00, 'Kutus, Mwea East, Kenya', '2026-03-23 23:55:19', 'active', NULL, 0, 'Sports', 'second_hand', 3, '[\"uploads\\/listings\\/lst_69c1d2e7b4a31.png\"]', 'product', NULL, NULL, NULL, NULL, 3, '[]', 1, 0, '0743458753', NULL, 'trending', 0.00, '', '', '', '', 0),
(16, 9, 'huppycow', 'not now right paw', 4539.00, 'Kutus, Mwea East, Kenya', '2026-03-24 01:00:47', 'active', NULL, 0, 'Sports', 'second_hand', 3, '[\"uploads\\/listings\\/lst_69c1e23f2d36f.png\"]', 'product', NULL, NULL, NULL, NULL, 3, '[]', 1, 0, '0743458753', NULL, 'trending', 0.00, '', '', '', '', 0),
(17, 3, 'mamafua', 'kufua nguo', 200.00, 'kutus', '2026-03-24 22:15:57', 'active', NULL, 0, 'Cleaning', 'New', 1, NULL, 'service', NULL, 'Per Project', 'uploads/services/svc_3_1774390557_95299716.png', NULL, 1, NULL, 1, 0, NULL, NULL, 'trending', 0.00, '', '', '', '', 0),
(18, 6, 'gyfu', 'tydyrdt', 456.00, 'Kirinyaga Central, Kenya', '2026-03-28 17:11:38', 'active', NULL, 0, 'Electronics', '', 1, '[\"uploads\\/listings\\/lst_69c80bca7c082.png\"]', 'product', NULL, NULL, NULL, NULL, 3, '[]', 0, 0, '064437347634', NULL, 'trending', 0.00, '', '', '', '', 0),
(19, 3, 'jkshsahfusA', 'HGSAHFLHLSG', 3666.00, 'Kutus, Mwea East, Kenya', '2026-03-28 17:39:47', 'active', NULL, 0, 'Office & Business', 'second_hand', 3, '[\"uploads\\/listings\\/biz_69c812638be9d.png\"]', 'product', NULL, NULL, NULL, NULL, 3, '{\"Pickup\":\"Available\"}', 1, 0, '0743364545', NULL, 'trending', 0.00, '', '', '', '', 0),
(20, NULL, 'uui', 'kkkk', 3444.00, 'Lat -1.17445, Lng 36.75900', '2026-04-14 12:06:34', 'active', NULL, 0, 'Sports', 'second_hand', 1, NULL, 'product', '', NULL, NULL, NULL, 2, NULL, 1, 0, '998899', NULL, 'trending', 40.00, '0', '1', '1', '1776168394847-811011355.jpg', 0),
(21, NULL, 'iiii', 'iiii', 35778.00, 'Lat -1.17445, Lng 36.75900', '2026-04-14 12:11:17', 'active', NULL, 0, 'Vehicles', 'second_hand', 1, NULL, 'product', '34ddyyy', NULL, NULL, NULL, 2, NULL, 1, 0, '998899', NULL, 'trending', 345.00, '1', '0', '1', '1776168677320-304539821.png', NULL),
(22, NULL, 'iiii', 'iiii', 35778.00, 'Lat -1.17445, Lng 36.75900', '2026-04-14 12:12:51', 'active', NULL, 0, 'Vehicles', 'second_hand', 1, NULL, 'product', '34ddyyy', NULL, NULL, NULL, 2, NULL, 1, 0, '998899', NULL, 'trending', 345.00, '1', '0', '1', '1776168771942-777220003.png', NULL),
(23, NULL, NULL, NULL, NULL, NULL, '2026-04-14 12:12:52', 'active', NULL, 0, NULL, 'New', 1, '1776168771942-777220003.png', 'product', NULL, NULL, NULL, NULL, 1, NULL, 0, 0, NULL, NULL, 'trending', NULL, NULL, NULL, NULL, NULL, 22),
(24, NULL, 'iiii', 'iiii', 35778.00, 'Lat -1.17445, Lng 36.75900', '2026-04-14 12:13:00', 'active', NULL, 0, 'Vehicles', 'second_hand', 1, NULL, 'product', '34ddyyy', NULL, NULL, NULL, 2, NULL, 1, 0, '998899', NULL, 'trending', 345.00, '1', '0', '1', '1776168780254-210860103.png', NULL),
(25, NULL, NULL, NULL, NULL, NULL, '2026-04-14 12:13:00', 'active', NULL, 0, NULL, 'New', 1, '1776168780254-210860103.png', 'product', NULL, NULL, NULL, NULL, 1, NULL, 0, 0, NULL, NULL, 'trending', NULL, NULL, NULL, NULL, NULL, 24),
(26, NULL, 'yyuui', 'iouiuhu8y', 6677.00, 'Lat -1.17445, Lng 36.75900', '2026-04-14 12:14:02', 'active', NULL, 0, 'Sports', 'second_hand', 1, NULL, 'product', '8ii', NULL, NULL, NULL, 3, NULL, 1, 0, '998899', NULL, 'trending', 577.00, '0', '1', '1', '1776168842698-866106293.jpg', NULL),
(27, NULL, NULL, NULL, NULL, NULL, '2026-04-14 12:14:02', 'active', NULL, 0, NULL, 'New', 1, '1776168842698-866106293.jpg', 'product', NULL, NULL, NULL, NULL, 1, NULL, 0, 0, NULL, NULL, 'trending', NULL, NULL, NULL, NULL, NULL, 26),
(28, NULL, 'yyuui', 'iouiuhu8y', 6677.00, 'Lat -1.17445, Lng 36.75900', '2026-04-14 12:21:20', 'active', NULL, 0, 'Sports', 'second_hand', 1, NULL, 'product', '8ii', NULL, NULL, NULL, 3, NULL, 1, 0, '998899', NULL, 'trending', 577.00, '0', '1', '1', '1776169280378-930623892.jpg', NULL),
(29, NULL, NULL, NULL, NULL, NULL, '2026-04-14 12:21:20', 'active', NULL, 0, NULL, 'New', 1, '1776169280378-930623892.jpg', 'product', NULL, NULL, NULL, NULL, 1, NULL, 0, 0, NULL, NULL, 'trending', 0.00, NULL, NULL, NULL, NULL, 28),
(30, NULL, 'yyuui', 'iouiuhu8y', 6677.00, 'Lat -1.17445, Lng 36.75900', '2026-04-14 12:21:29', 'active', NULL, 0, 'Sports', 'second_hand', 1, NULL, 'product', '8ii', NULL, NULL, NULL, 3, NULL, 1, 0, '998899', NULL, 'trending', 577.00, '0', '1', '1', '1776169289439-147706161.jpg', NULL),
(31, NULL, NULL, NULL, NULL, NULL, '2026-04-14 12:21:29', 'active', NULL, 0, NULL, 'New', 1, '1776169289439-147706161.jpg', 'product', NULL, NULL, NULL, NULL, 1, NULL, 0, 0, NULL, NULL, 'trending', 0.00, NULL, NULL, NULL, NULL, 30),
(32, NULL, 'yyuui', 'iouiuhu8y', 6677.00, 'Lat -1.17445, Lng 36.75900', '2026-04-14 12:21:30', 'active', NULL, 0, 'Sports', 'second_hand', 1, NULL, 'product', '8ii', NULL, NULL, NULL, 3, NULL, 1, 0, '998899', NULL, 'trending', 577.00, '0', '1', '1', '1776169290050-685254025.jpg', NULL),
(33, NULL, NULL, NULL, NULL, NULL, '2026-04-14 12:21:30', 'active', NULL, 0, NULL, 'New', 1, '1776169290050-685254025.jpg', 'product', NULL, NULL, NULL, NULL, 1, NULL, 0, 0, NULL, NULL, 'trending', 0.00, NULL, NULL, NULL, NULL, 32),
(34, NULL, 'yyuui', 'iouiuhu8y', 6677.00, 'Lat -1.17445, Lng 36.75900', '2026-04-14 12:21:30', 'active', NULL, 0, 'Sports', 'second_hand', 1, NULL, 'product', '8ii', NULL, NULL, NULL, 3, NULL, 1, 0, '998899', NULL, 'trending', 577.00, '0', '1', '1', '1776169290277-877726723.jpg', NULL),
(35, NULL, 'yyuui', 'iouiuhu8y', 6677.00, 'Lat -1.17445, Lng 36.75900', '2026-04-14 12:21:30', 'active', NULL, 0, 'Sports', 'second_hand', 1, NULL, 'product', '8ii', NULL, NULL, NULL, 3, NULL, 1, 0, '998899', NULL, 'trending', 577.00, '0', '1', '1', '1776169290507-925807194.jpg', NULL),
(36, NULL, NULL, NULL, NULL, NULL, '2026-04-14 12:21:30', 'active', NULL, 0, NULL, 'New', 1, '1776169290277-877726723.jpg', 'product', NULL, NULL, NULL, NULL, 1, NULL, 0, 0, NULL, NULL, 'trending', 0.00, NULL, NULL, NULL, NULL, 34),
(37, NULL, NULL, NULL, NULL, NULL, '2026-04-14 12:21:30', 'active', NULL, 0, NULL, 'New', 1, '1776169290507-925807194.jpg', 'product', NULL, NULL, NULL, NULL, 1, NULL, 0, 0, NULL, NULL, 'trending', 0.00, NULL, NULL, NULL, NULL, 35),
(38, NULL, 'yyuui', 'iouiuhu8y', 6677.00, 'Lat -1.17445, Lng 36.75900', '2026-04-14 12:21:30', 'active', NULL, 0, 'Sports', 'second_hand', 1, NULL, 'product', '8ii', NULL, NULL, NULL, 3, NULL, 1, 0, '998899', NULL, 'trending', 577.00, '0', '1', '1', '1776169290753-37390592.jpg', NULL),
(39, NULL, NULL, NULL, NULL, NULL, '2026-04-14 12:21:30', 'active', NULL, 0, NULL, 'New', 1, '1776169290753-37390592.jpg', 'product', NULL, NULL, NULL, NULL, 1, NULL, 0, 0, NULL, NULL, 'trending', 0.00, NULL, NULL, NULL, NULL, 38),
(40, NULL, 'yyuui', 'iouiuhu8y', 6677.00, 'Lat -1.17445, Lng 36.75900', '2026-04-14 12:21:31', 'active', NULL, 0, 'Sports', 'second_hand', 1, NULL, 'product', '8ii', NULL, NULL, NULL, 3, NULL, 1, 0, '998899', NULL, 'trending', 577.00, '0', '1', '1', '1776169290978-705843128.jpg', NULL),
(41, NULL, NULL, NULL, NULL, NULL, '2026-04-14 12:21:31', 'active', NULL, 0, NULL, 'New', 1, '1776169290978-705843128.jpg', 'product', NULL, NULL, NULL, NULL, 1, NULL, 0, 0, NULL, NULL, 'trending', 0.00, NULL, NULL, NULL, NULL, 40),
(42, NULL, 'yyuui', 'iouiuhu8y', 6677.00, 'Lat -1.17445, Lng 36.75900', '2026-04-14 12:21:31', 'active', NULL, 0, 'Sports', 'second_hand', 1, NULL, 'product', '8ii', NULL, NULL, NULL, 3, NULL, 1, 0, '998899', NULL, 'trending', 577.00, '0', '1', '1', '1776169291161-342418184.jpg', NULL),
(43, NULL, NULL, NULL, NULL, NULL, '2026-04-14 12:21:31', 'active', NULL, 0, NULL, 'New', 1, '1776169291161-342418184.jpg', 'product', NULL, NULL, NULL, NULL, 1, NULL, 0, 0, NULL, NULL, 'trending', 0.00, NULL, NULL, NULL, NULL, 42),
(44, NULL, 'hhhh', 'hhjjh', 3555.00, 'Lat -1.17445, Lng 36.75900', '2026-04-14 12:22:38', 'active', NULL, 0, 'Toys', 'second_hand', 1, NULL, 'product', '', NULL, NULL, NULL, 2, NULL, 1, 0, '998899', NULL, 'trending', 66.00, '0', '0', '1', '1776169358425-386529983.jpg', NULL),
(45, NULL, NULL, NULL, NULL, NULL, '2026-04-14 12:22:38', 'active', NULL, 0, NULL, 'New', 1, '1776169358425-386529983.jpg', 'product', NULL, NULL, NULL, NULL, 1, NULL, 0, 0, NULL, NULL, 'trending', 0.00, NULL, NULL, NULL, NULL, 44),
(46, 17, 'dancan', 'dagagag', 4900.00, 'Lat -1.17445, Lng 36.75900', '2026-04-14 12:32:41', 'active', NULL, 0, 'Books', 'second_hand', 1, NULL, 'product', 'agaga', NULL, NULL, NULL, 1, NULL, 1, 0, '998899', NULL, 'trending', 500.00, '0', '0', '1', '1776169961312-797807572.png', NULL),
(47, NULL, NULL, NULL, NULL, NULL, '2026-04-14 12:32:41', 'active', NULL, 0, NULL, 'New', 1, '1776169961312-797807572.png', 'product', NULL, NULL, NULL, NULL, 1, NULL, 0, 0, NULL, NULL, 'trending', 0.00, NULL, NULL, NULL, NULL, 46),
(48, 17, 'Bluetooth speaker', 'sayona double bluetooth speaker', 1200.00, 'Westlands', '2026-04-15 17:55:49', 'active', NULL, 0, 'Electronics', 'new', 1, NULL, 'product', '2333', NULL, NULL, NULL, 3, NULL, 1, 0, '798171482', NULL, 'trending', 1500.00, '1', '0', '1', '1776275749300-29977863.jpg', NULL),
(49, NULL, NULL, NULL, NULL, NULL, '2026-04-15 17:55:49', 'active', NULL, 0, NULL, 'New', 1, '1776275749300-29977863.jpg', 'product', NULL, NULL, NULL, NULL, 1, NULL, 0, 0, NULL, NULL, 'trending', 0.00, NULL, NULL, NULL, NULL, 48),
(50, 17, 'eejejej', 'jeu3i3u', 3344.00, 'Lat -1.17445, Lng 36.75900', '2026-04-15 18:30:57', 'active', NULL, 0, 'Toys', 'second_hand', 1, NULL, 'product', '34ddyyy', NULL, NULL, NULL, 2, NULL, 1, 0, '998899', NULL, 'trending', 55050.00, '0', '1', '1', '1776277857144-428932628.jpg', NULL),
(51, NULL, NULL, NULL, NULL, NULL, '2026-04-15 18:30:57', 'active', NULL, 0, NULL, 'New', 1, '1776277857144-428932628.jpg', 'product', NULL, NULL, NULL, NULL, 1, NULL, 0, 0, NULL, NULL, 'trending', 0.00, NULL, NULL, NULL, NULL, 50),
(52, 17, 'hjjjj', 'uiiuiji', 600.00, 'kenya', '2026-04-15 19:00:53', 'active', NULL, 0, 'cleaning', 'New', 1, NULL, 'service', NULL, NULL, NULL, NULL, 1, NULL, 1, 0, '998899', NULL, 'trending', 0.00, NULL, NULL, '1', '1776279653268-743685903.jpg', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `listing_flags`
--

CREATE TABLE `listing_flags` (
  `id` int(11) NOT NULL,
  `listing_id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `action` enum('flagged','removed','restored','warning') NOT NULL DEFAULT 'flagged',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `listing_id` int(11) DEFAULT NULL,
  `body` text NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `delivered` tinyint(1) DEFAULT 0,
  `seen` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `sender_id`, `receiver_id`, `listing_id`, `body`, `is_read`, `created_at`, `delivered`, `seen`) VALUES
(1, 6, 3, 11, 'ygygyggy', 1, '2026-03-22 02:04:54', 0, 0),
(2, 3, 6, 4, 'uyygyo', 1, '2026-03-22 02:06:29', 0, 0),
(3, 3, 6, 3, 'hello', 1, '2026-03-22 02:51:24', 0, 0),
(4, 6, 17, 3, 'how many', 0, '2026-03-22 02:52:22', 0, 1),
(5, 3, 6, 4, 'jnkn', 1, '2026-03-22 03:01:16', 0, 0),
(20, 17, 6, 4, 'Is this still available?', 0, '2026-04-09 06:44:35', 0, 0),
(21, 17, 6, 4, 'hello', 0, '2026-04-09 10:44:14', 0, 0),
(22, 17, 18, 13, 'mehn', 0, '2026-04-09 11:28:47', 0, 1),
(23, 18, 17, 13, 'rada is it available', 1, '2026-04-09 11:29:38', 0, 1),
(24, 17, 6, 4, '✅Still available?', 0, '2026-04-09 12:59:46', 0, 0),
(25, 17, 6, 4, '💰Best price?', 0, '2026-04-09 12:59:48', 0, 0),
(26, 18, 17, 13, 'yowwwww', 1, '2026-04-09 13:28:49', 0, 1),
(27, 18, 17, 13, 'yooow', 1, '2026-04-09 13:31:41', 0, 1),
(28, 18, 17, 13, 'rrrrriiiiiii niko kadi very bad', 1, '2026-04-09 13:35:56', 0, 1),
(29, 17, 18, 13, 'niko kadi', 0, '2026-04-09 13:37:39', 0, 1),
(30, 18, 17, 13, 'Hiyo item Iko?', 1, '2026-04-13 16:43:31', 1, 1),
(31, 17, 18, 13, 'ziii mzee', 0, '2026-04-13 16:44:12', 1, 1),
(32, 17, 18, 13, 'jjjjjjjj', 0, '2026-04-13 16:46:48', 1, 1),
(33, 18, 17, 13, 'Rada', 1, '2026-04-13 16:48:31', 1, 1),
(34, 18, 17, 13, 'Ni mbaya', 1, '2026-04-13 16:55:05', 0, 1),
(35, 18, 17, 13, 'Yow', 1, '2026-04-13 16:57:57', 1, 1),
(36, 18, 17, 13, 'Azin', 1, '2026-04-13 16:58:20', 1, 1),
(37, 17, 18, 13, 'mzee acha ujinga', 0, '2026-04-13 16:58:38', 1, 1),
(38, 17, 18, 13, 'hhj', 0, '2026-04-13 17:14:34', 1, 1),
(39, 17, 18, 13, 'Still available?', 0, '2026-04-13 17:16:59', 1, 1),
(40, 17, 18, 13, 'Still available?', 0, '2026-04-13 17:17:07', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `from_user` int(11) NOT NULL,
  `listing_id` int(11) NOT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'system',
  `title` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `link` varchar(500) DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `from_user`, `listing_id`, `type`, `title`, `body`, `link`, `is_read`, `created_at`) VALUES
(1, 1, 0, 0, 'auction_new', '🔨 New Auction Listed', 'Cynthia Wairimu listed \"fFHWENFHMHWDC\" starting at KSh 3,322.', 'auctions.php?new=1', 0, '2026-03-25 11:11:05'),
(2, 3, 0, 0, 'system', 'Report filed on your listing', 'Your listing \"jnjnjnjnjknjn\" has received a report and is under review.', 'listing_detail.php?id=11', 0, '2026-03-28 20:58:40'),
(3, 3, 0, 0, 'system', 'Report filed on your listing', 'Your listing \"jkshsahfusA\" has received a report and is under review.', 'listing_detail.php?id=19', 0, '2026-03-29 12:59:31'),
(4, 3, 0, 0, 'system', 'Report filed on your listing', 'Your listing \"jkshsahfusA\" has received a report and is under review.', 'listing_detail.php?id=19', 0, '2026-03-30 11:52:20'),
(5, 3, 0, 0, 'system', 'Report filed on your listing', 'Your listing \"jkshsahfusA\" has received a report and is under review.', 'listing_detail.php?id=19', 0, '2026-03-30 13:27:35'),
(6, 9, 0, 0, 'system', 'Report filed on your listing', 'Your listing \"huppycow\" has received a report and is under review.', 'listing_detail.php?id=16', 0, '2026-03-30 13:30:42'),
(7, 9, 0, 0, 'system', 'Report filed on your listing', 'Your listing \"huppycow\" has received a report and is under review.', 'listing_detail.php?id=14', 0, '2026-03-30 13:37:32'),
(8, 9, 0, 0, 'system', 'Report filed on your listing', 'Your listing \"huppycow\" has received a report and is under review.', 'listing_detail.php?id=14', 0, '2026-03-30 22:54:12'),
(9, 9, 0, 0, 'system', 'Report filed on your listing', 'Your listing \"huppycow\" has received a report and is under review.', 'listing_detail.php?id=14', 0, '2026-03-30 22:54:56'),
(10, 17, 18, 13, 'message', 'You have received a message', 'niko kadi', NULL, 0, '2026-04-09 13:37:39'),
(11, 17, 18, 13, 'message', 'You have received a message', 'Hiyo item Iko?', NULL, 0, '2026-04-13 16:43:31'),
(12, 18, 17, 13, 'message', 'You have received a message', 'ziii mzee', NULL, 0, '2026-04-13 16:44:12'),
(13, 18, 17, 13, 'message', 'You have received a message', 'jjjjjjjj', NULL, 0, '2026-04-13 16:46:48'),
(14, 17, 18, 13, 'message', 'You have received a message', 'Rada', NULL, 0, '2026-04-13 16:48:31'),
(15, 17, 18, 13, 'message', 'You have received a message', 'Ni mbaya', NULL, 0, '2026-04-13 16:55:05'),
(16, 17, 18, 13, 'message', 'You have received a message', 'Yow', NULL, 0, '2026-04-13 16:57:57'),
(17, 17, 18, 13, 'message', 'You have received a message', 'Azin', NULL, 0, '2026-04-13 16:58:20'),
(18, 18, 17, 13, 'message', 'You have received a message', 'mzee acha ujinga', NULL, 0, '2026-04-13 16:58:38'),
(19, 18, 17, 13, 'message', 'You have received a message', 'hhj', NULL, 0, '2026-04-13 17:14:34'),
(20, 18, 17, 13, 'message', 'You have received a message', 'Still available?', NULL, 0, '2026-04-13 17:16:59'),
(21, 18, 17, 13, 'message', 'You have received a message', 'Still available?', NULL, 0, '2026-04-13 17:17:07');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `buyer_id` int(11) NOT NULL,
  `listing_id` int(11) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `status` enum('pending','confirmed','shipped','completed','cancelled') NOT NULL DEFAULT 'pending',
  `total` decimal(10,2) NOT NULL DEFAULT 0.00,
  `seller_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `note` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(100) NOT NULL,
  `expires_at` datetime NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`id`, `user_id`, `token`, `expires_at`, `used`, `created_at`) VALUES
(1, 9, 'adedf3adf44e14fae507972415c9ed0097474858c6029ca1d515c5e1cdb5ac5c', '2026-03-28 12:55:24', 0, '2026-03-28 08:55:24');

-- --------------------------------------------------------

--
-- Table structure for table `professionals`
--

CREATE TABLE `professionals` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `pricing` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `id` int(11) NOT NULL,
  `reporter_id` int(11) NOT NULL,
  `listing_id` int(11) DEFAULT NULL,
  `reported_user_id` int(11) DEFAULT NULL,
  `reason` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `evidence_note` text DEFAULT NULL,
  `attachments` text DEFAULT NULL,
  `urgency` enum('low','medium','high','critical') NOT NULL DEFAULT 'low',
  `status` enum('pending','reviewed','resolved','dismissed') NOT NULL DEFAULT 'pending',
  `admin_note` text DEFAULT NULL,
  `reviewed_by` int(11) DEFAULT NULL,
  `reviewed_at` datetime DEFAULT NULL,
  `ticket_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reports`
--

INSERT INTO `reports` (`id`, `reporter_id`, `listing_id`, `reported_user_id`, `reason`, `description`, `evidence_note`, `attachments`, `urgency`, `status`, `admin_note`, `reviewed_by`, `reviewed_at`, `ticket_id`, `created_at`) VALUES
(2, 9, 12, NULL, 'Listing Report via Support Ticket', 'ffhtrhrhr5tyevdbrtyd', NULL, NULL, 'high', 'resolved', 'Removed by admin via report review.', NULL, '2026-03-28 22:59:55', 2, '2026-03-28 19:58:33'),
(3, 6, 11, 3, 'duplicate', '', '', NULL, 'low', 'resolved', '', NULL, '2026-03-29 15:19:20', NULL, '2026-03-28 20:58:40'),
(4, 6, NULL, NULL, 'Account Dispute via Support Ticket', 'hghfgffgfgfkgfcrvfbvtcrdvcesvwcr', NULL, NULL, 'high', 'resolved', 'Replied to support ticket #3: hello', NULL, '2026-03-29 00:24:40', 3, '2026-03-28 21:22:10'),
(5, 6, NULL, NULL, 'Account Dispute via Support Ticket', 'ffwfqfqfqghghghjghjghjg', NULL, NULL, 'high', 'resolved', '', NULL, '2026-03-29 15:19:12', 4, '2026-03-29 12:17:15'),
(6, 6, 3, NULL, 'Listing Report via Support Ticket', 'ihsddoufhauagofduoahfuohda', NULL, NULL, 'high', 'pending', NULL, NULL, NULL, 5, '2026-03-29 12:40:47'),
(7, 6, 19, 3, 'scam', '', 'gyuguygyiguy', NULL, 'low', 'pending', NULL, NULL, NULL, NULL, '2026-03-29 12:59:31'),
(9, 6, NULL, NULL, 'User Report via Support Ticket', 'shfouijjfjdsifjiodsfdsjfdiofjdhfsd sawa', NULL, NULL, 'high', 'pending', NULL, NULL, NULL, 7, '2026-03-29 13:02:51'),
(10, 6, 19, 3, 'already_purchased', 'hello nililipA but sikupata', 'ngio hii', NULL, 'low', 'pending', NULL, NULL, NULL, NULL, '2026-03-30 11:52:20'),
(11, 6, 19, 3, 'scam', '', 'jjuimqoewnymewqnyfweiu', NULL, 'low', 'pending', NULL, NULL, NULL, NULL, '2026-03-30 13:27:35'),
(12, 6, 16, 9, 'scam', '', 'huu ni mwizi kabisa mwizi', NULL, 'low', 'pending', NULL, NULL, NULL, NULL, '2026-03-30 13:30:42'),
(13, 6, 14, 9, 'scam', '', 'gyguygyuiifvrvcrerv', NULL, 'low', 'resolved', 'Resolved via support chat.', NULL, '2026-03-31 02:44:04', NULL, '2026-03-30 13:37:32'),
(14, 6, 14, 9, 'already_sold', 'giuonumoygnyu', '', NULL, 'low', 'pending', NULL, NULL, NULL, NULL, '2026-03-30 22:54:12'),
(15, 6, 14, 9, 'already_purchased', 'huihuiohiu', '', NULL, 'low', 'resolved', 'Resolved via support chat.', NULL, '2026-03-31 02:35:31', NULL, '2026-03-30 22:54:56');

-- --------------------------------------------------------

--
-- Table structure for table `saved_items`
--

CREATE TABLE `saved_items` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `listing_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `saved_items`
--

INSERT INTO `saved_items` (`id`, `user_id`, `listing_id`, `created_at`) VALUES
(5, 6, 13, '2026-03-24 09:41:31'),
(7, 17, 18, '2026-04-08 07:35:55');

-- --------------------------------------------------------

--
-- Table structure for table `seller_reviews`
--

CREATE TABLE `seller_reviews` (
  `id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL COMMENT 'user being reviewed',
  `reviewer_id` int(11) NOT NULL COMMENT 'user leaving the review',
  `listing_id` int(11) DEFAULT NULL COMMENT 'listing the review relates to',
  `rating` tinyint(1) NOT NULL COMMENT '1–5 stars',
  `review` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `seller_reviews`
--

INSERT INTO `seller_reviews` (`id`, `seller_id`, `reviewer_id`, `listing_id`, `rating`, `review`, `created_at`) VALUES
(1, 3, 6, 7, 3, 'he is fast and great', '2026-03-24 00:17:56'),
(2, 3, 17, 19, 1, 'not good', '2026-04-08 09:33:35'),
(6, 6, 17, 3, 2, 'very good service', '2026-04-08 10:50:16');

-- --------------------------------------------------------

--
-- Table structure for table `support_tickets`
--

CREATE TABLE `support_tickets` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `category` varchar(60) NOT NULL,
  `subject` varchar(120) NOT NULL,
  `message` text NOT NULL,
  `screenshot` varchar(255) DEFAULT NULL COMMENT 'Relative path to customer-uploaded screenshot',
  `urgency` enum('low','medium','high','critical') NOT NULL DEFAULT 'low',
  `status` enum('open','in_progress','resolved','closed') NOT NULL DEFAULT 'open',
  `admin_reply` text DEFAULT NULL,
  `replied_by` int(11) DEFAULT NULL,
  `replied_at` datetime DEFAULT NULL,
  `last_message_at` datetime DEFAULT NULL,
  `unread_admin` int(11) NOT NULL DEFAULT 0,
  `unread_user` int(11) NOT NULL DEFAULT 0,
  `report_id` int(11) DEFAULT NULL COMMENT 'Links to reports table when ticket is a report',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `support_tickets`
--

INSERT INTO `support_tickets` (`id`, `user_id`, `category`, `subject`, `message`, `screenshot`, `urgency`, `status`, `admin_reply`, `replied_by`, `replied_at`, `last_message_at`, `unread_admin`, `unread_user`, `report_id`, `created_at`) VALUES
(8, 6, 'payment', 'ou0ueiguuaghaidshuiavhis', 'huihufiahuifhdsuv sdb,admjbifduij', 'uploads/support/ticket_6_3db78846ed7b9f7f.png', 'medium', 'open', NULL, NULL, NULL, NULL, 0, 0, NULL, '2026-03-30 22:56:35');

-- --------------------------------------------------------

--
-- Table structure for table `ticket_messages`
--

CREATE TABLE `ticket_messages` (
  `id` int(11) NOT NULL,
  `ticket_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `sender_role` enum('user','admin') NOT NULL DEFAULT 'user',
  `body` text NOT NULL,
  `attachment` varchar(255) DEFAULT NULL COMMENT 'Relative path to image attached in this chat message',
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transport_listings`
--

CREATE TABLE `transport_listings` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `vehicle_type` varchar(100) NOT NULL,
  `service_type` varchar(100) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `location` varchar(255) NOT NULL,
  `plate` varchar(100) DEFAULT '',
  `capacity` varchar(100) DEFAULT '',
  `rate` decimal(10,2) DEFAULT 0.00,
  `rate_type` varchar(100) DEFAULT '',
  `negotiable` tinyint(1) DEFAULT 0,
  `phone` varchar(50) NOT NULL,
  `availability` varchar(100) DEFAULT '',
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transport_listings`
--

INSERT INTO `transport_listings` (`id`, `user_id`, `vehicle_type`, `service_type`, `title`, `description`, `location`, `plate`, `capacity`, `rate`, `rate_type`, `negotiable`, `phone`, `availability`, `created_at`) VALUES
(1, 17, 'motorbike', 'goods', 'trtr5y', 'tt24t43444eer', 'errrr', '33344', '400', 400.00, 'Per Trip', 1, '0712345678', 'anytime', '2026-04-16 20:40:59'),
(2, 17, 'truck', 'both', 'jiuw9uw9', 'ojsiwiwu9uiw', 'kenya', 'KAA', '400', 300.00, 'Per Delivery', 1, '0798171482', 'weekends', '2026-04-16 20:47:04');

-- --------------------------------------------------------

--
-- Table structure for table `transport_requests`
--

CREATE TABLE `transport_requests` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `pickup_location` varchar(255) NOT NULL,
  `dropoff_location` varchar(255) NOT NULL,
  `vehicle_type` varchar(50) DEFAULT 'motorcycle',
  `service_type` varchar(50) DEFAULT 'standard',
  `pickup_datetime` datetime DEFAULT NULL,
  `package_description` text DEFAULT NULL,
  `package_size` varchar(50) DEFAULT NULL,
  `recipient_name` varchar(255) DEFAULT NULL,
  `recipient_phone` varchar(50) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `status` varchar(50) DEFAULT 'pending',
  `estimated_cost` decimal(10,2) DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transport_requests`
--

INSERT INTO `transport_requests` (`id`, `user_id`, `pickup_location`, `dropoff_location`, `vehicle_type`, `service_type`, `pickup_datetime`, `package_description`, `package_size`, `recipient_name`, `recipient_phone`, `notes`, `status`, `estimated_cost`, `created_at`) VALUES
(1, 17, 'CBD division, Starehe, Nairobi, Kenya', 'Ruaka, Kiambaa, Kiambu, Kenya', 'car_van', 'standard', '2026-04-19 14:20:00', 'electronic', 'medium', 'kin', '0798171482', 'gaau', 'pending', 2278.00, '2026-04-19 08:20:53');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `profile_pic` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `token` varchar(255) NOT NULL,
  `google_id` varchar(100) DEFAULT NULL,
  `avatar` varchar(500) DEFAULT NULL,
  `email_verified` tinyint(1) NOT NULL DEFAULT 0,
  `marketing_emails` tinyint(1) NOT NULL DEFAULT 0,
  `role` enum('buyer','seller','professional','rider') DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `account_type` enum('individual','business') DEFAULT 'individual',
  `is_admin` tinyint(1) NOT NULL DEFAULT 0,
  `strike_count` tinyint(3) NOT NULL DEFAULT 0,
  `warning_count` tinyint(3) NOT NULL DEFAULT 0,
  `banned_reason` varchar(255) DEFAULT NULL,
  `status` enum('active','suspended','banned') NOT NULL DEFAULT 'active',
  `suspended_until` datetime DEFAULT NULL,
  `status_reason` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `phone`, `profile_pic`, `password`, `token`, `google_id`, `avatar`, `email_verified`, `marketing_emails`, `role`, `created_at`, `account_type`, `is_admin`, `strike_count`, `warning_count`, `banned_reason`, `status`, `suspended_until`, `status_reason`) VALUES
(1, 'dennis kimani', 'kim03@gmail.com', NULL, '', '$2y$10$4G.tzD1FiNXrEmtBeHTm8.GoEQ.aQgKciQmfM6RlXOsdEvwbRhvQS', '', NULL, NULL, 0, 0, NULL, '2026-02-23 20:37:18', 'individual', 1, 0, 0, NULL, 'active', NULL, NULL),
(2, 'dennis kimani', 'kimanidennis493@gmail.com', NULL, '', '$2y$10$QPAz48ZHo583n/2.MYrpiO1A75vK/tdh/SfG77P8jK1WXRQ9XS9Aq', '', NULL, NULL, 0, 0, NULL, '2026-02-23 20:58:21', 'individual', 0, 0, 0, NULL, 'active', NULL, NULL),
(3, 'dennis kimani', 'kimanidennis133@gmail.com', NULL, '', '$2y$10$RQjPvcZTGZ1d..gCN4iOzuQhNmAjbaE3sfC5fvCKD267LpA.iAU2a', '', NULL, NULL, 0, 0, NULL, '2026-02-23 21:05:10', 'business', 0, 0, 0, NULL, 'active', NULL, NULL),
(4, 'mother', 'joshuaandewone@gmail.com', '0743435567', '', '$2y$10$/9FqD.ZN.GS5F9enFeQzNeWjaWewGD.uz1naurYYaijYUw9EtXrke', '', NULL, NULL, 0, 1, NULL, '2026-02-25 19:36:57', 'individual', 0, 0, 0, NULL, 'active', NULL, NULL),
(5, 'jh', 'kim5@gmail.com', '0723226900', '', '$2y$10$w7YnjxxUNWR9hHUrQVR.1ezAUQW7q/ZxdCiQ3PTBgPsl09YpEbV9.', '', NULL, NULL, 0, 1, NULL, '2026-02-25 20:53:36', 'business', 0, 0, 0, NULL, 'active', NULL, NULL),
(6, 'Cynthia Wairimu', 'cindycj002@gmail.com', '0114452030', '', '$2y$10$M7fOMgz6rfboNlFqv2ZkWeau1xVIYWUujQ8bAIvncjMXXPYc5uGEm', '', NULL, NULL, 0, 1, '', '2026-02-26 12:20:17', 'individual', 0, 0, 0, NULL, 'active', NULL, NULL),
(7, 'cindy cj', 'cindycj003@gmail.com', '0114452030', '', '$2y$10$2jPcqxvc4T2xzKf58Pbf6urRef5U3eZG1murKUfdIC3j.WPPPneOO', '', NULL, NULL, 0, 1, NULL, '2026-02-26 12:27:00', 'business', 0, 0, 0, NULL, 'active', NULL, NULL),
(8, 'mother', 'joshuaandreuwone@gmail.com', '0723226901', '', '$2y$10$sjjps.ECqEaclB/pmmDAkOTyENVQKDsfGEpEkwngL0C72D9M0fOj.', '', NULL, NULL, 0, 1, NULL, '2026-03-15 20:08:46', 'individual', 0, 0, 0, NULL, 'active', NULL, NULL),
(9, 'joseph parmuat', 'joshuaandrewone@gmail.com', '0742476688', '', '$2y$10$roUOLDstcDZTL7zmExx5TOuJePDdwxS/tMmAn0/dKQ6PwC7uHkflm', '', NULL, NULL, 0, 1, NULL, '2026-03-23 23:51:19', 'individual', 0, 0, 0, NULL, 'active', NULL, NULL),
(10, 'Inamik Si', 'siinamik022@gmail.com', '+254723226905', '', '$2y$10$f3uleS3bSO7iYhSxARjgsuNxZBWs/wXbA1kaN67LNWkwRay..BL6S', '', NULL, NULL, 0, 1, NULL, '2026-03-25 11:12:43', 'individual', 0, 0, 0, NULL, 'active', NULL, NULL),
(17, 'Dancan Ngigi', 'ngigidancan227@gmail.com', '0798171482', '', '$2b$10$Hl0y1AeIk8M4/7vgUadyieiLPja1qq9IcvV1Zr7KBAUn.SILupmrK', '87ed4c6729bdfbf7fe34f5b135c2eae0', NULL, NULL, 1, 0, NULL, '2026-04-06 11:13:08', 'individual', 0, 0, 0, NULL, 'active', NULL, NULL),
(18, 'mbugua kinyanjui', 'kinyanjui.12389@student.ac.ke', '0798171482', '', '$2b$10$GN7f6K29.h0BDc52BWi6WewQkSb9Fs43tszBYnSS2d4xxuhH30bF6', 'b2071bba522bbad7986168a6ff22d927', NULL, NULL, 1, 0, NULL, '2026-04-09 11:23:31', 'individual', 0, 0, 0, NULL, 'active', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_notes`
--

CREATE TABLE `user_notes` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `note` text NOT NULL,
  `type` enum('note','warning','strike') NOT NULL DEFAULT 'note',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_actions_log`
--
ALTER TABLE `admin_actions_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_admin` (`admin_id`),
  ADD KEY `idx_target` (`target_type`,`target_id`);

--
-- Indexes for table `auctions`
--
ALTER TABLE `auctions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_ends_at` (`ends_at`),
  ADD KEY `idx_category` (`category`),
  ADD KEY `auctions_ibfk_2` (`winner_id`);

--
-- Indexes for table `auction_bids`
--
ALTER TABLE `auction_bids`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_auction` (`auction_id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `auction_watchlist`
--
ALTER TABLE `auction_watchlist`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_watch` (`user_id`,`auction_id`),
  ADD KEY `auction_id` (`auction_id`);

--
-- Indexes for table `barter_offers`
--
ALTER TABLE `barter_offers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_category` (`category`);

--
-- Indexes for table `business_profiles`
--
ALTER TABLE `business_profiles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `deliveries`
--
ALTER TABLE `deliveries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `delivery_requests`
--
ALTER TABLE `delivery_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender_id` (`sender_id`);

--
-- Indexes for table `flash_sales`
--
ALTER TABLE `flash_sales`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_active_ends` (`is_active`,`ends_at`),
  ADD KEY `flash_sales_ibfk_1` (`created_by`);

--
-- Indexes for table `listings`
--
ALTER TABLE `listings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `idx_category` (`category`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_created_at` (`created_at`),
  ADD KEY `idx_admin_status` (`status`);

--
-- Indexes for table `listing_flags`
--
ALTER TABLE `listing_flags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_listing_id` (`listing_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_sender_receiver` (`sender_id`,`receiver_id`),
  ADD KEY `idx_listing` (`listing_id`),
  ADD KEY `receiver_id` (`receiver_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user` (`user_id`,`created_at`),
  ADD KEY `idx_type` (`type`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `buyer_id` (`buyer_id`),
  ADD KEY `seller_id` (`seller_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_token` (`token`),
  ADD KEY `idx_user_id` (`user_id`);

--
-- Indexes for table `professionals`
--
ALTER TABLE `professionals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_urgency` (`urgency`),
  ADD KEY `idx_reporter` (`reporter_id`),
  ADD KEY `idx_listing` (`listing_id`),
  ADD KEY `reports_user_fk` (`reported_user_id`),
  ADD KEY `reports_admin_fk` (`reviewed_by`);

--
-- Indexes for table `saved_items`
--
ALTER TABLE `saved_items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_save` (`user_id`,`listing_id`),
  ADD KEY `listing_id` (`listing_id`);

--
-- Indexes for table `seller_reviews`
--
ALTER TABLE `seller_reviews`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_review` (`seller_id`,`reviewer_id`),
  ADD KEY `idx_seller` (`seller_id`),
  ADD KEY `idx_reviewer` (`reviewer_id`),
  ADD KEY `idx_listing` (`listing_id`);

--
-- Indexes for table `support_tickets`
--
ALTER TABLE `support_tickets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_report` (`report_id`);

--
-- Indexes for table `ticket_messages`
--
ALTER TABLE `ticket_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_ticket` (`ticket_id`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `transport_listings`
--
ALTER TABLE `transport_listings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transport_requests`
--
ALTER TABLE `transport_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `uq_google_id` (`google_id`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `user_notes`
--
ALTER TABLE `user_notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_actions_log`
--
ALTER TABLE `admin_actions_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auctions`
--
ALTER TABLE `auctions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `auction_bids`
--
ALTER TABLE `auction_bids`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auction_watchlist`
--
ALTER TABLE `auction_watchlist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `barter_offers`
--
ALTER TABLE `barter_offers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `business_profiles`
--
ALTER TABLE `business_profiles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `deliveries`
--
ALTER TABLE `deliveries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `delivery_requests`
--
ALTER TABLE `delivery_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `flash_sales`
--
ALTER TABLE `flash_sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `listings`
--
ALTER TABLE `listings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `listing_flags`
--
ALTER TABLE `listing_flags`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `professionals`
--
ALTER TABLE `professionals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `saved_items`
--
ALTER TABLE `saved_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `seller_reviews`
--
ALTER TABLE `seller_reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `support_tickets`
--
ALTER TABLE `support_tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `ticket_messages`
--
ALTER TABLE `ticket_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `transport_listings`
--
ALTER TABLE `transport_listings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `transport_requests`
--
ALTER TABLE `transport_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `user_notes`
--
ALTER TABLE `user_notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auctions`
--
ALTER TABLE `auctions`
  ADD CONSTRAINT `auctions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `auctions_ibfk_2` FOREIGN KEY (`winner_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `auction_bids`
--
ALTER TABLE `auction_bids`
  ADD CONSTRAINT `auction_bids_ibfk_1` FOREIGN KEY (`auction_id`) REFERENCES `auctions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `auction_bids_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `auction_watchlist`
--
ALTER TABLE `auction_watchlist`
  ADD CONSTRAINT `auction_watchlist_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `auction_watchlist_ibfk_2` FOREIGN KEY (`auction_id`) REFERENCES `auctions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `barter_offers`
--
ALTER TABLE `barter_offers`
  ADD CONSTRAINT `fk_barter_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `business_profiles`
--
ALTER TABLE `business_profiles`
  ADD CONSTRAINT `business_profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `deliveries`
--
ALTER TABLE `deliveries`
  ADD CONSTRAINT `deliveries_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `delivery_requests`
--
ALTER TABLE `delivery_requests`
  ADD CONSTRAINT `delivery_requests_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `flash_sales`
--
ALTER TABLE `flash_sales`
  ADD CONSTRAINT `flash_sales_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `listings`
--
ALTER TABLE `listings`
  ADD CONSTRAINT `listings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `messages_ibfk_3` FOREIGN KEY (`listing_id`) REFERENCES `listings` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`buyer_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD CONSTRAINT `fk_pr_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `professionals`
--
ALTER TABLE `professionals`
  ADD CONSTRAINT `professionals_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `reports`
--
ALTER TABLE `reports`
  ADD CONSTRAINT `reports_admin_fk` FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `reports_listing_fk` FOREIGN KEY (`listing_id`) REFERENCES `listings` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `reports_reporter_fk` FOREIGN KEY (`reporter_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reports_user_fk` FOREIGN KEY (`reported_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `saved_items`
--
ALTER TABLE `saved_items`
  ADD CONSTRAINT `saved_items_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `saved_items_ibfk_2` FOREIGN KEY (`listing_id`) REFERENCES `listings` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `seller_reviews`
--
ALTER TABLE `seller_reviews`
  ADD CONSTRAINT `reviews_listing_fk` FOREIGN KEY (`listing_id`) REFERENCES `listings` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `reviews_reviewer_fk` FOREIGN KEY (`reviewer_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_seller_fk` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
