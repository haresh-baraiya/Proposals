-- phpMyAdmin SQL Dump
-- version 5.2.2deb1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 28, 2025 at 05:33 AM
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
('laravel-cache-livewire-rate-limiter:16d36dff9abd246c67dfac3e63b993a169af77e6', 'i:1;', 1761628902),
('laravel-cache-livewire-rate-limiter:16d36dff9abd246c67dfac3e63b993a169af77e6:timer', 'i:1761628902;', 1761628902);

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
(4, '2025_10_17_090340_create_templates_table', 2),
(5, '2025_10_17_090429_create_proposals_table', 2),
(6, '2025_10_17_102527_create_personal_access_tokens_table', 3);

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
(17, 'App\\Models\\User', 1, 'chrome-extension', '34b4b3ad8833615f064b1aa26419265cca2e4d46ae604b0593ddf704073a3791', '[\"*\"]', '2025-10-28 00:02:13', NULL, '2025-10-28 00:01:49', '2025-10-28 00:02:13');

-- --------------------------------------------------------

--
-- Table structure for table `proposals`
--

CREATE TABLE `proposals` (
  `id` bigint UNSIGNED NOT NULL,
  `template_id` bigint UNSIGNED NOT NULL,
  `job_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `job_description` text COLLATE utf8mb4_unicode_ci,
  `job_skills` text COLLATE utf8mb4_unicode_ci,
  `job_budget` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `generated_proposal` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `tone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `length` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `proposals`
--

INSERT INTO `proposals` (`id`, `template_id`, `job_title`, `job_description`, `job_skills`, `job_budget`, `generated_proposal`, `tone`, `length`, `created_at`, `updated_at`) VALUES
(1, 1, 'Test Web Developer Position', 'We need a skilled web developer to build a modern website using React and Node.js.', 'React, Node.js, JavaScript', '$1000-$2000', 'Dear Hiring Manager,\n\nI am writing to express my strong interest in the Test Web Developer Position position. With 5+ years in web development, I am confident in my ability to deliver exceptional results for your project.\n\nI have carefully reviewed your job description: We need a skilled web developer to build a modern website using React and Node.js.\n\nMy expertise directly aligns with your requirements, particularly in React, Node.js, JavaScript. I understand that your budget is $1000-$2000, and I am prepared to work within your parameters while ensuring high-quality deliverables.\n\nMy approach includes:\n- Thorough project analysis and planning\n- Regular communication and progress updates\n- Clean, maintainable code following best practices\n- Testing and quality assurance\n- On-time delivery\n\nI would welcome the opportunity to discuss how my skills and experience can contribute to the success of your project. I am available for a call at your convenience.\n\nLooking forward to working with you.\n\nBest regards', 'professional', 'medium', '2025-10-17 04:24:43', '2025-10-17 04:24:43'),
(2, 1, 'Test Web Developer Position', 'We need a skilled web developer to build a modern website using React and Node.js.', 'React, Node.js, JavaScript', '$1000-$2000', 'Dear Hiring Manager,\n\nI am writing to express my strong interest in the Test Web Developer Position position. With 5+ years in web development, I am confident in my ability to deliver exceptional results for your project.\n\nI have carefully reviewed your job description: We need a skilled web developer to build a modern website using React and Node.js.\n\nMy expertise directly aligns with your requirements, particularly in React, Node.js, JavaScript. I understand that your budget is $1000-$2000, and I am prepared to work within your parameters while ensuring high-quality deliverables.\n\nMy approach includes:\n- Thorough project analysis and planning\n- Regular communication and progress updates\n- Clean, maintainable code following best practices\n- Testing and quality assurance\n- On-time delivery\n\nI would welcome the opportunity to discuss how my skills and experience can contribute to the success of your project. I am available for a call at your convenience.\n\nLooking forward to working with you.\n\nBest regards', 'professional', 'medium', '2025-10-17 05:51:37', '2025-10-17 05:51:37'),
(3, 1, 'Mobile/Full-Stack Developer for React and Flutter App', 'As part of our continued efforts to remain compliant with tax laws globally, please enter your Tax Identification Number here.Close the alertMobile/Full-Stack Developer for React and Flutter AppPosted 5 hours agoWorldwideSpecialized profiles can help you better highlight your expertise when submitting proposals to jobs like these. Create a specialized profile.SummaryJob Summary: You will be joining a developing team. As the Mobile/Full-Stack Developer, you will maintain and enhance the React and Flutter-based app for iOS/Android, focusing on frontend features and backend integrations to support weekly updates and 1M users. Key Responsibilities: - Design and develop cross-platform mobile applications for iOS and Android using React or Flutter - Implement QR code scanning functionality with camera integration - Integrate push notifications using OneSignal - Build intuitive user interfaces for scanning, user accounts, verification displays, and related flows - Manage app publishing and updates on Apple App Store and Google Play Store - Ensure app performance, quality, and responsiveness, including optimization for cross-platform compatibility - Implement offline-first architecture for key features - Collaborate with backend engineer on API integration for seamless code validations and system flows - Write clean, maintainable, and well-documented code - Conduct testing and debugging for optimal app performance, including automation - Handle app store compliance, reviews, version management, and deployments - Monitor analytics (e.g., Firebase) and implement weekly features or bug fixesDeliverablesDesign and develop cross-platform mobile applicationsImplement QR code scanning functionalityIntegrate push notifications using OneSignalBuild intuitive user interfacesManage app publishing and updatesEnsure app performance and responsivenessImplement offline-first architectureCollaborate on API integrationWrite clean and maintainable codeConduct testing and debuggingHandle app store compliance and deploymentsMonitor analytics and implement weekly featuresMore than 30 hrs/weekHourlyMore than 6 months6+ monthsDurationIntermediateI am looking for a mix of experience and valueExperience LevelAttachmentMobileFull-Stack Developer.pdf (313 KB) Project Type:Complex projectYou will be asked to answer the following questions when submitting a proposal:Portfolio of published React Native apps (links required)Describe your recent experience with similar projectsPlease list any certifications related to this projectInclude a link to your GitHub profile and/or websiteWhat frameworks have you worked with?Skills and ExpertiseMandatory skillsMobile App DevelopmentApache CordovaNice-to-have skillsIonic FrameworkAndroid App DevelopmentToolsReactFlutterOneSignalFirebaseApple App StoreGoogle Play StorePreferred qualificationsActivity on this jobProposals:Close the tooltipThis range includes relevant proposals, but does not include proposals that are withdrawn, declined, or archived. Please note that all proposals are accessible to clients on their applicants page.20 to 50Last viewed by client:Close the tooltipThis is when the client last reviewed or interacted with the applicants for this job.4 hours agoInterviewing:0Invites sent:0Unanswered invites:0Upgrade your membership to see the bid rangeClose the tooltipUpgrade to a Plus plan for more Connects and other perks.High $ Avg $ Low $ Upgrade MembershipYou’ll need Connects to bid. They’re like credits that show clients you’re serious. Learn moreBuy Connects to apply Close the tooltipTo submit a proposal, update your profile rate to $3.00/hour or moreSave jobFlag as inappropriateRequired Connects to submit a proposal: 21This is the number of Connects required to submit a proposal for this job. Learn MoreAvailable Connects: 0About the clientClose the tooltipThis client has a verified payment method with Upwork. Learn how this affects your payment protection.Payment method verifiedRating is 4.7 out of 5.4.74.68 of 43 reviewsUnited StatesHuntington Beach8:48 AM 99 jobs posted52% hire rate, 4 open jobs$6.1K total spent70 hires, 16 active$15.32 /hr avg hourly rate paid67 hoursMember since Nov 2, 2016Job linkCopy linkClient\'s recent history (50)Jobs in progressE-commerce Order Processor / Personal Assistant - Full TimeNo feedback givenTo freelancer: Fatima L.No feedback givenOct 2024 - Oct 2025Fixed-price $15.00Seeking Skilled Graphics Video Editor for Engaging ProjectsRating is 5.0 out of 5.5.05.00 starsall good!moreTo freelancer: Vadim L.Rating is 5.0 out of 5.5.05 starsGood WorkmoreJul 2025 - Jul 2025Fixed-price $180.00E-commerce Order ProcessorRating is 5.0 out of 5.5.05.00 starsmoreTo freelancer: Usman S.Rating is 5.0 out of 5.5.05 starsmoreMay 2024 - Jun 2025Fixed-price $393.00Virtual Assistant Full Time — Ecommerce order processingRating is 2.6 out of 5.2.62.55 starsmoreTo freelancer: Michellyn Jean C.Rating is 3.0 out of 5.3.03 starsmoreFeb 2025 - Jun 2025Fixed-price $247.00Virtual Assistant Full Time — Ecommerce order processingRating is 1.6 out of 5.1.61.55 starsmoreTo freelancer: Karenlou T.No feedback givenJan 2025 - May 2025Fixed-price $142.80View more (31)Other open jobs by this Client (3)DevOps/SRE Specialist for Scalable QR PlatformHourlyDatabase-Focused Backend Engineer for QR Code PlatformHourlyEcommerce Order Processing SpecialistHourly', 'Mobile App DevelopmentApache Cordova, Ionic FrameworkAndroid App Development', 'Close the tooltipTo submit a proposal, update your profile rate to $3.00/hour or more', 'Dear Hiring Manager,\n\nI am writing to express my strong interest in the Mobile/Full-Stack Developer for React and Flutter App position. With 5+, I am confident in my ability to deliver exceptional results for your project.\n\nI have carefully reviewed your job description: As part of our continued efforts to remain compliant with tax laws globally, please enter your Tax Identification Number here.Close the alertMobile/Full-Stack Developer for React and Flutter AppPosted 5 hours agoWorldwideSpecialized profiles can help you better highlight your expertise when submitting proposals to jobs like these. Create a specialized profile.SummaryJob Summary: You will be joining a developing team. As the Mobile/Full-Stack Developer, you will maintain and enhance the React and Flutter-based app for iOS/Android, focusing on frontend features and backend integrations to support weekly updates and 1M users. Key Responsibilities: - Design and develop cross-platform mobile applications for iOS and Android using React or Flutter - Implement QR code scanning functionality with camera integration - Integrate push notifications using OneSignal - Build intuitive user interfaces for scanning, user accounts, verification displays, and related flows - Manage app publishing and updates on Apple App Store and Google Play Store - Ensure app performance, quality, and responsiveness, including optimization for cross-platform compatibility - Implement offline-first architecture for key features - Collaborate with backend engineer on API integration for seamless code validations and system flows - Write clean, maintainable, and well-documented code - Conduct testing and debugging for optimal app performance, including automation - Handle app store compliance, reviews, version management, and deployments - Monitor analytics (e.g., Firebase) and implement weekly features or bug fixesDeliverablesDesign and develop cross-platform mobile applicationsImplement QR code scanning functionalityIntegrate push notifications using OneSignalBuild intuitive user interfacesManage app publishing and updatesEnsure app performance and responsivenessImplement offline-first architectureCollaborate on API integrationWrite clean and maintainable codeConduct testing and debuggingHandle app store compliance and deploymentsMonitor analytics and implement weekly featuresMore than 30 hrs/weekHourlyMore than 6 months6+ monthsDurationIntermediateI am looking for a mix of experience and valueExperience LevelAttachmentMobileFull-Stack Developer.pdf (313 KB) Project Type:Complex projectYou will be asked to answer the following questions when submitting a proposal:Portfolio of published React Native apps (links required)Describe your recent experience with similar projectsPlease list any certifications related to this projectInclude a link to your GitHub profile and/or websiteWhat frameworks have you worked with?Skills and ExpertiseMandatory skillsMobile App DevelopmentApache CordovaNice-to-have skillsIonic FrameworkAndroid App DevelopmentToolsReactFlutterOneSignalFirebaseApple App StoreGoogle Play StorePreferred qualificationsActivity on this jobProposals:Close the tooltipThis range includes relevant proposals, but does not include proposals that are withdrawn, declined, or archived. Please note that all proposals are accessible to clients on their applicants page.20 to 50Last viewed by client:Close the tooltipThis is when the client last reviewed or interacted with the applicants for this job.4 hours agoInterviewing:0Invites sent:0Unanswered invites:0Upgrade your membership to see the bid rangeClose the tooltipUpgrade to a Plus plan for more Connects and other perks.High $ Avg $ Low $ Upgrade MembershipYou’ll need Connects to bid. They’re like credits that show clients you’re serious. Learn moreBuy Connects to apply Close the tooltipTo submit a proposal, update your profile rate to $3.00/hour or moreSave jobFlag as inappropriateRequired Connects to submit a proposal: 21This is the number of Connects required to submit a proposal for this job. Learn MoreAvailable Connects: 0About the clientClose the tooltipThis client has a verified payment method with Upwork. Learn how this affects your payment protection.Payment method verifiedRating is 4.7 out of 5.4.74.68 of 43 reviewsUnited StatesHuntington Beach8:48 AM 99 jobs posted52% hire rate, 4 open jobs$6.1K total spent70 hires, 16 active$15.32 /hr avg hourly rate paid67 hoursMember since Nov 2, 2016Job linkCopy linkClient\'s recent history (50)Jobs in progressE-commerce Order Processor / Personal Assistant - Full TimeNo feedback givenTo freelancer: Fatima L.No feedback givenOct 2024 - Oct 2025Fixed-price $15.00Seeking Skilled Graphics Video Editor for Engaging ProjectsRating is 5.0 out of 5.5.05.00 starsall good!moreTo freelancer: Vadim L.Rating is 5.0 out of 5.5.05 starsGood WorkmoreJul 2025 - Jul 2025Fixed-price $180.00E-commerce Order ProcessorRating is 5.0 out of 5.5.05.00 starsmoreTo freelancer: Usman S.Rating is 5.0 out of 5.5.05 starsmoreMay 2024 - Jun 2025Fixed-price $393.00Virtual Assistant Full Time — Ecommerce order processingRating is 2.6 out of 5.2.62.55 starsmoreTo freelancer: Michellyn Jean C.Rating is 3.0 out of 5.3.03 starsmoreFeb 2025 - Jun 2025Fixed-price $247.00Virtual Assistant Full Time — Ecommerce order processingRating is 1.6 out of 5.1.61.55 starsmoreTo freelancer: Karenlou T.No feedback givenJan 2025 - May 2025Fixed-price $142.80View more (31)Other open jobs by this Client (3)DevOps/SRE Specialist for Scalable QR PlatformHourlyDatabase-Focused Backend Engineer for QR Code PlatformHourlyEcommerce Order Processing SpecialistHourly\n\nMy expertise directly aligns with your requirements, particularly in Mobile App DevelopmentApache Cordova, Ionic FrameworkAndroid App Development. I understand that your budget is Close the tooltipTo submit a proposal, update your profile rate to $3.00/hour or more, and I am prepared to work within your parameters while ensuring high-quality deliverables.\n\nMy approach includes:\n- Thorough project analysis and planning\n- Regular communication and progress updates\n- Clean, maintainable code following best practices\n- Testing and quality assurance\n- On-time delivery\n\nI would welcome the opportunity to discuss how my skills and experience can contribute to the success of your project. I am available for a call at your convenience.\n\nLooking forward to working with you.\n\nBest regards', 'professional', 'medium', '2025-10-17 06:18:34', '2025-10-17 06:18:34'),
(4, 1, 'Mobile/Full-Stack Developer for React and Flutter App', 'SummaryJob Summary: You will be joining a developing team. As the Mobile/Full-Stack Developer, you will maintain and enhance the React and Flutter-based app for iOS/Android, focusing on frontend features and backend integrations to support weekly updates and 1M users. Key Responsibilities: - Design and develop cross-platform mobile applications for iOS and Android using React or Flutter - Implement QR code scanning functionality with camera integration - Integrate push notifications using OneSignal - Build intuitive user interfaces for scanning, user accounts, verification displays, and related flows - Manage app publishing and updates on Apple App Store and Google Play Store - Ensure app performance, quality, and responsiveness, including optimization for cross-platform compatibility - Implement offline-first architecture for key features - Collaborate with backend engineer on API integration for seamless code validations and system flows - Write clean, maintainable, and well-documented code - Conduct testing and debugging for optimal app performance, including automation - Handle app store compliance, - Monitor analytics (e. , Firebase) and implement weekly features or bug fixesDeliverablesDesign and develop cross-platform mobile applicationsImplement QR code scanning functionalityIntegrate push notifications using OneSignalBuild intuitive user interfacesManage app publishing and updatesEnsure app performance and responsivenessImplement offline-first architectureCollaborate on API integrationWrite clean and maintainable codeConduct testing and debuggingHandle app store compliance and deploymentsMonitor analytics and implement weekly features', 'Mobile App DevelopmentApache Cordova, Ionic FrameworkAndroid App Development', 'Close the tooltipTo submit a proposal, update your profile rate to $3.00/hour or more', 'Dear Hiring Manager,\n\nI am writing to express my strong interest in the Mobile/Full-Stack Developer for React and Flutter App position. With 5+, I am confident in my ability to deliver exceptional results for your project.\n\nI have carefully reviewed your job description: SummaryJob Summary: You will be joining a developing team. As the Mobile/Full-Stack Developer, you will maintain and enhance the React and Flutter-based app for iOS/Android, focusing on frontend features and backend integrations to support weekly updates and 1M users. Key Responsibilities: - Design and develop cross-platform mobile applications for iOS and Android using React or Flutter - Implement QR code scanning functionality with camera integration - Integrate push notifications using OneSignal - Build intuitive user interfaces for scanning, user accounts, verification displays, and related flows - Manage app publishing and updates on Apple App Store and Google Play Store - Ensure app performance, quality, and responsiveness, including optimization for cross-platform compatibility - Implement offline-first architecture for key features - Collaborate with backend engineer on API integration for seamless code validations and system flows - Write clean, maintainable, and well-documented code - Conduct testing and debugging for optimal app performance, including automation - Handle app store compliance, - Monitor analytics (e. , Firebase) and implement weekly features or bug fixesDeliverablesDesign and develop cross-platform mobile applicationsImplement QR code scanning functionalityIntegrate push notifications using OneSignalBuild intuitive user interfacesManage app publishing and updatesEnsure app performance and responsivenessImplement offline-first architectureCollaborate on API integrationWrite clean and maintainable codeConduct testing and debuggingHandle app store compliance and deploymentsMonitor analytics and implement weekly features\n\nMy expertise directly aligns with your requirements, particularly in Mobile App DevelopmentApache Cordova, Ionic FrameworkAndroid App Development. I understand that your budget is Close the tooltipTo submit a proposal, update your profile rate to $3.00/hour or more, and I am prepared to work within your parameters while ensuring high-quality deliverables.\n\nMy approach includes:\n- Thorough project analysis and planning\n- Regular communication and progress updates\n- Clean, maintainable code following best practices\n- Testing and quality assurance\n- On-time delivery\n\nI would welcome the opportunity to discuss how my skills and experience can contribute to the success of your project. I am available for a call at your convenience.\n\nLooking forward to working with you.\n\nBest regards', 'professional', 'medium', '2025-10-17 06:29:14', '2025-10-17 06:29:14'),
(5, 1, 'Mobile/Full-Stack Developer for React and Flutter App', 'SummaryJob Summary: You will be joining a developing team. As the Mobile/Full-Stack Developer, you will maintain and enhance the React and Flutter-based app for iOS/Android, focusing on frontend features and backend integrations to support weekly updates and 1M users. Key Responsibilities: - Design and develop cross-platform mobile applications for iOS and Android using React or Flutter - Implement QR code scanning functionality with camera integration - Integrate push notifications using OneSignal - Build intuitive user interfaces for scanning, user accounts, verification displays, and related flows - Manage app publishing and updates on Apple App Store and Google Play Store - Ensure app performance, quality, and responsiveness, including optimization for cross-platform compatibility - Implement offline-first architecture for key features - Collaborate with backend engineer on API integration for seamless code validations and system flows - Write clean, maintainable, and well-documented code - Conduct testing and debugging for optimal app performance, including automation - Handle app store compliance, - Monitor analytics (e. , Firebase) and implement weekly features or bug fixesDeliverablesDesign and develop cross-platform mobile applicationsImplement QR code scanning functionalityIntegrate push notifications using OneSignalBuild intuitive user interfacesManage app publishing and updatesEnsure app performance and responsivenessImplement offline-first architectureCollaborate on API integrationWrite clean and maintainable codeConduct testing and debuggingHandle app store compliance and deploymentsMonitor analytics and implement weekly features', 'Mobile App DevelopmentApache Cordova, Ionic FrameworkAndroid App Development', 'Close the tooltipTo submit a proposal, update your profile rate to $3.00/hour or more', 'Dear Hiring Manager,\n\nI am writing to express my strong interest in the Mobile/Full-Stack Developer for React and Flutter App position. With 5+, I am confident in my ability to deliver exceptional results for your project.\n\nI have carefully reviewed your job description: SummaryJob Summary: You will be joining a developing team. As the Mobile/Full-Stack Developer, you will maintain and enhance the React and Flutter-based app for iOS/Android, focusing on frontend features and backend integrations to support weekly updates and 1M users. Key Responsibilities: - Design and develop cross-platform mobile applications for iOS and Android using React or Flutter - Implement QR code scanning functionality with camera integration - Integrate push notifications using OneSignal - Build intuitive user interfaces for scanning, user accounts, verification displays, and related flows - Manage app publishing and updates on Apple App Store and Google Play Store - Ensure app performance, quality, and responsiveness, including optimization for cross-platform compatibility - Implement offline-first architecture for key features - Collaborate with backend engineer on API integration for seamless code validations and system flows - Write clean, maintainable, and well-documented code - Conduct testing and debugging for optimal app performance, including automation - Handle app store compliance, - Monitor analytics (e. , Firebase) and implement weekly features or bug fixesDeliverablesDesign and develop cross-platform mobile applicationsImplement QR code scanning functionalityIntegrate push notifications using OneSignalBuild intuitive user interfacesManage app publishing and updatesEnsure app performance and responsivenessImplement offline-first architectureCollaborate on API integrationWrite clean and maintainable codeConduct testing and debuggingHandle app store compliance and deploymentsMonitor analytics and implement weekly features\n\nMy expertise directly aligns with your requirements, particularly in Mobile App DevelopmentApache Cordova, Ionic FrameworkAndroid App Development. I understand that your budget is Close the tooltipTo submit a proposal, update your profile rate to $3.00/hour or more, and I am prepared to work within your parameters while ensuring high-quality deliverables.\n\nMy approach includes:\n- Thorough project analysis and planning\n- Regular communication and progress updates\n- Clean, maintainable code following best practices\n- Testing and quality assurance\n- On-time delivery\n\nI would welcome the opportunity to discuss how my skills and experience can contribute to the success of your project. I am available for a call at your convenience.\n\nLooking forward to working with you.\n\nBest regards', 'friendly', 'short', '2025-10-17 06:31:11', '2025-10-17 06:31:11'),
(6, 2, 'Test Web Developer Position', 'We need a skilled web developer to build a modern website using React and Node.js. The project involves creating responsive designs and API integrations.', 'React, Node.js, JavaScript, API Development', '$2000-$5000', 'Hi there!\n\nThanks for posting this Test Web Developer Position opportunity – it sounds like a great project!\n\nI\'ve been working in tech for quite some time now (5+ years in web development), and I\'d love to help bring your vision to life. I read through your description and I\'m excited about what you\'re building.\n\nHere\'s what caught my attention: We need a skilled web developer to build a modern website using React and Node.js. The project involves creating responsive designs and API integrations.\n\nI have solid experience with React, Node.js, JavaScript, API Development, which seems like a perfect match for what you need. I noticed your budget is $2000-$5000, and I\'m flexible and ready to discuss how we can make this work.\n\nWhat I bring to the table:\n- A collaborative, easy-going work style\n- Clear communication throughout the project\n- Quality work that I\'m proud to put my name on\n- Flexibility to adapt to your needs\n\nI\'d love to chat more about your project! Feel free to reach out anytime – I\'m here to help.\n\nCheers!', 'friendly', 'medium', '2025-10-17 06:53:54', '2025-10-17 06:53:54'),
(7, 1, 'Shopify App Developer Needed', 'SummaryWe are seeking an experienced Shopify App Developer to create a custom app that enhances our e-commerce platform. The ideal candidate should have a strong understanding of Shopify\'s API, Liquid templating, and app deployment processes. You will be responsible for developing and integrating features that improve user experience and streamline operations. If you are passionate about building innovative solutions and have a proven track record in Shopify development, we would love to hear from you', NULL, 'Close the tooltipTo submit a proposal, update your profile rate to $3.00/hour or more', 'Dear Hiring Manager,\n\nI am writing to express my strong interest in the Shopify App Developer Needed position. With 5+, I am confident in my ability to deliver exceptional results for your project.\n\nI have carefully reviewed your job description: SummaryWe are seeking an experienced Shopify App Developer to create a custom app that enhances our e-commerce platform. The ideal candidate should have a strong understanding of Shopify\'s API, Liquid templating, and app deployment processes. You will be responsible for developing and integrating features that improve user experience and streamline operations. If you are passionate about building innovative solutions and have a proven track record in Shopify development, we would love to hear from you\n\nMy expertise directly aligns with your requirements, particularly in . I understand that your budget is Close the tooltipTo submit a proposal, update your profile rate to $3.00/hour or more, and I am prepared to work within your parameters while ensuring high-quality deliverables.\n\nMy approach includes:\n- Thorough project analysis and planning\n- Regular communication and progress updates\n- Clean, maintainable code following best practices\n- Testing and quality assurance\n- On-time delivery\n\nI would welcome the opportunity to discuss how my skills and experience can contribute to the success of your project. I am available for a call at your convenience.\n\nLooking forward to working with you.\n\nBest regards', 'friendly', 'short', '2025-10-17 07:18:07', '2025-10-17 07:18:07'),
(8, 1, 'ChatGPT Integration Specialist Needed', 'I understand that priorities may have shifted, which has left more …moreTo freelancer: Emmanuela May C. Rating is 5. 05 starsThank you for your continued support and dedication. I appreciate the quality of your work and your professionalism. Your contributions have been valu…moreFeb 2025 - Oct 202554 hrs @ $8. 00/hr Billed: $474. 43Chief of Staff Needed for Operational ProjectsRating is 5. 00 starsSheryle has been nothing but great, an absolute delight to work with. Her communication is clear, and it’s truly a pleasure collaborating with her. moreTo freelancer: Christel Marie P. 05 starsChristel is excellent and I would recommend her to anyone. moreJan 2025 - Sep 2025Fixed-price $250. 00TikTok Shop Manager & Shopify Integration SpecialistRating is 5. 00 starsmoreTo freelancer: Nicole T. No feedback givenDec 2024 - Jun 202541 hrs @ $18. 00/hr Billed: $791. 77Bookkeeper with experience in Excel, Xero, and Shopify InventoryRating is 5. 00 starsmoreTo freelancer: Mia T. 05 starsNo commentmoreApr 2025 - May 2025Fixed-price $70. 00Shopify Operations Director NeededRating is 5. 00 starsmoreTo freelancer: Rebecca C. 05 starsRachel is highly enthusiastic and driven to get things done. She possesses strong knowledge across various areas of marketing and Shopify. moreMar 2025 - Apr 2025Fixed-price $46. 00View more (21)Other open jobs by this Client (3)TikTok Marketing Specialist for Beauty E-commerce SalesHourlyResults-Driven Meta Ads Specialist for Beauty BrandHourlyExperienced Graphic Designer Wanted – Urgently', 'WordPressWeb DevelopmentPHPJavaScriptPython', 'Close the tooltipTo submit a proposal, update your profile rate to $3.00/hour or more', 'Dear Hiring Manager,\n\nI am writing to express my strong interest in the ChatGPT Integration Specialist Needed position. With 5+, I am confident in my ability to deliver exceptional results for your project.\n\nI have carefully reviewed your job description: I understand that priorities may have shifted, which has left more …moreTo freelancer: Emmanuela May C. Rating is 5. 05 starsThank you for your continued support and dedication. I appreciate the quality of your work and your professionalism. Your contributions have been valu…moreFeb 2025 - Oct 202554 hrs @ $8. 00/hr Billed: $474. 43Chief of Staff Needed for Operational ProjectsRating is 5. 00 starsSheryle has been nothing but great, an absolute delight to work with. Her communication is clear, and it’s truly a pleasure collaborating with her. moreTo freelancer: Christel Marie P. 05 starsChristel is excellent and I would recommend her to anyone. moreJan 2025 - Sep 2025Fixed-price $250. 00TikTok Shop Manager & Shopify Integration SpecialistRating is 5. 00 starsmoreTo freelancer: Nicole T. No feedback givenDec 2024 - Jun 202541 hrs @ $18. 00/hr Billed: $791. 77Bookkeeper with experience in Excel, Xero, and Shopify InventoryRating is 5. 00 starsmoreTo freelancer: Mia T. 05 starsNo commentmoreApr 2025 - May 2025Fixed-price $70. 00Shopify Operations Director NeededRating is 5. 00 starsmoreTo freelancer: Rebecca C. 05 starsRachel is highly enthusiastic and driven to get things done. She possesses strong knowledge across various areas of marketing and Shopify. moreMar 2025 - Apr 2025Fixed-price $46. 00View more (21)Other open jobs by this Client (3)TikTok Marketing Specialist for Beauty E-commerce SalesHourlyResults-Driven Meta Ads Specialist for Beauty BrandHourlyExperienced Graphic Designer Wanted – Urgently\n\nMy expertise directly aligns with your requirements, particularly in WordPressWeb DevelopmentPHPJavaScriptPython. I understand that your budget is Close the tooltipTo submit a proposal, update your profile rate to $3.00/hour or more, and I am prepared to work within your parameters while ensuring high-quality deliverables.\n\nMy approach includes:\n- Thorough project analysis and planning\n- Regular communication and progress updates\n- Clean, maintainable code following best practices\n- Testing and quality assurance\n- On-time delivery\n\nI would welcome the opportunity to discuss how my skills and experience can contribute to the success of your project. I am available for a call at your convenience.\n\nLooking forward to working with you.\n\nBest regards', 'friendly', 'short', '2025-10-17 07:26:44', '2025-10-17 07:26:44'),
(9, 1, 'Looking for a Customizable Grocery Delivery App (Node.js, Python, Flutter)', 'Please share demo links, GitHub repositories, or documentation if you already have a similar solution. More than 30 hrs/weekHourly1 to 3 months1-3 monthsDurationIntermediateI am looking for a mix of experience and valueExperience Level$15. 00HourlyContract-to-hire opportunityThis lets talent know that this job could become full time. Project Type:Ongoing projectSkills and ExpertiseMandatory skillsNode. jsPythonFlutterAPIReact NativeAndroidAPI IntegrationActivity on this jobProposals:', NULL, 'Close the tooltipTo submit a proposal, update your profile rate to $3.00/hour or more', 'Dear Hiring Manager,\n\nI am writing to express my strong interest in the Looking for a Customizable Grocery Delivery App (Node.js, Python, Flutter) position. With 5+, I am confident in my ability to deliver exceptional results for your project.\n\nI have carefully reviewed your job description: Please share demo links, GitHub repositories, or documentation if you already have a similar solution. More than 30 hrs/weekHourly1 to 3 months1-3 monthsDurationIntermediateI am looking for a mix of experience and valueExperience Level$15. 00HourlyContract-to-hire opportunityThis lets talent know that this job could become full time. Project Type:Ongoing projectSkills and ExpertiseMandatory skillsNode. jsPythonFlutterAPIReact NativeAndroidAPI IntegrationActivity on this jobProposals:\n\nMy expertise directly aligns with your requirements, particularly in . I understand that your budget is Close the tooltipTo submit a proposal, update your profile rate to $3.00/hour or more, and I am prepared to work within your parameters while ensuring high-quality deliverables.\n\nMy approach includes:\n- Thorough project analysis and planning\n- Regular communication and progress updates\n- Clean, maintainable code following best practices\n- Testing and quality assurance\n- On-time delivery\n\nI would welcome the opportunity to discuss how my skills and experience can contribute to the success of your project. I am available for a call at your convenience.\n\nLooking forward to working with you.\n\nBest regards', 'friendly', 'short', '2025-10-17 07:34:24', '2025-10-17 07:34:24'),
(10, 1, 'One-Page - AI Product Customizer with Live 2-D Generator + 3-D Curved Preview', 'SummaryI’m looking for a skilled developer to build and deploy a one-page interactive product customizer. Customers will design their own artwork through an AI image-generation API or by uploading an image, then instantly see it applied to a curved 3-D product preview and complete checkout. The flow is simple but must feel seamless: Generate or upload artwork on a 2-D design panel (flat printable surface). See it update live on a curved 3-D model above, wrapping smoothly as a seamless pattern around the object with no visible stretching or distortion. Choose hardware/accent colors, select size or configuration, and finish checkout (Stripe or similar). The system must: Use the AI API to generate seamless, horizontally tileable designs (no cropping or distortion). Implement parameter “bumpers” or constraints so outputs stay within the printable region. Include style presets—user-selectable options that automatically modify the AI prompt and parameters. Keep both 2-D and 3-D p Deliverables: A production-ready, deployed web page that manages the AI API integration, tiling enforcement, style presets, 2-D generator, 3-D curved mapping, color logic, and checkout. It should be fully deployed on my domain (not hosted elsewhere) and easy to embed in a Shopify or custom storefront. This is a contained project—one polished page, not a large app. The emphasis is on real-time accuracy, smooth updates, and clean execution. Looking for a builder who ships working results and writes maintainable, modern code. DeliverablesFully functional one-page product customizerAI-driven design generator integrated (prompt → seamless pattern → live preview)Live product preview (2D to 3D) with instant updatesColor and configuration options with real-time changesCheckout system (Stripe test mode or equivalent)Full deployment on my site or domain, ready for customersSource code + documentation for future updates', 'Three.js3D Modeling, ReactNode.jsShopify APIThree.jsTensorFlow', 'Close the tooltipTo submit a proposal, update your profile rate to $3.00/hour or more', 'Dear Hiring Manager,\n\nI am writing to express my strong interest in the One-Page - AI Product Customizer with Live 2-D Generator + 3-D Curved Preview position. With 5+, I am confident in my ability to deliver exceptional results for your project.\n\nI have carefully reviewed your job description: SummaryI’m looking for a skilled developer to build and deploy a one-page interactive product customizer. Customers will design their own artwork through an AI image-generation API or by uploading an image, then instantly see it applied to a curved 3-D product preview and complete checkout. The flow is simple but must feel seamless: Generate or upload artwork on a 2-D design panel (flat printable surface). See it update live on a curved 3-D model above, wrapping smoothly as a seamless pattern around the object with no visible stretching or distortion. Choose hardware/accent colors, select size or configuration, and finish checkout (Stripe or similar). The system must: Use the AI API to generate seamless, horizontally tileable designs (no cropping or distortion). Implement parameter “bumpers” or constraints so outputs stay within the printable region. Include style presets—user-selectable options that automatically modify the AI prompt and parameters. Keep both 2-D and 3-D p Deliverables: A production-ready, deployed web page that manages the AI API integration, tiling enforcement, style presets, 2-D generator, 3-D curved mapping, color logic, and checkout. It should be fully deployed on my domain (not hosted elsewhere) and easy to embed in a Shopify or custom storefront. This is a contained project—one polished page, not a large app. The emphasis is on real-time accuracy, smooth updates, and clean execution. Looking for a builder who ships working results and writes maintainable, modern code. DeliverablesFully functional one-page product customizerAI-driven design generator integrated (prompt → seamless pattern → live preview)Live product preview (2D to 3D) with instant updatesColor and configuration options with real-time changesCheckout system (Stripe test mode or equivalent)Full deployment on my site or domain, ready for customersSource code + documentation for future updates\n\nMy expertise directly aligns with your requirements, particularly in Three.js3D Modeling, ReactNode.jsShopify APIThree.jsTensorFlow. I understand that your budget is Close the tooltipTo submit a proposal, update your profile rate to $3.00/hour or more, and I am prepared to work within your parameters while ensuring high-quality deliverables.\n\nMy approach includes:\n- Thorough project analysis and planning\n- Regular communication and progress updates\n- Clean, maintainable code following best practices\n- Testing and quality assurance\n- On-time delivery\n\nI would welcome the opportunity to discuss how my skills and experience can contribute to the success of your project. I am available for a call at your convenience.\n\nLooking forward to working with you.\n\nBest regards', 'friendly', 'short', '2025-10-17 07:37:14', '2025-10-17 07:37:14'),
(11, 1, 'One-Page - AI Product Customizer with Live 2-D Generator + 3-D Curved Preview', 'SummaryI’m looking for a skilled developer to build and deploy a one-page interactive product customizer. Customers will design their own artwork through an AI image-generation API or by uploading an image, then instantly see it applied to a curved 3-D product preview and complete checkout. The flow is simple but must feel seamless: Generate or upload artwork on a 2-D design panel (flat printable surface). See it update live on a curved 3-D model above, wrapping smoothly as a seamless pattern around the object with no visible stretching or distortion. Choose hardware/accent colors, select size or configuration, and finish checkout (Stripe or similar). The system must: Use the AI API to generate seamless, horizontally tileable designs (no cropping or distortion). Implement parameter “bumpers” or constraints so outputs stay within the printable region. Include style presets—user-selectable options that automatically modify the AI prompt and parameters. Keep both 2-D and 3-D p Deliverables: A production-ready, deployed web page that manages the AI API integration, tiling enforcement, style presets, 2-D generator, 3-D curved mapping, color logic, and checkout. It should be fully deployed on my domain (not hosted elsewhere) and easy to embed in a Shopify or custom storefront. This is a contained project—one polished page, not a large app. The emphasis is on real-time accuracy, smooth updates, and clean execution. Looking for a builder who ships working results and writes maintainable, modern code. DeliverablesFully functional one-page product customizerAI-driven design generator integrated (prompt → seamless pattern → live preview)Live product preview (2D to 3D) with instant updatesColor and configuration options with real-time changesCheckout system (Stripe test mode or equivalent)Full deployment on my site or domain, ready for customersSource code + documentation for future updates', 'Three.js3D Modeling, ReactNode.jsShopify APIThree.jsTensorFlow', 'Close the tooltipTo submit a proposal, update your profile rate to $3.00/hour or more', 'Dear Hiring Manager,\n\nI am writing to express my strong interest in the One-Page - AI Product Customizer with Live 2-D Generator + 3-D Curved Preview position. With 5+, I am confident in my ability to deliver exceptional results for your project.\n\nI have carefully reviewed your job description: SummaryI’m looking for a skilled developer to build and deploy a one-page interactive product customizer. Customers will design their own artwork through an AI image-generation API or by uploading an image, then instantly see it applied to a curved 3-D product preview and complete checkout. The flow is simple but must feel seamless: Generate or upload artwork on a 2-D design panel (flat printable surface). See it update live on a curved 3-D model above, wrapping smoothly as a seamless pattern around the object with no visible stretching or distortion. Choose hardware/accent colors, select size or configuration, and finish checkout (Stripe or similar). The system must: Use the AI API to generate seamless, horizontally tileable designs (no cropping or distortion). Implement parameter “bumpers” or constraints so outputs stay within the printable region. Include style presets—user-selectable options that automatically modify the AI prompt and parameters. Keep both 2-D and 3-D p Deliverables: A production-ready, deployed web page that manages the AI API integration, tiling enforcement, style presets, 2-D generator, 3-D curved mapping, color logic, and checkout. It should be fully deployed on my domain (not hosted elsewhere) and easy to embed in a Shopify or custom storefront. This is a contained project—one polished page, not a large app. The emphasis is on real-time accuracy, smooth updates, and clean execution. Looking for a builder who ships working results and writes maintainable, modern code. DeliverablesFully functional one-page product customizerAI-driven design generator integrated (prompt → seamless pattern → live preview)Live product preview (2D to 3D) with instant updatesColor and configuration options with real-time changesCheckout system (Stripe test mode or equivalent)Full deployment on my site or domain, ready for customersSource code + documentation for future updates\n\nMy expertise directly aligns with your requirements, particularly in Three.js3D Modeling, ReactNode.jsShopify APIThree.jsTensorFlow. I understand that your budget is Close the tooltipTo submit a proposal, update your profile rate to $3.00/hour or more, and I am prepared to work within your parameters while ensuring high-quality deliverables.\n\nMy approach includes:\n- Thorough project analysis and planning\n- Regular communication and progress updates\n- Clean, maintainable code following best practices\n- Testing and quality assurance\n- On-time delivery\n\nI would welcome the opportunity to discuss how my skills and experience can contribute to the success of your project. I am available for a call at your convenience.\n\nLooking forward to working with you.\n\nBest regards', 'friendly', 'short', '2025-10-17 07:40:46', '2025-10-17 07:40:46');
INSERT INTO `proposals` (`id`, `template_id`, `job_title`, `job_description`, `job_skills`, `job_budget`, `generated_proposal`, `tone`, `length`, `created_at`, `updated_at`) VALUES
(12, 1, 'One-Page - AI Product Customizer with Live 2-D Generator + 3-D Curved Preview', 'SummaryI’m looking for a skilled developer to build and deploy a one-page interactive product customizer. Customers will design their own artwork through an AI image-generation API or by uploading an image, then instantly see it applied to a curved 3-D product preview and complete checkout. The flow is simple but must feel seamless: Generate or upload artwork on a 2-D design panel (flat printable surface). See it update live on a curved 3-D model above, wrapping smoothly as a seamless pattern around the object with no visible stretching or distortion. Choose hardware/accent colors, select size or configuration, and finish checkout (Stripe or similar). The system must: Use the AI API to generate seamless, horizontally tileable designs (no cropping or distortion). Implement parameter “bumpers” or constraints so outputs stay within the printable region. Include style presets—user-selectable options that automatically modify the AI prompt and parameters. Keep both 2-D and 3-D p Deliverables: A production-ready, deployed web page that manages the AI API integration, tiling enforcement, style presets, 2-D generator, 3-D curved mapping, color logic, and checkout. It should be fully deployed on my domain (not hosted elsewhere) and easy to embed in a Shopify or custom storefront. This is a contained project—one polished page, not a large app. The emphasis is on real-time accuracy, smooth updates, and clean execution. Looking for a builder who ships working results and writes maintainable, modern code. DeliverablesFully functional one-page product customizerAI-driven design generator integrated (prompt → seamless pattern → live preview)Live product preview (2D to 3D) with instant updatesColor and configuration options with real-time changesCheckout system (Stripe test mode or equivalent)Full deployment on my site or domain, ready for customersSource code + documentation for future updates', 'Three.js3D Modeling, ReactNode.jsShopify APIThree.jsTensorFlow', 'Close the tooltipTo submit a proposal, update your profile rate to $3.00/hour or more', 'Dear Hiring Manager,\n\nI am writing to express my strong interest in the One-Page - AI Product Customizer with Live 2-D Generator + 3-D Curved Preview position. With 5+, I am confident in my ability to deliver exceptional results for your project.\n\nI have carefully reviewed your job description: SummaryI’m looking for a skilled developer to build and deploy a one-page interactive product customizer. Customers will design their own artwork through an AI image-generation API or by uploading an image, then instantly see it applied to a curved 3-D product preview and complete checkout. The flow is simple but must feel seamless: Generate or upload artwork on a 2-D design panel (flat printable surface). See it update live on a curved 3-D model above, wrapping smoothly as a seamless pattern around the object with no visible stretching or distortion. Choose hardware/accent colors, select size or configuration, and finish checkout (Stripe or similar). The system must: Use the AI API to generate seamless, horizontally tileable designs (no cropping or distortion). Implement parameter “bumpers” or constraints so outputs stay within the printable region. Include style presets—user-selectable options that automatically modify the AI prompt and parameters. Keep both 2-D and 3-D p Deliverables: A production-ready, deployed web page that manages the AI API integration, tiling enforcement, style presets, 2-D generator, 3-D curved mapping, color logic, and checkout. It should be fully deployed on my domain (not hosted elsewhere) and easy to embed in a Shopify or custom storefront. This is a contained project—one polished page, not a large app. The emphasis is on real-time accuracy, smooth updates, and clean execution. Looking for a builder who ships working results and writes maintainable, modern code. DeliverablesFully functional one-page product customizerAI-driven design generator integrated (prompt → seamless pattern → live preview)Live product preview (2D to 3D) with instant updatesColor and configuration options with real-time changesCheckout system (Stripe test mode or equivalent)Full deployment on my site or domain, ready for customersSource code + documentation for future updates\n\nMy expertise directly aligns with your requirements, particularly in Three.js3D Modeling, ReactNode.jsShopify APIThree.jsTensorFlow. I understand that your budget is Close the tooltipTo submit a proposal, update your profile rate to $3.00/hour or more, and I am prepared to work within your parameters while ensuring high-quality deliverables.\n\nMy approach includes:\n- Thorough project analysis and planning\n- Regular communication and progress updates\n- Clean, maintainable code following best practices\n- Testing and quality assurance\n- On-time delivery\n\nI would welcome the opportunity to discuss how my skills and experience can contribute to the success of your project. I am available for a call at your convenience.\n\nLooking forward to working with you.\n\nBest regards', 'friendly', 'short', '2025-10-17 07:42:46', '2025-10-17 07:42:46');

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
('G9GFwvn8pxI6CGkICkhMZvD1eGySj2OxsoXDoFW5', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'YTo3OntzOjY6Il90b2tlbiI7czo0MDoiZDlqcEVZSU1FMFdsbkFzaDN6N1RySjd3N0xTZklrZGJ6ZE9aVzBUMSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9wcm9wb3NhbHMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjM6InVybCI7YTowOnt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjE3OiJwYXNzd29yZF9oYXNoX3dlYiI7czo2MDoiJDJ5JDEyJEJPSXUwVERmYXdkUm01L2I5SE5vVE83SjlFN245VERoY0pjeDRvQlZwQTg2S1BteXJPMU9TIjtzOjY6InRhYmxlcyI7YToxOntzOjQwOiI4Zjg5YzdkYjcyY2RjZjdiMTA4NTNhNDEwMDUwYWFlYl9jb2x1bW5zIjthOjc6e2k6MDthOjc6e3M6NDoidHlwZSI7czo2OiJjb2x1bW4iO3M6NDoibmFtZSI7czoxMzoidGVtcGxhdGUubmFtZSI7czo1OiJsYWJlbCI7czo4OiJUZW1wbGF0ZSI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjE7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6OToiam9iX3RpdGxlIjtzOjU6ImxhYmVsIjtzOjk6IkpvYiB0aXRsZSI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjI7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MTA6ImpvYl9idWRnZXQiO3M6NToibGFiZWwiO3M6MTA6IkpvYiBidWRnZXQiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjoxO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjowO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7Tjt9aTozO2E6Nzp7czo0OiJ0eXBlIjtzOjY6ImNvbHVtbiI7czo0OiJuYW1lIjtzOjQ6InRvbmUiO3M6NToibGFiZWwiO3M6NDoiVG9uZSI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjQ7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6NjoibGVuZ3RoIjtzOjU6ImxhYmVsIjtzOjY6Ikxlbmd0aCI7czo4OiJpc0hpZGRlbiI7YjowO3M6OToiaXNUb2dnbGVkIjtiOjE7czoxMjoiaXNUb2dnbGVhYmxlIjtiOjA7czoyNDoiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjtOO31pOjU7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MTA6ImNyZWF0ZWRfYXQiO3M6NToibGFiZWwiO3M6MTA6IkNyZWF0ZWQgYXQiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjowO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjoxO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7YjoxO31pOjY7YTo3OntzOjQ6InR5cGUiO3M6NjoiY29sdW1uIjtzOjQ6Im5hbWUiO3M6MTA6InVwZGF0ZWRfYXQiO3M6NToibGFiZWwiO3M6MTA6IlVwZGF0ZWQgYXQiO3M6ODoiaXNIaWRkZW4iO2I6MDtzOjk6ImlzVG9nZ2xlZCI7YjowO3M6MTI6ImlzVG9nZ2xlYWJsZSI7YjoxO3M6MjQ6ImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI7YjoxO319fX0=', 1761628848),
('iNVUoHwgzsiTTHRZsNr2cz4XlnGauAwnvKlNqhA4', NULL, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoia2dGcjlLTHdYdFFJUkFSWFI2SjJlbWhJZmJwYm9RUHZSSm01d3I1RyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9sb2dpbiI7fX0=', 1760709288);

-- --------------------------------------------------------

--
-- Table structure for table `templates`
--

CREATE TABLE `templates` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `tone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'professional',
  `length` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'medium',
  `description` text COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `usage_count` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `templates`
--

INSERT INTO `templates` (`id`, `name`, `content`, `tone`, `length`, `description`, `is_active`, `usage_count`, `created_at`, `updated_at`) VALUES
(1, 'Professional Web Development', 'Dear Hiring Manager,\n\nI am writing to express my strong interest in the {{job_title}} position. With {{experience}}, I am confident in my ability to deliver exceptional results for your project.\n\nI have carefully reviewed your job description: {{job_description}}\n\nMy expertise directly aligns with your requirements, particularly in {{skills}}. I understand that your budget is {{budget}}, and I am prepared to work within your parameters while ensuring high-quality deliverables.\n\nMy approach includes:\n- Thorough project analysis and planning\n- Regular communication and progress updates\n- Clean, maintainable code following best practices\n- Testing and quality assurance\n- On-time delivery\n\nI would welcome the opportunity to discuss how my skills and experience can contribute to the success of your project. I am available for a call at your convenience.\n\nLooking forward to working with you.\n\nBest regards', 'professional', 'medium', 'Standard professional template for web development projects', 1, 11, '2025-10-17 03:40:29', '2025-10-17 07:42:46'),
(2, 'Friendly Web Development', 'Hi there!\n\nThanks for posting this {{job_title}} opportunity – it sounds like a great project!\n\nI\'ve been working in tech for quite some time now ({{experience}}), and I\'d love to help bring your vision to life. I read through your description and I\'m excited about what you\'re building.\n\nHere\'s what caught my attention: {{job_description}}\n\nI have solid experience with {{skills}}, which seems like a perfect match for what you need. I noticed your budget is {{budget}}, and I\'m flexible and ready to discuss how we can make this work.\n\nWhat I bring to the table:\n- A collaborative, easy-going work style\n- Clear communication throughout the project\n- Quality work that I\'m proud to put my name on\n- Flexibility to adapt to your needs\n\nI\'d love to chat more about your project! Feel free to reach out anytime – I\'m here to help.\n\nCheers!', 'friendly', 'medium', 'Warm and approachable template for web development', 1, 1, '2025-10-17 03:40:29', '2025-10-17 06:53:54');

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
(1, 'admin', 'admin@admin.com', NULL, '$2y$12$BOIu0TDfawdRm5/b9HNoTO7J9E7n9TDhcJcx4oBVpA86KPmyrO1OS', NULL, '2025-10-17 01:59:33', '2025-10-17 01:59:33');

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
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `proposals`
--
ALTER TABLE `proposals`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `templates`
--
ALTER TABLE `templates`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
