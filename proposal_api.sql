-- phpMyAdmin SQL Dump
-- version 5.2.2deb1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 29, 2025 at 09:35 AM
-- Server version: 8.4.6-0ubuntu0.25.04.3
-- PHP Version: 8.4.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `proposal_api`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('laravel-cache-livewire-rate-limiter:16d36dff9abd246c67dfac3e63b993a169af77e6', 'i:1;', 1761722687),
('laravel-cache-livewire-rate-limiter:16d36dff9abd246c67dfac3e63b993a169af77e6:timer', 'i:1761722687;', 1761722687);

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
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
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
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_10_17_090340_create_templates_table', 1),
(5, '2025_10_17_090429_create_proposals_table', 1),
(6, '2025_10_17_102527_create_personal_access_tokens_table', 1),
(7, '2025_10_28_000000_remove_experience_from_templates', 1),
(8, '2025_10_28_111410_remove_tone_length_usage_columns', 1),
(9, '2025_10_28_132930_add_openai_fields_to_proposals_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(9, 'App\\Models\\User', 1, 'chrome-extension', '61f8d7ba6e9d249a36a3505cff5ee74ad2cfbe1e5adb5b49f4ea22f09730b5bf', '[\"*\"]', '2025-10-29 04:03:28', NULL, '2025-10-29 04:03:00', '2025-10-29 04:03:28');

-- --------------------------------------------------------

--
-- Table structure for table `proposals`
--

CREATE TABLE `proposals` (
  `id` bigint UNSIGNED NOT NULL,
  `template_id` bigint UNSIGNED DEFAULT NULL,
  `job_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `job_description` text COLLATE utf8mb4_unicode_ci,
  `job_skills` text COLLATE utf8mb4_unicode_ci,
  `job_budget` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `generated_at` timestamp NULL DEFAULT NULL,
  `experience_mentioned` text COLLATE utf8mb4_unicode_ci,
  `skills_used` text COLLATE utf8mb4_unicode_ci,
  `client_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `generated_proposal` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `proposals`
--

INSERT INTO `proposals` (`id`, `template_id`, `job_title`, `job_description`, `job_skills`, `job_budget`, `generated_at`, `experience_mentioned`, `skills_used`, `client_name`, `generated_proposal`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Full Stack Developer for E-commerce Platform', 'We need a skilled developer to build a modern e-commerce platform using React and Node.js. The project includes user authentication, payment integration, and admin dashboard.', 'React, Node.js, JavaScript, MongoDB', '$2000-$5000', '2025-10-29 03:35:47', NULL, NULL, NULL, 'Dear Hiring Manager,\n\nI am excited to apply for the Full Stack Developer position for your e-commerce platform. With over 5 years of experience in web development, I have extensive expertise in React and Node.js, which aligns perfectly with your requirements.\n\nI have built multiple e-commerce solutions featuring user authentication, secure payment integrations (such as Stripe and PayPal), and dynamic admin dashboards. My proficiency with MongoDB ensures robust data handling and scalability for your platform.\n\nI understand the importance of a seamless, secure user experience and am eager to bring your vision to life with clean, efficient code. Let’s discuss how I can contribute to your project’s success. I am available for a call at your convenience.\n\nBest regards,\n\n[Your Name]', '2025-10-29 03:35:47', '2025-10-29 03:35:47'),
(2, 1, 'Full Stack Developer for E-commerce Platform', 'We need a skilled developer to build a modern e-commerce platform using React and Node.js.', 'React, Node.js, JavaScript, MongoDB', '$2000-$5000', NULL, NULL, NULL, NULL, 'Dear Hiring Manager,\n\nI am writing to express my strong interest in the Full Stack Developer for E-commerce Platform position. I am confident in my ability to deliver exceptional results for your project.\n\nI have carefully reviewed your job description: We need a skilled developer to build a modern e-commerce platform using React and Node.js.\n\nMy expertise directly aligns with your requirements, particularly in React, Node.js, JavaScript, MongoDB. I understand that your budget is $2000-$5000, and I am prepared to work within your parameters while ensuring high-quality deliverables.\n\nMy approach includes:\n- Thorough project analysis and planning\n- Regular communication and progress updates\n- Clean, maintainable code following best practices\n- Testing and quality assurance\n- On-time delivery\n\nI would welcome the opportunity to discuss how my skills and experience can contribute to the success of your project. I am available for a call at your convenience.\n\nLooking forward to working with you.\n\nBest regards', '2025-10-29 03:36:10', '2025-10-29 03:36:10'),
(3, 5, 'Deep Learning Model Development for Text Classification', 'SummaryWe are seeking an experienced consultant to analyze our current Amazon listings and develop an AI strategy to enhance our visual content. The consultant will identify suitable AI tools and develop prompt structures, workflows, and quality standards for image and video generation. DeliverablesAnalyze current Amazon listingsDefine AI strategyIdentify suitable AI toolsDevelop prompt structuresCreate workflows and quality standards', 'Amazon Web ServicesSearch Engine Optimization, Amazon S3Amazon MWS, MidjourneyRunwayChatGPT, AI Model Training', '$800.00', NULL, NULL, NULL, NULL, 'Hello,\n\nI\'m interested in your Deep Learning Model Development for Text Classification project and believe I\'m a great fit.\n\nKey points:\n• Amazon Web ServicesSearch Engine Optimization, Amazon S3Amazon MWS, MidjourneyRunwayChatGPT, AI Model Training expertise\n• Available to start immediately\n• Budget: $800.00 works for me\n• Quality delivery guaranteed\n\nI\'ve reviewed your requirements: SummaryWe are seeking an experienced consultant to analyze our current Amazon listings and develop an AI strategy to enhance our visual content. The consultant will identify suitable AI tools and develop prompt structures, workflows, and quality standards for image and video generation. DeliverablesAnalyze current Amazon listingsDefine AI strategyIdentify suitable AI toolsDevelop prompt structuresCreate workflows and quality standards\n\nLet\'s discuss how I can help achieve your goals.\n\nBest regards', '2025-10-29 03:37:12', '2025-10-29 03:37:12'),
(4, NULL, 'Simple Test Job', 'Test description', 'PHP, Laravel', '$1000', '2025-10-29 03:47:21', NULL, NULL, NULL, 'Dear Hiring Manager,\n\nI’ve carefully reviewed your test job posting and am enthusiastic about the opportunity to demonstrate my skills. With over 5 years of specialized experience in web development, particularly with PHP and Laravel, I am confident in my ability to deliver a high-quality, efficient solution tailored to your needs.\n\nGiven that this is a test, I am prepared to showcase my expertise through a practical demonstration or a brief sample task, which has been my approach in successfully completing similar projects in the past. My work emphasizes clean, scalable code and timely delivery, ensuring client satisfaction.\n\nI would appreciate the chance to discuss how my skills align with your requirements further. Please let me know if there’s a specific aspect you’d like me to focus on in the test, or if you have any preliminary questions.\n\nLooking forward to your response and the possibility of collaborating.\n\nBest regards,\n[Your Name]', '2025-10-29 03:47:21', '2025-10-29 03:47:21'),
(5, 1, 'React Developer for E-commerce Dashboard', 'We need an experienced React developer to build a modern admin dashboard for our e-commerce platform. The dashboard should include analytics, order management, and user management features. Must have experience with React, TypeScript, and modern UI libraries.', 'React, TypeScript, JavaScript, Material-UI, Redux', '$3000-$6000', '2025-10-29 03:47:43', NULL, NULL, NULL, 'Dear Hiring Manager,  \n\nI am excited to apply for the React Developer role to build your e-commerce admin dashboard. With over [X years] of experience developing React-based dashboards, including projects for e-commerce platforms, I am well-equipped to deliver a solution that meets your needs for analytics, order management, and user management.  \n\nYour requirement for React, TypeScript, and modern UI libraries aligns perfectly with my expertise. I have successfully implemented similar features using React, TypeScript, Material-UI, and state management with Redux in past projects. For example, I recently built a dashboard that improved order processing efficiency by 30% through intuitive UI and real-time analytics integration.  \n\nMy approach includes:  \n- Conducting a detailed analysis to tailor the dashboard to your specific e-commerce workflows.  \n- Using modular, maintainable code practices to ensure scalability.  \n- Integrating robust testing (unit and integration tests) for reliability.  \n- Providing weekly progress updates and maintaining open communication.  \n\nI am confident I can deliver within your budget of $3000–$6000 without compromising quality. I’ve attached links to my portfolio and GitHub for your review, which include examples of admin dashboards I’ve developed.  \n\nI’d love to discuss how my experience can bring value to your project. Please let me know a convenient time for a call.  \n\nBest regards,  \n[Your Name]', '2025-10-29 03:47:43', '2025-10-29 03:47:43'),
(6, 5, 'Deep Learning Model Development for Text Classification', 'SummaryWe are seeking an experienced consultant to analyze our current Amazon listings and develop an AI strategy to enhance our visual content. The consultant will identify suitable AI tools and develop prompt structures, workflows, and quality standards for image and video generation. DeliverablesAnalyze current Amazon listingsDefine AI strategyIdentify suitable AI toolsDevelop prompt structuresCreate workflows and quality standards', 'Amazon Web ServicesSearch Engine Optimization, Amazon S3Amazon MWS, MidjourneyRunwayChatGPT, AI Model Training', '$800.00', '2025-10-29 03:50:24', NULL, NULL, NULL, 'Hello,\n\nI am excited about your project to enhance visual content for your Amazon listings through AI strategy. With extensive experience in AI-driven visual content generation, including prompt engineering, workflow design, and tool selection (such as Midjourney, Runway, and others), I am confident I can help you achieve your goals.\n\nIn my previous roles, I have:\n- Developed AI strategies for e-commerce clients, improving visual engagement and conversion rates.\n- Created structured prompts and quality standards for consistent, high-quality image and video outputs.\n- Analyzed existing content to identify gaps and opportunities for AI integration.\n\nI would start by conducting a thorough analysis of your current Amazon listings to tailor a strategy that aligns with your brand and objectives. My approach ensures not only the identification of the best AI tools but also the establishment of efficient workflows to streamline your content creation process.\n\nI am available to begin immediately and believe my expertise can deliver significant value within your budget. I would love to schedule a brief call to discuss your specific needs and how I can help you succeed.\n\nBest regards,\n[Your Name]', '2025-10-29 03:50:24', '2025-10-29 03:50:24'),
(7, 1, 'Test Web Developer Position', 'We need a skilled web developer to build a modern website using React and Node.js.', 'React, Node.js, JavaScript', '$1000-$2000', NULL, NULL, NULL, NULL, 'Dear Hiring Manager,\n\nI am writing to express my strong interest in the Test Web Developer Position position. I am confident in my ability to deliver exceptional results for your project.\n\nI have carefully reviewed your job description: We need a skilled web developer to build a modern website using React and Node.js.\n\nMy expertise directly aligns with your requirements, particularly in React, Node.js, JavaScript. I understand that your budget is $1000-$2000, and I am prepared to work within your parameters while ensuring high-quality deliverables.\n\nMy approach includes:\n- Thorough project analysis and planning\n- Regular communication and progress updates\n- Clean, maintainable code following best practices\n- Testing and quality assurance\n- On-time delivery\n\nI would welcome the opportunity to discuss how my skills and experience can contribute to the success of your project. I am available for a call at your convenience.\n\nLooking forward to working with you.\n\nBest regards', '2025-10-29 03:52:49', '2025-10-29 03:52:49'),
(8, 6, 'Mechanical Design for Industrial Material-Handling Machine', 'SummaryUrgently needed ----- A tutorial is needed to simulate the response parameters e. (Cutting Reaction Force (F x , F y , F z ) and Cutting Zone Temperature, T c ) using Finite Element Method for Turning a composite material while considering Input parameters e. (RPM, Feed and Depth of Cut) in ANSYS. A word document is attached herewith containing all the necessary material/ cutting tool properties for setting the simulation parameters. The required simulation model will need to be run for 18 experimental runs where the experimental conditions are mentioned in the provided document as well. The 3D models which are to be used for this simulation are also attached herewith which are to be loaded without any geometrical or any other type of errors in ANSYS for the FEA simulation', 'ANSYSFinite Element Analysis', '$35.00', '2025-10-29 04:03:47', NULL, NULL, NULL, 'Dear Hiring Manager,\n\nI am writing to express my strong interest in your project to simulate cutting reaction forces and temperature in ANSYS for turning a composite material. I have carefully reviewed the attached Word document and 3D models and understand the urgency and technical requirements, including the 18 experimental runs with varying RPM, feed, and depth of cut parameters.\n\nWith over [X years] of experience in Finite Element Analysis using ANSYS, specifically in machining simulations for composite materials, I am well-equipped to handle this project. My expertise includes setting up simulation parameters based on material properties, ensuring error-free geometry import, and analyzing results for forces (F_x, F_y, F_z) and temperature (T_c). I have successfully completed similar projects, such as [brief example, e.g., \"simulating turning processes for carbon-fiber composites\"].\n\nMy approach will involve:\n1. Validating the 3D models in ANSYS to avoid geometrical errors.\n2. Configuring the simulation parameters as per the provided document.\n3. Running the 18 experimental runs efficiently and documenting the results clearly.\n4. Delivering a comprehensive tutorial outlining the process and findings.\n\nI am confident in delivering high-quality results within your $35 budget and timeline. I am available to start immediately and provide regular updates throughout the project.\n\nI would welcome the opportunity to discuss further details and demonstrate how my skills align with your needs.\n\nBest regards,\n[Your Name]', '2025-10-29 04:03:47', '2025-10-29 04:03:47');

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
('HA35roOeRN5nWz1H9fNV2VHKO4Txc4mEep76EvoR', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'YTo3OntzOjY6Il90b2tlbiI7czo0MDoiQnlITGhpMmhieXp2S2NpZlZDa3daM1JQcHZPaUVhQlhrbHZ4NlJycCI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjM3OiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYWRtaW4vcHJvcG9zYWxzIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjE3OiJwYXNzd29yZF9oYXNoX3dlYiI7czo2MDoiJDJ5JDEyJHY3STY2cU9PT2RlTVYuYUNqOFVXTC5hYUJiLnBici5HQlJib0UvdHVKOXU4MG1Ma0pXYnllIjtzOjY6InRhYmxlcyI7YToyOntzOjQwOiI4Zjg5YzdkYjcyY2RjZjdiMTA4NTNhNDEwMDUwYWFlYl9jb2x1bW5zIjthOjU6e2k6MDthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czoxMzoidGVtcGxhdGUubmFtZSI7czo1OiJsYWJlbCI7czo4OiJUZW1wbGF0ZSI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjE7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6OToiam9iX3RpdGxlIjtzOjU6ImxhYmVsIjtzOjk6IkpvYiB0aXRsZSI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjI7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MTA6ImpvYl9idWRnZXQiO3M6NToibGFiZWwiO3M6MTA6IkpvYiBidWRnZXQiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aTozO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjEwOiJjcmVhdGVkX2F0IjtzOjU6ImxhYmVsIjtzOjEwOiJDcmVhdGVkIGF0IjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MTtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MTtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO2I6MDt9aTo0O2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjEwOiJ1cGRhdGVkX2F0IjtzOjU6ImxhYmVsIjtzOjEwOiJVcGRhdGVkIGF0IjtzOjg6ImlzSGlkZGVuIjtiOjA7czo5OiJpc1RvZ2dsZWQiO2I6MDtzOjEyOiJpc1RvZ2dsZWFibGUiO2I6MTtzOjI0OiJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiO2I6MTt9fXM6NDA6Ijg4MTFiNWU5Y2E1YzU4MDA5NjEwMzlmMjNjMjg2MzhjX2NvbHVtbnMiO2E6NTp7aTowO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjQ6Im5hbWUiO3M6NToibGFiZWwiO3M6NDoiTmFtZSI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjE7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MTE6ImRlc2NyaXB0aW9uIjtzOjU6ImxhYmVsIjtzOjExOiJEZXNjcmlwdGlvbiI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjI7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6OToiaXNfYWN0aXZlIjtzOjU6ImxhYmVsIjtzOjk6IklzIGFjdGl2ZSI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjM7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MTA6ImNyZWF0ZWRfYXQiO3M6NToibGFiZWwiO3M6MTA6IkNyZWF0ZWQgYXQiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjowO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjoxO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7YjoxO31pOjQ7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MTA6InVwZGF0ZWRfYXQiO3M6NToibGFiZWwiO3M6MTA6IlVwZGF0ZWQgYXQiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjowO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjoxO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7YjoxO319fX0=', 1761730469);

-- --------------------------------------------------------

--
-- Table structure for table `templates`
--

CREATE TABLE `templates` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `templates`
--

INSERT INTO `templates` (`id`, `name`, `content`, `description`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Professional Web Development', 'Dear Hiring Manager,\n\nI am writing to express my strong interest in the {{job_title}} position. I am confident in my ability to deliver exceptional results for your project.\n\nI have carefully reviewed your job description: {{job_description}}\n\nMy expertise directly aligns with your requirements, particularly in {{skills}}. I understand that your budget is {{budget}}, and I am prepared to work within your parameters while ensuring high-quality deliverables.\n\nMy approach includes:\n- Thorough project analysis and planning\n- Regular communication and progress updates\n- Clean, maintainable code following best practices\n- Testing and quality assurance\n- On-time delivery\n\nI would welcome the opportunity to discuss how my skills and experience can contribute to the success of your project. I am available for a call at your convenience.\n\nLooking forward to working with you.\n\nBest regards', 'Standard professional template for web development projects', 1, '2025-10-29 01:48:20', '2025-10-29 01:48:20'),
(2, 'Friendly Web Development', 'Hi there!\n\nThanks for posting this {{job_title}} opportunity – it sounds like a great project!\n\nI\'d love to help bring your vision to life. I read through your description and I\'m excited about what you\'re building.\n\nHere\'s what caught my attention: {{job_description}}\n\nI have solid experience with {{skills}}, which seems like a perfect match for what you need. I noticed your budget is {{budget}}, and I\'m flexible and ready to discuss how we can make this work.\n\nWhat I bring to the table:\n- A collaborative, easy-going work style\n- Clear communication throughout the project\n- Quality work that I\'m proud to put my name on\n- Flexibility to adapt to your needs\n\nI\'d love to chat more about your project! Feel free to reach out anytime – I\'m here to help.\n\nCheers!', 'Warm and approachable template for web development', 1, '2025-10-29 01:48:20', '2025-10-29 01:48:20'),
(3, 'Professional Web Development', 'Dear Hiring Manager,\n\nI am writing to express my strong interest in the {{job_title}} position. I am confident in my ability to deliver exceptional results for your project.\n\nI have carefully reviewed your job description: {{job_description}}\n\nMy expertise directly aligns with your requirements, particularly in {{skills}}. I understand that your budget is {{budget}}, and I am prepared to work within your parameters while ensuring high-quality deliverables.\n\nMy approach includes:\n- Thorough project analysis and planning\n- Regular communication and progress updates\n- Clean, maintainable code following best practices\n- Testing and quality assurance\n- On-time delivery\n\nI would welcome the opportunity to discuss how my skills and experience can contribute to the success of your project. I am available for a call at your convenience.\n\nLooking forward to working with you.\n\nBest regards', 'Standard professional template for web development projects', 1, '2025-10-29 01:48:50', '2025-10-29 01:48:50'),
(4, 'Friendly Web Development', 'Hi there!\n\nThanks for posting this {{job_title}} opportunity – it sounds like a great project!\n\nI\'d love to help bring your vision to life. I read through your description and I\'m excited about what you\'re building.\n\nHere\'s what caught my attention: {{job_description}}\n\nI have solid experience with {{skills}}, which seems like a perfect match for what you need. I noticed your budget is {{budget}}, and I\'m flexible and ready to discuss how we can make this work.\n\nWhat I bring to the table:\n- A collaborative, easy-going work style\n- Clear communication throughout the project\n- Quality work that I\'m proud to put my name on\n- Flexibility to adapt to your needs\n\nI\'d love to chat more about your project! Feel free to reach out anytime – I\'m here to help.\n\nCheers!', 'Warm and approachable template for web development', 1, '2025-10-29 01:48:50', '2025-10-29 01:48:50'),
(5, 'Concise & Direct', 'Hello,\n\nI\'m interested in your {{job_title}} project and believe I\'m a great fit.\n\nKey points:\n• {{skills}} expertise\n• Available to start immediately\n• Budget: {{budget}} works for me\n• Quality delivery guaranteed\n\nI\'ve reviewed your requirements: {{job_description}}\n\nLet\'s discuss how I can help achieve your goals.\n\nBest regards', 'Short and to-the-point template for quick applications', 1, '2025-10-29 01:48:50', '2025-10-29 01:48:50'),
(6, 'AI-Enhanced Template', 'Dear Hiring Manager,\n\nI\'m excited about your {{job_title}} project and would love to contribute to its success.\n\nProject Understanding:\n{{job_description}}\n\nMy Relevant Skills:\n{{skills}}\n\nBudget Alignment:\nI see your budget is {{budget}}, and I\'m confident we can deliver excellent value within this range.\n\nWhy Choose Me:\n- Proven track record in similar projects\n- Clear communication and regular updates\n- Quality-focused approach\n- On-time delivery commitment\n\nI\'d appreciate the opportunity to discuss your project in detail and show how my expertise can benefit your goals.\n\nLooking forward to your response.\n\nBest regards', 'Template designed to work well with AI enhancement', 1, '2025-10-29 01:48:50', '2025-10-29 01:48:50');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Test User', 'admin@admin.com', '2025-10-29 01:48:19', '$2y$12$v7I66qOOOdeMV.aCj8UWL.aaBb.pbr.GBRboE/tuJ9u80mLkJWbye', 'p76INTOUgG', '2025-10-29 01:48:20', '2025-10-29 01:48:20');

--
-- Indexes for dumped tables
--

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
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indexes for table `proposals`
--
ALTER TABLE `proposals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `proposals_template_id_foreign` (`template_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `templates`
--
ALTER TABLE `templates`
  ADD PRIMARY KEY (`id`);

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
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `proposals`
--
ALTER TABLE `proposals`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `templates`
--
ALTER TABLE `templates`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `proposals`
--
ALTER TABLE `proposals`
  ADD CONSTRAINT `proposals_template_id_foreign` FOREIGN KEY (`template_id`) REFERENCES `templates` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
