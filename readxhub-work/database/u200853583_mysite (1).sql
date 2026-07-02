-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 25, 2026 at 03:50 AM
-- Server version: 11.8.6-MariaDB-log
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u200853583_mysite`
--

-- --------------------------------------------------------

--
-- Table structure for table `admingglogin`
--

CREATE TABLE `admingglogin` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `pass_id` varchar(50) NOT NULL,
  `datetime` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admingglogin`
--

INSERT INTO `admingglogin` (`id`, `username`, `password`, `pass_id`, `datetime`) VALUES
(2, 'Admin_Lucky', '101001988', '845424', '2024-05-05 12:59:54');

-- --------------------------------------------------------

--
-- Table structure for table `admin_users`
--

CREATE TABLE `admin_users` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin_users`
--

INSERT INTO `admin_users` (`user_id`, `user_name`, `user_password`, `created_at`) VALUES
(6, 'Luck', 'Ayush10', '2025-01-05 05:19:04');

-- --------------------------------------------------------

--
-- Table structure for table `blogcomment`
--

CREATE TABLE `blogcomment` (
  `id` int(11) NOT NULL,
  `blog_id` int(11) NOT NULL,
  `user_email` varchar(255) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `profile_picture_url` text NOT NULL,
  `text` text NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `parent_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `blogcomment`
--

INSERT INTO `blogcomment` (`id`, `blog_id`, `user_email`, `user_name`, `profile_picture_url`, `text`, `created_at`, `updated_at`, `parent_id`) VALUES
(9, 9, 'pm9825167@gmail.com', 'Ayushi Mishra', 'https://lh3.googleusercontent.com/a/ACg8ocJGOZGjGwqLp3IgUBKFgAGmhL1zGfxaKzoP2UyxuBtxb0w2et8=s96-c', 'Bahut hi exciting orthrilling hai \nWaiting for the next part ????', '2025-04-02 15:01:37', '2025-06-21 11:32:06', NULL),
(12, 9, 'dhiraj0172@gmail.com', 'Dhiraj', 'https://lh3.googleusercontent.com/a/ACg8ocJYadgNQpz5pN-gtFnxR8OLc2de8aAizh3eiZenC02TapUe8ANc=s96-c', 'Kafi zada acha hai bhai,,esa feel ho rha hai ki koi working professionals na ya likha hai ???? experience person na', '2025-04-02 16:34:06', '2025-06-21 11:32:12', NULL),
(13, 9, 'rreehhaann123123@gmail.com', 'Rehan', 'https://lh3.googleusercontent.com/a/ACg8ocIuRC_Ifg7_EFF8cK_2Z2ywj7rGlIrbNHOMbUwN065TWi6DStE=s96-c', 'That was too good. \nKami h bs animation ki..', '2025-04-02 16:34:40', '2025-06-21 11:32:30', NULL),
(14, 9, 'thisismeadarshokay@gmail.com', 'Late account', 'https://lh3.googleusercontent.com/a/ACg8ocJjVs1VKbrk2oTdQ3I385wF3x-TuZclYgLwDc7KMiA5-qJ89w=s96-c', 'bro story mast hai bas thoda visuals ka kami hai baaki story op.', '2025-04-03 02:23:09', '2025-06-21 11:32:34', NULL),
(15, 0, 'adarshfinalchannel@gmail.com', 'Adarsh Singh', 'https://lh3.googleusercontent.com/a/ACg8ocIikx352-eGDuN3w03OD52sYyhgz81xGPZrBJNtuTPLuG9aEQ=s96-c', 'This really touched me. The way you described freedom, confusion, and that quiet longing—it felt so real. \'A free bird without wings\' stayed with me... it’s such a powerful way to show how we all sometimes feel ready to fly, but life doesn’t always give us the sky we want. Beautifully written and deeply relatable.', '2025-04-06 11:18:25', '2025-06-21 11:33:19', NULL),
(16, 11, 'adarshfinalchannel@gmail.com', 'Adarsh Singh', 'https://lh3.googleusercontent.com/a/ACg8ocIikx352-eGDuN3w03OD52sYyhgz81xGPZrBJNtuTPLuG9aEQ=s96-c', 'Everyone will find their destiny before end. Don\'t worry 😊', '2025-04-06 11:20:55', '2025-04-06 11:20:55', NULL),
(21, 9, 'sanukumar61101@gmail.com\r\n\r\n', 'sanu kumar', 'https://lh3.googleusercontent.com/a/ACg8ocL4O0gA395RA4Xy_a6TdHOtvNNDfnGqFY6uBTgopNCShmR4S6A=s96-c', 'Duniya ka sabse best story hai ye! isse achha koi story ho hi na sakta hai! bhai waiting for the next episode! please jaldi se release karo! \r\n', '2025-05-18 04:50:53', '2025-06-21 12:08:18', NULL),
(23, 10, 'adarsh.singhvishnu@gmail.com', 'Adarsh Singh Rajput', 'https://lh3.googleusercontent.com/a/ACg8ocIDZps0tSoh3HcBJvhmDaf1g7CEuD_8VnhGQIhWeq_3WirJ6BzC=s96-c', 'one comment for myself hihihih. \nnoiceee', '2025-06-21 12:09:04', '2025-06-21 12:09:04', NULL),
(24, 13, 'adarsh.singhvishnu@gmail.com', 'Adarsh Singh Rajput', 'https://lh3.googleusercontent.com/a/ACg8ocIDZps0tSoh3HcBJvhmDaf1g7CEuD_8VnhGQIhWeq_3WirJ6BzC=s96-c', 'Noiceee ', '2025-06-21 15:49:55', '2025-06-21 15:49:55', NULL),
(25, 15, 'adarshfinalchannel@gmail.com', 'Adarsh Singh', 'https://lh3.googleusercontent.com/a/ACg8ocIikx352-eGDuN3w03OD52sYyhgz81xGPZrBJNtuTPLuG9aEQ=s96-c', 'Bro! itna jaldi matured nhi hona hota hai! tumhare jaise sab log ho gye fir to politcs hi khhatam ho jaayega! waise kaafi achha likhte ho. waiting for the next part', '2025-06-23 10:29:20', '2025-06-23 10:29:20', NULL),
(26, 22, 'adarsh.singhvishnu@gmail.com', 'Adarsh Singh Rajput', 'https://lh3.googleusercontent.com/a/ACg8ocIDZps0tSoh3HcBJvhmDaf1g7CEuD_8VnhGQIhWeq_3WirJ6BzC=s96-c', 'Noiceeee', '2025-07-05 10:26:34', '2025-07-05 10:26:34', NULL),
(27, 24, 'adarsh.singhvishnu@gmail.com', 'Adarsh Singh Rajput', 'https://lh3.googleusercontent.com/a/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'Bruhh just loved it!\naisa pratit hota hai jaise tum sach me puratan kaal se glti se yaha teleport ho chuke ho!\n\nagar kisi gen z ne ye padh liya to uska pura jal jaayega those who used to abuse everyone parents and next moment mandir jaake khud ko innocent samjhte ishwar ke saamne. \nhihihi.\n\nkeep it up', '2025-07-23 07:17:57', '2025-07-23 14:49:19', NULL),
(34, 15, 'siddhujatav16@gmail.com', 'Siddhu', 'https://lh3.googleusercontent.com/a/ACg8ocKsbIcupg7y33-HVH0MVBhjBgVl7x1yFv4N793z4Sc0KDsLmA=s96-c', 'wow aapne reply ka option bhi bna diya kya baat hai buddy\n', '2025-07-24 02:15:06', '2025-07-24 02:15:06', 25),
(36, 24, 'siddhujatav16@gmail.com', 'Siddhu', 'https://lh3.googleusercontent.com/a/ACg8ocKsbIcupg7y33-HVH0MVBhjBgVl7x1yFv4N793z4Sc0KDsLmA=s96-c', 'thankyou brother \ni hope gen-z will understand my thoughts!!', '2025-07-24 02:16:23', '2025-07-24 02:16:23', 27),
(37, 27, 'siddhujatav16@gmail.com', 'Siddhu', 'https://lh3.googleusercontent.com/a/ACg8ocKsbIcupg7y33-HVH0MVBhjBgVl7x1yFv4N793z4Sc0KDsLmA=s96-c', 'Main reason hai population and corrupt govt because govt. Hi promote krti hai sari chijo ko jo indian citizens ko distract krti hai and wo companies ruling party ko ek very large amount pay krti h iske badle! \nWaise kaafi accha likha brother keep it up ^~^', '2025-08-11 12:28:38', '2025-08-11 12:28:38', NULL),
(38, 27, 'adarsh.singhvishnu@gmail.com', 'Adarsh Singh Rajput', 'https://lh3.googleusercontent.com/a/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'haaa bhai mera bhi yahi manna hai! mujhe abhi current me koi ek party nhi dikhta jo chahta hai ki desh tarakki kare wrna wo log apna nind tyag ke sirf development ke liye sochte! abhi ke govt sirf sapne bechte hai ', '2025-08-12 12:47:22', '2025-08-12 12:47:22', 37),
(39, 26, 'adarsh.singhvishnu@gmail.com', 'Adarsh Singh Rajput', 'https://lh3.googleusercontent.com/a/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'bro noiceee! \nbut isbaar itna chhota kyu likha', '2025-08-12 12:48:11', '2025-08-12 12:48:11', NULL),
(40, 28, 'vishnushankar.singhadarsh@gmail.com', 'Vishnu shankar Singh', 'https://lh3.googleusercontent.com/a/ACg8ocIkFjh1-dpm_SKIKLeCapHH8D4I0dsIaeX_0qSE8M70ypq_aTR1=s96-c', 'Waah waah!\nEkdam badhiya', '2025-08-15 11:34:45', '2025-08-15 11:34:45', NULL),
(41, 27, 'acaydr@gmail.com', 'dr Acay', 'https://lh3.googleusercontent.com/a/ACg8ocK_oQNLcvaXL0sFwYMdH3IiXMU_z13m6VG8-4r7RykMYouB5Q=s96-c', 'Bhai kha ho ', '2025-08-19 02:32:13', '2025-08-19 02:32:13', NULL),
(42, 27, 'adarsh.singhvishnu@gmail.com', 'Adarsh Singh Rajput', 'https://lh3.googleusercontent.com/a/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'India me', '2025-10-07 04:06:34', '2025-10-07 04:06:34', 41),
(43, 28, 'siddhujatav16@gmail.com', 'Siddhu', 'https://lh3.googleusercontent.com/a/ACg8ocKsbIcupg7y33-HVH0MVBhjBgVl7x1yFv4N793z4Sc0KDsLmA=s96-c', 'GOODMORNIG SAVERA HO GYA *~*', '2025-10-23 16:01:03', '2025-10-23 16:01:03', NULL),
(45, 31, 'adarshfinalchannel@gmail.com', 'Adarsh Singh', 'https://lh3.googleusercontent.com/a/ACg8ocIikx352-eGDuN3w03OD52sYyhgz81xGPZrBJNtuTPLuG9aEQ=s96-c', 'It was preety amezing bro!', '2025-10-25 15:38:51', '2025-10-25 15:38:51', NULL),
(46, 32, 'payment@readxhub.in', 'ReadXHub', 'https://lh3.googleusercontent.com/a/ACg8ocLDx4NMqEBs5O-0zg-OkmQE_DwD1zQWw5-fFEMEPmy__G1UdWI=s96-c', 'noicee', '2025-12-16 05:05:39', '2025-12-16 05:05:39', NULL),
(47, 31, 'payment@readxhub.in', 'ReadXHub', 'https://lh3.googleusercontent.com/a/ACg8ocLDx4NMqEBs5O-0zg-OkmQE_DwD1zQWw5-fFEMEPmy__G1UdWI=s96-c', 'really', '2025-12-16 05:30:21', '2025-12-16 05:30:21', 45),
(54, 27, 'payment@readxhub.in', 'ReadXHub', 'https://lh3.googleusercontent.com/a/ACg8ocLDx4NMqEBs5O-0zg-OkmQE_DwD1zQWw5-fFEMEPmy__G1UdWI=s96-c', 'you won\'t recieve my mail', '2025-12-16 06:10:35', '2025-12-16 06:10:35', NULL),
(55, 32, 'adarsh.singhvishnu@gmail.com', 'Adarsh Singh Rajput', 'https://lh3.googleusercontent.com/a/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'bro i really loved it', '2025-12-16 06:45:30', '2025-12-16 06:45:30', NULL),
(57, 28, 'deenukmwt277@gmail.com', 'Deendayal Kumawat', 'https://lh3.googleusercontent.com/a/ACg8ocICa6rgEwOyoxYldhU949jbx13wug64okZfB-MsVzqV-TNo3A=s96-c', 'Aag laga di aag laga di 🔥😎', '2025-12-16 14:37:57', '2025-12-16 14:37:57', NULL),
(58, 42, 'adarsh.singhvishnu@gmail.com', 'GDR', 'https://lh3.googleusercontent.com/a/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'Amezing Information!\nThank You Disha Mam', '2026-01-13 16:16:32', '2026-01-13 16:16:32', NULL),
(59, 35, 'ayushbhadoriya918@gmail.com', 'Harsh P S B', 'https://lh3.googleusercontent.com/a/ACg8ocLbDSDB4EawXoSWOujb5NBdBBDeWQBkiMmFG8jx50pOC9BizxVB=s96-c', 'Majestic ecosystem... helpful for multiple talent', '2026-01-15 05:50:35', '2026-01-15 05:50:35', NULL),
(60, 43, 'adarsh.singhvishnu@gmail.com', 'GDR', 'https://lh3.googleusercontent.com/a/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'Nice information ℹ️ \nThank You So Much 😊 \nWill be better if get any video with the article .', '2026-01-24 10:15:58', '2026-01-24 10:15:58', NULL),
(61, 44, 'adarsh.singhvishnu@gmail.com', 'GDR', 'https://lh3.googleusercontent.com/a/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'Informative Article!\n😊', '2026-01-24 21:32:57', '2026-01-24 21:32:57', NULL),
(62, 44, 'ayushbhadoriya918@gmail.com', 'Harsh P S B', 'https://lh3.googleusercontent.com/a/ACg8ocLbDSDB4EawXoSWOujb5NBdBBDeWQBkiMmFG8jx50pOC9BizxVB=s96-c', 'Helpful', '2026-01-25 07:21:27', '2026-01-25 07:21:27', NULL),
(63, 45, 'kumardubeyadarsh67@gmail.com', 'Adarsh Kumar Dubey', 'https://lh3.googleusercontent.com/a/ACg8ocJU2dC04FsNU2Om3uMstGp0u5BAmx9C8VQ0qaLOL0KkGayHoXxj=s96-c', 'It was amezing to learn.', '2026-01-25 08:05:47', '2026-01-25 08:05:47', NULL),
(64, 26, 'siddhujatav16@gmail.com', 'Siddhu', 'https://lh3.googleusercontent.com/a/ACg8ocKsbIcupg7y33-HVH0MVBhjBgVl7x1yFv4N793z4Sc0KDsLmA=s96-c', 'kyuki ye poem he', '2026-01-29 06:20:43', '2026-01-29 06:20:43', 39),
(65, 45, 'siddhujatav16@gmail.com', 'Siddhu', 'https://lh3.googleusercontent.com/a/ACg8ocKsbIcupg7y33-HVH0MVBhjBgVl7x1yFv4N793z4Sc0KDsLmA=s96-c', 'thanks kyuki ye board exam me likh ke aau ga agr 4 marks ka question aaya toh ^~^', '2026-01-29 06:21:51', '2026-01-29 06:21:51', NULL),
(66, 48, 'pm9825167@gmail.com', 'Ayushi Mishra', 'https://lh3.googleusercontent.com/a/ACg8ocJGOZGjGwqLp3IgUBKFgAGmhL1zGfxaKzoP2UyxuBtxb0w2et8=s96-c', 'Woah .. you write so well mitraa .. It\'s totally worth it . Nd it\'s really engaging.. you\'ll make a fine writer .. Keep going', '2026-06-25 02:22:42', '2026-06-25 02:22:42', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `blogs`
--

CREATE TABLE `blogs` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `author` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `blogs`
--

INSERT INTO `blogs` (`id`, `title`, `content`, `description`, `keywords`, `author`, `created_at`) VALUES
(10, 'Bhramandh Ke Pare: Ek Rahasya Ki Shuruaat', '<p>scene 1 suru hota hai jaha ek lady ka mission hota hai jo uske boss ke dwara dia jaata hai jo usne pura complete kiya tha aur usko uske badle me kuchh paise milne waale the.<br>mission sayad kisi ko maarna hota hai. lekin hairani ki baat ye hai ki wo paise lene ke bajaye waha se bhhag rhi thi, wo kisi tunnel ke andar se bhhag rhi thi.&nbsp;<br>scene shift hota hai ek chhoti 17 saal ki ladki aur 15 saal ke ladke ke taraf jo baat kar rhe hote hai ki mummy kaha milegi ab. tabhi wo ladki bolti hai mujhe pata hai wo kaha ho sakti hai aur fir wo dono kahi jaane lagte hai.<br>scene shift hota hai us aurat pe jo tunnel se bhhag rhi thi wahi pe ek daasi use kuchh sone ke maala de rhi thi aur kuchh chize par wo lady bolti ye sahi time nhi hai is chiz ka mujhe bhhagna padega aur ham dekhte hai ki wo bhhagne lagi.<br>scene shift hota hai un dono bachoo pe jo mummy ko dhhundhe ke liye kahi jaa rhe the ab wo tunnel me ek andhhere jagah pe kisi ka wait kar rhe aur unke position se maalum hota hai ki wo taiyari me hai ki koi jaise hi aayega use andhere ka fayda utha ke laat se maar ke gira denge.<br>aur waha pe koi aarha tha aur un dono ne laat maar ke gira diya. par hame dekhne ko milta hai ki wo uski mummy nhi thi wo koi chor tha jo saman leke bhhag rha tha. tabhi wo ladki bolti hai ki \"Mumyyyyyyyyyyyyyyyyyyyyyyy!\" aur hame dekhne ko milta hai ki uski mummy kisi se lad rhi thi&nbsp;<br>aur haa wo mummy aur koi nhi balki wo lady jo apna mission complete karke bhhag rhi thi wahi thi. fir dekhte hai us lady me aur ek ajib tarike ke dikhne waale creature ke bich me intense fight ho rha tha but wo lady jit rhi thi kyuki uske paas andhere ka advantage tha aur use is tunnel ka aadat hai.<br>aur us tunnel me ek serect room tha jisme wo creature chala gya par achanak se ham dekhte hai ki us lady ne apne muh se bahut saara flame fire nikala aur pure room ko jala diya aur wahi pe ham dekhte hai ki wo creature ya bole alien mar chuka hai aur wo uske rakh bacha hai.<br>hame ye bhi dekhne ko milta hai ki alien ka body me kuchh changes aaye jo mara hai aur jo kuchh liquid me badal gya. ab wo lady secret room se bahar aai apne bachoo ko dekhne to uske raunghte khhade ho jaate hai wo dekhti hai ki uske bachee aur ek chor ka body liquid ban chuka hai and they are dead now. ham dekhte hai ki unke body ab pighhal chuke hai jo dekh ke hi kisi ka aatma kaamp jaaye. wo lady rone ke haal me aagai aur usne chilana suru kar diya \"Ashish!!!!! Prerna!!!!!!!\" Aur Hame Pata Chalta Hai Ki Un Dono Ka Naam Ashish Aur Prerna Tha, Jo ab na rhe. par achanak se ham dekhte hai ki karib pure tunnel me har 4 metre pe 1 alien ya kisi type creatre khhade hai aur wo lady dekh kar bahut dar jaati hai use bilkul samjh nhi aata ki ye sab kya chal rha hai ye sab hai kon, uske sath ho kya rha hai. wo ladki darte hue ek ek krke usko paar kar rhi thi aur aage badh rhi hoti aur wo tunnel se nikal gai aur use aasmaan me visuals dikhte kuchh ajib creature ka jo use apne nazro se ghhayal kar rhe aur warn kar rhe ki wo lautenge aur badla lenge.<br>ladki waha se nikal gai bahut jaldi.&nbsp;</p>\r\n<p>Scene Shift(Bhram)<br>Rudrakar: Trikal hamara bheja hua pyada to mar chuka hai. par achha baat ye hua ki ham aakhirkaar ek grah khhojne me kaamyaab ho paaye. mujhe to yakin nhi ho rha ki Bhram Ke Alava bhi koi aur grah hai is purn bhramandh me.&nbsp;<br>Trikal: Mujhe bhi bahut aashcharya ho rha par sochne waala baat to ye hai jab is grah ke baare me baaki desh jaanenge to unka kya kehna hoga.<br>Rudrakar: Nhi ham abhi baaki desho ko is grah ke baare me nhi bata sakte warna hame waha pe badla lene jaane se pratibandh laga diya jaayega aur wo log apna jaach pratal karenge. hame soch samjh ke kadam uthana hoga.<br>Trikal: Sahi kaha mitra. hame pahle apne jaasus us jagah pe bhejna hoga aur jaana hoga ki waha ke logo ke kya saktiya hai aur kya wo log hamare liye khhatra to nhi hai na.<br>Rudrakar: hahahahhahahha! is khhel me maza aayega.</p>', 'Ek mission jo safalta se pura ho gaya tha, lekin badle me milne wale paiso ke bajaye ek anjaani bhagdaud shuru ho gayi. Ek lady, jo tunnel ke andheron me apni jaan bachane ko majboor thi, aur do bache jo apni maa ki talash me the. Ek rahasya jo sirf ek se', 'Sci-fi kahani, thriller story, alien mystery, tunnel secret, bhramandh rahasya, horror science fiction, mission and betrayal, secret planet, cosmic conspiracy, extraterrestrial war.', 'Adarsh Singh', '2025-04-02 14:53:31'),
(11, 'Path of light ', '<p>Beyond the starry nights&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; lies universe so vast,&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; yet we stand in fright.&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Anxious of the past.</p>\r\n<p>There\'s so much hidden ahead&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;yet we dwell in what\'s left behind&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; why should I care about what other\'s said In my life, I can be of my kind</p>\r\n<p>In this endless world where we roam ,&nbsp; &nbsp; &nbsp; &nbsp;anxiety grips , crumbles us from within&nbsp; &nbsp; &nbsp;yet in vast expenses, I am not alone,&nbsp; &nbsp; &nbsp; &nbsp; I have a home where ours are akin.</p>\r\n<p>They are truly mine , their love&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Is a heart, I lean upon.&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;The worries like waves, come and gone.&nbsp; &nbsp; Their care, guiding me down.</p>\r\n<p>Leave behind what come and passed&nbsp; &nbsp; &nbsp; &nbsp; Just keep on living, without shadow of doubt.&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;This path of light will enlighten us out.</p>', 'Path of light \r\nTo all who are reading this you are strong and special..', 'Poetry ', 'Breeze', '2025-04-06 10:30:35'),
(12, 'Threshold density ', '<p>Out sigh the foggy embers of the glass,</p>\r\n<p>as shakes the wheels of the train,</p>\r\n<p>the train surpassing the rain of my window</p>\r\n<p>that fled away with the thoughts, again.</p>\r\n<p>&nbsp;</p>\r\n<p>&rsquo;I am a free bird&rsquo; echoes the clouds</p>\r\n<p>clouds fluttering the curtains of my eyes</p>\r\n<p>&rsquo;but without wings, right?&rsquo;</p>\r\n<p>whispers the pages of my past life.</p>\r\n<p>&nbsp;</p>\r\n<p>Pushing me off from the threshold destiny is now,</p>\r\n<p>finally, I am ready to fly high,</p>\r\n<p>but, the sky is not of my choice,</p>\r\n<p>thunders and bolt flashing with the tides.</p>\r\n<p>&nbsp;</p>\r\n<p>Excavate out the alveoli,</p>\r\n<p>what is the use of increased surface area?</p>\r\n<p>If my breathing can&rsquo;t even reach the heart,</p>\r\n<p>to oxygenate the bones of aviation?</p>', 'Free bird but without wings ', 'Poetry ', 'Breeze', '2025-04-06 10:37:17'),
(13, 'To, the thriving addiction towards Petrichor ', '<p>The chaos, the city lights, the mayhem</p>\r\n<p>The missing feeling of living in a day dream;</p>\r\n<p>&nbsp;</p>\r\n<p>The cloud, the darkness, the rain&nbsp;</p>\r\n<p>The water sweeping out,</p>\r\n<p>Leaving the lungs a need for air&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>The better feeling of silence of a graveyard,</p>\r\n<p>Then sitting between living,</p>\r\n<p>Listening to their chaos .</p>\r\n<p>&nbsp;</p>\r\n<p>The thunder the windfall the storm</p>\r\n<p>Screaming go home,</p>\r\n<p>Till the world tears apart.</p>\r\n<p>&nbsp;</p>\r\n<p>The beggary of name</p>\r\n<p>That can\'t be reckoned&nbsp;</p>\r\n<p>Half the world has it,</p>\r\n<p>Other half being still born</p>', 'To, the thriving addiction towards Petrichor ', 'Poetry ', 'Breeze', '2025-04-10 06:48:31'),
(14, 'Talking to a fish in an aquarium ', '<p>You swim, slow and small</p>\r\n<p>In your glass walls jar.</p>\r\n<p>I sit and watch, day and night,</p>\r\n<p>Shining bright blue in the soft light.</p>\r\n<p>Do you dream of a bigger sea?</p>\r\n<p>Do you feel like I do?</p>\r\n<p>Trapped in a place that is too small to grow,</p>\r\n<p>wanting to be free... and nowhere to go.</p>\r\n<p>You are quiet and I am quiet,</p>\r\n<p>under the same quiet sky.</p>\r\n<p>If I could, I would let you go free,</p>\r\n<p>And maybe I could be free, too.</p>', 'Poetry ', 'Poetry ', 'Breeze', '2025-05-05 15:30:04'),
(15, 'Poetry ', '<p>The world\'s a stage.</p>\r\n<p>Tryna be perfect?</p>\r\n<p>Gonna get reduced to ashes.</p>\r\n<p>Mad dash for an escape,</p>\r\n<p>Can\'t wake up the dazed;</p>\r\n<p>They long for the damned word success</p>\r\n<p>That\'s a neverending maze.</p>', 'Poetry ', 'Poetry ', 'Breeze', '2025-05-05 15:30:49');

-- --------------------------------------------------------

--
-- Table structure for table `blog_creators`
--

CREATE TABLE `blog_creators` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `bio` varchar(2000) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `gender` varchar(20) DEFAULT 'male',
  `show_email` tinyint(1) DEFAULT 0,
  `public_email` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `blog_creators`
--

INSERT INTO `blog_creators` (`id`, `name`, `phone`, `date_of_birth`, `profile_picture`, `bio`, `email`, `username`, `gender`, `show_email`, `public_email`, `created_at`) VALUES
(5, 'GDR', '8809978817', '2007-04-22', 'https://readxhub.in/blogs/uploads/1782308297_image_logo.png', 'Hey guys,\r\nThis is the GDR!\r\nHere I am teaching something I didn\'t even know yesterday!', 'adarshfinalchannel@gmail.com', 'GDR', 'male', 1, 'gdr.adarshsingh@gmail.com', '2025-06-21 12:13:08'),
(7, 'Disha', '8794681105', '2009-09-15', 'uploads/profile_pics/profile_6856c899bfd728.58871985.jpg', 'Hi I am Disha. I am a writer. I like writing poetries. And have diverse topic interests. I would like to share my knowledge and whatever I can share. It\'s my pleasure to connect with this website. ', 'dishayadav545@gmail.com', 'disha', 'male', 0, NULL, '2025-06-21 14:58:33'),
(10, 'Breeze', '7858961142', '2008-01-28', 'uploads/profile_pics/profile_6856cdc98d5d40.44495729.jpg', 'Jiye or jeene de \r\nSukooon and peace', 'pm9825167@gmail.com', 'breeze', 'female', 0, '', '2025-06-21 15:20:41'),
(11, 'SIDDHARTH', '8817806421', '2008-09-22', 'uploads/profile_pics/profile_685926202ce974.76130297.jpg', 'HELLO GUYS,\n MYSELF SIDDHARTH\n\"JOIN ME ON THIS JOURNEY, LET\'S  LEARN TOGETHER\"', 'siddhujatav16@gmail.com', 'siddharth', 'male', 0, NULL, '2025-06-23 10:02:08'),
(12, 'SIDDHARTH', '8817806421', '2008-09-22', 'uploads/profile_pics/profile_685926258b25a0.21788390.jpg', 'HELLO GUYS,\r\n MYSELF SIDDHARTH\r\n\"JOIN ME ON THIS JOURNEY, LET\'S  LEARN TOGETHER\"', 'siddhujatav16@gmail.com', 'siddharth_1429', 'male', 0, NULL, '2025-06-23 10:02:13'),
(13, 'SIDDHARTH', '8817806421', '2008-09-22', 'uploads/profile_pics/profile_68592652855603.66802259.jpg', 'HELLO GUYS,\r\n MYSELF SIDDHARTH\r\n\"JOIN ME ON THIS JOURNEY, LET\'S  LEARN TOGETHER\"', 'siddhujatav16@gmail.com', 'siddharth_4095', 'male', 0, NULL, '2025-06-23 10:02:58'),
(14, 'SIDDHARTH', '8817806421', '2008-09-22', 'uploads/profile_pics/profile_685926558f3cb6.90903580.jpg', 'HELLO GUYS,\r\n MYSELF SIDDHARTH\r\n\"JOIN ME ON THIS JOURNEY, LET\'S  LEARN TOGETHER\"', 'siddhujatav16@gmail.com', 'siddharth_7021', 'male', 0, NULL, '2025-06-23 10:03:01'),
(15, 'Sanu kumar', '7061342115', '2009-04-30', 'uploads/profile_pics/profile_68592ec80b51d6.50641429.jpg', 'If you are bad , I am your dad.', 'sanukumar61101@gmail.com', 'sanu_kumar', 'male', 0, NULL, '2025-06-23 10:39:04'),
(16, 'Sanu kumar', '7061342115', '2009-04-30', 'uploads/profile_pics/profile_68592ec8592040.58943942.jpg', 'If you are bad , I am your dad.', 'sanukumar61101@gmail.com', 'sanu_kumar_7456', 'male', 0, NULL, '2025-06-23 10:39:04'),
(17, 'RANDHIR SINGH', '7366935188', '2005-06-22', 'uploads/profile_pics/profile_68593863281ba2.78122468.jpeg', 'Professional Blogger,\r\nIIT, JEE Aspirant\r\ngonna create something unique ', 'itisreadxhub@gmail.com', 'randhir_singh', 'male', 0, NULL, '2025-06-23 11:20:03'),
(18, 'RANDHIR SINGH', '7366935188', '2005-06-22', 'uploads/profile_pics/profile_6859387d2dbfd0.00813782.jpeg', 'Professional Blogger,\r\nIIT, JEE Aspirant\r\ngonna create something unique ', 'itisreadxhub@gmail.com', 'randhir_singh_9372', 'male', 0, NULL, '2025-06-23 11:20:29'),
(19, 'raj', '9795647253', '2009-01-27', 'uploads/profile_pics/profile_68595a1258ee38.79385256.png', 'sghjnjhjumn iurvnbnlmfjg ajf   27512848  @adarsh rajsingh juthj4jujhrju6aeh', 'rajheartkiller18110@gmail.com', 'raj', 'male', 0, NULL, '2025-06-23 13:43:46'),
(20, 'raj', '9795647253', '2009-01-27', 'uploads/profile_pics/profile_68595a1954be14.75868686.png', 'sghjnjhjumn iurvnbnlmfjg ajf   27512848  @adarsh rajsingh juthj4jujhrju6aeh', 'rajheartkiller18110@gmail.com', 'raj_5317', 'male', 0, NULL, '2025-06-23 13:43:53'),
(22, 'Adarsh', '9472153687', '1993-04-22', 'https://readxhub.in/blogs/uploads/1782202086_my_pffp.jpeg', 'hey guys this is me adarsh singh rajput how are you all', 'adarsh.singhvishnu@gmail.com', 'adarsh', 'male', 0, NULL, '2025-06-23 16:40:58'),
(23, 'Deenu kmwt', '8824876745', '2006-04-03', 'uploads/profile_pics/profile_685d07871d2b68.29063562.png', 'I am a part time and Full time Traveller \r\nI like Secrets and mysterious 🗿', 'deenukmwt277@gmail.com', 'deenu_kmwt', 'male', 0, NULL, '2025-06-26 08:40:39'),
(24, '', '', '0000-00-00', NULL, '', '', 'user', 'male', 0, NULL, '2025-07-02 22:13:52'),
(25, '', '', '0000-00-00', NULL, '', '', 'user_6715', 'male', 0, NULL, '2025-07-02 22:13:53'),
(26, '', '', '0000-00-00', NULL, '', '', 'user_4977', 'male', 0, NULL, '2025-10-10 06:27:48'),
(27, '', '', '0000-00-00', NULL, '', '', 'user_7209', 'male', 0, NULL, '2025-10-11 23:30:11'),
(28, 'ReadXHub', '9939914772', '2007-05-22', 'uploads/profile_pics/profile_6940ea13202e13.93712341.jpg', 'We\'ll provide the topic of readxhub and the cyber security', 'payment@readxhub.in', 'readxhub', 'male', 0, NULL, '2025-12-16 05:11:47'),
(29, 'Raj singh ', '9795647253', '2009-01-27', 'uploads/profile_pics/profile_694b3d33405e19.28416769.jpg', 'I\'m Co-founder of ReadXHub \r\n', 'mr.rajsingh.student@gmail.com', 'raj_singh', 'male', 0, NULL, '2025-12-24 01:09:07'),
(30, 'Srishti', '9289851178', '2007-05-22', 'uploads/profile_pics/profile_6975c1953b2ab9.96001764.jpg', 'I write Blog releted to technologiaaa', 'adarshsingh22042006@gmail.com', 'srishti', 'male', 0, NULL, '2026-01-25 07:09:09'),
(31, '', '', '0000-00-00', NULL, '', '', 'user_7395', 'male', 0, NULL, '2026-04-08 04:06:54'),
(32, '', '', '0000-00-00', NULL, '', '', 'user_3200', 'male', 0, NULL, '2026-06-07 18:19:02');

-- --------------------------------------------------------

--
-- Table structure for table `blog_posts`
--

CREATE TABLE `blog_posts` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `keywords` text DEFAULT NULL,
  `author` varchar(100) DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `email` varchar(255) DEFAULT NULL,
  `views` int(11) DEFAULT 0,
  `notifications_sent` tinyint(1) DEFAULT 0,
  `likes` int(11) DEFAULT 0,
  `dislikes` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `blog_posts`
--

INSERT INTO `blog_posts` (`id`, `title`, `description`, `keywords`, `author`, `content`, `slug`, `url`, `created_at`, `email`, `views`, `notifications_sent`, `likes`, `dislikes`) VALUES
(13, 'The path of light ', 'The path of light ', 'Poetry ', 'Breeze', 'Beyond the starry nights lies universe so vast, yet we stand in fright. Anxious of the past.\r\nThere\'s so much hidden ahead yet we dwell in what\'s left behind why should I care about what other\'s said In my life, I can be of my kind\r\nIn this endless world where we roam, anxiety grips, crumbles us from within yet in vast expenses, I am not alone, I have a home where ours are akin.\r\nThey are truly mine, their love Is a heart, I lean upon. The worries like waves, come and gone. Their care, guiding me down.\r\nLeave behind what come and passed Just keep on living, without shadow of doubt. This path of light will enlighten us out.', 'the-path-of-light-1750519785', 'https://readxhub.in/blogs/post.php?slug=the-path-of-light-1750519785', '2025-06-21 15:29:45', 'pm9825167@gmail.com', 10, 1, 2, 0),
(15, 'PRATYAVARAN', '\"LET\'S LEARN TOGETHER.\"', '', 'SIDDHARTH', 'HELLO DOSTO,\r\nSWAGAT HAI AAP SABHI KA MERI IS AUTOBIOGRAPHY KE SEASON~1 KE CHAPTER~1 ME................\r\n \r\n\r\nYe bat tab ki hai jab mene pehli bar {god/bhagwan} ki tasveer dekhi thi or unke bare me apno se jana tha jaise jaise me bada hua mera najariya bhagwan ko lekar \r\nbadalta rha hai suruati dor me mere liye bhagwan ka matlab tha esi koi shakti jis ne is duniya ko bnaya hai or sare insan unhe apna pita{father} mante hai unki\r\npuja karte hai or yahi se insan apne aap ko alag alag dharmo me baatna suru kr dete hai jaise sikh,hindu,bodh,muslim,christan etc. mene jana ki sab dharmo me \r\nek baat saman thi or wo ye ki we sab kisi na kisi ki puja karte hai or ye pure vishwa me fela hua hai. me samajta hu ki dharma ki shurauat us samay se hui\r\njab insan aadimanav se pragati kar insan ban rha tha jab jarur insan ke man me khud ke astitava ko lekar sawal aaye hoge or insano ne hi alag alag dharm\r\nbnaye hoge jika lakshya hoga insano ko ek samuh[group] me jodna ttaki we ekjut ho sake hor shanti se re rahe aanek dharmo me kuch dharm granth or dharmic \r\nkitabo me afterlife ka concept bhi hai jaise ki ye karm kro ge te ye hoga wagerah wagerah... inko bnanae ke piche ka karan meri disthi me logo ko bure karm \r\nkrne se rokna or acche kam krne ki liye harsh vardhan krna rha hoga vartman[present] me dharm,bhgwan or unke nam ka prayog logo me foot dalne or raaj krne\r\nki niti pe kayam hai aanek neta bharat me jo bhi majoritiy ka dharma hota hai us dharm ko support krte hai taaki we majority of the voters ko apni or kar\r\neasily election jeet jaye jha ek se jyada dharma hote hai wha minority ko majority ka dar diya jata hai or apne fyde ke liye use kiya jata hai, hmari kahani\r\nke author insano ki dohari prvati se nafrat krte hai or wo pate hai ki ye sab jo bhi unhone bahar ki duniya se bhagwan ke baare me jaana hai wo sach nhi ya yu khae\r\nki aadha aadura sach hai or is sach ko janne ke liye hmare author ne shuru kiya aapne jivan ka ek naya daur jisme wo introspection[aatmachintan] krte or use ek\r\nbook me likha karte, jha aam bacche us umara me khela krte hai wo playground ke ek kone ek ped ke niche beth jate or us book me ye saari bate likha karte ye silsila yu \r\nhi kayam hai abhi tak kuch prashno ke jawab mile hai or kuch ke aabhi janna baaki hai hai. Mera janam ek financially stable parivar me hua, meri family ko city se move\r\nkar ke ek gao me aana pada kyuki mere father ka transfer ek village me hua tha me gao ke baccho se jyada ghul mil nhi paaya or me akela rehne laga jise me is \r\nduniya ko jyada acche dhang se samaj paaya jab aam  bacche khelne kudne me vyast the tab se hi mene introspection start kr di thi or me use kaagaz me utrna shuru kar \r\ndiya tha me insano se jyada janvaro ke sath rha hu or bohot sare janvaro ko mene rescue bhi kiya hai or mene ye paaya ki insan se jyada vafadar animals hote hai\r\nwe bas aapki aatention or pyar paakar hi khus ho jate hai jab ki insan ke sab kuch  krne ke bad bhi jab aapki importance unke liye khatam ho jati hai we aapko chod dete\r\nhai chahe kitna bhi gehra rista kyu na ho ek samya ke baad wo dheere dheere fika hune lagta hai, lekin hai kuch insan is duniya me jarur hai jo bina kisi matlab ke \r\nbhi aapka sath dete hai or ese hi logo ko is kahani ke author dhoond rahe hai.............continue...\r\n\r\n\r\nTHANKYOU SO MUCH FOR READING MY BLOG!!   ^~^\r\nNEXT PART COMING SOON....', 'pratyavaran-1750673649', 'https://readxhub.in/blogs/post.php?slug=pratyavaran-1750673649', '2025-06-23 10:14:09', 'siddhujatav16@gmail.com', 3, 1, 0, 0),
(16, 'Daily tired student life', 'How I get frustrated because of study gym and cooking food for family ', 'Student problem, life problems, student life problems ', 'Sanu kumar', 'Life is getting to hactic daily going to gym waking up at 5:00 a.m. then getting fresh then going to the gym and doing so much workout lifting so much weight and then coming to home then getting fresh then taking a bath and then I cook the food not for only myself but as well as for my father. This not only make me frustrated but also irritate me when I go to study cause I have a lots of syllabus I am in class 12th but when I go to study because of the gym workout running I feel so much sleepy but the thing is I can\'t even sleep because if I failed in class 12th or even score less than either I\'ll be kicked out of my house aur I have to do some job like labour job so I feel like  the student life is so hactic who is from middle class family or below middle first family. \r\nI\'ll keep posting my blog later thank you .', 'daily-tired-student-life-1750675612', 'https://readxhub.in/blogs/post.php?slug=daily-tired-student-life-1750675612', '2025-06-23 10:46:52', 'sanukumar61101@gmail.com', 0, 1, 0, 0),
(17, 'Life of an IIT Aspirant: A Rollercoaster Ride', 'As I sit here, reflecting on my journey as an IIT aspirant, I\'m filled with a mix of emotions - frustration, disappointment, and a glimmer of hope. Growing up in Motihari, Bihar, I always dreamed of cracking the IIT-JEE and making my family proud. But, little did I know, the path to success would be paved with challenges that would test my resolve and resilience.\r\n', 'iit aspirent, life of an iit aspirent, sad life of iit, iit sad life aspirent', 'RANDHIR SINGH', 'By Randhir Singh, Motihari, Bihar\r\n\r\nAs I sit here, reflecting on my journey as an IIT aspirant, I\'m filled with a mix of emotions - frustration, disappointment, and a glimmer of hope. Growing up in Motihari, Bihar, I always dreamed of cracking the IIT-JEE and making my family proud. But, little did I know, the path to success would be paved with challenges that would test my resolve and resilience.\r\n\r\nI left my hometown, eager to pursue my dreams in Patna, a city teeming with aspiring students like me. I enrolled in a coaching institute, hoping to learn from the best faculty and surround myself with like-minded individuals. But, reality hit hard. The faculty was subpar, and I struggled to grasp concepts. Despite my best efforts, I felt lost and demotivated.\r\n\r\nThe financial burden was crushing. My family had invested Rs. 2 lakhs in my coaching, a significant amount for us. The weight of expectations from my family, relatives, and friends was suffocating. Everyone believed in me, but I couldn\'t shake off the feeling that I was letting them down.\r\n\r\nThe days turned into weeks, and the weeks into months. I continued to struggle, feeling like I was drowning in a sea of uncertainty. The pressure to perform mounted, and I began to doubt my abilities. Would I ever make it to IIT? Was I good enough?\r\n\r\nDespite the setbacks, I refused to give up. I picked myself up, dusted myself off, and kept moving forward. I realized that failure is not the end; it\'s a stepping stone to success. I\'m still on this journey, and I\'m determined to make the most of it.\r\n\r\nTo all the IIT aspirants out there, I want to say that you\'re not alone. We\'re all in this together, navigating the ups and downs of this rollercoaster ride. Don\'t be disheartened by setbacks; instead, learn from them and keep pushing forward.\r\n\r\nAs for me, I\'ll continue to work hard, fueled by the fire of determination. I\'ll make my family proud, not just by cracking the IIT-JEE, but by giving it my all and emerging stronger, wiser, and more resilient.\r\n\r\nRandhir Singh', 'life-of-an-iit-aspirant-a-rollercoaster-ride-1750678198', 'https://readxhub.in/blogs/post.php?slug=life-of-an-iit-aspirant-a-rollercoaster-ride-1750678198', '2025-06-23 11:29:58', 'itisreadxhub@gmail.com', 0, 1, 0, 0),
(19, 'Alien\'s Attack', 'How Alien Planed To Destroy The Earth And Take The...', 'Allien attack, story, fiction, silly story', 'Adarsh', 'Scene 1:\r\nSuru hota hai jaha ek lady ka mission hota hai jo uske boss ke dwara dia jaata hai. Usne pura mission complete kiya tha aur uske badle me use kuchh paise milne waale the. Mission sayad kisi ko maarna hota hai.\r\n\r\nLekin hairani ki baat ye hai ki wo paise lene ke bajaye waha se bhag rahi thi. Wo kisi tunnel ke andar se bhaag rahi thi.\r\n\r\nScene 2:\r\nScene shift hota hai ek chhoti 17 saal ki ladki aur 15 saal ke ladke ki taraf, jo baat kar rahe hote hai, “Mummy kaha milegi ab?” Tabhi wo ladki bolti hai, “Mujhe pata hai wo kaha ho sakti hai,” aur fir wo dono kahi jaane lagte hai.\r\n\r\nScene 3:\r\nScene shift hota hai us aurat pe jo tunnel se bhaag rahi thi. Wahi pe ek daasi use kuchh sone ke maala de rahi thi aur kuchh aur chize bhi. Par wo lady bolti hai, “Ye sahi time nahi hai is chiz ka, mujhe bhaagna padega,” aur ham dekhte hai ki wo bhaagne lagi.\r\n\r\nScene 4:\r\nScene shift hota hai un dono bachcho pe jo mummy ko dhundhne ke liye kahi ja rahe the. Ab wo tunnel me ek andhere jagah pe kisi ka wait kar rahe hote hai. Unke position se maalum hota hai ki wo taiyari me hai ki jaise hi koi aaye, use andhere ka fayda utha ke laat se gira denge.\r\n\r\nAur waha pe koi aa raha tha. Un dono ne laat maar ke gira diya. Par hame dekhne ko milta hai ki wo mummy nahi thi — wo koi chor tha jo saman leke bhag raha tha.\r\n\r\nTabhi wo ladki zor se chillati hai, “Mumyyyyyyyyyyyyyyyyyyyyyyy!”\r\n\r\nAur hame dekhne ko milta hai ki uski mummy kisi se lad rahi thi.\r\n\r\nScene 5:\r\nAur haa — wo mummy aur koi nahi balki wahi lady thi jo apna mission complete karke bhaag rahi thi. Fir dekhte hai us lady aur ek ajeeb tarike ke dikhne waale creature ke bich intense fight ho raha tha.\r\n\r\nLekin wo lady jeet rahi thi kyunki uske paas andhere ka advantage tha aur use is tunnel ka aadat bhi tha.\r\n\r\nScene 6:\r\nUs tunnel me ek secret room tha jisme wo creature chala gaya. Achaanak se ham dekhte hai ki us lady ne apne muh se bahut saara flame fire nikala aur poore room ko jala diya. Wahi pe hame dekhne ko milta hai ki wo creature — ya bole alien — mar chuka hai, sirf uski rakh bachi hai.\r\n\r\nScene 7:\r\nHame ye bhi dekhne ko milta hai ki alien ke body me kuchh changes aaye. Jo mara hai, wo kuchh liquid me badal gaya.\r\n\r\nAb wo lady secret room se bahar aayi apne bachcho ko dekhne... to uske raungte khade ho jaate hai.\r\n\r\nWo dekhti hai ki uske bachche aur wo chor — dono ka body liquid ban chuka hai. They are dead now.\r\n\r\nHam dekhte hai ki unke body ab pighal chuke hai, jo dekh kar hi kisi ka aatma kaamp jaaye. Wo lady rone ke haal me aagayi aur usne chillana suru kar diya:\r\n“Ashish!!!!! Prerna!!!!!!!”\r\n\r\nAur hame pata chalta hai ki un dono ka naam Ashish aur Prerna tha — jo ab nahi rahe.\r\n\r\nScene 8:\r\nAchaanak se ham dekhte hai ki kareeb poore tunnel me har 4 metre pe ek alien ya kisi type ka creature khade hai.\r\n\r\nWo lady dekh kar bahut dar jaati hai. Use bilkul samajh nahi aata ki ye sab kya chal raha hai — ye sab hai kaun, uske saath ho kya raha hai.\r\n\r\nWo ladki darte hue ek ek karke unko paar kar rahi hoti hai aur aage badh rahi hoti hai. Wo tunnel se nikal jaati hai.\r\n\r\nUse aasman me visuals dikhte hai — kuchh ajeeb creature ke — jo use apni nazro se ghayal kar rahe hote hai aur warn kar rahe hote hai:\r\n“Hum lautenge... aur badla lenge.”\r\n\r\nLadki waha se nikal jaati hai — bahut jaldi.\r\n\r\nScene Shift (Bhram):\r\n\r\nRudrakar:\r\n“Trikal, hamara bheja hua pyada to mar chuka hai. Par achhi baat ye hui ki ham aakhirkaar ek grah khojne me kaamyab ho paaye. Mujhe to yakin nahi ho raha ki Bhram ke alava bhi koi aur grah hai is poorn bhramaandh me.”\r\n\r\nTrikal:\r\n“Mujhe bhi bahut aashcharya ho raha hai. Par sochne waali baat to ye hai — jab is grah ke baare me baaki desh jaanenge to unka kya kehna hoga?”\r\n\r\nRudrakar:\r\n“Nahi, ham abhi baaki desho ko is grah ke baare me nahi bata sakte. Warna hame waha pe badla lene jaane se pratibandh laga diya jaayega, aur wo log apna jaanch-pratal karenge. Hame soch samajh ke kadam uthana hoga.”\r\n\r\nTrikal:\r\n“Sahi kaha mitra. Hame pehle apne jaasus us jagah pe bhejna hoga aur jaana hoga ki waha ke logon ke kya saktiya hai — aur kya wo log hamare liye khatra to nahi hai.”\r\n\r\nRudrakar:\r\n“Hahahahahaha! Is khel me maza aayega.”', 'alien-s-attack-1751009602', 'https://readxhub.in/blogs/post.php?slug=alien-s-attack-1751009602', '2025-06-27 07:33:22', 'adarsh.singhvishnu@gmail.com', 6, 1, 2, 0),
(20, 'Threshold density ', 'Free bird without wings', 'Poetry ', 'Breeze', '\r\n\r\nOut sigh the foggy embers of the glass,\r\nas shakes the wheels of the train,\r\nthe train surpassing the rain of my window\r\nthat fled away with the thoughts, again.\r\n\r\n‘I am a free bird’ echoes the clouds\r\nclouds fluttering the curtains of my eyes\r\n‘but without wings, right?’\r\nwhispers the pages of my past life.\r\n\r\nPushing me off from the threshold destiny is now,\r\nfinally, I am ready to fly high,\r\nbut, the sky is not of my choice,\r\nthunders and bolt flashing with the tides.\r\n\r\nExcavate out the alveoli,\r\nwhat is the use of increased surface area?\r\nIf my breathing can’t even reach the heart,\r\nto oxygenate the bones of aviation', 'threshold-density-1751185016', 'https://readxhub.in/blogs/post.php?slug=threshold-density-1751185016', '2025-06-29 08:16:56', 'pm9825167@gmail.com', 0, 1, 0, 0),
(21, 'To the thriving addiction towards petrichor ', 'Poetry ', 'Poetry', 'Breeze', '\r\nThe chaos, the city lights, the mayhem\r\nThe missing feeling of living in a day dream;\r\n\r\nThe cloud, the darkness, the rain\r\nThe water sweeping out,\r\nLeaving the lungs a need for air\r\n\r\nThe better feeling of silence of a graveyard,\r\nThen sitting between living,\r\nListening to their chaos.\r\n\r\nThe thunder the windfall the storm\r\nScreaming go home,\r\nTill the world tears apart.\r\n\r\nThe beggary of name\r\nThat can\'t be reckoned\r\nHalf the world has it,\r\nOther half being still born\r\n', 'to-the-thriving-addiction-towards-petrichor-1751185171', 'https://readxhub.in/blogs/post.php?slug=to-the-thriving-addiction-towards-petrichor-1751185171', '2025-06-29 08:19:31', 'pm9825167@gmail.com', 0, 1, 0, 0),
(22, 'Talking to a fish in an aquarium ', 'Poetry ', 'Poetry ', 'Breeze', '\r\nYou swim, slow and small\r\nIn your glass walls jar.\r\nI sit and watch, day and night,\r\nShining bright blue in the soft light.\r\nDo you dream of a bigger sea?\r\nDo you feel like I do?\r\nTrapped in a place that is too small to grow,\r\nwanting to be free... and nowhere to go.\r\nYou are quiet and I am quiet,\r\nunder the same quiet sky.\r\nIf I could, I would let you go free,\r\nAnd maybe I could be free, too.\r\n', 'talking-to-a-fish-in-an-aquarium-1751185246', 'https://readxhub.in/blogs/post.php?slug=talking-to-a-fish-in-an-aquarium-1751185246', '2025-06-29 08:20:46', 'pm9825167@gmail.com', 0, 1, 0, 0),
(23, 'Staged lives', 'Poetry ', 'Poetry ', 'Breeze', '\r\nThe world\'s a stage.\r\nTryna be perfect?\r\nGonna get reduced to ashes.\r\nMad dash for an escape,\r\nCan\'t wake up the dazed;\r\nThey long for the damned word success\r\nThat\'s a neverending maze.', 'staged-lives-1751185306', 'https://readxhub.in/blogs/post.php?slug=staged-lives-1751185306', '2025-06-29 08:21:46', 'pm9825167@gmail.com', 3, 1, 0, 0),
(24, '\"निर्विकल्प\"', 'Ek aisi avastha jahan man ke sabhi dwandh shant ho jaate hain, aur vyakti apne kartavya ke path par nishkaam, satya-nishth aur moh-rahit chintan ke saath agrasar hota hai', '', 'SIDDHARTH', '--AUTOBIOGRAPHY PART 2\r\n\r\n                      \"NIRVILALP\"\r\n\r\n\r\nKuch pal aise hote hain jo samay ki dhaara me kho jaate hain… aur kuch pal, \r\nSamay ko hi rok dete hain. Us shaam, wahi hua....\r\n\r\nWo samaytha jahan andar ke sawal shabdon ke saath nahi, bhaavnaon ke saath \r\nubharne lage the. \r\n\r\n\"kya aapne kabhi is bat par vichar kiya hai ki kyu log dhan,lobh or moh ke \r\npiche pade rehte hai kyu log ek jhoothi or esi jindigi jine me bita dete hai\r\njis se we khud to sukhi nhi hote parntu apne aas pass wale logo ko yeh dikane \r\nme hi unka pura jivan beet jata hai ki wo doosro se jyada khush hai jeevan me\r\nhar insan aaj ke daur me yhi kr rha nakli dikhawe ka jeewan jis se wo khud hi\r\nnhi chatha bas deekhawa krne ke liye esi jindgi jeene ko majbur hai poore jivan \r\ninsan sukh ki khoj me lga deta hai or jab use sukh ki prapti nhi hoti to woh \r\ntoh wo anek alag alag raste apnata hai kuch log nashe ka sahara lete hai kuch \r\nlog sab ki attention pana chate hai or kuch log toh dharmic karm kand jese puja\r\npath aadi esi liye krte hai taaki is jivan ke sath sath mritu ke uparant bhi unhe \r\nswarg ke sukh ki prapti ho sake kya aap bhi un logo me se hi hai jo ye sab krte \r\nhai? kya ye sab krne ke baad bhi aapko sukh ki prapti hoti hai ??? uttar hai nhi\r\nis se aapko kuch samy ke liye santavna to jarur mil kati hai par jivan me sukh \r\nkabhi nhi mil sakta jivan me sukh pane ke liye jaruri hai dharm aausar aacharan\r\nkrna hame ye samaj na hoga ki dharm ke anusar aacharan krne me sukh nhi balki\r\ndharm anusar aacharan swayam sukh hai!! hi Jab koi maanav moh-rahit hokar,\r\n poorn satyanishtha evam nishkaam bhaav se apne kartavya ka paalan karta hai, \r\ntab vah Brahmaswaroop aanand ki anubhuti karta hai\r\n\"Aur tab, us kshan mein jab koi vyakti na lobh se bandha hota hai,\r\n na dikhave se — keval apne dharm ka paalan kar raha hota hai, \r\ntab uska antarman maun nahi rehta… woh goonjta hai us aanand mein jo na\r\n toh paane se aata hai, na hi khone se chala jaata hai.\r\nYahi saccha sukh hai — jo karm ki shuddhata mein hai, aur aatma ki shaanti mein.\"\r\n\r\n\r\n\"Chaliye, ab milte hain us agle anubhav ke prarambh mein — jahan shabdon ke pare,\r\n bhavnaayein bolti hain... aur soch ek nai disha ki khoj mein nikal padti hai.\r\nAgla bhaag, ek aur roshni lekar aayega. Aapse phir mulakaat hogi!!!\r\n', '-1753081731', 'https://readxhub.in/blogs/post.php?slug=-1753081731', '2025-07-21 07:08:51', 'siddhujatav16@gmail.com', 0, 1, 0, 0),
(26, '\"The Truth Behind Love', 'POETRY', '', 'SIDDHARTH', 'If love is because of lust,    \r\n                                                                                                                                                         It feels like rust.\r\n                                                                                                                                                                              If love is because of aspiration, Then use it as fire.\r\n                                                                                                                                           It has the potential to fulfill Your overwhelming desire!', 'the-truth-behind-love-1754417224', 'https://readxhub.in/blogs/post.php?slug=the-truth-behind-love-1754417224', '2025-08-05 18:07:04', 'siddhujatav16@gmail.com', 0, 1, 0, 0);
INSERT INTO `blog_posts` (`id`, `title`, `description`, `keywords`, `author`, `content`, `slug`, `url`, `created_at`, `email`, `views`, `notifications_sent`, `likes`, `dislikes`) VALUES
(27, 'NEW BHARAT', 'how can we really develop our india', 'india, bharat, development', 'Adarsh', 'today i don\'t know why and how but i came up with some idea for our country!\r\n\r\ni was thinking about myself that how i waste my most of the time and why i\'m not productive! why india has lot of employment issue!\r\nwhy kids are getting distracted in wrong things.\r\n\r\nwhy kids, men, women everyone are distracted in lust! why country isn\'t able to show it\'s full power! \r\nwe have most population in the world still we are top 4 economy! and we should even not talk about per capita income! \r\n\r\nwhy our contry is suffering from the problem of employement!\r\n\r\nso i found out some main problem!\r\nthe thing i find that in china, south korea, japan - people like their national brand. made in their own country! \r\nbut in india people are not that loyal with their country brand! just not because india has not good things! but because forign brands are so hyped! for example :\r\n\r\n1️⃣ Tech & Gadgets\r\nApple (USA) – iPhones, MacBooks, iPads (yes, made mostly in China/Vietnam but brand = USA).\r\n\r\nSamsung (South Korea) – High-end phones, TVs.\r\n\r\nSony (Japan) – TVs, PlayStations, audio gear.\r\n\r\nDell, HP (USA) – Laptops.\r\n\r\n💡 Why so popular? Brand prestige, cutting-edge features, and global hype.\r\n\r\n2️⃣ Fashion & Clothing\r\nNike, Adidas, Puma (USA/Germany) – Sportswear.\r\n\r\nH&M, Zara (Sweden/Spain) – Fast fashion.\r\n\r\nLevi’s (USA) – Jeans.\r\n\r\nGucci, Louis Vuitton (Italy/France) – Luxury bags, shoes, clothes (rich people vibes ✨).\r\n\r\n💡 Why so popular? Quality, style, “status” factor.\r\n\r\n3️⃣ Food & Beverages\r\nCoca-Cola, Pepsi (USA) – Soft drinks.\r\n\r\nNestlé (Switzerland) – Chocolates, coffee.\r\n\r\nKellogg’s (USA) – Cereals.\r\n\r\nFerrero Rocher (Italy) – Chocolates.\r\n\r\nRed Bull (Austria) – Energy drink.\r\n\r\n💡 Why so popular? Taste + aggressive marketing.\r\n\r\n4️⃣ Cars & Bikes\r\nMercedes-Benz, BMW, Audi (Germany) – Luxury cars.\r\n\r\nToyota, Honda (Japan) – Reliable cars.\r\n\r\nHarley-Davidson (USA) – Bikes.\r\n\r\nKawasaki, Yamaha (Japan) – Superbikes.\r\n\r\n💡 Why so popular? Luxury appeal + engineering trust.\r\n\r\n5️⃣ Lifestyle Products\r\nIKEA (Sweden) – Furniture.\r\n\r\nDyson (UK) – Vacuums, hair dryers.\r\n\r\nChanel, Dior (France) – Perfumes.\r\n\r\n💡 Why so popular? Unique designs, premium image.\r\n\r\nin above example, it isn\'t only famous because of it\'s hype but also because of their speciality and making! but in our country people has not that skills which their county has! the reason is simple, in USA,JAPAN,CHINA,GERMANY those country focuses on education, skills so much! that\'s why their kids came up with different different enovation! \r\nbut here on the name of enovation we came up with ideas like - \"jungle rummy, ludo khhelo paisa jito, winzo, spin and win!\"\r\n\r\nbut why these all are happening, just because of education, the people who are doing these kinds of enovation they were also a kid at a time but they didn\'t get that maturity for a country, for loyality, for right wrong otherwise they would always invest their telent on the application like instagram facebook for their own country which actually give employment! but we are not getting real talent!\r\n\r\nwe have also good system which is booming in this world LIKE :\r\nUPI (Unified Payments Interface)\r\n\r\nbut i don\'t think we can end up with another application like this which are being used by another nation and if there is then one two!\r\n\r\nbut why is that Silicon Valley are coming with thousands of application but india with none when we has largest population!\r\n\r\nwhy no one is talking about it!\r\n\r\ni guess this is the time when we should take major serioes steps for this!\r\n\r\nif we don\'t give focus on this problem and ignore it then this problem will backfire us too much in future!\r\n\r\nthis was all the probelm but what about the solution? \r\n\r\nso i\'ve some ideas for it which we can use .\r\n\r\nin this case i\'ve came up with some ideas! with this idea, i can\'t directly say that our economy will directly show boost. it is the long term process but once we did this then we\'ll have major matured, productive and hard working people! \r\n\r\nfirst thing which we need to tackle is the civic sense! \r\nthis is the root cause of india\'s bad impression on foreginers!\r\n\r\nand this is not the thing which can be fixed in a month or in an year! this will ofcourse take long time! \r\nbut we are countinosly ignoring it!\r\n\r\nso first we need to deal with this !\r\nfor this we need to make a very strict education system! \r\nwhere every teachers are being monitor by the government that they are teaching well or not and in case schools are taking it casually then government has full rights to suspend the schools for a certain time!\r\n\r\ni think we need to revive sanskrit and hindi again! \r\nwhat am i saying? hindi . we all speak hindi right?\r\nsadly our 90% of hindi are urdu!\r\nbut we all indian still think that we speaks hindi!\r\n\r\nthat is wrong!\r\n\r\nwait if we remove english then how would we survive? how we\'ll get employement! how we\'ll settel in USA UK?\r\n\r\nthis question is also important!\r\n\r\nif we look at china then everyone speak chinese their! no one speaks english their still the economy of china is $19.23 trillion USD . second largest! an no wonder if in future it beat the USA.\r\n\r\nso now the question isn\'t about if we remove english then how our economy survive! that thing is different that someone wants to go to USA, UK, KOREA , JAPAN or any other country and why they don\'t go! after all their eco system is best! they all deserve to live best!\r\n\r\nso the thing is can\'t we make our own eco system the best eco system! ofcourse we can.\r\n\r\nso we where talking about civic sence and removing english!\r\n\r\nonce we revived our sanskrit and hindi totally then we should be focusing on giving all book knowledge in only hindi and sanskrit both. pure hindi sanskrit! it will make knowledge for each and every people of india! after all elon musk gain most of his knowledge from books! who knows if elon musk were born in india then he could  never go that far which he did in USA cause their all space and each knowledge were in english!\r\n\r\nso we should be focusing to revive sanskrit and hindi! it will take ofcourse more then 10-15 years!\r\nbut why don\'t we start today!\r\n\r\nthis is the first step which we need to take, along with we have to take many steps more cause we can\'t wait 15 years then take step 2. after all we need to progress our country!\r\n\r\nonce we made education way more easier for each person then we\'ll have to look for the teachers! \r\n\r\nafter all\r\n\"Clay can be shaped only while it’s soft; once it’s hardened, you can’t change its form.\"\r\n\r\nit means we\'ll have to teach these all things which they are kids! \r\nonce they grown up then we can\'t put restriction to anyone which they are doing since childhood!\r\n\r\nthis is the thing!\r\n\r\nso does that mean only teachers and school are responsible for this civic sense? \r\nofcourse not totally! but somewhere yes!\r\n\r\nnow days as per my experience especially in government school. even i take example of delhi government school which everyone clam it\'s best! there as well i\'ve seen many teacher coming to class. sitting there and without teaching they are going! many of teacher even using rough words which we can\'t even expect from a person who live in slum! \r\n\r\nso we need to give serious trainning to the teacher . each and every teacher! no matter government teacher or private teacher! \r\n\r\ngovernment should have to take this very seriously!\r\n\r\nwe\'ll need to go for little dictatorship. \r\n\r\ni know this sounds very crazy! what dictatorship?\r\n\r\nno not! but ofcourse whoever (governemnt) will implement this that government will be called dictator!\r\nbut the thing we\'ll have to stand with that goverment! \r\n\r\nwhy am i saying so!\r\n\r\nthe reason is if we really wanna strict education system where teacher do they duty very seriosly then we\'ll have to give a device(made by government) which will be permanent on when teacher are teaching. \r\nwhat would be the working of the device: \r\nso that device will keep teacher name, school their identity! and record the teacher voice when they are teaching! this should be fundamental! \r\nin starting for cost issue! those teacher who are not able to buy the device they must have to go for the application which would be the similar to the device and teacher will login and start recording their!\r\n\r\nhow this will help! \r\nso students will have full rights to complaint against their school and any specific teacher without revealing their name. \r\n\r\nis this enough? the answer is no! \r\ngoverment will have to make a specific team or sector for this! this will increase the employement here! \r\n\r\nthat will be 24*7 service! when someone will complaint then that team will take instant action without further delay and see the recording and verify weather complaint is correct or not! in case complaint is incorrect then student will get score system for their compalint value that would be also written on their student card! \r\n\r\nso here every school will be transparent! \r\n\r\nand student will be also statisfied! this system should be availible in each and every school!\r\n\r\nthis is all about teacher and student transperency! \r\n\r\nevery teacher and student should have a card like we all have aadhar card.\r\nin the case of teacher card! \r\nthat card will hold the students rating which they have taught!\r\n\r\nso in future other school can see their rating before giving the job!\r\nand more can be stored on teacher card!\r\n\r\nabout student card! this is already in process by indian government but with this speed it will never be effective!\r\nstudent card should urgently provided to every student! \r\nthat card will hold a student every school, collage record!\r\n\r\ntheir every class marks!\r\ndosent\' matter UNIT exam or anual exam!\r\n\r\nand the complaint they have made to governemnt about teachers! how much they have given the fair complaint and unfair complaint!\r\nso students will not make any wrong aligation on any teacher!\r\n\r\ntheir should be a compulsary additional subject in school should be introduced which will teach the student about civic sense! \r\n\r\nin that subject we need to focus most on the student that they are learning and applying or not! that thing on government how they are dealing with it! but this is the most important step that students are taking that subject seriosly or not!\r\n\r\nthis would be easy to teach the student of kg to class 7th even but after that it would be even way more tough! now days!\r\n\r\nso this is how we gonna take an standard improvement in the education system! this will not only make civic sense better of future generation of india but also take many Entrepreneurs, innovators and way more people from india!\r\n\r\n----------------------------------------------------------------------------------------------------------------------------------------------------------------------\r\n\r\nis this enough?\r\nno ofcourse not!\r\nthis isn\'t enough!\r\n\r\nmany people are suffering from major distraction, addiction in our country! \r\nthe main addiction are:\r\nSocial media scrolling (Instagram, TikTok, YouTube Shorts — endless dopamine hits)\r\n\r\nBinge-watching (Netflix, web series, anime marathons)\r\n\r\nOveruse of smartphones (mindless checking, notifications every 2 min)\r\n\r\nPornography (linked to lust, but more specific)\r\n\r\nJunk food & sugary drinks (comfort eating)\r\n\r\nGambling / betting apps (including fantasy cricket, stock market hype without knowledge)\r\n\r\nDrugs, alcohol, smoking (substance abuse)\r\n\r\nAttention-seeking & validation addiction (likes, comments, followers)\r\n\r\nLet\'s talk about this social media,\r\nchina has their tik tok and many other platform.\r\nhow they work! \r\nplatform like tik tok where we see shorts that are called \"Douyin\" in china\r\nhow it works in china:\r\n\r\nDouyin in China: A Learning-Focused Feed\r\nYouth Mode Controls: On Douyin, minors under 14 are capped at 40 minutes per day, and access is blocked from 10 p.m. to 6 a.m. The feed is filled with educational content—science, history, art—to “inspire vocations” among youth.\r\n\r\nContent Quality: A study analyzed short videos on Chinese platforms (like Douyin), English, and Japanese platforms. It found that 85.7% of Chinese videos were deemed educationally “useful,” vs. only 65% for English and 36.7% for Japanese ones.\r\n\r\nthis was my example why china is world second most greater economy!\r\n\r\nthink if we implement these all then how much we can go far!\r\n\r\nso we need to talk with all forign platform like instagram, youtube etc to take same function in the application! \r\nand that should be must! instagram always give a small popup after 30 minute of reel watching but it\'s very small and people ignore it! but it shouldn\'t be ignored! it should be compulsary that no one would be able to watch reels after 30 minutes! \r\nand all reels should be releted to education, news but not should be releted to enter10ment!\r\n\r\ngovernment should fund our youth with a team for making our country own social media focus their most! somehow they should take all people on the same platform like youtube!\r\nonce this functionality will be introduced then it will also controbute in our economy! \r\nas per data - In Q1 2025, YouTube pulled in about $8.92–$8.93 billion solely from ad revenue\r\nso if we can make our own country app then we can be able to pull up so much from our own application only through ads! \r\n\r\nand their are many other feature we can introduce and earn!\r\n\r\nbut i don\'t know why government shamelessly ignoring these all things!\r\n\r\nso we should first strictly introduce our own application then ban forign application and take our all youth on our own platform and people can only join that app with verifying by their aadhar card! \r\n\r\nthis will verify the age of the person! and with the same app we should be able to use UPI and other!\r\n\r\nthis is my idea about social media problem!\r\n\r\nBinge-watching (Netflix, web series, anime marathons)\r\n\r\nwhen we talk about web series then their are alot of content which are influencing people to live that lifestyle which are full of myth where people waste their lifetime money for showing the other people that they are happy but they actually are not! \r\n\r\nthere are 18+ conetnt in most of the web series, netflix now days! \r\n\r\nwe seriosly  need to focus on this issue!\r\n\r\nbefore any movie release in india! that should follow india act laws!\r\nofcourse we need to remove britishers laws acts cause they are outdated and we need to come up with new act laws where should be strictly written that what content any moview web series can\'t add in their movie!\r\n\r\ntheir are big impact of movie web series on our youth! \r\n\r\nso it\'s a serios issue!\r\n\r\nif we talk about anime then it is upcomming most greater revenue source for any country!\r\nif we take example of japan:\r\nTotal Industry Revenue (2023)\r\nThe entire anime industry in Japan reached a record high of approximately ¥3.3465 trillion in 2023—that’s around $21 billion \r\n\r\nso we should fund to new companies for this industry and make such anime relted to history and fiction! \r\n\r\nthis is the best to way influence our youth easily so we should invest most here and make such story line which anyone love it!\r\n\r\ni don\'t have much words but it\'s should be a priority! \r\n\r\n---------------------------------------------------------------------------------------------------------------------------------------------------------------------\r\n\r\nOveruse of smartphones (mindless checking, notifications every 2 min)\r\n\r\nthis is also a serios issue! \r\neven if i ask chatgpt that if it would be suprime of india then what it would do to solve this issue then it knows but what about government?-\r\n1️⃣ Policy Level – Make It Hard to Get Hooked\r\nDigital Well-being Law:\r\nMandate all smartphones sold in India to have built-in daily screen time limits ON by default for minors (e.g., max 2 hours/day for entertainment apps).\r\n\r\nNotification Throttling:\r\nForce social media apps to batch notifications and send them only once every 30 minutes instead of instantly. (Stops dopamine spikes.)\r\n\r\nNo \"Infinite Scroll\" for Kids:\r\nLike China does with Douyin, enforce “youth mode” with educational content priority and no autoplay for under-18s.\r\n\r\nAd Tax on Addictive Apps:\r\nLevy extra digital tax on platforms that profit from excessive engagement without providing productive tools.\r\n\r\n2️⃣ Education Level – Train the Brain Early\r\nDigital Literacy in Schools:\r\nStart from Class 6 — teach kids how algorithms exploit attention, just like we teach how bacteria grow in biology.\r\n\r\n\"Focus Challenges\" in Class:\r\nWeekly no-phone study challenges in schools with small rewards (gamified discipline).\r\n\r\nPublic Awareness Ads:\r\nJust like anti-smoking campaigns, run relatable ads showing how phone overuse kills focus, grades, and real-life social skills.\r\n\r\n3️⃣ Tech Infrastructure – Design for Discipline\r\nGovt. “Focus App” (Free):\r\nOne national app pre-installed on all phones — blocks distracting apps during work/school hours and tracks “focus streaks.”\r\n\r\nISP-Level Filters:\r\nOption for parents to turn on “Study Mode Internet” that blocks entertainment sites during homework time.\r\n\r\nReward Programs:\r\nLink reduced screen time to govt. perks like extra library credits, student scholarship points, or fitness app vouchers.\r\n\r\nthese steps can be taken but why our government will think of these?\r\nthier kids are studying in forign schools. why they care about others?\r\n\r\n----------------------------------------------------------------------------------------------------------------------------------------------------------------------\r\n\r\nPornography (linked to lust, but more specific)\r\n\r\nthis is the one of the most serios issue nowdays!\r\n\r\ntheir are many website which are operating in india which is giving access of pornography content easily!\r\neven pornhub is banned in india but easily accessable through vpn!\r\n\r\nhow this is causing problem!\r\n\r\nIndia ranks among the top countries in online pornography traffic according to several public traffic lists and media reports, but ranking varies by source and metric (searches, site visits, time spent). Historic reports and aggregated lists often put India very high on the list. \r\n\r\nWhy it becomes a long-term problem (evidence-based harms)\r\nMultiple systematic reviews and studies link early or heavy exposure to pornography with real harms for young people and communities:\r\n\r\nMental health & behaviour: increased emotional problems, unrealistic sexual expectations, higher risk-taking sexual behaviour, and links to aggression in some studies. \r\n\r\nProblematic use / addiction-like patterns: a subset of users develop compulsive use that affects studies, relationships, and dating confidence. Recent cross-sectional studies show associations with anxiety, lower wellbeing and difficulties in relationships. \r\n\r\nSocial harms: objectification of partners, distorted consent understanding, and potential impacts on gender attitudes (evidence is mixed but concerning). Public-health framing treats this like a risk behaviour to reduce. \r\n\r\nSo it’s not just “moral panic” — there are measurable downstream effects, especially for adolescents whose brains and social understanding are still developing.\r\n\r\nas per data in india the age of 8-9 year kid are consuming the pornography content in india! this is the serioes issue!\r\n\r\ni don\'t say the sex education isn\'t good!\r\nit should be fundamental for everyone! but there should be a class and age for kids when to learn the things!\r\nin india our education system do not give sex education to kids! \r\n\r\nif any girl are in pain of periods then most of the boys compare themselves with girls pain!\r\n\r\nthey don\'t even dare to help any girl in this case! everyone are very shy to ask even for that help! this is the situation of india! it is ofcourse a issue but we are talking about the pornography conetnt\r\nit must be banned by every way!\r\n\r\nif we ask ai that how it solve this issue if it would be a PM:\r\nAs PM — practical, evidence-backed plan (no naive blanket ban)\r\nYes, we’d talk to ISPs — but a simple “block and pray” approach fails (people use VPNs, mirror sites, etc.), raises privacy/free-speech issues, and can harm legitimate sites. History shows India tried wide blocking in 2015 and faced backlash with limited lasting effect. Effective policy must be multi-pronged. \r\nThe Guardian\r\nAl Jazeera\r\n\r\nMy 6-point national strategy (fast → medium → long term)\r\n1) Protect kids first — mandatory age-assurance & default controls (fast)\r\n\r\nRequire platforms accessible in India to implement robust age verification or a government-certified “youth mode” that defaults ON for accounts flagged as minors.\r\n\r\nPre-install parental-control options on new devices sold in India; make activation simple.\r\n(Policy model used/considered in other countries; age-verification reduces accidental exposure). \r\nPMC\r\n\r\n2) ISP & platform partnership for targeted blocking (practical enforcement)\r\n\r\nWork with ISPs to block child-sexual-abuse material (CSAM) and known exploitative sites — strict, targeted enforcement for illegal content (not a blanket adult block).\r\n\r\nSet a legal standard and judicial oversight for what ISPs must block to avoid abuse/censorship. (Blocking only illegal content is defensible and harder to circumvent with legal tools for enforcement.) \r\n\r\n3) Education at scale (highest ROI for long term)\r\n\r\nAdd compulsory digital sexual literacy from middle school: content about consent, healthy relationships, how porn is staged/fictional, risks of compulsive use, and how algorithms push content.\r\n\r\nTrain teachers & parents with playbooks and “no-shame” conversation guides. Evidence shows education reduces harms and risky behaviors.\r\n\r\nthis is said by AI.\r\neven ai knows but government?\r\n\r\nas a CS student i would add in this!\r\nif any VPN wants to operate in india legally then it should follow this rule as well for pornography conetnt! otherwise vpn company can cause serioes issue!\r\n\r\n---------------------------------------------------------------------------------------------------------------------------------------------------------------------\r\nJunk food & sugary drinks (comfort eating)\r\n\r\nGambling / betting apps (including fantasy cricket, stock market hype without knowledge)\r\n\r\nDrugs, alcohol, smoking (substance abuse)\r\n\r\nAttention-seeking & validation addiction (likes, comments, followers)\r\n\r\nthese all are also a big issue! \r\n\r\n1️⃣ Junk Food & Sugary Drinks\r\nWhy it’s a problem: obesity, diabetes, poor focus in students. India’s youth sugar consumption is 2–3× WHO’s safe limit.\r\n\r\nPM Plan:\r\n\r\nSugar Tax 2.0 → Increase tax on sugary drinks & ultra-processed junk, use the revenue to fund free healthy school lunches.\r\n\r\nLabelling Law → Mandatory red/yellow/green warning labels (like tobacco warnings) for high-sugar/high-salt foods.\r\n\r\nAd Ban in Schools → No junk food advertising targeting children under 16.\r\n\r\nHealthy Canteens → Replace chips & sodas in school/college cafeterias with affordable healthier options.\r\n\r\n2️⃣ Gambling / Betting Apps (Fantasy Cricket, uninformed stock hype)\r\nWhy it’s a problem: youth debt, addiction, depression, risky financial habits.\r\n\r\nPM Plan:\r\n\r\nRegulatory License System → Only allow betting/fantasy platforms with strict daily spending caps, no credit cards allowed.\r\n\r\nKYC Age Gate → Mandatory age verification (18+), with AI detection for fake IDs.\r\n\r\nFinancial Literacy in Schools → Teach real investing & probability from Class 8 so kids understand “house always wins.”\r\n\r\nDark Pattern Ban → Outlaw manipulative notifications & “free bonus” tricks in gambling apps.\r\n\r\n3️⃣ Drugs, Alcohol, Smoking\r\nWhy it’s a problem: health damage, crime, school dropouts, dependency.\r\n\r\nPM Plan:\r\n\r\nTobacco & Alcohol Age Limit Enforcement → Real penalties for shops selling to minors, surprise raids.\r\n\r\nCampus Safety Task Force → Random checks + counselling for first-time offenders in schools/colleges.\r\n\r\nRehab over Jail → For non-violent drug offenders, mandatory rehab programs instead of prison.\r\n\r\nPublic Campaign → Youth-focused anti-drug ads using influencers, memes, and real-life survivor stories.\r\n\r\n4️⃣ Attention-Seeking & Validation Addiction (likes, followers, comments)\r\nWhy it’s a problem: anxiety, low self-worth, distraction from studies.\r\n\r\nPM Plan:\r\n\r\nHide Likes Option by Default → Make likes/views hidden unless user chooses otherwise (Instagram did partial, make it default in India).\r\n\r\nNotification Batch Law → Social apps allowed to send only one batch of non-urgent notifications every 30 minutes.\r\n\r\nDigital Well-being Education → Mandatory workshops in schools about algorithms, dopamine loops, and mental health.\r\n\r\n“Focus Hours” Challenge → Nationwide campaign where schools compete for max hours of no-social-media usage.\r\n\r\ni didn\'t talk about this issue cause i\'m about to talk something now which would directly solve this issue!\r\n\r\n----------------------------------------------------------------------------------------------------------------------------------------------------------------------\r\n\r\nmy own idea for NEW BHARAT\r\n\r\nnow i\'m gonna talk about police/cops of our country!\r\ndosen\'t matter cops of SI/SHO/CID/CBI or any department! this is about all!\r\n\r\ni\'ll come to this first we should introduce a system in every part of country! \r\nin every state in every district there should be multiple government -Bharat Suraksha Kala Kendra(\"India Defence Art Centre\")\r\n\r\nthis should be in big area and this should be compuslary for every kids whose age are between 7-25  untill or unless anyone is suffering physically.  \r\nnow why this?\r\n\r\nin india we are facing the fitness issue so much! ofcourse the reason is junk food, phone addiction and less workout!\r\n\r\nso by this we\'ll focus on everyone .\r\n\r\nso basically as written in our granth books!\r\n\r\n“Along with the mala (symbol of spirituality), knowledge of the spear (self-defence) is also necessary.”\r\n\r\nso we\'ll introduce swords system for each and every citizen of our country! especially for the person who are cops!\r\n\r\nnow here is a catch! if we give these kinds of dangrous weapon then people will kill each other. isn\'t it correct?\r\n\r\nyes it is and it will happen!\r\nagain there is a catch!\r\n\r\nNew Bharat Sword System\r\nTagline: \"A sword in the hand of the trained, discipline in the heart of the nation.\"\r\n\r\n⚔ 1. The 3-Phase Sword Training & Certification System\r\nPhase 1 – Beginner Level (Age 7–17)\r\nPractice Swords Only — blunt, lightweight, made of wood/polycarbonate.\r\n\r\nTeaches discipline, ethics, and control — when not to use weapons is as important as knowing how to use them.\r\n\r\nMulti-discipline combat training: karate, boxing, wrestling, archery, mixed martial arts.\r\n\r\nAnnual skill assessments ensure progress.\r\n\r\nNo Aadhaar link at this stage, but digital skill record will be kept in the national database.\r\n\r\nPhase 2 – Citizen Sword (Age 18+)\r\nIssued only after:\r\n✅ Skill test clearance\r\n✅ Moral evaluation\r\n✅ Physical fitness check\r\n\r\nNon-lethal sword — no sharp edges, but strong enough to immobilize attackers.\r\n\r\nSmart Features (Aadhaar-linked):\r\n\r\nGPS tracker (live location to govt servers).\r\n\r\nVoice recorder (auto-activated when sword is drawn).\r\n\r\nUnique serial number on sword & sheath.\r\n\r\nBiometric lock — only the registered owner can use.\r\n\r\nPublic verification portal — enter sheath’s serial number to see owner name & legal status.\r\n\r\nPhase 3 – Elite Swordsman\r\nFor those who master all combat forms — swords, archery, unarmed combat, tactical movement.\r\n\r\nMust pass Phase 3 Elite Combat Test (harder than police/army entry test).\r\n\r\nAwarded real sharpened combat sword + National Elite Badge of Honour.\r\n\r\nUnique sheath design — exclusive pattern only for elite holders.\r\n\r\nCarrying elite sheath without authorization = heavy fine + strict action.\r\n\r\nReassessment Rule:\r\n\r\nAny Level 2 swordsman can apply for reassessment to attempt Level 3 test.\r\n\r\n👮 2. Police & Armed Forces Integration\r\nPolice, army, and paramilitary must pass at least Phase 2 before joining service.\r\n\r\nElite (Phase 3) is preferred but not compulsory.\r\n\r\nEven citizens who reach Elite level can join later if they choose — not mandatory.\r\n\r\nAnnual combat re-certification to keep all officers fit and ready.\r\n\r\n💼 3. Elite Swordsman Job Portal\r\nGovernment-run online portal where:\r\n\r\nOfficials, companies, and security agencies can hire elite swordsmen for short contracts.\r\n\r\nAll assignments tracked and approved by government to prevent illegal use.\r\n\r\nElite swordsmen can live normal lives but can also earn extra by accepting official missions.\r\n\r\n📡 4. Aadhaar-Linking & Weapon Tracking System\r\nRegistration Process:\r\n\r\nApply online with Aadhaar e-KYC.\r\n\r\nSerial number & digital ID linked to Aadhaar in National Weapon Registry.\r\n\r\nGPS & voice recorder activated and bound to that user’s profile.\r\n\r\nTracking Tech:\r\n\r\nWireless charging while sword is in sheath.\r\n\r\nLow-power GPS + IoT SIM keeps sword online 24/7.\r\n\r\nMotion sensor activates tracking & recording only when drawn.\r\n\r\nAnti-tamper law — disabling the tracker is a criminal offence.\r\n\r\nPublic Portal:\r\n\r\nAnyone can check a sword’s ownership with the serial number.\r\n\r\n🏛 5. Bharat Suraksha Kala Kendras (India Defence Art Centres)\r\nOne centre in every district.\r\n\r\nIncludes:\r\n\r\nMartial arts halls\r\n\r\nObstacle courses\r\n\r\nWeapon training zones\r\n\r\nGyms & fitness tracks\r\n\r\nDigital progress tracking for every student.\r\n\r\nCompulsory attendance for ages 7–25 (unless medically unfit).\r\n\r\n🚨 6. Misuse Prevention & Law Enforcement\r\nIf sword is drawn in a restricted zone (schools, hospitals, airports) → instant alert to police.\r\n\r\nFirst offence = 10-year ban + fine.\r\n\r\nSecond offence = lifetime ban + criminal charges.\r\n\r\nAll swords monitored in real-time by central control centre.\r\n\r\n🌏 7. National Benefits\r\nHealth Revolution — Fit citizens reduce healthcare burden.\r\n\r\nCrime Deterrence — Criminals avoid trained people.\r\n\r\nCultural Pride — Revives India’s warrior heritage.\r\n\r\nBetter Police — Every officer is combat-ready.\r\n\r\nYouth Discipline — Reduces laziness & digital addiction.\r\n\r\n📜 8. Vision Statement\r\n\"In the New Bharat, every citizen will be a protector, every officer a warrior, and every sword a symbol of responsibility — not fear.\"\r\n\r\nsince our slogan is \"Maala ke sath bhhala ka gyan bhi avyasayak hai\" \r\n\r\nif we don\'t know even self defence then how will we protect anyone or our country at any attack !\r\n\r\ni think this should be done by our government! \r\n\r\nyeah they need to allocate alot fund for this program but once it is done then it will create so much employment from this and even people will start growing mentally and leraning discipline.\r\n\r\nthis isn\'t should be only compuslary for men but also for women!\r\n\r\nafterall in our history their are many female warrior like how can we forget our pride rani lakshmibai!\r\n\r\nmy idea is in little rough format but this can literally be a damnnnnnnnnnnn i don\'t even have the words!\r\n\r\nalong with it as previously i said we need to revive our sanskrit and hindi . then we\'ll have to only use anyone of them like maybe hindi on everything like medicine, books, and each and every product made in india! \r\n\r\nand i guess i don\'t need to explain this to matured people that why on medicine!\r\n\r\nin india there are alot of medicine where are written caution but sadly many of our indian people avoid that: reason? they don\'t understand english!\r\n\r\ni\'ve to add alot in this but i know that my voice will never reach to those people who actually can get these changes in our country and make it a new india where everyone are ready to protact not only ourseleves but also to them who are weak or need help!\r\n\r\nfor now that\'s it!\r\nif anywhere my spelling gets incorrect then ignore it cause i\'m also a human and writting it so fast .', 'new-bharat-1754907771', 'https://readxhub.in/blogs/post.php?slug=new-bharat-1754907771', '2025-08-11 10:22:51', 'adarsh.singhvishnu@gmail.com', 4, 1, 2, 0),
(31, 'SWATANTRATA', '', '', 'SIDDHARTH', ' Zindagi apne raaz khul ke nahi batati.\r\n\r\nWoh un logon ko chhupke se inaam deti hai jo dekhne ka hunar rakhte hain.\r\n\r\nBaaki log bas waqt ke saath chal dete hain — ya toh kal ke afsos mein, ya kal ke sapnon mein.\r\n\r\nPar jo log aaj ke ek pal ko mehsoos kar lete hain,\r\n\r\nwoh samajh jaate hain ki asli sukoon ka rang kya hota hai.\r\n\r\n\r\n\r\nYeh rang shor mein nahi, shaanti mein milta hai.\r\n\r\nNa kisi race jeetne mein, na kisi saboot dene mein…\r\n\r\nWoh sukoon tab milta hai jab aap ek pal ko poore dil se jeete ho.\r\n\r\nJab tirange ki shaan ko dekh kar aap ke shabd khud thher jaate hain…\r\n\r\n\r\n\r\n\r\n\r\nZindagi ka asli sauda yahi hai — chhoti cheezon mein bade arth dhoondhna.\r\n\r\nAur jab yeh aadat ban jaati hai, toh aap samajh jaate ho ki sukhi hone ke liye\r\n\r\nduniya ka sab kuch paana zaroori nahi…\r\n\r\nbas uss ek pal ko mehsoos karna zaroori hai jo aapke dil ke andar goonjta rahe.\r\n\r\n\r\n\r\nAur shayad isi liye, aaj ke din — jab hum apni azaadi ka jashn mana rahe hain —\r\n\r\nAur yaad rahe, azaadi sirf kagaz par likhi hui ek tareekh nahi hoti,\r\n\r\nbalki ek ehsaas hota hai jo har dil me zinda rehna chahiye.\r\n\r\nJab desh ka har nagrik moh, swarth aur bhay ke bandhan tod deta hai…\r\n\r\ntab hi woh sach mein azaad hota hai.*', 'swatantrata-1761235115', 'https://readxhub.in/blogs/post.php?slug=swatantrata-1761235115', '2025-10-23 15:58:35', 'siddhujatav16@gmail.com', 1, 1, 1, 0),
(32, 'BHRAM-LOK', '', '', 'SIDDHARTH', '  AUTOBIOGRAPHY PART-3\r\n                                                       \" BHRAM-LOK \"\r\n\r\n\"Kabhi kabhi lekhak bhi unhi uljhanon ka shikar ho jaate hain, jinke baare mein woh likh rahe hote hai. Likhnay ki kala ke saath \r\nek bojh bhi judta hai — apne hi sochon ke jaal me phans jaane ka.  jab tak kisi vishaya ka  asli arth hi khoja na jaaye.\r\n Aur isi anubhav ke beech se janm leta hai yeh vichaar… jo insaan aur uske aanubhavon ke asli roop ko \r\nsamajhne ki ek sajag koshish hai.\"\r\n\r\n \r\n*\"Insaan aur janwar ke beech ek badi line kheenchti hai — emotions. Janwar apne emotions ko seedhe aur pure tarike se dikhate hain,\r\n lekin insaan apni buddhi aur soch ke jaal me ulajh jaata hai. Aur wahi buddhi, jo ek vardaan honi chahiye thi, kabhi kabhi ek abhishap\r\n ban jaati hai. Us abhishap ka naam hai — Overthinking.\"*  \r\n\r\n---\r\n\r\nInsan or janvar ko alag bnane wale ankek guno me se ek goon hai bhavnaye janvaro me jo bhavnaye hoti hai wo pure hote\r\n wo poorna tah saach or saaf hoti hai parantu insano me esa ni hai sab se jyda buddhiman hone ki wjah se ya yu kahe ki ye\r\n ek abhishrap bn jata hia aaj ke daur me aneko bar hm esi chijo ke liye pareshan hote hai jika vastvikta se koi nanta\r\n nhi hota ham aadik sochne ki  wajah se ek bhramk duniya me pravesh kr jate hia or uski me ulajh kr reh jate hai or isi\r\n wajah se jo hmare emotions hote hai we sacche ho kar bhi sacche nhi hote hmari aneko bhavanye chintaye aashaye or\r\n nirashaye vyarth ki hoti hai. jo vastav me kabhi hua hi nhi uska vismaran kar ke hm jo bhav utpan krte hai aakhir unka kya mol.\r\n aakhir kyu hia manshusya itna vichitra??\r\n iska karan hai overthinking aaj ki generation ko vastav me overtinking ki bimari si ho gyi hai or esa hua hai jarurat se jyada\r\n jankari unke pass bahut kam samy me pahuchne ke karan ye exitment se insan ko bhar deta hai jis se vyakti overtinkig krne\r\n lagta hia or bhatak jata hia apne marg se is se bachne ka ek hi marg hai or vo yah hai ki deemag ko utni hi imformation \r\ndena jo ki woh process kr paye jarurat se jyada ya apne karyshetra se bhar ki jankar agr deemag tak pahuchegi toh woh turant \r\nkam se bhatak jayega ye pure vishva ki bahut badi aabadi ki samsya hia purantu yeh chota sa upay krne se is bimari se bacha \r\nja sakta hai. \r\n\r\n---\r\n*\"Toh kya yehi hai insaan ki sabse badi vidambana — ki uske emotions sachche hote hue bhi sachche nahi lagte? Jab soch reality se \r\nkat jaati hai aur bhram ki duniya me ghus jaati hai, tab insaan apne hi jaal me phans jaata hai. Overthinking se bachne ka ek\r\n hi raasta hai: apne dimaag ko utna hi bojh dena jitna wo sambhal sake. Jab soch santulit hoti hai, tabhi emotions shuddh hote\r\n hain… aur tabhi jeevan apne asli arth me jeeya jaa sakta hai.\"*  \r\n\"Aur ab yeh vichaar apne ant ki or badh raha hai… par kahani yahin khatam nahi hoti. Agle bhaag me hum ek naye pehlu ki khoj karenge — \r\njahan soch aur bhavnaayein ek aur roshni lekar aayengi.ek naye najariye ke saath \r\n Tab tak ke liye, apne man ko shant rakhiye aur apne emotions ko samajhne ki koshish jaari rakhiye.\r\n\r\nThank you for giving your precious time to us.\"*', 'bhram-lok-1764348119', 'https://readxhub.in/blogs/post.php?slug=bhram-lok-1764348119', '2025-11-28 16:41:59', 'siddhujatav16@gmail.com', 0, 1, 1, 1),
(42, 'Introduction to accessibility testing', 'This blog provides an overview about the basics of accessibility testing & it\'s fundamental principles.', 'Accessibility testing, accessibility, testing, testing of accessibility, learning by disha, learning accessibility, disha learning, how to do accessibility testing', 'Disha', 'Introduction:\r\n\r\nIn this digital world, we are a lot dependent on online platforms. Whether we access educational content, Ecommerce website, or to just for entertainment, we are mostly on our phones or pcs.\r\n\r\nSince every thing has become digital, we must ensure that everyone is able to access the digital upgrade. Accessibility makes sure that not to exclude any buddy. Whether it’s a person with visual disability, hearing disability, or any other disability, we must ensure that every one is able to access the content on the web and interact without any barrior.\r\n\r\nWhat is accessibility testing:\r\n\r\nIt refers to a test the websites and applications, whether they are accessible through screen readers or any assistive technologies on all operating systems and any person with any disability is able to access all the digital tools just like others.\r\n\r\nWCAG:\r\n\r\nWCAG (web content accessibility guidelines) are the guidelines provided by W3C to ensure that companies build accessible products.\r\n\r\n It has major 4 principles;\r\n\r\nPerceivable; it ensures that the content is easily accessible.\r\n\r\nOperable; the website is easy to navigate.\r\n\r\nUnderstandable; the content is easy\r\n\r\nTo understand.\r\n\r\nRobust; it ensures that the website is accessible across all assistive technologies.\r\n\r\nIf we want to make the\r\n\r\nSoftware accessible, it must comply with principles of WCAG and pass the success criteria.\r\n\r\nLevels of accessibility:\r\n\r\nA level; in this level the website is least accessible for the users.\r\n\r\nAA level; it is considered a good level of accessibility level. Most companies use this level of accessibility in their software.\r\n\r\nAAA level. Its highest level of accessibility which is not seen generally and using this level of accessibility can lead to a lot of changes in UI UX of the website, due to which its not much preferred.', 'introduction-to-accessibility-testing-1768320908', 'https://readxhub.in/blogs/post.php?slug=introduction-to-accessibility-testing-1768320908', '2026-01-13 16:15:08', 'dishayadav545@gmail.com', 0, 1, 0, 0),
(43, 'What is Android accessibility', 'Certical contains the major aspects which are to be tuesday in Android accessibility testing.', 'Android, accessibility testing,', 'Disha', 'Android accessibility testing:\r\nAs everyone does not interact in the same way with smart devices as we do, so accessibility brings a fairness for the people with different disabilities, such as visual impairment, cognitive disability, or any other disability, it should be insure that each and everyone is able to access the content of this digital world as everyone else does. \r\nAndroid accessibility testing can help in identifying the problems related to accessibility and resolve it to make the experience of the users seamless through their apps. \r\nThe aspects to test:\r\nProper labelling:  the images and buttons should be labelled correctly. This makes it easier for the people to navigate through the application with screen readers\r\nColour contrast: a proper colour contrast makes it easier for reading the text and using the application in extreme conditions, like in daylight during outdoors.  It should be made sure that the app has a good colour contrast in both dark mode, & light mode. \r\nTouch targets: the interactive elements of an application should have an enough size which is reachable for the users. People with mobility disabilities can face difficulty if the button size is smaller.  People with low vision, even normal people who have large fingers, if there walking, aur travelling, can face difficulty if the touch targets are smaller. \r\nUsing accessibility services: by using accessibility services, such as talk back, switch access, it can be experienced whether an application is accessible for the people who use the services or not. It must be checked that all actions in the application are easily accessible through the services.', 'what-is-android-accessibility-1769190101', 'https://readxhub.in/blogs/post.php?slug=what-is-android-accessibility-1769190101', '2026-01-23 17:41:41', 'dishayadav545@gmail.com', 0, 1, 1, 0),
(44, 'Introduction to Web development', 'This blog mainly focuses on the over view & a basic understanding about web development.', 'Website, web development, html', 'Disha', 'Introduction:\r\n\r\nWe use various websites in our daily life for different purposes. These are created using a process called web development.\r\n\r\nWeb development:\r\n\r\nIt’s a process of developing websites which can be accessed on any internet browser.\r\n\r\nIt is platform independent, can be accessed on any device, such as a computer, laptop, smart phone. It has a wider audience, since accessing websites is easier because of its compatibility with different devices.\r\nIt contains mainly 2 parts;\r\n\r\n Front end: \r\n\r\nIt is the basic structure of a website. It is built using HTML, CSS & java script. It is basically what a user sees while using the website.\r\n\r\nHTML is used to make basic structure of the website. CSS is used to style the page, so that it looks attractive. Java script adds interactivity to the web page.\r\n\r\n  Back end:\r\n\r\nIt is the server part of the website. It is made to manage the data, to run the logic & it is not visible to the users.\r\n\r\n The back end is made using PHP, python etc. Various frameworks are used, such as jango etc. Data bases are managed Using, MongoDB.\r\n\r\nFront end and back end combine together and form a website.\r\n\r\nPeople who manage and develop front end, they are known as front end developers & people concerned with back end management, are known as back end developers.\r\n\r\nFull stack developers are those who keep their expertise in both front end, as well as back end.\r\n\r\n[youtube:S3bg7Y3dfbU]', 'introduction-to-web-development-1769276377', 'https://readxhub.in/blogs/post.php?slug=introduction-to-web-development-1769276377', '2026-01-24 17:39:37', 'dishayadav545@gmail.com', 1, 1, 3, 1),
(45, 'Why Organisation Choose Semiconductor', 'Why the big companies and Organisation always choose semiconductors', 'Semiconductors, conductors, insulator', 'Srishti', 'Hello everyone this is Srishti and today we will know detail about the semiconductors that why company is prefer semiconductor more and will know every concept of semiconductor the first we will start from the electronic device.\r\n\r\nElectronic device: An electronic device is one in which the flow of charge carriers (electrons and holes) is controlled.\r\n\r\nClassification of the solids on the basis of their electrical properties:\r\nMetals have low resistivity and high conductivity.\r\n\r\nInsulators have high resistivity and low conductivity.\r\n\r\nSemiconductors: they passes resistivity or conductivity intermediate to metals and insulator.\r\n\r\nProperties of semiconductors: \r\n\r\n1. Semiconductors have a much higher resistivity then metal \r\n2. Semiconductor have a temperature coefficient of resistivity (alpha) that is both negative and high. That is the resistivity of semiconductor decreases rapidly with the temperature while that of metal increases.\r\n\r\nShow the main reason why companies and Organisation prefer semiconductor is :\r\nCompanies prefer semiconductors because:\r\nConductivity can be controlled (using doping, electric field, temperature)\r\nThey can form devices like:\r\nDiode\r\nTransistor\r\nIC chips\r\nThey are the foundation of:\r\nMicroprocessors\r\nMicrocontrollers\r\nComputers\r\nSmartphones\r\n\r\nSemiconductors are preferred because their conductivity can be precisely controlled, making them ideal for electronic switching and amplification.\r\nTypes of semiconductors:\r\nIntrinsic\r\nExtrinsic\r\nDoping:\r\nn-type\r\np-type\r\nCharge carriers:\r\nElectrons\r\nHoles\r\n\r\nSemiconductors are widely used because their conductivity can be controlled by doping and external voltage. This property makes them essential for manufacturing diodes, transistors, integrated circuits, microprocessors, and modern electronic devices.\r\n..\r\n\r\nIn upcoming articles we will no more about such topics which is useful related to hardware and software and the integration of hardware and software.', 'why-organisation-choose-semiconductor-1769325487', 'https://readxhub.in/blogs/post.php?slug=why-organisation-choose-semiconductor-1769325487', '2026-01-25 07:18:07', 'adarshsingh22042006@gmail.com', 12, 1, 4, 0);
INSERT INTO `blog_posts` (`id`, `title`, `description`, `keywords`, `author`, `content`, `slug`, `url`, `created_at`, `email`, `views`, `notifications_sent`, `likes`, `dislikes`) VALUES
(48, 'Overview of Indian Economy (NIOS Class 12 Economics Chapter 1 Explained)', 'Learn the fundamentals of the Indian Economy, its historical background, major characteristics, and economic development after independence. This beginner-friendly NIOS Class 12 Economics Chapter 1 tutorial simplifies important concepts for exam preparation.', 'nios economics, class 12 economics, overview of indian economy, indian economy notes, nios 318, indian economy tutorial, indian economy explained, economics chapter 1, nios exam preparation, indian economy features', 'GDR', 'Hi guys,\r\n<br />\r\nIt\'s me, GDR.\r\n\r\nI was studying economics, so I was wondering that I\'m a person who always forgets the things whatever I study. <br />\r\nSo what can be the method where I can study and remember it for a long time? Then I came across an idea or solution to write whatever I learn, and I found this blog website as the best option. \r\n<br />\r\n<br />\r\n\r\nSo from now on, whatever I study, I\'ll teach you guys.\r\n<br />\r\nThe topic is overview of the economy.\r\n<br />\r\n\r\nAfter completing this lesson, you will be able to:\r\n<br />\r\ndescribe the characteristics or features of Indian economy.\r\n\r\nexplain the problems faced by Indian economy.\r\nexplain the role of agriculture in India; and\r\ndescribe the growth of industry in India\r\n\r\n\r\n<br />\r\n\r\nOkay, so most of us feel economics is a boring thing, but do you know that economics is the only thing that runs every country? \r\n\r\nOkay, didn\'t understand?\r\nlet\'s understand it in simple words.\r\n<br />\r\n\r\nLet me give you a basic funny definition of economy. \r\nThe giant Whatsapp group of a country called \"Money, Power & Things\"\r\n\r\nOkay, still didn\'t understand?\r\nSo you see, the money, power and things (assets) of the country run the country? isn\'t it?\r\n\r\nAn economy is simply the following: \r\nThe system that answers 3 questions:\r\nWho makes things?\r\nWho buys things?\r\nWho earns the money?\r\n\r\nOr even simpler:\r\n\r\nHow a country earns money, spends that money, makes stuff and survives.\r\n\r\nI guess this is more than sufficient to know about what an economy is.\r\nIsn\'t it 🧃?\r\n\r\nThink of India as a huge game. \r\nPeople = Player\r\nGovt = Game Admin\r\nBusiness =  Shops\r\nMoney = Points\r\nRoads, internet, electricity -> Game map\r\n\r\nIf everything works smoothly, then the economy grows; otherwise, hehehhehe, you know right?\r\n\r\nOkay, let\'s understand that what the factor of the economy are. <br />\r\n\r\n# People\r\nOf course, First is always <br/>\r\n### People\r\nNo people means no workers, and no workers mean no customers. \r\nUmm, for example...\r\n\r\nWho buys butterscotch if no one exists?\r\nIsn\'t it 🧃?\r\n\r\n# Money\r\nMoney keeps moving \r\nYou buy food  -> Shopkeeper earns -> Shopkeeper pays employee -> Employees buy things.\r\n\r\nAnd this cycle runs the economy.\r\n\r\nMoney is like the blood in the human body.\r\n\r\nIf blood stops moving -> You are done for....\r\n\r\n# Business\r\nBusiness makes product and provide services\r\n\r\nExample:\r\nTata\r\nReliance \r\nReadXHub\r\nLocal chai vendors\r\n\r\nOh, did i add something odd? Well, I don\'t think so\r\nmuhehehehee\r\n\r\nWithout business, people would have nothing to buy anything.\r\nWell, it means we should sometimes be grateful to business owners...\r\n\r\n\r\n# Government\r\n\r\n### Government is the referee 🏁.\r\n\r\nIt: \r\n\r\n- Builds Road\r\n- Make Rules\r\n- Collect taxes\r\n- Builds schools and hospitals\r\n\r\n# Resources\r\n\r\nThings we use to produce goods.\r\n\r\nFor example:\r\n- Lands\r\n- Water\r\n- Iron\r\n- Coal\r\n- Forests\r\n\r\nNo resources = No production\r\n\r\n\r\nAnd finally, last but not the least \r\n\r\n# Technologia\r\nTechnology makes work faster.\r\n\r\nExample:\r\n\r\nUsing Excel instead of writing huge calculations by hand.\r\n\r\n\r\nSo if i put economy in simple words, then it is something when a normal person wake up in the morning, eats the Butterscotch and then complaint about its price, and then work for entire day and sleeps, and like this, the whole economy keeps running\r\n\r\n\r\n<br />\r\nWell, since I\'m from India, I guess I should list the Indian economy features as per current data:\r\n\r\n- Mixed economy\r\n- Fast-growing economy\r\n- Large population and workforce\r\n- Strong service sector\r\n- Agriculture remains important\r\n- Rapid digital transformation\r\n- Expanding infrastructure\r\n- Growing manufacturing sector\r\n- Income inequality challenges\r\n- Increasing global influence\r\n\r\nLet us understand these one by one:\r\n\r\n### Low Per Capita Income\r\nSee, as an Indian it is difficult to acknowledge, but India is still considered a country with a relatively low per capita income compared to many developed countries.\r\n\r\nOkay, I know, I know, don\'t ask me that, bruh. What the heck is this per capita income? But I\'m pretty sure that you must have heard of this term, \'per capita income\'...\r\ndidn\'t you?\r\n\r\nBut let me explain it...\r\n\r\nPer capita income is like the total income of a country divided by the total number of people in the country.\r\n\r\nThis is the simplest definition.\r\n\r\nIt tells us how much money each person would get on average if everyone\'s income were shared equally.\r\n\r\nImagine 5 friends earn a total of ₹500.\r\n\r\nTotal income = ₹500\r\nTotal people = 5\r\n\r\nPer capita income = ₹500 ÷ 5 = ₹100\r\n\r\nThis does NOT mean everyone actually has ₹100.\r\n\r\nMaybe:\r\n\r\nRahul has ₹300\r\nAman has ₹150\r\nPriya has ₹50\r\nTwo friends have ₹0\r\n\r\nBut on average, it\'s ₹100.\r\n\r\nFormula\r\nPer Capita Income = Total National Income ÷ Total Population\r\n\r\n\r\nOkay, now let\'s understand that low per capita income.\r\nWait, why even need to understand?\r\nDidn\'t you figure it out till now?\r\nhehehehe... no worries, let\'s understand it together 😭.\r\n\r\nnot enough smart haa?\r\n\r\nOkay, let me explain\r\n\r\nWhen India\'s total income is divided among its huge population, the average income per person becomes relatively low.\r\n\r\nofc..\r\n\r\nOkay, so we got that much, huh...\r\n\r\nNow let\'s see the data about India and what it says.\r\n\r\n\r\nAs per the latest data, India\'s per capita net national income for 2024-25 was about ₹205,000 per year; officially, this means in a month it\'s around something like ₹17k per month, roughly.\r\n\r\nwhich is so low as per current stuff....\r\n\r\nespecially after these wars...\r\n\r\nOkay, why this war affects any economy, we\'ll understand in an upcoming blog.\r\n\r\nBut let\'s have some comparison with biggest giants Like USA & China\r\n\r\nSo the USA\'s per capita income is roughly 33 times higher than India\'s, and China\'s is about 5.3 times higher. <br />\r\nso we can assume our situation by this...\r\nSuppose India\'s per capita income is represented as ₹100; then the USA\'s per capita income would be roughly ₹3300 and China\'s would be roughly ₹530.\r\n\r\n<br/>\r\n# Heavy population pressure\r\nNow let\'s talk about something that every Indian experiences every day...\r\n\r\n### Population:\r\nIndia officially overtook China and became the world\'s most populated country. \r\n\r\nAs per the current estimate, India\'s population is around 1.46 billion (146 crore+) people.\r\n\r\nSounds cool, right?\r\nWell... yes and no.\r\n\r\nSee, having a huge population is both an advantage and also a disadvantage.\r\n\r\nLike in a squad match of PUBG or Free Fire, the more team members you have, the more chances there are of you winning.\r\nisn\'t it?\r\n\r\nSame things here...\r\n\r\nMore population means the following:\r\n- More workers\r\n- More customers \r\n- More Ideas\r\n- Bigger market\r\n\r\nThis is actually one of India\'s biggest strengths.\r\n\r\nBut, but, but.\r\n\r\nAnd of course there are always but\r\n\r\nIf jobs don\'t increase at the same speed as the population, then problems start appearing.\r\n\r\nImagine you have 10 pizzas. (Just imagine – don\'t buy; well, you can\'t even buy.)\r\nInitially there are 5 friends\r\n\r\nEveryone is happy (happie happie happie)\r\nNow suddenly 50 more friends arrived, but the pizza is the same then?\r\n\r\nHehehe, what would you do...?\r\n\r\nThis is exactly what population pressure means.\r\n\r\nI guess some people still have no awareness about what condoms are...\r\n\r\nJust for their fun, they bring innocent babies into this hell world, and then that innocent baby suffers the torture.\r\n\r\nThere are more people competing for the same resources.\r\n\r\nResources like:\r\n- Jobs\r\n- Houses\r\n- Water\r\n- Electricity\r\n- Hospitals\r\n- Schools\r\n- Public Transport\r\n\r\nThis puts pressure on the government because it has to build enough infrastructure for everyone.\r\n\r\nYou might have already seen this around you.\r\n\r\nLong traffic jams 🚗.\r\n\r\nCrowded metros 🚇.\r\n\r\nHuge competition in exams 🥲.\r\n\r\nWaiting lines everywhere 😭.\r\n\r\nYup... population pressure.\r\n\r\nNow don\'t misunderstand me.\r\n\r\nPopulation itself is NOT the problem.\r\n\r\nA population without enough opportunities is the problem.\r\n\r\nCountries like China, the USA and Japan also have huge populations.\r\n\r\nWait, did I really say Japan?\r\nOops, my bad.\r\n\r\n\r\nThe difference is how efficiently jobs, industries and infrastructure are created.\r\n\r\nSo the goal is not to reduce people.\r\n\r\nThe goal is to create enough opportunities for people.\r\n\r\nIn simple words:\r\n\r\nMore people + More opportunities = Economic growth. 📈\r\n\r\nMore people + Fewer opportunities = Economic pressure 📉\r\n\r\nAnd yes...\r\n\r\nEvery Indian has already experienced this pressure at least once while standing in a queue somewhere 😭😂.\r\n\r\n## Dependence on Agriculture 🌾\r\n\r\nOkay, last but not least (outdated dialogue)\r\n\r\nLet\'s talk about agriculture.\r\n\r\nYou must have heard this sentence\r\n\r\nIndia is an agricultural country.\r\n\r\nAnd honestly... It is true to a certain extent.\r\n\r\nEven today a huge number of Indians are directly dependent on agriculture for their livelihood.\r\n\r\nNow here is an interesting part...\r\nAgriculture gives jobs to a lot of people, but it doesn\'t contribute to the economy in the same proportion. \r\n\r\nConfused?\r\nLet me explain hehehhe\r\n\r\nSuppose there are 100 people.\r\n\r\nAround 40-50 people are working in agriculture.\r\n\r\nBut agriculture contributes only around 15-18%  to India\'s economy (GDP)\r\n\r\nWhich means...\r\n\r\nMany people are working, but the amount of money generated per worker is relatively low.\r\n\r\nNow why does this happen?\r\n\r\nThere are multiple reasons:\r\n\r\n1. To many people are dependent on small amount of land\r\n\r\nImagine 10 brothers inheriting 1 farm.\r\n\r\nAs generations pass, the same land gets divided into smaller and smaller pieces.\r\n\r\nIsn\'t it funny?\r\nOh shit, I wonder why my family got such small lands.\r\n\r\nsed...\r\n\r\n2. Lack of technology\r\nMany farmers still have no access to the latest technology/machines for their work, like modern irrigation systems and advanced farming methods.\r\n\r\n3. Dependence on monsoon\r\nAlthough irrigation has improved a lot, many areas still heavily depend on rainfall.\r\n\r\nLess rain = less crop production.\r\n\r\n4. Low productivity\r\nProductivity simply means:\r\nHow much output can you produce from these resources you have?\r\n\r\n5. Lack of education and training 📚\r\n\r\nModern farming requires knowledge about soil, fertilisers, machinery and market demand.\r\n\r\nNot every farmer gets access to proper training. \r\n\r\nBut wait...\r\nDon\'t think agriculture is weak or useless.\r\n\r\nAgriculture is literally pillars of India and the world.\r\n\r\nOtherwise, humankind is done for.\r\n\r\nIt feeds 1.4 billion people every day in India.\r\n\r\nWithout farmers...\r\n\r\nNo wheat 🌾.\r\n\r\nNo rice 🍚.\r\n\r\nNo vegetables 🥔.\r\n\r\nNo fruits 🍎.\r\n\r\nNo food 😭.\r\n\r\nThe real challenge is not agriculture itself.\r\n\r\nThe challenge is increasing productivity and making farming more profitable.', 'overview-of-indian-economy-nios-class-12-economics-chapter-1-explained-1782314421', 'https://readxhub.in/blogs/post.php?slug=overview-of-indian-economy-nios-class-12-economics-chapter-1-explained-1782314421', '2026-06-24 15:20:21', 'adarshfinalchannel@gmail.com', 1, 1, 5, 0);

-- --------------------------------------------------------

--
-- Table structure for table `blog_reactions`
--

CREATE TABLE `blog_reactions` (
  `id` int(11) NOT NULL,
  `blog_id` int(11) NOT NULL,
  `user_email` varchar(255) NOT NULL,
  `reaction` enum('like','dislike') NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `blog_reactions`
--

INSERT INTO `blog_reactions` (`id`, `blog_id`, `user_email`, `reaction`, `created_at`) VALUES
(1, 31, 'd63c544419abd00383bd11cd34e1c545d2018f85da13f6b2dc90aa26b4ec2a67', 'like', '2026-06-23 11:20:12'),
(2, 45, 'd63c544419abd00383bd11cd34e1c545d2018f85da13f6b2dc90aa26b4ec2a67', 'like', '2026-06-23 11:20:15'),
(3, 13, 'f6a0062d5232d5882734a4f8e8d319491235493778c5afa313bb7a24f7832f84', 'like', '2026-06-23 13:37:10'),
(4, 13, 'd7d9218894f6351f64a9aedd5aa94316cf2e4cddbb82adcd3a845ffa4a36b476', 'like', '2026-06-23 13:38:04'),
(5, 45, '5ad1d62f0823dd5d91a8bd49fd2944584f3209c995da59b48c0f19a44a900370', 'like', '2026-06-23 14:04:49'),
(6, 32, '5ad1d62f0823dd5d91a8bd49fd2944584f3209c995da59b48c0f19a44a900370', 'dislike', '2026-06-23 14:05:03'),
(7, 32, 'fa7839c8f15befee01517a436197680c26abd4c73bd3c218c828349a8e7b7a1b', 'like', '2026-06-23 14:09:34'),
(8, 45, 'adarsh.singhvishnu@gmail.com', 'like', '2026-06-23 14:37:08'),
(9, 45, '4e18e07e9452a5fcd7809c4e87b571fbef8552de40a3ec3a60619f23d7abe4a3', 'like', '2026-06-23 17:45:28'),
(10, 43, '4e18e07e9452a5fcd7809c4e87b571fbef8552de40a3ec3a60619f23d7abe4a3', 'like', '2026-06-23 17:45:48'),
(11, 27, '7eec1e37473cf49528de9893303fb8bffb04d2de91a7f68bae60d6eac3167c33', 'like', '2026-06-24 02:49:46'),
(12, 27, 'f9cbae01d0db520f9b4bcd9fe1ba3610579f32fd29b2fbd5a2fe4c73851040cc', 'like', '2026-06-24 05:52:53'),
(13, 19, 'f9cbae01d0db520f9b4bcd9fe1ba3610579f32fd29b2fbd5a2fe4c73851040cc', 'like', '2026-06-24 05:53:03'),
(14, 44, '94b2a7e2ef09c84907dac410b2d604392d086d336894e7e390e58142c600362c', 'dislike', '2026-06-24 05:55:52'),
(15, 44, '5cb3b74826385456fceb79c1e67370c0efe0b946fe583bc04b77f860d2809d36', 'like', '2026-06-24 05:57:19'),
(16, 44, '8ea0fef08118b4664f0523583bbb4565d49129908c5bc53c90fb2c19555e5e6c', 'like', '2026-06-24 05:58:12'),
(17, 44, 'efc14871d52426383a56cae1161490ed2cd26cee2ebd27d4e158280c0177e143', 'like', '2026-06-24 05:58:16'),
(18, 19, 'adarsh.singhvishnu@gmail.com', 'like', '2026-06-24 08:31:28'),
(19, 48, 'adarsh.singhvishnu@gmail.com', 'like', '2026-06-24 15:27:30'),
(20, 48, 'prithv.x0000@gmail.com', 'like', '2026-06-24 15:29:42'),
(21, 48, 'rohantayade09@gmail.com', 'like', '2026-06-24 15:35:42'),
(22, 48, 'pm9825167@gmail.com', 'like', '2026-06-24 15:39:06'),
(23, 48, 'sophie.belle334477@gmail.com', 'like', '2026-06-24 20:58:29');

-- --------------------------------------------------------

--
-- Table structure for table `blog_views`
--

CREATE TABLE `blog_views` (
  `id` int(11) NOT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `viewed_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `blog_views`
--

INSERT INTO `blog_views` (`id`, `ip`, `slug`, `viewed_at`) VALUES
(9218, '139.5.242.40', 'talking-to-a-fish-in-an-aquarium-1751185246', '2025-07-23 14:09:14'),
(9219, '139.5.242.40', 'hey-guys-1753279958', '2025-07-23 14:14:37'),
(9220, '139.5.242.40', 'alien-s-attack-1751009602', '2025-07-23 14:15:00'),
(9223, '139.5.242.40', '-1753081731', '2025-07-23 14:15:57'),
(9235, '139.5.242.40', 'staged-lives-1751185306', '2025-07-23 14:47:06'),
(9239, '139.5.242.40', 'life-of-an-iit-aspirant-a-rollercoaster-ride-1750678198', '2025-07-23 17:39:16'),
(9240, '2409:40d0:11fd:f1d8:8000::', '-1753081731', '2025-07-23 19:49:00'),
(9244, '2409:40d0:11fd:f1d8:8000::', 'staged-lives-1751185306', '2025-07-23 19:50:18'),
(9245, '2409:40c4:28d:26c:c94d:bd3d:6374:a4e2', 'pratyavaran-1750673649', '2025-07-24 00:06:14'),
(9246, '2409:40c4:28d:26c:dce8:9c6:4a96:8fb9', '-1753081731', '2025-07-24 02:13:55'),
(9247, '2409:40c4:28d:26c:dce8:9c6:4a96:8fb9', 'pratyavaran-1750673649', '2025-07-24 02:14:35'),
(9253, '139.5.242.40', 'the-path-of-light-1750519785', '2025-07-24 03:00:41'),
(9257, '139.5.242.40', 'pratyavaran-1750673649', '2025-07-24 03:01:31'),
(9258, '45.118.159.66', 'pratyavaran-1750673649', '2025-07-24 06:08:02'),
(9259, '45.118.159.66', '-1753081731', '2025-07-24 06:08:06'),
(9261, '45.118.159.66', 'to-the-thriving-addiction-towards-petrichor-1751185171', '2025-07-24 07:09:23'),
(9262, '45.118.159.66', 'daily-tired-student-life-1750675612', '2025-07-24 07:09:26'),
(9263, '45.118.159.66', 'alien-s-attack-1751009602', '2025-07-24 07:09:29'),
(9264, '45.118.159.66', 'the-path-of-light-1750519785', '2025-07-24 07:09:34'),
(9265, '45.118.159.66', 'staged-lives-1751185306', '2025-07-24 07:26:27'),
(9266, '45.118.159.66', 'threshold-density-1751185016', '2025-07-24 07:26:32'),
(9270, '45.118.159.66', 'life-of-an-iit-aspirant-a-rollercoaster-ride-1750678198', '2025-07-24 08:19:15'),
(9276, '2409:40c4:1170:cfea:5143:8dd9:d7c0:ee71', '-1753081731', '2025-07-24 13:41:38'),
(9281, '45.118.159.66', 'talking-to-a-fish-in-an-aquarium-1751185246', '2025-07-24 14:40:00'),
(9283, '2409:40d0:ba:a436:8000::', '-1753081731', '2025-07-24 15:45:42'),
(9290, '2409:40c4:1170:cfea:18e8:46db:d2e5:b4b2', '-1753081731', '2025-07-25 01:12:33'),
(9291, '2409:40c4:1170:cfea:18e8:46db:d2e5:b4b2', 'pratyavaran-1750673649', '2025-07-25 01:12:50'),
(9292, '45.118.159.139', 'threshold-density-1751185016', '2025-07-25 06:26:32'),
(9293, '45.118.159.139', 'the-path-of-light-1750519785', '2025-07-25 06:27:02'),
(9296, '2409:40d0:102f:3eac:8000::', '-1753081731', '2025-07-26 04:49:15'),
(9298, '45.118.159.139', '-1753081731', '2025-07-26 07:41:29'),
(9299, '2409:40d0:3b:a0cf:8000::', 'to-the-thriving-addiction-towards-petrichor-1751185171', '2025-07-26 11:50:14'),
(9300, '2409:40c4:30ad:f343:e9:1908:4a90:85df', 'pratyavaran-1750673649', '2025-07-27 02:22:19'),
(9301, '2409:40c4:30ad:f343:e9:1908:4a90:85df', '-1753081731', '2025-07-27 02:23:08'),
(9303, '2409:40c4:30c6:7730:79ce:482a:a69:af38', 'pratyavaran-1750673649', '2025-07-27 12:06:27'),
(9304, '45.118.159.139', 'staged-lives-1751185306', '2025-07-28 09:41:49'),
(9308, '45.118.159.139', 'talking-to-a-fish-in-an-aquarium-1751185246', '2025-07-28 09:42:38'),
(9309, '45.118.159.139', 'to-the-thriving-addiction-towards-petrichor-1751185171', '2025-07-28 09:43:18'),
(9313, '45.118.159.139', 'daily-tired-student-life-1750675612', '2025-07-28 13:20:23'),
(9314, '2409:40c4:275:a1af:7434:c4fd:981e:25d9', 'pratyavaran-1750673649', '2025-07-29 00:35:34'),
(9318, '45.118.159.139', 'alien-s-attack-1751009602', '2025-07-29 08:31:19'),
(9322, '2409:40e4:29:d597:8000::', 'alien-s-attack-1751009602', '2025-07-29 15:50:36'),
(9328, '2409:40e4:29:d597:8000::', 'staged-lives-1751185306', '2025-07-30 06:54:01'),
(9330, '2409:40e4:29:d597:8000::', 'talking-to-a-fish-in-an-aquarium-1751185246', '2025-07-30 06:54:36'),
(9331, '2409:40e4:29:d597:8000::', 'threshold-density-1751185016', '2025-07-30 06:55:08'),
(9332, '2409:40e4:29:d597:8000::', 'the-path-of-light-1750519785', '2025-07-30 06:55:52'),
(9335, '2409:40e4:29:d597:8000::', '-1753081731', '2025-07-30 06:58:00'),
(9339, '2401:4900:73dc:2d7f:a484:eff0:9aa9:b003', '-1753081731', '2025-07-31 09:10:47'),
(9340, '2409:40e4:1350:7750:8000::', 'the-path-of-light-1750519785', '2025-07-31 13:03:38'),
(9341, '2409:40e4:5d:efec:8000::', 'the-path-of-light-1750519785', '2025-08-01 09:03:30'),
(9343, '2401:4900:83ad:a73a:5045:9220:3f53:6d1b', '-1753081731', '2025-08-01 14:32:24'),
(9344, '2401:4900:83ad:a73a:5045:9220:3f53:6d1b', 'staged-lives-1751185306', '2025-08-01 14:32:42'),
(9347, '2401:4900:83ad:a73a:5045:9220:3f53:6d1b', 'to-the-thriving-addiction-towards-petrichor-1751185171', '2025-08-01 15:45:56'),
(9349, '2401:4900:83ad:a73a:5045:9220:3f53:6d1b', 'the-path-of-light-1750519785', '2025-08-01 15:46:01'),
(9350, '2401:4900:83ad:a73a:5045:9220:3f53:6d1b', 'pratyavaran-1750673649', '2025-08-01 15:46:04'),
(9351, '2401:4900:83ad:a73a:5045:9220:3f53:6d1b', 'daily-tired-student-life-1750675612', '2025-08-01 15:46:08'),
(9352, '2401:4900:83ad:a73a:5045:9220:3f53:6d1b', 'life-of-an-iit-aspirant-a-rollercoaster-ride-1750678198', '2025-08-01 15:46:13'),
(9353, '2401:4900:83ad:a73a:5045:9220:3f53:6d1b', 'alien-s-attack-1751009602', '2025-08-01 15:46:18'),
(9354, '2401:4900:83ad:a73a:5045:9220:3f53:6d1b', 'threshold-density-1751185016', '2025-08-01 15:46:25'),
(9355, '2401:4900:a068:dfcf:cb06:e8f5:fe3c:229b', '-1753081731', '2025-08-01 17:47:35'),
(9356, '2401:4900:a068:dfcf:cb06:e8f5:fe3c:229b', 'life-of-an-iit-aspirant-a-rollercoaster-ride-1750678198', '2025-08-01 17:47:48'),
(9358, '2409:40c4:1165:8fd6:f14b:4cb9:d83c:d975', 'pratyavaran-1750673649', '2025-08-02 04:51:22'),
(9359, '45.118.159.124', '-1753081731', '2025-08-03 04:38:32'),
(9360, '45.118.159.124', 'staged-lives-1751185306', '2025-08-03 04:38:37'),
(9361, '45.118.159.124', 'talking-to-a-fish-in-an-aquarium-1751185246', '2025-08-03 04:38:40'),
(9362, '45.118.159.124', 'to-the-thriving-addiction-towards-petrichor-1751185171', '2025-08-03 04:38:46'),
(9363, '45.118.159.124', 'threshold-density-1751185016', '2025-08-03 04:38:53'),
(9364, '139.5.248.209', '-1753081731', '2025-08-03 14:53:21'),
(9365, '202.173.125.89', '-1753081731', '2025-08-05 02:37:13'),
(9366, '202.173.125.89', 'pratyavaran-1750673649', '2025-08-05 04:11:04'),
(9367, '2409:40d0:30bb:606b:8000::', 'alien-s-attack-1751009602', '2025-08-05 12:49:01'),
(9368, '2401:4900:a060:28aa:31c9:59be:90ae:8d94', 'alien-s-attack-1751009602', '2025-08-05 12:49:53'),
(9370, '2409:40c4:30ab:3a97:c446:9e26:59cb:64f4', 'pratyavaran-1750673649', '2025-08-05 18:05:23'),
(9372, '2409:40c4:30ab:3a97:c446:9e26:59cb:64f4', 'the-truth-behind-love-1754417224', '2025-08-05 18:28:49'),
(9373, '2409:40c4:15e:fc2b:db3:c65d:e98c:f25d', 'pratyavaran-1750673649', '2025-08-06 18:13:31'),
(9374, '2409:40c4:15e:fc2b:db3:c65d:e98c:f25d', 'the-truth-behind-love-1754417224', '2025-08-06 18:13:39'),
(9379, '202.173.125.89', 'the-truth-behind-love-1754417224', '2025-08-07 02:41:53'),
(9380, '2409:40d0:1395:6762:8000::', 'the-truth-behind-love-1754417224', '2025-08-08 05:21:27'),
(9381, '2409:40d0:29:30e7:8000::', 'pratyavaran-1750673649', '2025-08-08 06:28:51'),
(9382, '2409:40c4:30c6:96f0:382f:8b53:9049:884f', 'pratyavaran-1750673649', '2025-08-09 10:36:42'),
(9384, '2409:40c4:30c6:96f0:382f:8b53:9049:884f', 'the-truth-behind-love-1754417224', '2025-08-09 10:40:01'),
(9387, '2409:40c4:30c6:96f0:382f:8b53:9049:884f', '-1753081731', '2025-08-09 10:41:24'),
(9389, '2409:40c4:30a6:43a1:1400:704f:faa5:ba00', 'pratyavaran-1750673649', '2025-08-10 19:28:10'),
(9390, '2409:40c4:30a6:43a1:1400:704f:faa5:ba00', 'the-truth-behind-love-1754417224', '2025-08-10 19:28:47'),
(9391, '152.59.62.71', '-1753081731', '2025-08-10 19:28:57'),
(9393, '2409:40d0:3d:8679:8000::', 'the-truth-behind-love-1754417224', '2025-08-11 08:12:40'),
(9394, '2409:40d0:3d:8679:8000::', 'staged-lives-1751185306', '2025-08-11 08:12:43'),
(9395, '139.5.242.33', 'new-bharat-1754907771', '2025-08-11 10:23:00'),
(9396, '2401:4900:8849:9b7b:15dd:7ffa:c9b2:2f78', 'new-bharat-1754907771', '2025-08-11 10:25:27'),
(9400, '2409:40c4:15e:6f36:b531:7da2:93a5:485', 'new-bharat-1754907771', '2025-08-11 12:24:22'),
(9403, '117.254.233.55', 'new-bharat-1754907771', '2025-08-11 15:14:57'),
(9404, '2401:4900:a019:4cbb:ea8c:655e:9d75:d514', 'new-bharat-1754907771', '2025-08-11 18:32:44'),
(9409, '139.5.242.33', 'the-truth-behind-love-1754417224', '2025-08-12 12:47:48'),
(9411, '2401:4900:a01e:5f36:41fc:32d3:52:8f51', 'new-bharat-1754907771', '2025-08-12 16:15:00'),
(9412, '2401:4900:a47f:ca48::7704:9a69', 'new-bharat-1754907771', '2025-08-13 01:04:26'),
(9413, '45.118.159.236', 'new-bharat-1754907771', '2025-08-13 09:58:44'),
(9415, '2409:40d0:30ba:b1ba:8000::', 'new-bharat-1754907771', '2025-08-14 06:44:32'),
(9416, '2401:4900:88d0:1b2:f07f:78b4:fe23:2a24', 'new-bharat-1754907771', '2025-08-14 10:47:21'),
(9417, '139.5.248.245', 'the-truth-behind-love-1754417224', '2025-08-14 17:27:56'),
(9419, '139.5.248.245', 'andhere-se-jang-1755193105', '2025-08-14 17:40:21'),
(9422, '139.5.248.245', 'new-bharat-1754907771', '2025-08-14 17:41:44'),
(9423, '139.5.248.245', '-1753081731', '2025-08-14 17:42:09'),
(9424, '139.5.242.100', 'andhere-se-jang-1755193105', '2025-08-15 11:30:13'),
(9425, '139.5.242.174', 'andhere-se-jang-1755193105', '2025-08-15 11:33:16'),
(9429, '139.5.242.174', 'the-truth-behind-love-1754417224', '2025-08-15 11:35:02'),
(9430, '139.5.248.139', '-1753081731', '2025-08-15 17:05:09'),
(9431, '139.5.248.207', '-1753081731', '2025-08-16 18:19:33'),
(9432, '202.173.125.161', 'andhere-se-jang-1755193105', '2025-08-17 12:51:16'),
(9433, '2402:3a80:41f2:2eb:0:1e:2786:4201', 'new-bharat-1754907771', '2025-08-19 02:31:19'),
(9435, '2402:3a80:41f2:2eb:0:1e:2786:4201', 'andhere-se-jang-1755193105', '2025-08-19 02:32:50'),
(9436, '2402:3a80:41f2:2eb:0:1e:2786:4201', 'the-truth-behind-love-1754417224', '2025-08-19 02:32:59'),
(9437, '2402:3a80:41f2:2eb:0:1e:2786:4201', 'staged-lives-1751185306', '2025-08-19 02:33:14'),
(9438, '2402:3a80:41f2:2eb:0:1e:2786:4201', 'alien-s-attack-1751009602', '2025-08-19 02:33:35'),
(9440, '139.5.242.178', 'staged-lives-1751185306', '2025-08-19 08:31:23'),
(9441, '139.5.242.178', 'talking-to-a-fish-in-an-aquarium-1751185246', '2025-08-19 08:31:26'),
(9442, '139.5.242.178', 'andhere-se-jang-1755193105', '2025-08-19 08:31:29'),
(9443, '139.5.242.178', 'new-bharat-1754907771', '2025-08-19 08:31:33'),
(9451, '103.108.5.92', 'new-bharat-1754907771', '2025-08-20 12:58:12'),
(9452, '103.108.5.170', 'new-bharat-1754907771', '2025-08-21 09:07:36'),
(9453, '103.108.5.170', 'alien-s-attack-1751009602', '2025-08-21 09:07:46'),
(9454, '103.108.5.170', 'threshold-density-1751185016', '2025-08-21 09:07:55'),
(9455, '103.108.5.43', 'talking-to-a-fish-in-an-aquarium-1751185246', '2025-08-22 02:17:25'),
(9456, '2401:4900:a131:f21c:fa52:8ce3:1785:b885', 'new-bharat-1754907771', '2025-08-22 07:28:57'),
(9457, '2409:40c4:15d:52e3:4f5:d06e:44d1:a551', 'pratyavaran-1750673649', '2025-08-22 16:32:26'),
(9458, '103.108.5.162', 'messge-for-aadarsh-1755880490', '2025-08-23 03:48:22'),
(9459, '103.108.5.162', 'andhere-se-jang-1755193105', '2025-08-23 03:49:28'),
(9460, '103.108.5.162', 'new-bharat-1754907771', '2025-08-23 03:49:39'),
(9461, '2401:4900:a013:fdae:7fc9:d06b:5e19:2309', 'new-bharat-1754907771', '2025-08-23 03:50:35'),
(9462, '2401:4900:8849:b01:988:a87b:9c75:18c8', 'messge-for-aadarsh-1755880490', '2025-08-24 01:39:34'),
(9465, '103.108.5.162', '-1753081731', '2025-08-24 04:24:50'),
(9466, '103.108.5.162', 'life-of-an-iit-aspirant-a-rollercoaster-ride-1750678198', '2025-08-24 04:24:56'),
(9467, '103.108.5.110', 'new-bharat-1754907771', '2025-08-27 17:17:21'),
(9468, '2401:4900:b80:c1fe:cd3a:eacf:d85f:c0b9', 'new-bharat-1754907771', '2025-08-29 17:01:31'),
(9470, '103.108.5.196', 'new-bharat-1754907771', '2025-08-29 17:02:35'),
(9471, '103.108.5.33', 'threshold-density-1751185016', '2025-09-09 02:27:08'),
(9472, '103.108.5.33', 'new-bharat-1754907771', '2025-09-10 14:38:05'),
(9473, '2401:4900:8202:5603:ce4e:4a6b:7204:3a05', 'new-bharat-1754907771', '2025-09-10 18:26:33'),
(9474, '2409:40d0:1018:b702:8000::', 'andhere-se-jang-1755193105', '2025-09-12 02:34:50'),
(9475, '103.108.5.107', 'andhere-se-jang-1755193105', '2025-09-12 02:35:23'),
(9476, '103.108.5.24', 'the-truth-behind-love-1754417224', '2025-09-16 16:34:40'),
(9477, '103.108.5.55', 'new-bharat-1754907771', '2025-09-27 07:08:18'),
(9478, '2409:40d2:1268:6dd4:2cd7:c1ff:fe39:d41d', 'new-bharat-1754907771', '2025-10-02 14:26:23'),
(9479, '2401:4900:8206:2a20:cfb2:d14e:306e:17d6', 'new-bharat-1754907771', '2025-10-02 14:26:51'),
(9481, '2401:4900:8388:ca7c:3f04:6c5:3f19:2c18', 'andhere-se-jang-1755193105', '2025-10-07 04:05:41'),
(9482, '2401:4900:8388:ca7c:3f04:6c5:3f19:2c18', '-1753081731', '2025-10-07 04:05:47'),
(9483, '2401:4900:8388:ca7c:3f04:6c5:3f19:2c18', 'alien-s-attack-1751009602', '2025-10-07 04:05:53'),
(9484, '2401:4900:8388:ca7c:3f04:6c5:3f19:2c18', 'new-bharat-1754907771', '2025-10-07 04:06:15'),
(9486, '103.108.5.139', '-1760077668', '2025-10-12 15:29:10'),
(9490, '103.108.5.139', 'andhere-se-jang-1755193105', '2025-10-14 13:23:40'),
(9491, '2409:40c4:11e4:1af8:2c4d:7f25:97c5:408c', 'pratyavaran-1750673649', '2025-10-23 15:54:15'),
(9492, '2409:40c4:11e4:1af8:2c4d:7f25:97c5:408c', '-1753081731', '2025-10-23 15:54:58'),
(9493, '2409:40c4:11e4:1af8:2c4d:7f25:97c5:408c', 'swatantrata-1761235115', '2025-10-23 15:58:54'),
(9494, '2409:40c4:11e4:1af8:2c4d:7f25:97c5:408c', 'andhere-se-jang-1755193105', '2025-10-23 15:59:12'),
(9496, '2409:40c4:11e4:1af8:2c4d:7f25:97c5:408c', 'the-truth-behind-love-1754417224', '2025-10-23 16:01:49'),
(9497, '2409:40c4:11e4:1af8:2c4d:7f25:97c5:408c', '-1760077668', '2025-10-23 16:02:08'),
(9499, '103.108.5.36', 'swatantrata-1761235115', '2025-10-25 15:38:05'),
(9502, '103.108.5.36', '-1760077668', '2025-10-25 15:39:04'),
(9503, '2409:40d0:11f9:2aaf:8000::', 'swatantrata-1761235115', '2025-11-07 08:40:31'),
(9504, '2409:40d0:11f9:2aaf:8000::', '-1753081731', '2025-11-07 08:40:34'),
(9505, '2409:40d0:11f9:2aaf:8000::', '-1760077668', '2025-11-07 08:40:37'),
(9506, '2409:40d0:11f9:2aaf:8000::', 'andhere-se-jang-1755193105', '2025-11-07 08:40:39'),
(9507, '2409:40d0:11f9:2aaf:8000::', 'new-bharat-1754907771', '2025-11-07 08:40:48'),
(9508, '2409:40d0:11f9:2aaf:8000::', 'the-truth-behind-love-1754417224', '2025-11-07 08:41:01'),
(9511, '2409:40d0:11f9:2aaf:8000::', 'threshold-density-1751185016', '2025-11-07 08:41:12'),
(9512, '2409:40d0:11f9:2aaf:8000::', 'to-the-thriving-addiction-towards-petrichor-1751185171', '2025-11-07 08:41:16'),
(9513, '2409:40d0:11f9:2aaf:8000::', 'talking-to-a-fish-in-an-aquarium-1751185246', '2025-11-07 08:41:19'),
(9514, '2409:40d0:103a:cb9e:8000::', 'new-bharat-1754907771', '2025-11-10 03:59:00'),
(9515, '103.108.5.140', '-1760077668', '2025-11-26 02:02:27'),
(9516, '103.108.5.140', 'the-truth-behind-love-1754417224', '2025-11-26 02:02:30'),
(9517, '103.108.5.140', 'threshold-density-1751185016', '2025-11-26 02:02:35'),
(9518, '2409:40c4:285:f5b9:cd52:36b8:7c92:f40e', 'bhram-lok-1764348119', '2025-11-28 16:42:08'),
(9519, '2409:40c4:285:f5b9:cd52:36b8:7c92:f40e', 'swatantrata-1761235115', '2025-11-28 16:42:18'),
(9520, '2409:40c4:285:f5b9:cd52:36b8:7c92:f40e', '-1760077668', '2025-11-28 16:42:38'),
(9521, '2409:40c4:285:f5b9:cd52:36b8:7c92:f40e', 'the-truth-behind-love-1754417224', '2025-11-28 16:42:50'),
(9522, '2409:40c4:285:f5b9:d410:9a07:fc2b:86fc', 'bhram-lok-1764348119', '2025-11-29 08:26:27'),
(9523, '103.108.5.60', 'bhram-lok-1764348119', '2025-12-03 15:19:27'),
(9524, '2409:40c4:158:739c:90a:d0f7:7222:2937', 'bhram-lok-1764348119', '2025-12-04 09:14:55'),
(9526, '139.5.248.130', '-1760077668', '2025-12-04 17:55:01'),
(9527, '139.5.248.130', 'staged-lives-1751185306', '2025-12-04 17:55:44'),
(9528, '139.5.248.130', 'andhere-se-jang-1755193105', '2025-12-04 17:56:24'),
(9529, '2409:40c4:289:eaaf:58c2:8245:e7a1:3c7b', 'bhram-lok-1764348119', '2025-12-09 16:05:16'),
(9530, '2409:40c4:289:eaaf:58c2:8245:e7a1:3c7b', 'swatantrata-1761235115', '2025-12-09 16:05:41'),
(9531, '2409:40c4:289:eaaf:58c2:8245:e7a1:3c7b', 'andhere-se-jang-1755193105', '2025-12-09 16:06:14'),
(9532, '2409:40c4:289:eaaf:58c2:8245:e7a1:3c7b', 'to-the-thriving-addiction-towards-petrichor-1751185171', '2025-12-09 16:06:42'),
(9533, '2405:201:5c20:5812:25a9:cd51:a3b8:7091', 'andhere-se-jang-1755193105', '2025-12-10 07:10:55'),
(9535, '2405:201:5c20:5812:25a9:cd51:a3b8:7091', 'new-bharat-1754907771', '2025-12-10 07:12:30'),
(9538, '103.108.5.91', 'bhram-lok-1764348119', '2025-12-16 04:29:23'),
(9540, '103.108.5.91', '31', '2025-12-16 04:50:17'),
(9541, '103.108.5.91', '32', '2025-12-16 04:50:21'),
(9542, '103.108.5.91', '30', '2025-12-16 04:50:24'),
(9543, '103.108.5.91', 'swatantrata-1761235115', '2025-12-16 04:50:47'),
(9544, '103.108.5.91', 'new-bharat-1754907771', '2025-12-16 04:53:27'),
(9550, '103.108.5.91', 'talking-to-a-fish-in-an-aquarium-1751185246', '2025-12-16 04:57:05'),
(9559, '103.108.5.91', 'andhere-se-jang-1755193105', '2025-12-16 05:20:26'),
(9564, '103.108.5.91', '-1753081731', '2025-12-16 05:35:46'),
(9565, '103.108.5.91', 'the-truth-behind-love-1754417224', '2025-12-16 05:36:00'),
(9574, '103.108.5.91', 'to-the-thriving-addiction-towards-petrichor-1751185171', '2025-12-16 06:27:43'),
(9605, '103.108.5.91', 'how-to-use-wikipedia-search-inside-readxhub-chat-gdr-guide-1765868531', '2025-12-16 07:02:39'),
(9621, '103.108.5.91', 'what-is-gdr-meaning-features-and-how-it-powers-smart-learning-on-readxhub-1765870002', '2025-12-16 07:26:57'),
(9622, '103.108.5.91', 'who-is-adarsh-creator-and-founder-of-readxhub-1765870571', '2025-12-16 07:36:16'),
(9623, '103.108.5.91', 'why-should-you-buy-readxhub-1765870703', '2025-12-16 07:38:31'),
(9633, '2401:4900:88d1:afa5:b54d:11b1:87c6:b3f9', 'why-should-you-buy-readxhub-1765870703', '2025-12-16 12:24:14'),
(9635, '2401:4900:88d1:afa5:b54d:11b1:87c6:b3f9', 'what-is-gdr-meaning-features-and-how-it-powers-smart-learning-on-readxhub-1765870002', '2025-12-16 12:34:26'),
(9637, '223.181.127.63', 'what-is-gdr-meaning-features-and-how-it-powers-smart-learning-on-readxhub-1765870002', '2025-12-16 12:40:30'),
(9642, '103.108.5.91', 'readxhub-mm-smart-knowledge-retrieval-inside-chat-1765888946', '2025-12-16 12:42:32'),
(9645, '2401:4900:88d1:afa5:b54d:11b1:87c6:b3f9', 'how-to-use-wikipedia-search-inside-readxhub-chat-gdr-guide-1765868531', '2025-12-16 12:43:58'),
(9650, '103.108.5.91', 'readxhub-gdr-smart-knowledge-retrieval-inside-chat-1765889339', '2025-12-16 12:49:39'),
(9668, '103.108.5.91', 'why-you-should-never-run-random-github-code-without-understanding-it-1765946107', '2025-12-17 04:35:12'),
(9751, '103.108.5.91', 'alien-s-attack-1751009602', '2025-12-17 05:50:59'),
(9761, '103.108.5.91', 'daily-tired-student-life-1750675612', '2025-12-17 06:01:47'),
(9776, '157.119.45.232', 'why-should-you-buy-readxhub-1765870703', '2025-12-17 13:45:35'),
(9780, '139.5.248.230', 'why-should-you-buy-readxhub-1765870703', '2025-12-17 15:18:30'),
(9782, '103.108.5.91', 'threshold-density-1751185016', '2025-12-18 02:51:19'),
(9783, '2409:40e4:10bc:a7fa:5a35:68ea:832e:ece0', 'threshold-density-1751185016', '2025-12-18 02:54:52'),
(9787, '45.251.49.43', 'new-bharat-1754907771', '2025-12-19 05:34:14'),
(9790, '2401:4900:81ee:61ea:eed0:8d73:ca41:7150', 'new-bharat-1754907771', '2025-12-19 13:02:39'),
(9791, '2401:4900:81ee:61ea:eed0:8d73:ca41:7150', 'why-should-you-buy-readxhub-1765870703', '2025-12-19 13:02:54'),
(9794, '116.72.188.159', 'why-should-you-buy-readxhub-1765870703', '2025-12-19 15:54:17'),
(9795, '103.108.5.63', 'why-should-you-buy-readxhub-1765870703', '2025-12-20 11:16:01'),
(9797, '103.108.5.63', 'readxhub-gdr-smart-knowledge-retrieval-inside-chat-1765889339', '2025-12-20 11:29:15'),
(9803, '103.108.5.56', 'why-you-should-never-run-random-github-code-without-understanding-it-1765946107', '2025-12-22 08:55:30'),
(9804, '103.108.5.158', 'readxhub-gdr-smart-knowledge-retrieval-inside-chat-1765889339', '2025-12-22 14:19:54'),
(9805, '106.219.172.232', 'who-is-adarsh-creator-and-founder-of-readxhub-1765870571', '2025-12-24 01:01:55'),
(9807, '103.108.5.245', 'founder-and-co-founder-1766538737', '2025-12-25 03:39:31'),
(9808, '103.108.5.245', 'readxhub-gdr-smart-knowledge-retrieval-inside-chat-1765889339', '2025-12-25 03:45:43'),
(9810, '103.108.5.11', 'founder-and-co-founder-1766538737', '2025-12-25 11:44:52'),
(9811, '103.108.5.11', 'readxhub-gdr-smart-knowledge-retrieval-inside-chat-1765889339', '2025-12-25 11:44:58'),
(9812, '103.108.5.115', 'founder-and-co-founder-1766538737', '2025-12-26 03:01:54'),
(9814, '103.108.5.115', 'readxhub-gdr-smart-knowledge-retrieval-inside-chat-1765889339', '2025-12-26 14:11:57'),
(9815, '2401:4900:884a:c1b0:8935:6e42:ffd5:8b9b', 'pratyavaran-1750673649', '2025-12-27 05:16:39'),
(9816, '2401:4900:88d3:28dd:e5ca:429a:3f86:acfb', 'founder-and-co-founder-1766538737', '2025-12-27 12:45:17'),
(9822, '103.108.5.222', 'founder-and-co-founder-1766538737', '2025-12-27 12:57:48'),
(9823, '223.181.122.227', 'who-is-adarsh-creator-and-founder-of-readxhub-1765870571', '2025-12-28 02:01:42'),
(9824, '223.181.122.227', 'biography-of-rajsingh-1766887252', '2025-12-28 02:02:30'),
(9826, '103.108.5.222', 'biography-of-rajsingh-1766887252', '2025-12-28 03:30:32'),
(9827, '2401:4900:88d3:28dd:c058:de4b:6900:f97', 'biography-of-rajsingh-1766887252', '2025-12-28 03:32:54'),
(9843, '2401:4900:88d1:1029:d124:97ff:151e:478d', 'biography-of-rajsingh-1766887252', '2025-12-28 09:27:03'),
(9844, '2401:4900:88d2:2c75:e58b:fc4c:6960:9001', 'founder-and-co-founder-1766538737', '2025-12-28 14:34:43'),
(9845, '2401:4900:88d2:2c75:e58b:fc4c:6960:9001', 'biography-of-rajsingh-1766887252', '2025-12-28 14:36:11'),
(9848, '2401:4900:385d:31e5:95c3:60ff:e728:79c0', 'biography-of-rajsingh-1766887252', '2026-01-05 02:47:15'),
(9849, '2401:4900:884b:6a16:f95a:7866:3e19:60fb', 'biography-of-rajsingh-1766887252', '2026-01-07 03:08:36'),
(9850, '2401:4900:71dd:7c58:3c42:c7eb:c04b:1e5a', 'how-to-use-wikipedia-search-inside-readxhub-chat-gdr-guide-1765868531', '2026-01-13 16:09:04'),
(9851, '2401:4900:71dd:7c58:3c42:c7eb:c04b:1e5a', 'who-is-adarsh-creator-and-founder-of-readxhub-1765870571', '2026-01-13 16:09:21'),
(9853, '2401:4900:71dd:7c58:3c42:c7eb:c04b:1e5a', 'readxhub-gdr-smart-knowledge-retrieval-inside-chat-1765889339', '2026-01-13 16:09:31'),
(9854, '2401:4900:71dd:7c58:3c42:c7eb:c04b:1e5a', 'why-should-you-buy-readxhub-1765870703', '2026-01-13 16:09:44'),
(9856, '2401:4900:71dd:7c58:3c42:c7eb:c04b:1e5a', 'introduction-to-accessibility-testing-1768320908', '2026-01-13 16:15:23'),
(9858, '2401:4900:b3ee:da00:5e10:49c7:d8b5:d2cb', 'introduction-to-accessibility-testing-1768320908', '2026-01-14 09:01:17'),
(9860, '116.206.159.169', 'introduction-to-accessibility-testing-1768320908', '2026-01-14 09:55:13'),
(9861, '139.5.248.219', 'introduction-to-accessibility-testing-1768320908', '2026-01-14 11:29:43'),
(9867, '192.140.155.118', 'introduction-to-accessibility-testing-1768320908', '2026-01-14 14:54:06'),
(9868, '2409:40e1:315f:2dc9:a889:45ff:fe57:8697', 'introduction-to-accessibility-testing-1768320908', '2026-01-15 05:41:22'),
(9872, '2409:40e1:315f:2dc9:a889:45ff:fe57:8697', 'staged-lives-1751185306', '2026-01-15 05:47:11'),
(9873, '2409:40e1:315f:2dc9:a889:45ff:fe57:8697', 'why-should-you-buy-readxhub-1765870703', '2026-01-15 05:47:18'),
(9874, '2409:40e1:315f:2dc9:a889:45ff:fe57:8697', 'who-is-adarsh-creator-and-founder-of-readxhub-1765870571', '2026-01-15 05:47:33'),
(9875, '2409:40e1:315f:2dc9:a889:45ff:fe57:8697', 'alien-s-attack-1751009602', '2026-01-15 05:51:30'),
(9876, '2409:40e1:315f:2dc9:a889:45ff:fe57:8697', 'how-to-use-wikipedia-search-inside-readxhub-chat-gdr-guide-1765868531', '2026-01-15 05:53:27'),
(9877, '2409:40e1:315f:2dc9:a889:45ff:fe57:8697', 'new-bharat-1754907771', '2026-01-15 05:54:36'),
(9878, '2409:40e1:315f:2dc9:a889:45ff:fe57:8697', 'the-path-of-light-1750519785', '2026-01-15 05:55:56'),
(9879, '2409:40e1:315f:2dc9:a889:45ff:fe57:8697', 'biography-of-rajsingh-1766887252', '2026-01-15 05:56:33'),
(9883, '106.192.109.16', 'introduction-to-accessibility-testing-1768320908', '2026-01-16 12:53:31'),
(9886, '106.192.109.16', 'readxhub-gdr-smart-knowledge-retrieval-inside-chat-1765889339', '2026-01-16 12:54:14'),
(9887, '106.192.109.16', 'how-to-use-wikipedia-search-inside-readxhub-chat-gdr-guide-1765868531', '2026-01-16 12:54:31'),
(9888, '106.192.109.16', 'who-is-adarsh-creator-and-founder-of-readxhub-1765870571', '2026-01-16 12:54:41'),
(9889, '2401:4900:88d1:cd35:4585:45b5:3065:d7d', 'introduction-to-accessibility-testing-1768320908', '2026-01-16 12:57:34'),
(9893, '2401:4900:3b0a:5dce:e3a1:c229:3c8c:a4ca', 'introduction-to-accessibility-testing-1768320908', '2026-01-17 13:19:58'),
(9894, '2401:4900:3b0a:5dce:e3a1:c229:3c8c:a4ca', 'biography-of-rajsingh-1766887252', '2026-01-17 13:20:02'),
(9895, '2401:4900:3b0a:5dce:e3a1:c229:3c8c:a4ca', 'life-of-an-iit-aspirant-a-rollercoaster-ride-1750678198', '2026-01-17 13:20:06'),
(9896, '2401:4900:3b0a:5dce:e3a1:c229:3c8c:a4ca', 'daily-tired-student-life-1750675612', '2026-01-17 13:20:10'),
(9897, '2401:4900:3b0a:5dce:e3a1:c229:3c8c:a4ca', 'founder-and-co-founder-1766538737', '2026-01-17 13:20:13'),
(9898, '2401:4900:3b0a:5dce:e3a1:c229:3c8c:a4ca', 'alien-s-attack-1751009602', '2026-01-17 13:20:18'),
(9900, '2401:4900:3b0a:5dce:e3a1:c229:3c8c:a4ca', 'why-should-you-buy-readxhub-1765870703', '2026-01-17 13:20:24'),
(9901, '2401:4900:3b0a:5dce:e3a1:c229:3c8c:a4ca', 'the-path-of-light-1750519785', '2026-01-17 13:20:27'),
(9902, '2401:4900:3b0a:5dce:e3a1:c229:3c8c:a4ca', 'pratyavaran-1750673649', '2026-01-17 13:20:31'),
(9903, '2401:4900:3b0a:5dce:e3a1:c229:3c8c:a4ca', '-1753081731', '2026-01-17 13:21:16'),
(9904, '2401:4900:3b0a:5dce:e3a1:c229:3c8c:a4ca', 'staged-lives-1751185306', '2026-01-17 13:21:31'),
(9905, '2401:4900:88d0:3bc5:774b:5769:2a2e:37f5', 'introduction-to-accessibility-testing-1768320908', '2026-01-17 17:50:50'),
(9906, '2401:4900:3ccb:a054::2b:da7f', 'introduction-to-accessibility-testing-1768320908', '2026-01-19 05:03:36'),
(9907, '2401:4900:3ccb:a054::2b:da7f', 'biography-of-rajsingh-1766887252', '2026-01-19 05:03:39'),
(9908, '2401:4900:b4de:4111:f01a:82ff:fe90:f1f8', 'introduction-to-accessibility-testing-1768320908', '2026-01-21 12:04:06'),
(9909, '139.5.248.238', 'introduction-to-accessibility-testing-1768320908', '2026-01-23 17:33:34'),
(9911, '139.5.248.238', 'what-is-android-accessibility-1769190101', '2026-01-23 17:43:08'),
(9912, '2401:4900:715b:a040::20:1b22', 'what-is-android-accessibility-1769190101', '2026-01-24 10:08:28'),
(9913, '2401:4900:715b:a040::20:1b22', 'introduction-to-accessibility-testing-1768320908', '2026-01-24 10:11:16'),
(9939, '2401:4900:715b:a040::20:1b22', 'biography-of-rajsingh-1766887252', '2026-01-24 10:29:08'),
(9943, '139.5.248.203', 'introduction-to-web-development-1769276377', '2026-01-24 17:40:09'),
(9944, '139.5.248.203', 'founder-and-co-founder-1766538737', '2026-01-24 17:40:31'),
(9948, '2409:4070:211a:c579:b385:5869:8c1c:643b', 'introduction-to-web-development-1769276377', '2026-01-24 17:54:39'),
(9950, '117.96.147.33', 'introduction-to-web-development-1769276377', '2026-01-24 21:29:11'),
(9951, '2401:4900:73da:6d76:6c73:4bee:3a04:61a2', 'how-to-use-wikipedia-search-inside-readxhub-chat-gdr-guide-1765868531', '2026-01-24 23:16:40'),
(9952, '2401:4900:3cdb:b405::24:6eac', 'introduction-to-web-development-1769276377', '2026-01-25 06:44:14'),
(9953, '2401:4900:3cdb:b405::24:6eac', 'why-should-you-buy-readxhub-1765870703', '2026-01-25 06:45:58'),
(9954, '2401:4900:3cdb:b405::24:6eac', 'talking-to-a-fish-in-an-aquarium-1751185246', '2026-01-25 06:46:02'),
(9956, '2401:4900:88d1:c5cd:3ead:52f1:9502:802b', 'introduction-to-web-development-1769276377', '2026-01-25 06:47:34'),
(9961, '2401:4900:3cdb:b405::24:6eac', 'the-truth-behind-love-1754417224', '2026-01-25 06:49:03'),
(9962, '2401:4900:3cdb:b405::24:6eac', 'bhram-lok-1764348119', '2026-01-25 06:49:10'),
(9963, '2401:4900:3cdb:b405::24:6eac', 'pratyavaran-1750673649', '2026-01-25 06:49:17'),
(9967, '106.222.168.69', 'introduction-to-web-development-1769276377', '2026-01-25 07:11:24'),
(9968, '2401:4900:3cdb:b405::24:6eac', 'why-organisation-choose-semiconductor-1769325487', '2026-01-25 07:18:15'),
(9969, '2409:40e1:310f:f329:a438:ebff:fe3e:d64', 'introduction-to-web-development-1769276377', '2026-01-25 07:19:59'),
(9987, '2400:c600:536d:673b::1', 'why-organisation-choose-semiconductor-1769325487', '2026-01-25 11:27:51'),
(9990, '139.5.248.203', 'why-organisation-choose-semiconductor-1769325487', '2026-01-25 11:34:57'),
(9996, '2401:4900:88d1:c5cd:3ead:52f1:9502:802b', 'why-organisation-choose-semiconductor-1769325487', '2026-01-25 12:03:23'),
(10004, '2400:c600:536d:673b:745e:7d3e:debf:cb28', 'introduction-to-web-development-1769276377', '2026-01-25 13:21:10'),
(10008, '2401:4900:3cdb:b405::24:6eac', 'what-is-android-accessibility-1769190101', '2026-01-25 13:48:56'),
(10009, '2401:4900:3cdb:b405::24:6eac', 'readxhub-gdr-smart-knowledge-retrieval-inside-chat-1765889339', '2026-01-25 13:48:59'),
(10010, '2401:4900:3cdb:b405::24:6eac', 'the-path-of-light-1750519785', '2026-01-25 13:49:03'),
(10012, '2401:4900:3cdb:b405::24:6eac', 'life-of-an-iit-aspirant-a-rollercoaster-ride-1750678198', '2026-01-25 13:49:14'),
(10013, '2401:4900:3cdb:b405::24:6eac', 'alien-s-attack-1751009602', '2026-01-25 13:49:18'),
(10014, '2409:40e4:10bc:30b6:c277:a234:e704:773b', 'why-organisation-choose-semiconductor-1769325487', '2026-01-25 13:51:27'),
(10020, '139.5.248.169', 'why-should-you-buy-readxhub-1765870703', '2026-01-25 16:02:15'),
(10022, '2401:4900:b404:4d69:e500:d12c:2714:3ec3', 'why-organisation-choose-semiconductor-1769325487', '2026-01-26 03:23:42'),
(10023, '2401:4900:b404:4d69:e500:d12c:2714:3ec3', 'introduction-to-web-development-1769276377', '2026-01-26 03:23:46'),
(10024, '2401:4900:b404:4d69:e500:d12c:2714:3ec3', 'what-is-android-accessibility-1769190101', '2026-01-26 03:23:54'),
(10025, '2401:4900:b404:4d69:e500:d12c:2714:3ec3', 'readxhub-gdr-smart-knowledge-retrieval-inside-chat-1765889339', '2026-01-26 03:23:58'),
(10026, '2401:4900:b404:4d69:e500:d12c:2714:3ec3', 'the-path-of-light-1750519785', '2026-01-26 03:24:04'),
(10027, '2401:4900:b404:4d69:e500:d12c:2714:3ec3', 'to-the-thriving-addiction-towards-petrichor-1751185171', '2026-01-26 03:24:09'),
(10029, '2401:4900:b404:4d69:e500:d12c:2714:3ec3', 'why-should-you-buy-readxhub-1765870703', '2026-01-26 03:24:20'),
(10030, '2401:4900:b404:4d69:e500:d12c:2714:3ec3', 'introduction-to-accessibility-testing-1768320908', '2026-01-26 03:24:26'),
(10033, '2401:4900:71ce:2168:2bb3:4a1c:3662:5d4e', 'why-organisation-choose-semiconductor-1769325487', '2026-01-26 04:47:57'),
(10034, '2401:4900:7034:f7c9:a899:bff:fe92:4caa', 'why-organisation-choose-semiconductor-1769325487', '2026-01-27 02:22:21'),
(10035, '2401:4900:7034:f7c9:a899:bff:fe92:4caa', 'introduction-to-web-development-1769276377', '2026-01-27 02:22:28'),
(10036, '2401:4900:7034:f7c9:a899:bff:fe92:4caa', 'why-should-you-buy-readxhub-1765870703', '2026-01-27 02:22:32'),
(10037, '2401:4900:7034:f7c9:a899:bff:fe92:4caa', 'what-is-android-accessibility-1769190101', '2026-01-27 02:22:37'),
(10038, '2401:4900:7040:9284:f41c:ba1f:f3c4:6928', 'why-organisation-choose-semiconductor-1769325487', '2026-01-27 05:45:40'),
(10040, '2401:4900:7040:9284:f41c:ba1f:f3c4:6928', 'introduction-to-web-development-1769276377', '2026-01-27 05:45:51'),
(10041, '2401:4900:7040:9284:f41c:ba1f:f3c4:6928', 'what-is-android-accessibility-1769190101', '2026-01-27 05:45:58'),
(10043, '2401:4900:7040:9284:f41c:ba1f:f3c4:6928', 'how-to-use-wikipedia-search-inside-readxhub-chat-gdr-guide-1765868531', '2026-01-27 05:46:04'),
(10044, '2401:4900:3e3d:3fc2:90db:e0ff:fe42:4d82', 'why-organisation-choose-semiconductor-1769325487', '2026-01-28 03:40:52'),
(10045, '2401:4900:3e3d:3fc2:90db:e0ff:fe42:4d82', 'introduction-to-web-development-1769276377', '2026-01-28 03:40:57'),
(10046, '2401:4900:3e3d:3fc2:90db:e0ff:fe42:4d82', 'what-is-android-accessibility-1769190101', '2026-01-28 03:41:04'),
(10047, '2401:4900:3e3d:3fc2:90db:e0ff:fe42:4d82', 'introduction-to-accessibility-testing-1768320908', '2026-01-28 03:41:07'),
(10048, '2401:4900:3e3d:3fc2:90db:e0ff:fe42:4d82', 'biography-of-rajsingh-1766887252', '2026-01-28 03:41:11'),
(10049, '2401:4900:3e3d:3fc2:90db:e0ff:fe42:4d82', 'talking-to-a-fish-in-an-aquarium-1751185246', '2026-01-28 03:41:14'),
(10050, '2401:4900:3e3d:3fc2:90db:e0ff:fe42:4d82', 'why-should-you-buy-readxhub-1765870703', '2026-01-28 03:41:20'),
(10052, '2401:4900:b561:a422:e1b2:8377:430c:a1db', 'why-organisation-choose-semiconductor-1769325487', '2026-01-28 18:13:14'),
(10053, '2401:4900:b561:a422:e1b2:8377:430c:a1db', 'introduction-to-web-development-1769276377', '2026-01-28 18:13:18'),
(10054, '2401:4900:b55d:2b1e:c86a:e60f:e056:562c', 'introduction-to-web-development-1769276377', '2026-01-29 04:11:33'),
(10055, '2409:40c4:30ab:fee8:9012:1083:a053:7620', 'swatantrata-1761235115', '2026-01-29 06:16:24'),
(10056, '2409:40c4:30ab:fee8:9012:1083:a053:7620', 'introduction-to-accessibility-testing-1768320908', '2026-01-29 06:18:11'),
(10057, '2409:40c4:30ab:fee8:9012:1083:a053:7620', 'the-truth-behind-love-1754417224', '2026-01-29 06:20:19'),
(10058, '2409:40c4:30ab:fee8:9012:1083:a053:7620', 'why-organisation-choose-semiconductor-1769325487', '2026-01-29 06:20:51'),
(10059, '2401:4900:b55c:dd20:c86a:e60f:e056:562c', 'why-organisation-choose-semiconductor-1769325487', '2026-01-29 06:21:26'),
(10061, '2401:4900:b55c:dd20:c86a:e60f:e056:562c', 'who-is-adarsh-creator-and-founder-of-readxhub-1765870571', '2026-01-29 06:23:09'),
(10062, '2401:4900:b55c:dd20:c86a:e60f:e056:562c', 'pratyavaran-1750673649', '2026-01-29 06:23:22'),
(10063, '2401:4900:b55c:dd20:c86a:e60f:e056:562c', 'the-path-of-light-1750519785', '2026-01-29 06:23:25'),
(10064, '2401:4900:b55c:dd20:c86a:e60f:e056:562c', '-1753081731', '2026-01-29 06:23:28'),
(10065, '2401:4900:b55c:dd20:c86a:e60f:e056:562c', 'new-bharat-1754907771', '2026-01-29 06:23:32'),
(10070, '185.132.178.95', 'why-organisation-choose-semiconductor-1769325487', '2026-01-29 15:36:48'),
(10071, '185.132.178.95', 'introduction-to-web-development-1769276377', '2026-01-29 15:36:56'),
(10072, '185.132.178.95', 'introduction-to-accessibility-testing-1768320908', '2026-01-29 15:37:10'),
(10074, '185.132.178.95', 'founder-and-co-founder-1766538737', '2026-01-29 15:37:24'),
(10076, '185.132.178.95', 'swatantrata-1761235115', '2026-01-30 00:55:15'),
(10079, '2401:4900:715b:a1cf::3b:3baa', 'why-organisation-choose-semiconductor-1769325487', '2026-01-31 01:55:43'),
(10080, '2401:4900:384d:825b:2:2:ce86:c998', 'why-organisation-choose-semiconductor-1769325487', '2026-01-31 10:05:53'),
(10083, '2401:4900:384d:825b:2:2:ce86:c998', 'introduction-to-web-development-1769276377', '2026-01-31 12:11:18'),
(10084, '2401:4900:71b0:e7de:e1:60b5:db92:2fc0', 'why-organisation-choose-semiconductor-1769325487', '2026-02-01 03:57:23'),
(10086, '2401:4900:7042:ceff:d43f:3aff:fe2f:2cee', 'who-is-adarsh-creator-and-founder-of-readxhub-1765870571', '2026-02-02 05:49:37'),
(10088, '2401:4900:7042:ceff:d43f:3aff:fe2f:2cee', 'why-should-you-buy-readxhub-1765870703', '2026-02-02 05:49:54'),
(10089, '2401:4900:7042:ceff:d43f:3aff:fe2f:2cee', 'introduction-to-web-development-1769276377', '2026-02-02 05:50:02'),
(10090, '2401:4900:7663:c28b:a030:5cff:fe60:f4a7', 'introduction-to-web-development-1769276377', '2026-02-03 06:44:57'),
(10091, '2401:4900:7663:c28b:a030:5cff:fe60:f4a7', 'why-organisation-choose-semiconductor-1769325487', '2026-02-03 06:45:02'),
(10092, '2401:4900:7789:c988:1c61:5473:cd51:57e0', 'why-organisation-choose-semiconductor-1769325487', '2026-02-03 10:00:36'),
(10093, '2401:4900:7789:c988:1c61:5473:cd51:57e0', 'introduction-to-web-development-1769276377', '2026-02-03 10:00:48'),
(10094, '2401:4900:7789:c988:1c61:5473:cd51:57e0', 'introduction-to-accessibility-testing-1768320908', '2026-02-03 10:00:56'),
(10095, '125.17.13.54', 'who-is-adarsh-creator-and-founder-of-readxhub-1765870571', '2026-02-04 13:55:06'),
(10096, '125.17.13.54', 'why-organisation-choose-semiconductor-1769325487', '2026-02-04 13:57:06'),
(10097, '2401:4900:767b:4533:ddb2:a5f9:44a:71b1', 'why-organisation-choose-semiconductor-1769325487', '2026-02-04 13:57:07'),
(10098, '192.178.8.73', 'why-organisation-choose-semiconductor-1769325487', '2026-02-04 13:57:10'),
(10101, '2401:4900:b3d0:f815:689b:1cff:fedf:5944', 'why-organisation-choose-semiconductor-1769325487', '2026-02-05 12:58:11'),
(10102, '2401:4900:b3d0:f815:689b:1cff:fedf:5944', 'introduction-to-web-development-1769276377', '2026-02-05 13:19:08'),
(10103, '2401:4900:b473:5465:4574:4705:bcf5:be88', 'why-organisation-choose-semiconductor-1769325487', '2026-02-09 15:02:30'),
(10104, '2401:4900:715b:a07e::23:9f83', 'why-organisation-choose-semiconductor-1769325487', '2026-02-10 12:21:37'),
(10105, '2401:4900:b526:927b:19d8:33d1:7d2d:97cc', 'why-organisation-choose-semiconductor-1769325487', '2026-02-12 04:32:48'),
(10106, '2402:3a80:45c0:75c9:a532:98f9:bc24:9a97', 'pratyavaran-1750673649', '2026-02-13 06:19:18'),
(10107, '2402:3a80:45c0:75c9:a532:98f9:bc24:9a97', 'why-organisation-choose-semiconductor-1769325487', '2026-02-13 06:19:52'),
(10108, '2401:4900:b588:5ed3:19d8:33d1:7d2d:97cc', 'introduction-to-web-development-1769276377', '2026-02-13 08:50:12'),
(10109, '2401:4900:b588:5ed3:19d8:33d1:7d2d:97cc', 'who-is-adarsh-creator-and-founder-of-readxhub-1765870571', '2026-02-13 08:50:18'),
(10110, '2401:4900:73ec:ff2e:34c5:e4ff:fe7c:2138', 'why-organisation-choose-semiconductor-1769325487', '2026-02-15 06:23:30'),
(10111, '2401:4900:73ec:ff2e:34c5:e4ff:fe7c:2138', 'readxhub-gdr-smart-knowledge-retrieval-inside-chat-1765889339', '2026-02-15 06:23:36'),
(10113, '2401:4900:73ec:ff2e:34c5:e4ff:fe7c:2138', 'what-is-android-accessibility-1769190101', '2026-02-15 06:42:12'),
(10115, '2401:4900:73e4:290c:7406:7f68:acb0:9999', 'why-organisation-choose-semiconductor-1769325487', '2026-02-15 12:36:21'),
(10116, '2401:4900:73e2:40b9:f051:efff:fed0:223a', 'why-organisation-choose-semiconductor-1769325487', '2026-02-16 10:39:23'),
(10117, '2401:4900:73f4:2576:f4c2:b76f:b331:ff04', 'why-organisation-choose-semiconductor-1769325487', '2026-02-17 06:18:10'),
(10120, '2401:4900:3e48:23bc:5c4b:b457:2c64:b757', 'new-bharat-1754907771', '2026-02-22 04:08:10'),
(10122, '2401:4900:b4eb:fe0b:f496:baff:fe43:2b2f', 'introduction-to-web-development-1769276377', '2026-02-25 03:26:45'),
(10123, '2401:4900:b4eb:fe0b:f496:baff:fe43:2b2f', 'introduction-to-accessibility-testing-1768320908', '2026-02-25 03:26:55'),
(10124, '2401:4900:3cdb:b488::3d:7117', 'introduction-to-web-development-1769276377', '2026-03-01 03:48:16'),
(10125, '2401:4900:3b02:c4cc:45ef:3aa:5c2d:db01', 'what-is-android-accessibility-1769190101', '2026-03-01 14:50:08'),
(10126, '2409:40e4:1082:3a9e:5e3f:91e6:a5b9:c3b8', 'the-path-of-light-1750519785', '2026-03-02 06:25:27'),
(10127, '2401:4900:3cdb:a0be::36:1bbc', 'why-organisation-choose-semiconductor-1769325487', '2026-03-05 10:54:52'),
(10128, '2401:4900:3cab:a019::21:e961', 'why-organisation-choose-semiconductor-1769325487', '2026-03-06 03:53:11'),
(10129, '2401:4900:b585:922f:553a:5a4e:3cbc:f132', 'why-organisation-choose-semiconductor-1769325487', '2026-03-07 16:22:06'),
(10130, '2401:4900:705a:10d5:8f7:c07a:5e75:9b4c', 'why-should-you-buy-readxhub-1765870703', '2026-03-10 01:54:37'),
(10131, '2401:4900:b462:b074:f816:1ff:fe53:16d9', 'introduction-to-accessibility-testing-1768320908', '2026-03-12 13:55:40'),
(10133, '2401:4900:b563:9752:cccb:b3ff:fee8:f61b', 'what-is-android-accessibility-1769190101', '2026-03-16 10:55:51'),
(10135, '103.160.27.112', 'introduction-to-web-development-1769276377', '2026-03-17 13:21:47'),
(10136, '103.160.27.112', 'why-organisation-choose-semiconductor-1769325487', '2026-03-19 12:09:09'),
(10137, '2401:4900:88d2:f71f:6205:ad3f:bc:9146', 'biography-of-rajsingh-1766887252', '2026-03-19 12:09:21'),
(10140, '103.108.5.238', 'why-organisation-choose-semiconductor-1769325487', '2026-03-26 06:08:38'),
(10141, '103.108.5.238', 'to-the-thriving-addiction-towards-petrichor-1751185171', '2026-03-26 14:14:57'),
(10143, '103.108.5.238', 'what-is-android-accessibility-1769190101', '2026-03-26 14:21:40'),
(10145, '103.108.5.238', 'new-bharat-1754907771', '2026-03-26 14:31:11'),
(10146, '2401:4900:88d1:2d8c:160c:72bd:9946:31dd', 'why-organisation-choose-semiconductor-1769325487', '2026-03-26 18:50:10'),
(10147, '103.108.5.64', 'introduction-to-web-development-1769276377', '2026-03-27 13:26:48'),
(10148, '103.108.5.64', 'readxhub-gdr-smart-knowledge-retrieval-inside-chat-1765889339', '2026-03-27 13:26:52'),
(10149, '103.108.5.64', 'introduction-to-accessibility-testing-1768320908', '2026-03-27 13:26:59'),
(10150, '103.108.5.64', 'what-is-android-accessibility-1769190101', '2026-03-27 13:35:38'),
(10151, '103.108.5.46', 'why-organisation-choose-semiconductor-1769325487', '2026-04-04 05:18:06'),
(10152, '2409:4085:3dcd:235b::e34b:c518', 'the-path-of-light-1750519785', '2026-04-05 13:57:42'),
(10153, '2409:4085:3dcd:235b::e34b:c518', 'why-organisation-choose-semiconductor-1769325487', '2026-04-05 13:58:03'),
(10154, '2409:4085:3dcd:235b::e34b:c518', 'introduction-to-web-development-1769276377', '2026-04-05 13:58:18'),
(10155, '2409:4085:3dcd:235b::e34b:c518', 'the-truth-behind-love-1754417224', '2026-04-05 13:58:48'),
(10157, '2401:4900:767d:fa93:bc26:15ff:fe12:c0d6', 'what-is-android-accessibility-1769190101', '2026-04-28 03:09:19'),
(10158, '2401:4900:767d:fa93:bc26:15ff:fe12:c0d6', 'why-organisation-choose-semiconductor-1769325487', '2026-04-28 03:09:22'),
(10160, '2401:4900:767d:fa93:bc26:15ff:fe12:c0d6', 'introduction-to-web-development-1769276377', '2026-04-28 03:09:32'),
(10161, '2401:4900:767d:fa93:bc26:15ff:fe12:c0d6', 'life-of-an-iit-aspirant-a-rollercoaster-ride-1750678198', '2026-04-28 03:09:36'),
(10162, '2401:4900:767d:fa93:bc26:15ff:fe12:c0d6', 'how-to-use-wikipedia-search-inside-readxhub-chat-gdr-guide-1765868531', '2026-04-28 03:09:38'),
(10163, '2401:4900:767d:fa93:bc26:15ff:fe12:c0d6', 'daily-tired-student-life-1750675612', '2026-04-28 03:09:40'),
(10164, '2401:4900:767d:fa93:bc26:15ff:fe12:c0d6', 'pratyavaran-1750673649', '2026-04-28 03:09:42'),
(10165, '103.108.5.114', 'what-is-android-accessibility-1769190101', '2026-05-02 06:31:52'),
(10166, '103.108.5.114', 'complete-html-tutorial-in-hinglish-step-by-step-for-beginners-1777781983', '2026-05-03 04:19:52'),
(10167, '103.108.5.181', 'complete-html-tutorial-in-hinglish-step-by-step-for-beginners-1777781983', '2026-05-04 14:46:41'),
(10168, '103.108.5.181', 'threshold-density-1751185016', '2026-05-04 14:50:48'),
(10169, '103.108.5.75', 'what-is-android-accessibility-1769190101', '2026-05-18 08:23:07'),
(10170, '103.108.5.128', 'why-organisation-choose-semiconductor-1769325487', '2026-05-20 11:01:17'),
(10171, '103.108.5.128', 'introduction-to-web-development-1769276377', '2026-05-20 12:21:42'),
(10172, '103.108.5.199', 'new-bharat-1754907771', '2026-05-23 12:11:27'),
(10173, '2401:4900:88d0:65da:e498:fa23:98d2:f302', 'introduction-to-web-development-1769276377', '2026-06-07 04:11:10'),
(10174, '103.108.5.226', 'why-organisation-choose-semiconductor-1769325487', '2026-06-10 04:18:26'),
(10176, '103.108.5.226', 'introduction-to-web-development-1769276377', '2026-06-10 04:18:45'),
(10177, '2401:4900:8381:b601:290d:c46:5201:b3e5', 'what-is-android-accessibility-1769190101', '2026-06-13 11:51:56'),
(10178, '2401:4900:8381:b601:290d:c46:5201:b3e5', 'introduction-to-web-development-1769276377', '2026-06-13 11:52:09'),
(10179, '103.108.5.14', 'introduction-to-accessibility-testing-1768320908', '2026-06-18 02:21:13'),
(10180, '103.108.5.14', 'to-the-thriving-addiction-towards-petrichor-1751185171', '2026-06-20 16:57:57'),
(10181, '2409:40e4:1084:408b:c0b:ec7a:e6a9:64d5', 'to-the-thriving-addiction-towards-petrichor-1751185171', '2026-06-21 00:43:30'),
(10182, '2409:40e4:1084:408b:c0b:ec7a:e6a9:64d5', 'introduction-to-web-development-1769276377', '2026-06-21 00:43:50'),
(10183, '2409:40e4:1084:408b:c0b:ec7a:e6a9:64d5', 'who-is-adarsh-creator-and-founder-of-readxhub-1765870571', '2026-06-21 00:44:03'),
(10184, '2409:40e4:1084:408b:c0b:ec7a:e6a9:64d5', 'the-truth-behind-love-1754417224', '2026-06-21 00:44:27'),
(10185, '2409:40e4:1084:408b:c0b:ec7a:e6a9:64d5', 'life-of-an-iit-aspirant-a-rollercoaster-ride-1750678198', '2026-06-21 00:45:07'),
(10186, '2409:40e4:1084:408b:c0b:ec7a:e6a9:64d5', 'the-path-of-light-1750519785', '2026-06-21 00:45:56'),
(10187, '2409:40e4:1084:408b:c0b:ec7a:e6a9:64d5', 'threshold-density-1751185016', '2026-06-21 00:46:05'),
(10189, '2409:40e4:1084:408b:c0b:ec7a:e6a9:64d5', 'talking-to-a-fish-in-an-aquarium-1751185246', '2026-06-21 00:46:12'),
(10190, '2409:40e4:1084:408b:c0b:ec7a:e6a9:64d5', 'staged-lives-1751185306', '2026-06-21 00:46:17'),
(10191, '103.108.5.68', 'who-is-adarsh-creator-and-founder-of-readxhub-1765870571', '2026-06-23 04:22:08'),
(10192, '103.108.5.68', 'why-organisation-choose-semiconductor-1769325487', '2026-06-23 04:59:05'),
(10193, '103.108.5.68', 'new-bharat-1754907771', '2026-06-23 06:40:04'),
(10199, '103.108.5.68', 'pratyavaran-1750673649', '2026-06-23 06:42:18'),
(10205, '103.108.5.68', 'introduction-to-web-development-1769276377', '2026-06-23 06:46:00'),
(10206, '103.108.5.68', 'what-is-android-accessibility-1769190101', '2026-06-23 06:46:17'),
(10207, '103.108.5.68', 'swatantrata-1761235115', '2026-06-23 07:39:51');

-- --------------------------------------------------------

--
-- Table structure for table `chat_messages`
--

CREATE TABLE `chat_messages` (
  `id` int(11) NOT NULL,
  `sender_email` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `sent_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `chat_messages`
--

INSERT INTO `chat_messages` (`id`, `sender_email`, `message`, `sent_at`) VALUES
(1, 'dhruv.gagandevraj@gmail.com', 'Hello', '2024-09-30 04:44:37'),
(2, 'adarsh.singhvishnu@gmail.com', 'hi', '2024-09-30 04:44:53'),
(3, 'adarsh.singhvishnu@gmail.com', 'hello', '2024-09-30 15:08:32'),
(4, 'adarsh.singhvishnu@gmail.com', 'sun rha hai', '2024-09-30 15:19:38'),
(5, 'adarsh.singhvishnu@gmail.com', 'adarsh', '2024-12-16 08:27:54');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `video_day` int(11) NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `reply_to` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `video_day`, `email`, `comment`, `reply_to`, `created_at`) VALUES
(50, 2, 'jhavinay897@gmail.com', 'This is fully useful to prank on your Frend 🙂', 0, '2024-09-21 11:26:48'),
(51, 2, 'pinkeedevi10100@gmail.com', 'Sir mera 10 15 classes unlock kar dijiye please', 0, '2024-09-22 05:47:54'),
(52, 2, 'pinkeedevi10100@gmail.com', 'But it\'s also slow. Even we can use website which are fast', 50, '2024-09-22 05:52:00'),
(53, 2, 'khushivishnushankarsingh@gmail.com', 'Thank you 😊', 0, '2024-10-06 02:08:39'),
(56, 1, 'subhamsingh10100@gmail.com', 'wonderful! i love to learn the hacking by you sir', 0, '2024-11-25 06:36:39'),
(57, 1, 'v3344856@gmail.com', 'very interesting course for ethical hacking and a good website ', 56, '2024-12-01 12:51:43');

-- --------------------------------------------------------

--
-- Table structure for table `contact_messages`
--

CREATE TABLE `contact_messages` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `contact_messages`
--

INSERT INTO `contact_messages` (`id`, `name`, `email`, `phone`, `message`, `created_at`) VALUES
(2, 'Adarsh', 'adars3@gmai.com', '8789587841', 'I wanna talk to you', '2025-02-11 08:42:29'),
(3, '', '', '', '', '2025-02-12 08:56:48'),
(4, 'Abhinav Kumar', 'abhinav6204651@gmail.com', '9341337085', 'Hi bro Hi to talk to you tomorrow ', '2025-02-12 08:56:48'),
(5, '', '', '', '', '2025-02-12 15:35:21'),
(6, '', '', '', '', '2025-02-15 11:55:00'),
(7, 'khushi devi ', 'khushivishnushankarsingh@gmail.com', '8810560868', 'this is my first ', '2025-02-15 11:55:00');

-- --------------------------------------------------------

--
-- Table structure for table `contact_submissions`
--

CREATE TABLE `contact_submissions` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `submitted_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `contact_submissions`
--

INSERT INTO `contact_submissions` (`id`, `name`, `email`, `message`, `submitted_at`) VALUES
(2, 'Babuni', 'babunidevi10100@gmail.com', 'Adarsh is good', '2026-02-14 05:59:03');

-- --------------------------------------------------------

--
-- Table structure for table `coursebuyer`
--

CREATE TABLE `coursebuyer` (
  `id` int(11) NOT NULL,
  `name` varchar(40) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `phone` bigint(12) NOT NULL,
  `country` varchar(15) NOT NULL,
  `country_code` varchar(5) NOT NULL,
  `amount` varchar(10) NOT NULL,
  `address` varchar(100) NOT NULL,
  `day_count` int(11) NOT NULL,
  `order_id` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `device_id` varchar(100) NOT NULL,
  `ip_address` varchar(20) NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT current_timestamp(),
  `otp` varchar(6) NOT NULL,
  `latitude` varchar(50) NOT NULL,
  `longitude` varchar(55) NOT NULL,
  `google_id` varchar(255) DEFAULT NULL,
  `google_access_token` text DEFAULT NULL,
  `google_name` varchar(255) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `uniquecode` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `email_sent` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `coursebuyer`
--

INSERT INTO `coursebuyer` (`id`, `name`, `email`, `profile_image`, `phone`, `country`, `country_code`, `amount`, `address`, `day_count`, `order_id`, `password`, `device_id`, `ip_address`, `datetime`, `otp`, `latitude`, `longitude`, `google_id`, `google_access_token`, `google_name`, `date_of_birth`, `profile_picture`, `uniquecode`, `created_at`, `email_sent`) VALUES
(59, 'Raj ', 'rajheartkiller18110@gmail.com', NULL, 9795647253, '', '', '', 'Sumbhi bazar Gambhirvan azamgarh uttar pradesh ', 0, '', '$2y$10$pTBbuEM4bO1pGuedpANTW.17TD02fyiLUmNgMQN8dYvT0Zu/qLE9m', 'user_68e9f73e602003.37193007', '2401:4900:a50a:a89a:', '2024-08-21 10:54:01', '', '0.00000000', '0.00000000', NULL, NULL, NULL, '1970-01-01', NULL, '', '2024-09-21 03:56:02', 0),
(60, 'Tera bhai', 'deenukmwt277@gmail.com', 'uploads/deenukmwt277@gmail.com/file-GpBCZdtaju8yWSGcEFrctZ.webp', 7726919294, '', '', '', 'Bhilwara', 0, '', '$2y$10$8MqLpfvwPyO5a0KVu.kk5Osf15yp0aoCm/s5mqVjqWe5UKSLCGh1K', 'user_693912d9efcc47.62632724', '2409:4085:4e18:da1::', '2024-07-01 11:39:43', '', '25.354137', '74.6491306', NULL, NULL, 'Deendayal Kumawat', '1970-01-01', 'uploads/deenukmwt277@gmail.com/ACg8ocICa6rgEwOyoxYldhU949jbx13wug64okZfB-MsVzqV-TNo3A=s96-c', '', '2024-09-21 03:56:02', 0),
(61, 'Vinay jha', 'jhavinay897@gmail.com', 'uploads/jhavinay897@gmail.com/IMG_20241014_105142.jpg', 987654321, '', '', '', 'Mayur Vihar, Delhi, India', 0, '', '$2y$10$DCQEltMfM4RwZVs3KjhAIOxMOWFAhVr9Eluk00NLhsGBr9mR3rAaC', 'user_692d32ae473542.50665592', '2409:4050:d8b:6086::', '2024-08-22 02:23:04', '', '28.60607410', '77.31823990', NULL, NULL, 'vinay Jha', '1970-01-01', 'uploads/jhavinay897@gmail.com/ACg8ocKWj1UM43evKWhX1rTjJ94QbuUvZC_JaGtGDCWEdTwPtiY9pM0M=s96-c', '', '2024-09-21 03:56:02', 0),
(62, 'Aditya', 'amahi5136@gmail.com', NULL, 6446469568, '', '', '', '', 0, '', '$2y$10$UcRswdvXa8N7Z5INQc9Q4uLetRkqUOuGHnpRimUJwvTdtUfAPS29O', '', '', '2024-08-22 03:51:25', '', '0.00000000', '0.00000000', NULL, NULL, NULL, NULL, NULL, '', '2024-09-21 03:56:02', 0),
(63, 'Akash', 'aryasatyam1121@gmail.com', NULL, 8953483194, '', '', '', 'Mayur Vihar, Delhi, India', 0, '', '$2y$10$.gThWE67WLfEnGjMu4dHz.53L9xT8U.vv8drmUF6xTaIhY49YMWJu', '', '', '2024-08-22 05:48:30', '', '28.60627670', '77.31862200', NULL, NULL, NULL, NULL, NULL, '', '2024-09-21 03:56:02', 0),
(64, 'Adarsh', 'ninij78254@albarulo.com', NULL, 9289851174, '', '', '', 'New Delhi, Delhi, India', 0, '', '$2y$10$wp4pJbfbHnh/./NSLxu2WOjx02EMfsWal2WnrqzsaVGdNfeStwdEC', '', '', '2024-08-22 07:48:31', '', '28.61301760', '77.23089920', NULL, NULL, NULL, NULL, NULL, '', '2024-09-21 03:56:02', 0),
(65, 'Inha', 'annieallen88328@gmail.com', NULL, 7827792717, '', '', '', '', 0, '', '$2y$10$hC/Ckop6F22pegoB6zCpT.8Lvn4iGj8QTGYun4wG2Q.enWZfd1g.i', '', '', '2024-08-22 13:41:34', '', '0.00000000', '0.00000000', NULL, NULL, NULL, NULL, NULL, '', '2024-09-21 03:56:02', 0),
(74, 'Satish ranjan', 'bgmi73169@gmail.com', 'uploads/bgmi73169@gmail.com/1000070185.jpg', 7481010522, '', '', '', 'Patahi, Bihar, India', 0, '', '$2y$10$nODUHWHU.Vocnbstev.zQOgy9XhesdYL.c0x/pOoiURXoXJGbSsVm', '', '', '2024-08-25 03:59:23', '', '', '', NULL, NULL, NULL, NULL, NULL, '', '2024-09-21 03:56:02', 0),
(75, 'Rahul', 'anshu123@gmail.com', NULL, 8839667422, '', '', '', 'Indoor', 0, '', '$2y$10$pGnUZFLLciRFy3nVDNt4EeEjb3UPxHbfdmU/b/ybAhAtfFxbwtp3i', '66cee100972fa', '2409:4050:2dcd:90e5:', '2024-08-25 04:36:36', '', '', '', NULL, NULL, NULL, '1970-01-01', NULL, '', '2024-09-21 03:56:02', 0),
(81, 'Nipu', 'nipudevi8801@gmail.com', NULL, 91, '', '', '', 'Preet Vihar, Delhi, India', 0, '', '$2y$10$FIX3QEeC/o6aJdyNndmcOudKSEmFkApp8yILFb/361YalU1kyHEsC', '66d701b2443d3', '2401:4900:5d86:bfba:', '2024-08-28 11:41:18', '', '28.6287612', '77.3194588', NULL, NULL, 'Nipu devi', '1970-01-01', 'uploads/nipudevi8801@gmail.com/ACg8ocLKSPiZQtgcmNuUa3YYBesf7uwlQQzM21Q8UaqSh8dL2yTQJXc=s96-c', '', '2024-09-21 03:56:02', 0),
(82, 'Bongoni Devendar Goud', 'goudd461@gmail.com', NULL, 7569208544, '', '', '', 'Warangal ', 0, '', '$2y$10$Zl77UV2oeIgfAFsuGIHMneYNNB1csviCXs2TCsGOEy3B/tmnPN0Ye', '', '', '2024-08-30 06:57:00', '', '', '', NULL, NULL, NULL, NULL, NULL, '', '2024-09-21 03:56:02', 0),
(83, 'Pranab', 'pranavneechadi@gmail.com', NULL, 65366526347, '', '', '', 'Bengaluru, Karnataka, India', 0, '', '$2y$10$Pei3ezDdIn5FvoX8E2gGQOUDne7GJIRvzJCoU.RIivgmHkxzXxG2a', '', '', '2024-08-30 07:04:28', '', '13.001348', '77.5645309', NULL, NULL, NULL, NULL, NULL, '', '2024-09-21 03:56:02', 0),
(85, 'Muhammad Zohaib Amjad', 'zabiim02@gmail.com', NULL, 3495448578, '', '', '', 'Dha Phase 8', 0, '', '$2y$10$SMFap5tXq4vBozavlUzbyOdupkbxyEJn0Ih9Fh0KzYMgMYBaeIlNe', '', '', '2024-08-30 07:35:10', '', '', '', NULL, NULL, NULL, NULL, NULL, '', '2024-09-21 03:56:02', 0),
(87, 'Aniruďha Chaudhari', 'chaudharianirudha899@gmail.com', NULL, 7863858813, '', '', '', 'Gandhinagar ', 0, '', '$2y$10$mEVoKxkQ7m3x4vY0trp/secRgUMcoYaMdGnx2LM6yj03bnSGDjG7y', '', '', '2024-08-30 11:32:22', '', '', '', NULL, NULL, NULL, NULL, NULL, '', '2024-09-21 03:56:02', 0),
(88, 'Amit kumar', 'sacik76359@kwalah.com', NULL, 9263205072, '', '', '', 'Daman', 0, '', '$2y$10$C/Tcat5s.5hgBubpAwOZ4.mO34lIrD.kByUpoROwp/nHcfRWW0foW', '66d205f6ef874', '2409:40c1:28:40e1:88', '2024-08-30 17:45:23', '', '', '', NULL, NULL, NULL, '1970-01-01', NULL, '', '2024-09-21 03:56:02', 0),
(89, 'Hari', 'harikaran3123@gmail.com', NULL, 918668181098, '', '', '', '', 0, '', '$2y$10$mOSTeeOfAIQyC0phSEg8Tu/I2P4g5d.rRe48AM3McBp3.zN1wO9cm', '', '', '2024-08-30 18:35:16', '', '', '', NULL, NULL, NULL, NULL, NULL, '', '2024-09-21 03:56:02', 0),
(90, 'Prince', 'princemth10@gmail.com', NULL, 7261869603, '', '', '', 'Phagwara punjab', 0, '', '$2y$10$Dnouqi3EByNvuPyWxqe2aenihfCKE2fUlOY8Ad/J59/KEJ36YgnWq', '', '', '2024-08-30 18:38:36', '', '', '', NULL, NULL, NULL, NULL, NULL, '', '2024-09-21 03:56:02', 0),
(92, 'Supriya', 'supriyasruji@gmail.com', NULL, 8143253698, '', '', '', 'Andhra Pradesh, India', 0, '', '$2y$10$1.Rab5gfnl6tb7.GBWw3suOme7VmpPpOk5CHit.kEFilZjPwJtGVu', '675e74844fc7c', '2401:4900:33a6:d072:', '2024-09-05 05:41:35', '', '', '', NULL, NULL, NULL, '1970-01-01', NULL, '', '2024-09-21 03:56:02', 0),
(93, 'Raj', 'raj22293114@gmail.com', NULL, 9310659353, '', '', '', 'Dallypura delhi 110096', 0, '', '$2y$10$Wbt/pb6NmIAYbIAupfKXz.lizbjQDeScDK5alLnAxJwir4jtJg9yy', '66d9a2265ee19', '2405:204:3489:63ac:5', '2024-09-05 12:17:54', '', '', '', NULL, NULL, NULL, '1970-01-01', NULL, '', '2024-09-21 03:56:02', 0),
(94, 'Omji', 'vinodkumary414@gmail.com', NULL, 9971731395, '', '', '', 'Habra mhaola dallupura ', 0, '', '$2y$10$na0sWYBprasFbNlWyyZHn.4K6REGFVpWznlq3RWX39njE1mmx2Hzq', '66d9ed2dcb13b', '2401:4900:5d99:37ad:', '2024-09-05 17:35:48', '', '', '', NULL, NULL, NULL, '1970-01-01', NULL, '', '2024-09-21 03:56:02', 0),
(95, 'Farhan ', 'farhanian4u@gmail.com', NULL, 9154556988, '', '', '', 'South City Mall, 375, Prince Anwar Shah Rd, South City Complex, Jadavpur, Kolkata', 0, '', '$2y$10$Ictg96hlzaTLR3b0orSGhOMmvYtsX8V5UBvskgoVUixhJ9Y7JEJJW', '66dbc798804f3', '103.73.196.9', '2024-09-07 03:23:48', '', '', '', NULL, NULL, NULL, '1970-01-01', NULL, '', '2024-09-21 03:56:02', 0),
(98, 'Shohan Khan', 'kshohan.personal@gmail.com', NULL, 8801621297636, '', '', '', 'Tangail, Dhaka, Bangladesh', 0, '', '$2y$10$y5Qkt6f.3QoqxIZ1gTSLJejKDjU9adcrvENMuiJCccUh020vLs1W.', '66edd80d2f04d', '103.157.94.60', '2024-09-20 20:15:49', '', '', '', NULL, NULL, NULL, '1970-01-01', NULL, '', '2024-09-21 03:56:02', 0),
(99, 'Sanaya', 'pinkeedevi10100@gmail.com', 'uploads/pinkeedevi10100@gmail.com/images.jpeg', 8521634215, '', '', '', 'Preet Vihar, Delhi, India', 0, '', '$2y$10$ADfXIGJplVY795pyvY5LWe20K9WuZ/w.nsX6nw3TPMVNCJ2MJiWZK', '66f209b090750', '2409:4050:e41:1512::', '2024-09-01 02:35:23', '', '28.6290666', '77.3197346', NULL, NULL, NULL, '1970-01-01', NULL, '', '2024-09-22 05:46:13', 0),
(100, 'Niraj Shaw', 'nirajshaw1320@gmail.com', NULL, 8294354630, '', '', '', 'Bharat mata colony, mauri gram ', 0, '', '$2y$10$MDOjdwwpjzfr7mbZEjf6mu21GZwlmUUzry/EGIJ7YXkfLTz3AoNtO', '674d617715f2f', '223.191.37.118', '2024-09-27 14:30:52', '', '', '', NULL, NULL, NULL, '1970-01-01', NULL, '', '2024-09-27 14:30:52', 0),
(108, 'Utkarsh kumar', 'khushisinghadarsh@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJWKpfb2SuZ5S1L2IhbdAXrkYkv55k95KJaSeY9XUa3eNhZhV-W=s96-c', 9334670998, '', '', '', 'Mothihari', 0, '', '$2y$10$kPKgPvngc2/rqkvSP8AHV.ys8EjlhU9PhUWT14WJiV5vp5m.BAtuC', 'user_693e2f2e296379.03188645', '139.5.242.178', '2024-09-10 02:19:03', '', '26.6583266', '84.9316762', '111623594566264262666', NULL, NULL, '2008-09-29', 'https://lh3.googleusercontent.com/a/ACg8ocJWKpfb2SuZ5S1L2IhbdAXrkYkv55k95KJaSeY9XUa3eNhZhV-W=s96-c', '', '2024-09-30 02:17:08', 0),
(110, 'Dhruv', 'dhruv.gagandevraj@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLwn8Hr-Wd-7xB2ZHsyHoR-718tiqa0T6n5mnsZbwthWalgmA=s96-c', 9707798078, '', '', '', 'Preet Vihar', 0, '', '$2y$10$xEhY5.Jp6ygXCI6dp4AL3uw0aDJgDLwVGEHdnH47RrodSzTUUVvYW', '66fa2c7f926cd', '2409:4050:2e80:a4d4:', '2024-09-30 04:43:43', '', '28.6292666', '77.319759', '100068658424070509474', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocLwn8Hr-Wd-7xB2ZHsyHoR-718tiqa0T6n5mnsZbwthWalgmA=s96-c', '', '2024-09-30 04:43:43', 0),
(112, 'Ankush Kumar', 'ankushkumar80176@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocI7Y9wFkX7AFc8Euc9FKcx22TqzQKjXQsBA_6KDL3Q5MYtKyg=s96-c', 6203728878, '', '', '', 'Patahi', 0, '', '$2y$10$UTN5TzOz1L9.pYq/pX7tAe9OZRIcjoRZh3fokb9E6TLsoVKHL4qfO', '69df2a1e32aad', '2401:4900:7051:64fd:', '2024-10-02 09:41:01', '', '', '', '105361124765055551693', NULL, 'Ankush Kumar', '1970-01-01', 'uploads/ankushkumar80176@gmail.com/ACg8ocIo0yHyIutxkjD2R6g1Nb7ktA4AzQWsFOde0oF1Moy6wR1F1nHF=s96-c', '', '2024-10-02 09:41:01', 0),
(114, 'Parmod ', 'gpramod09@gmail.com', NULL, 9920219054, '', '', '', 'Sumbhi bazar gambhirvan Azamgarh ', 0, '', '$2y$10$DX64oWKNjSfPSnzqYSZSAeq31AhDosnepH4iEhM5pgW5aAyYa4hPq', '', '', '2024-10-18 13:21:04', '', '', '', NULL, NULL, NULL, NULL, NULL, '', '2024-10-18 13:21:04', 0),
(115, 'Sanjeev Yadav', 'sanjeev8400yadav@gmail.com', NULL, 8400760557, '', '', '', 'L 266 Delta 2 Greater Noida Uttar Pradesh', 0, '', '$2y$10$0d4hzg0seEkeRYRaiQM8t.GyLXI.pXdQTNBVy6pKGNq2KIvB8A1Mm', '6719f22f81d84', '2409:40e3:101e:a723:', '2024-10-24 07:06:06', '', '', '', NULL, NULL, NULL, NULL, NULL, '', '2024-10-24 07:06:06', 0),
(116, 'Sreenu', 's80752791@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLC36vkdU2roMA77FYer1RnbVdwBO8glj1UTlQbk00Ixg16LA=s96-c', 7676494820, '', '', '', 'Bangolore ', 0, '', '$2y$10$6IyHoThzrCVJfr4KOjMHTea6FBtMwZmbRl2oIND6UqqyU0qMr5sma', '671b27640d4a9', '2409:40f0:102e:4d3d:', '2024-09-15 05:11:59', '', '', '', '113552564042972408991', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocLC36vkdU2roMA77FYer1RnbVdwBO8glj1UTlQbk00Ixg16LA=s96-c', '', '2024-10-25 05:06:44', 0),
(117, 'Donthakur', 'd822719@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocIMmoiCfP8CMI5JD-d0aUMb8MbnDWvUx1Xc8EHOutvgmQUzig=s96-c', 6307366473, '', '', '', 'Hasanganj', 0, '', '$2y$10$s/03MlP2tf5avbJ6A7gQMOSm3DCDbtzvxXrH949ZNjl9SaE4xByui', '671b43ea53390', '2409:40e3:103f:94f8:', '2024-10-05 07:11:52', '', '26.6196145', '80.6787704', '101297769478687868395', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocIMmoiCfP8CMI5JD-d0aUMb8MbnDWvUx1Xc8EHOutvgmQUzig=s96-c', '', '2024-10-25 07:08:07', 0),
(118, 'Madhu Priya', 'madhupriya33447@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocK21fDtVqFmqQQ_NvrFdXAOTLWLHRpZV7fFp_bEld5Blt_FjA=s96-c', 9199683814, '', '', '', 'Garhwa', 0, '', '$2y$10$PEGOJB4qfoiU.4lXtfuwGu9nUueKz0hqaf0LIPw2kkV9maREScoZq', '674b306cc7c09', '2409:40e4:2002:1816:', '2024-09-15 07:15:54', '', '', '', '101760842949758896880', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocK21fDtVqFmqQQ_NvrFdXAOTLWLHRpZV7fFp_bEld5Blt_FjA=s96-c', '', '2024-10-25 07:08:12', 0),
(119, 'Sreenu Abhilash', 'sreenuabhilash7464@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocIuCxb1nTsnK-ebsOyaVEFzEyOsbD-ZUMDPOpEdr7SCZILj9Evo=s96-c', 0, '', '', '', '', 0, '', '$2y$10$kifOQb3TEdiLGi2ZiSOVEuaoITFPAtka1SlGGX0vUc1qBHwlirHqy', '671b96d9086e4', '2409:40f0:102e:4d3d:', '2024-10-25 13:02:17', '', '', '', '112577323852380860385', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocIuCxb1nTsnK-ebsOyaVEFzEyOsbD-ZUMDPOpEdr7SCZILj9Evo=s96-c', '', '2024-10-25 13:02:17', 0),
(120, 'Mharish', 'harish.76711@gmail.com', NULL, 6301316594, '', '', '', 'Dharmavaram (Satya Sai dist)', 0, '', '$2y$10$xH4A9LhdBQL8uzvxF8z07uwBPI4V78UXeD6T0TipezcLWA1eNPUJ6', '671d09abcfc06', '2409:408c:119a:1d62:', '2024-10-26 14:52:19', '', '', '', NULL, NULL, NULL, NULL, NULL, '', '2024-10-26 14:52:19', 0),
(121, 'Satyam Singh', 'singhsatyam5212@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJXrM3Y5aLGkV3obGRmoUn1AaTZZeBSSy2HVfi8WY719Saao3M=s96-c', 8419855212, '', '', '', 'Add:-vill bhaisaura,unnao', 0, '', '', '671ddd22f161b', '2409:40e3:4018:a780:', '2024-10-27 06:26:42', '', '', '', '102492096378664213318', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocJXrM3Y5aLGkV3obGRmoUn1AaTZZeBSSy2HVfi8WY719Saao3M=s96-c', '', '2024-10-27 06:26:42', 0),
(122, 'Shivam singh', 'shivamsingh69399@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocL0ji-V241L_c-It5cU_uU7FGUEobZsExfXqTeOxIfk6INN4A=s96-c', 8607650982, '', '', '', 'Muzaffarpur', 0, '', '', '671fa4d418b15', '2402:3a80:1c4d:60e6:', '2024-10-28 14:51:00', '', '26.1224637', '85.3780454', '103157547785989007335', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocL0ji-V241L_c-It5cU_uU7FGUEobZsExfXqTeOxIfk6INN4A=s96-c', '', '2024-10-28 14:51:00', 0),
(123, 'Sudhanshu Agarwal', 'shudhanshusanam0@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKfvg1ysFOYg-U2dVIHj3clhmydw_e0fsvdpeEFMRUFGwpxxhvi=s96-c', 7352107842, '', '', '', 'Mothihari', 0, '', '', '67204eae0d8fa', '2401:4900:3b1f:756:9', '2024-09-19 03:12:04', '', '26.6607866', '84.9316157', '112714541195405825960', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocKfvg1ysFOYg-U2dVIHj3clhmydw_e0fsvdpeEFMRUFGwpxxhvi=s96-c', '', '2024-10-29 02:55:42', 0),
(124, 'Durgesh Soni', 'dur2122soni@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocIzVN89E2Q1b-_c86OIr188npqucRNs4VNb9ZSfjSGMSZh6t7dB=s96-c', 6375754921, '', '', '', 'Nagaur Rajasthan ', 0, '', '', '672078166aaf9', '2409:40d4:1014:f3de:', '2024-10-29 05:52:22', '', '', '', '112623584945002851590', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocIzVN89E2Q1b-_c86OIr188npqucRNs4VNb9ZSfjSGMSZh6t7dB=s96-c', '', '2024-10-29 05:52:22', 0),
(125, 'AKASH KUMAR', 'akashstark01@gmail.com', NULL, 7903230688, '', '', '', 'KOSHI COLONY WARD NO-17 ', 0, '', '$2y$10$5T/h5GNHsNOw3x8fESUBHOueSCAuFjldyiqihSligPOj4VnXHWr6G', '', '', '2024-10-29 14:42:47', '', '', '', NULL, NULL, NULL, NULL, NULL, '', '2024-10-29 14:42:47', 0),
(126, 'Waqas Ahmad', 'wj75377835@gmail.com', NULL, 923176345241, '', '', '', 'Pakistan punjab jhang', 0, '', '$2y$10$ZybyVrAcbEsCF9xw/63V3OMNRsK/GRjR/LqHVC6Z98vy7lJngS9Sy', '67238b4bb0a53', '223.123.8.154', '2024-10-27 03:49:28', '', '', '', NULL, NULL, NULL, NULL, NULL, '', '2024-10-31 13:50:08', 0),
(127, 'Rehan', 'rreehhaann123123@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocIuRC_Ifg7_EFF8cK_2Z2ywj7rGlIrbNHOMbUwN065TWi6DStE=s96-c', 7324949840, '', '', '', 'Dhaka', 0, '', '', '6724c72981c16', '2401:4900:73e5:26c9:', '2024-11-01 12:18:49', '', '26.641819', '85.2222652', '112571789977284180515', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocIuRC_Ifg7_EFF8cK_2Z2ywj7rGlIrbNHOMbUwN065TWi6DStE=s96-c', '', '2024-11-01 12:18:49', 0),
(128, 'Lol gamer 666', 'l82705724@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKtYo7kSucB-VpFxXp4OcWn9OQxxcfBbZTATQ7Op_miI0d-oQ=s96-c', 7070430499, '', '', '', 'Teghra', 0, '', '', '6726ebe8d6ed6', '2401:4900:73e5:a53e:', '2024-10-29 03:21:54', '', '25.4910757', '85.9409048', '100405381744586707596', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocKtYo7kSucB-VpFxXp4OcWn9OQxxcfBbZTATQ7Op_miI0d-oQ=s96-c', '', '2024-11-03 03:20:08', 0),
(129, 'Devil Aisha', 'devilaisha.ai@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJhMcPBrCKGxU5etKpyVjnWoDDhbs7bCj53PePoQgHl300J8Q=s96-c', 7595858945, '', '', '', 'Naity road me know these 😂😂 next ', 0, '', '', '67276560ba522', '2405:201:8003:7037:9', '2024-11-03 11:58:24', '', '', '', '116168363393590557797', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocJhMcPBrCKGxU5etKpyVjnWoDDhbs7bCj53PePoQgHl300J8Q=s96-c', '', '2024-11-03 11:58:24', 0),
(130, 'Che', 'leompena42@gmail.com', NULL, 7175143219, '', '', '', 'Washington, District of Columbia, United States of America (the)', 0, '', '$2y$10$IKx1V2jQMJmvdD.00p9dZu5ajFNoHOLqwItiVepSCloDKWHDTCSkK', '', '', '2024-10-05 01:40:12', '', '38.883333', '-77', NULL, NULL, NULL, NULL, NULL, '', '2024-11-04 01:38:05', 0),
(131, 'Youssef', 'youssefwblor@gmail.com', NULL, 201210889966, '', '', '', 'Vjsiirubrjs jdjrj idjdb', 0, '', '$2y$10$9oQKVR9tINLISm.cGolp1.MbIirJEQt8C/qZF6HO3TXpWgGApzV16', '672830fceb340', '156.202.52.89', '2024-10-05 02:30:08', '', '', '', NULL, NULL, NULL, NULL, NULL, '', '2024-11-04 02:26:31', 0),
(132, 'Alka Kumari', 'alka.kumarikaran@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKOZg4UnG4rQUC7QPHVH4uLpXeNhBxrLQNRXHmXbDunMJtTUg=s96-c', 0, '', '', '', '', 0, '', '', '672b486c17c40', '223.176.23.252', '2024-11-06 10:43:56', '', '', '', '106880335027622844457', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocKOZg4UnG4rQUC7QPHVH4uLpXeNhBxrLQNRXHmXbDunMJtTUg=s96-c', '', '2024-11-06 10:43:56', 0),
(133, 'RadhaKrishna', 'twoaffen777@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLfEs5wF10DCMC1jGRrt2buC1m9tqas0BOIU8dKe3atSYjg0A=s96-c', 7983695599, '', '', '', 'Dehradun ', 0, '', '', '673095b4d480c', '2409:40d2:2d:f3e:800', '2024-10-11 11:57:27', '', '', '', '105168996858936309609', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocLfEs5wF10DCMC1jGRrt2buC1m9tqas0BOIU8dKe3atSYjg0A=s96-c', '', '2024-11-10 11:15:00', 0),
(134, 'Parkash PK', 'ppk956231@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLzD1oE-xEO1HMKE7Fe1eZ-Z5K7ij_YhfA2oi5aH6rm-d3t7FI=s96-c', 33346794, '', '', '', 'Xd', 0, '', '$2y$10$mcOZXFanSU3J7DZyPbhtze8UMvx47zgn.sgjtDxszZnuw/Y.mPIpe', '67360dfed122d', '43.242.178.30', '2024-11-14 14:49:34', '', '', '', '111296513587338081752', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocLzD1oE-xEO1HMKE7Fe1eZ-Z5K7ij_YhfA2oi5aH6rm-d3t7FI=s96-c', '', '2024-11-14 14:49:34', 0),
(135, 'VISHAL shehzada', 'vishalshehzada63@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocITB9_Xw5vzOnU7aThZ6yIo2LbqQJpX6mNZ4GV-W98kfmgdZw=s96-c', 9896100703, '', '', '', 'Yamunanagar', 0, '', '', '673b0c28bfe57', '2409:4051:189:3458::', '2024-11-18 09:43:04', '', '30.1296868', '77.288069', '110880829331513680429', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocITB9_Xw5vzOnU7aThZ6yIo2LbqQJpX6mNZ4GV-W98kfmgdZw=s96-c', '', '2024-11-18 09:43:04', 0),
(136, 'Rishiraj singh', 'rishirajs182@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLyEJ4v0vb7h_erNRedVuQU_7J63MfWlPZE_Vh3PNCYEF8xyQ=s96-c', 9138135798, '', '', '', 'Bahadurgarh,haryana', 0, '', '', '673b2ad5588e2', '45.249.87.131', '2024-11-14 11:56:45', '', '', '', '109012542465584947948', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocLyEJ4v0vb7h_erNRedVuQU_7J63MfWlPZE_Vh3PNCYEF8xyQ=s96-c', '', '2024-11-18 11:53:57', 0),
(138, 'Lpwjhariya Golll', 'gollllpwjhariya@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocI-16lqaC9lRBeOLos33F2utVDcT9ams35_NS34WBJ7CTlw9g=s96-c', 8794681105, '', '', '', 'Sikandarabad', 0, '', '$2y$10$cjwSJ3AfJXQWSbPNj.FJluoeQqJTuiAFtbEhs9biQLMLRAyew/p7m', '675556263f768', '139.5.248.201', '2024-10-30 16:11:37', '', '', '', '109443800209518529728', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocI-16lqaC9lRBeOLos33F2utVDcT9ams35_NS34WBJ7CTlw9g=s96-c', '', '2024-11-19 08:12:53', 0),
(139, 'Goverdhan Bairagi ', 'goverdhanbairagi623@gmail.com', NULL, 7879000938, '', '', '', 'Shadora , ashoknagar in mp', 0, '', '$2y$10$ViIW9xByKlmjyiZZpiIfd.3q4hXWx2w0TA1rtWBP8xTljasm0cyKa', '673da5729a158', '2409:40c4:302e:b772:', '2024-11-11 10:12:13', '', '', '', NULL, NULL, NULL, NULL, NULL, '', '2024-11-20 09:00:32', 0),
(140, 'Rohit Rajput', 'rohitrj6787@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLLT_uMgzLCh5jyzXOTIfvDIewMGoJyWLmA8sJMRmDfwgkXYw=s96-c', 0, '', '', '', '', 0, '', '', '67847c606c38c', '2405:201:5c12:e048:7', '2024-11-20 09:40:44', '', '', '', '106278047720411878914', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocLLT_uMgzLCh5jyzXOTIfvDIewMGoJyWLmA8sJMRmDfwgkXYw=s96-c', '', '2024-11-20 09:40:44', 0),
(141, 'Rohit Rajput', 'rohitrs4504@gmail.com', NULL, 8239848549, '', '', '', 'Jain nasiya road , jain chhatraws, roop vihar colony', 0, '', '$2y$10$3/39oEqrZBDP6YTCKRGUv.ooya3lyi9zSHzQ85/tLu2gC9rviNjyW', '673db10ccbf88', '2405:201:5c12:e058:2', '2024-11-15 10:00:10', '', '', '', NULL, NULL, NULL, NULL, NULL, '', '2024-11-20 09:48:40', 0),
(142, 'Bithika Saha', 'bithikas424@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocL9MSQ9Lbn6TzNYJ4lapPhELCMX81pO8Pw4OaWDN0V65acjwA=s96-c', 0, '', '', '', '', 0, '', '', '673dd008d22a9', '103.189.11.59', '2024-11-20 12:03:20', '', '', '', '108736448520209680004', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocL9MSQ9Lbn6TzNYJ4lapPhELCMX81pO8Pw4OaWDN0V65acjwA=s96-c', '', '2024-11-20 12:03:20', 0),
(143, 'Anshu', 'avni14tamar@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKPFY8z97WkMigf_LAOVfxRjYsWJ6hhIxF2oHH2m4VQ41U9A9A=s96-c', 0, '', '', '', '', 0, '', '', '673ded971e843', '2401:4900:c0e:1e09:7', '2024-11-20 14:09:27', '', '', '', '113570011631885012521', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocKPFY8z97WkMigf_LAOVfxRjYsWJ6hhIxF2oHH2m4VQ41U9A9A=s96-c', '', '2024-11-20 14:09:27', 0),
(144, 'tareq monuwar', 'tareqmining1@gmail.com', NULL, 8801869792130, '', '', '', 'Bishwanath, Sylhet Division, Bangladesh', 0, '', '', '', '', '2024-11-22 05:09:31', '', '24.8184832', '91.7602304', NULL, NULL, NULL, NULL, NULL, '', '2024-11-22 05:09:31', 0),
(145, 'Riya Dav', 'rdav7683@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJs1il-dKGbL2HW8-Uz3FPypZrqDrWZIImlbpVVTyhrL5TuGg=s96-c', 1723047310, '', '', '', 'Patiya', 0, '', '', '6741ac35e9160', '103.185.25.241', '2024-11-23 10:17:07', '', '', '', '116083012653155463197', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocJs1il-dKGbL2HW8-Uz3FPypZrqDrWZIImlbpVVTyhrL5TuGg=s96-c', '', '2024-11-23 10:17:07', 0),
(146, 'Adarsh Kumar', 'adarsh.singhpersonal@gmail.com', 'uploads/adarsh.singhpersonal@gmail.com/Screenshot_2025-01-21_08_33_46.png', 9939914772, '', '', '', 'Dhaka', 0, '', '$2y$10$LCVxE0DqgDSuE47PlQFwKeUatfyVFcKf/6hQWiLQdb4adgdL5XY6S', 'user_6954e2237de716.34863185', '202.173.125.245', '2024-11-24 06:28:29', '', '26.635231', '85.2012236', '110668341056405265800', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocJZ54We60kYEufKwVn4niqDa9ydf3LHGMb5bK-2qAt_6DJbsH0=s96-c', '', '2024-11-24 06:28:29', 0),
(147, 'Rajnish Singh', 'rajnish.ksingh2003@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocInNgespOLLk3Y3bniU1C-lb_e1NFEU8j_P2Hgf_wQm7sd8xQBF=s96-c', 9508718871, '', '', '', 'Patahi', 0, '', '', '6742f60a18f13', '2409:40e4:115c:133d:', '2024-10-25 09:57:56', '', '26.6341839', '85.2578557', '103214946199462361841', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocInNgespOLLk3Y3bniU1C-lb_e1NFEU8j_P2Hgf_wQm7sd8xQBF=s96-c', '', '2024-11-24 09:46:50', 0),
(148, 'Guddi Singh', 'singhguddi17088@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKB0rdUmY-FrUam4jOslH7M5uimNnjOSYfag0RgO41KjTH6=s96-c', 7484952547, '', '', '', 'Dhaka', 0, '', '', '6743df9b4b372', '2402:8100:2636:70df:', '2024-11-25 02:23:23', '', '26.6372773', '85.2513864', '113725627114623221290', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocKB0rdUmY-FrUam4jOslH7M5uimNnjOSYfag0RgO41KjTH6=s96-c', '', '2024-11-25 02:23:23', 0),
(149, 'Ankit Rajput', 'ankitrajput26598@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKRhEuXyZovOi9Ua1JfXVdm_G0R7bGtpy7vUcxpZweXOXeQng=s96-c', 7739555374, '', '', '', 'Dhaka', 0, '', '', '674405984b2f4', '2409:408a:2bc3:b772:', '2024-11-25 05:05:28', '', '26.6372773', '85.2513864', '103911745571241290523', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocKRhEuXyZovOi9Ua1JfXVdm_G0R7bGtpy7vUcxpZweXOXeQng=s96-c', '', '2024-11-25 05:05:28', 0),
(150, 'subham singh', 'subhamsingh10100@gmail.com', 'uploads/subhamsingh10100@gmail.com/hacker image download.jpg', 9518491795, '', '', '', 'Patna', 0, '', '', '67441a2517050', '2409:408a:2bc3:b772:', '2024-11-16 06:40:33', '', '25.5940947', '85.1375645', '106673268606170087083', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocIzcEMtWBH5dDdX_LYi0rcwywjW1IPcWTm0zDeLYY9xyKeOqA=s96-c', '', '2024-11-25 06:33:09', 0),
(151, 'Amit ', 'ourvlogsteam@gmail.com', NULL, 8292785894, '', '', '', 'Jharkhand Jharkhand ', 0, '', '$2y$10$GDtaWBN95B/pzxub2MkuleefCZiOVYQ7Xa/gIIb6JHIHma.9P/7tq', '67455ecd5a02a', '152.58.134.30', '2024-11-26 05:35:48', '', '', '', NULL, NULL, NULL, '1970-01-01', NULL, '', '2024-11-26 05:35:48', 0),
(152, 'Zakwan Ansari', 'zakwanansari70272@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKM1MXGGqT9om7TkFv5u7BuCBWb-NHcKYtCewPYQo-5tivERZc=s96-c', 6351993135, '', '', '', 'Moradabad', 0, '', '$2y$10$CyklZOAdrZTxCG2E4tPqmORWCQrw3tsUHSmppwMfs.2SN3/WG8tFi', '6747afacbc042', '2409:40d2:101c:a9ff:', '2024-11-27 23:46:03', '', '28.8296385', '78.8536583', '101535056374809713776', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocKM1MXGGqT9om7TkFv5u7BuCBWb-NHcKYtCewPYQo-5tivERZc=s96-c', '', '2024-11-27 23:46:03', 0),
(153, 'adarsh singh', 'talk@gagandevraj.com', 'uploads/talk@gagandevraj.com/bash2.png', 9878457414, '', '', '', 'New Delhi', 0, '', '', '674aaad753955', '2409:4050:2d02:e8cd:', '2024-11-29 00:25:03', '', '28.6130176', '77.2308992', '103921628581790343411', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocKEo-i8u9F9fhnI6EXMCKbdokPbHPcuO3WR5DNoH9RrrhasfA=s96-c', '', '2024-11-29 00:25:03', 0),
(154, 'Madhumala', 'madhumala902@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocID8roVN-xvpJrDRnPS9DfQ5X8T4E78WPos2eqzvfqHNAGgEg=s96-c', 9835445128, '', '', '', 'Garhwa', 0, '', '', '674b30e10f161', '2409:40e4:2002:1816:', '2024-11-29 05:03:38', '', '', '', '107539543396533844297', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocID8roVN-xvpJrDRnPS9DfQ5X8T4E78WPos2eqzvfqHNAGgEg=s96-c', '', '2024-11-29 05:03:38', 0),
(155, 'Ali Hadi', 'ahdi6929@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJK7SqEFQsa-Hbh8rnAWSyr_WoDw5U82rj5wa2iqQ6phBgbpw=s96-c', 0, '', '', '', '', 0, '', '', '674b3a698b58b', '154.57.223.226', '2024-11-30 16:16:41', '', '', '', '100603849120903176762', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocJK7SqEFQsa-Hbh8rnAWSyr_WoDw5U82rj5wa2iqQ6phBgbpw=s96-c', '', '2024-11-30 16:16:41', 0),
(156, 'I Am', 'raginisharma198689@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJvB9-4zaEeGCHP3DH8oJ8uUwZBwd2SZjh0C2WkYSL8iNgDZw=s96-c', 9805706443, '', '', '', 'Himanchal pradesh', 0, '', '', '674bc9bc596ea', '2401:4900:5f3a:8c9:e', '2024-11-01 02:30:01', '', '', '', '111657147592969566442', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocJvB9-4zaEeGCHP3DH8oJ8uUwZBwd2SZjh0C2WkYSL8iNgDZw=s96-c', '', '2024-12-01 02:28:12', 0),
(157, 'Aryan', 'aryanbabu10100@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLIT3u2dAxVNf4jUkCXpbxa-CzhlYb2KUv0M4IWDA3IehEqmQ=s96-c', 0, '', '', '', '', 0, '', '', '674be71875901', '2405:204:128b:22f6::', '2024-12-01 04:33:28', '', '', '', '112497959344650302394', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocLIT3u2dAxVNf4jUkCXpbxa-CzhlYb2KUv0M4IWDA3IehEqmQ=s96-c', '', '2024-12-01 04:33:28', 0),
(158, 'Babe We', 'babewe763@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocL7Q1mm6J03PBuNSpJbW5oK0I0csYqVjcZRF12LWZECObb_Dg=s96-c', 8091144557, '', '', '', 'Baijnath', 0, '', '', '674bef9820bd1', '2401:4900:5d1f:b57:d', '2024-11-01 05:20:36', '', '32.056606', '76.6444202', '105018240818050476717', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocL7Q1mm6J03PBuNSpJbW5oK0I0csYqVjcZRF12LWZECObb_Dg=s96-c', '', '2024-12-01 05:09:44', 0),
(159, 'RANI DEVI', 'ranisyal1981@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocIS5e1Lw_nWtmcXD0Q-_v5ulztCE1coVZ6QyzCy9OTF-TEJGg=s96-c', 9805101859, '', '', '', 'Baijnath', 0, '', '', '674bf0f75d0ea', '2401:4900:5f10:19da:', '2024-11-01 05:20:43', '', '', '', '115769661346189030946', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocIS5e1Lw_nWtmcXD0Q-_v5ulztCE1coVZ6QyzCy9OTF-TEJGg=s96-c', '', '2024-12-01 05:15:35', 0),
(160, 'Resma Gangupam', 'resmagangupam@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLlnprsCJJZoFPUwA5TTcD5LnarM0VWkOlp_XUjZDnWzmJvqA=s96-c', 8106576239, '', '', '', 'Andhra Pradesh ', 0, '', '', '674c1d34cde88', '2401:4900:6584:fa4f:', '2024-11-01 08:25:56', '', '', '', '115737475668453717305', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocLlnprsCJJZoFPUwA5TTcD5LnarM0VWkOlp_XUjZDnWzmJvqA=s96-c', '', '2024-12-01 08:24:20', 0),
(161, 'vishesh', 'v3344856@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLM8c06DKXwp_MqpWhghbaNACXcBcYRmbdYf0D5exQnRfgArBY=s96-c', 7889432732, '', '', '', 'Civil Lines', 0, '', '$2y$10$NGQB9xr4/JYlQv4J92B1WO5f/6Te/N3laMh2/iM/PD26fLgXyubmW', '675ee00b7e4c0', '2406:b400:71:7b67:35', '2024-11-04 12:53:02', '', '28.6654464', '77.1915776', '109600698837210044177', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocLM8c06DKXwp_MqpWhghbaNACXcBcYRmbdYf0D5exQnRfgArBY=s96-c', '', '2024-12-01 12:48:15', 0),
(162, 'Shiv Bhati', 'shivbhati373@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLlqG0-QVAMSgTxXOkmX5O9Y4_sIhIA5Sk8pbseBI5kknlXUA=s96-c', 0, '', '', '', '', 0, '', '', '674ff6b78110a', '2409:4052:2e40:2a90:', '2024-12-04 06:29:11', '', '', '', '108361124886745895182', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocLlqG0-QVAMSgTxXOkmX5O9Y4_sIhIA5Sk8pbseBI5kknlXUA=s96-c', '', '2024-12-04 06:29:11', 0),
(163, 'Pradip more', 'pm4222570@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocL4ETqhsL12cGW_corF52MOuwG4Ee1INb-FpEPyIvKM6t-vsw=s96-c', 9529992059, '', '', '', 'Gangapur', 0, '', '', '675e9f040543e', '2409:40c2:100c:7364:', '2024-12-15 09:19:00', '', '19.8488772', '75.2112584', '108032173707160615254', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocL4ETqhsL12cGW_corF52MOuwG4Ee1INb-FpEPyIvKM6t-vsw=s96-c', '', '2024-12-15 09:19:00', 0),
(164, 'Bot Suraj', 'botsuraj414@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocIs9eE-mhIkwQuhJyQA7W2SCMafuwFrDWtDKzZzbRp4Pc3ypw=s96-c', 2894354630, '', '', '', 'Bidhannagar', 0, '', '', '675fe253f22f3', '2401:4900:3bd4:535c:', '2024-11-18 08:20:25', '', '22.5816962', '88.4304141', '114473171756797142439', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocIs9eE-mhIkwQuhJyQA7W2SCMafuwFrDWtDKzZzbRp4Pc3ypw=s96-c', '', '2024-12-16 08:18:27', 0),
(167, 'CSEC241102032 Muhammad Haseeb Tariq', 'csec241102032@kfueit.edu.pk', 'https://lh3.googleusercontent.com/a/ACg8ocJ1smaPyhmlQXLEjrujLP54HHr-Qmn8w_2kNQXgZOco1tnXnA=s96-c', 0, '', '', '', '', 0, '', '', '6761a9424f8d8', '175.107.230.17', '2024-12-17 16:39:30', '', '', '', '109801405178860258492', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocJ1smaPyhmlQXLEjrujLP54HHr-Qmn8w_2kNQXgZOco1tnXnA=s96-c', '', '2024-12-17 16:39:30', 0),
(168, 'Adarsh Singh Rajput', 'contactcaadarshyt@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJ9Flm1pflRrg5EQ7y4zq4BqypjllkFd4ySPMINlwo2JDPrug=s96-c', 9946765654, '', '', '', 'Seelam Pur', 0, '', '', '676ffe78d0c6c', '202.173.125.179', '2024-12-28 13:34:48', '', '28.6818304', '77.2636672', '109372146138619396706', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocJ9Flm1pflRrg5EQ7y4zq4BqypjllkFd4ySPMINlwo2JDPrug=s96-c', '', '2024-12-28 13:34:48', 0),
(169, 'Halominaria', 'halominaria@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKxDlWgu2ogl_FG8QtMPF_PFDZdKpWD2R2aBUqWFe9IL0LOr7A=s96-c', 9128562587, '', '', '', 'Civil Lines', 0, '', '$2y$10$xjzC5X7YfKEgFeVue0Yg3unZlwtZJaTUpBLTUUTFr.wyNhizyibsi', '677bae39b897c', '139.5.242.91', '2025-01-02 07:01:46', '', '28.6654464', '77.1915776', '103570570526000618264', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocKxDlWgu2ogl_FG8QtMPF_PFDZdKpWD2R2aBUqWFe9IL0LOr7A=s96-c', '', '2025-01-02 07:01:46', 0),
(170, 'P.bavadesh', 'p.bavadesh@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJLMmH0W224tKxLliG_D67SARAIjUt8f3SV9UNPOMuoKoD72w=s96-c', 0, '', '', '', '', 0, '', '', '6783c208eaf9b', '49.204.107.14', '2025-01-12 13:22:16', '', '', '', '110083278330080834443', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocJLMmH0W224tKxLliG_D67SARAIjUt8f3SV9UNPOMuoKoD72w=s96-c', '', '2025-01-12 13:22:16', 0),
(171, 'Ayushi', 'thissoundssuspicious@gmail.com', 'uploads/thissoundssuspicious@gmail.com/IMG_20250121_100837.png', 7858961142, '', '', '', 'Kuch bhi ', 0, '', '$2y$10$5D20IPBTcu5Wlz4iCXYoDuZBiGzAw6YatRwv.LYAvg/2UvY9vvCJ2', '67a78018aa57f', '2409:40e4:1157:5ea7:', '2024-12-18 06:40:49', '', '', '', '112038562159300320016', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocLQEZSx3emwJ-i6luAme9PIReTU0TyN35iumMneffW4vtosSw=s96-c', '', '2025-01-17 06:39:52', 0),
(172, 'Unicorn House', 'unicornhouse8@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLeRozrPHtk6Q_VDoQA9e_HPDy2ZOF9SX8J8nmvmKrjLZIK6tM=s96-c', 0, '', '', '', '', 0, '', '', '67911e3230f44', '2409:4089:dec4:e604:', '2025-01-22 16:34:58', '', '', '', '117036571370780743210', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocLeRozrPHtk6Q_VDoQA9e_HPDy2ZOF9SX8J8nmvmKrjLZIK6tM=s96-c', '', '2025-01-22 16:34:58', 0),
(173, 'Sarthak Singh', 'singhsarthak79688@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJ1hNz2m2auvr9wjipqTxGjV3rJDjepeHUA8fGZUbXs6G0y_Q=s96-c', 0, '', '', '', '', 0, '', '', '6791dbd06b152', '2409:4063:6dba:d104:', '2025-01-23 06:04:00', '', '', '', '108798578304277807657', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocJ1hNz2m2auvr9wjipqTxGjV3rJDjepeHUA8fGZUbXs6G0y_Q=s96-c', '', '2025-01-23 06:04:00', 0),
(174, 'Abhishek Kumar', 'abhishekk909080@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKg3lJsolJtRCZlbx1-IiqF6QiIHnt9R6TO2-Z5B8MLmVSFFQ=s96-c', 0, '', '', '', '', 0, '', '', '6793151bba631', '2401:4900:8243:a4d1:', '2025-01-24 04:20:43', '', '', '', '100746589603566274381', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocKg3lJsolJtRCZlbx1-IiqF6QiIHnt9R6TO2-Z5B8MLmVSFFQ=s96-c', '', '2025-01-24 04:20:43', 0),
(175, 'We Are champion', 'arechampionw@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLRfROCItO47Gy-ioCI9YnYL6VETvReSnmq4nyOZXNJNRKJlA=s96-c', 9939847342, '', '', '', 'Preet Vihar', 0, '', '', '6794f229ab6b6', '2401:4900:5d9a:bdab:', '2024-12-26 14:19:42', '', '28.6290604', '77.3197465', '108081399268563711850', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocLRfROCItO47Gy-ioCI9YnYL6VETvReSnmq4nyOZXNJNRKJlA=s96-c', '', '2025-01-25 14:16:09', 0),
(176, 'Himanshu Singh', 'singhhimanshu6477@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocI4D3anZI5GlADCCwte6VNXKototSTE_34Zl728lYDKzL94_w=s96-c', 9643926901, '', '', '', 'Preet Vihar', 0, '', '', '67985a3616b57', '2405:204:130a:c012::', '2025-01-28 04:16:54', '', '28.6291594', '77.3196697', '116540518367619025198', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocI4D3anZI5GlADCCwte6VNXKototSTE_34Zl728lYDKzL94_w=s96-c', '', '2025-01-28 04:16:54', 0),
(177, 'Mani Kanta', 'manimudaliyar1997@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKq3TUkvaAJkUi6KnaZlDZaf62bFZX8O3y2PYh5RlIiuPYeDw=s96-c', 0, '', '', '', '', 0, '', '', '6799323515e6c', '2402:8100:25d3:6d21:', '2025-01-28 19:38:29', '', '', '', '110496349731563471337', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocKq3TUkvaAJkUi6KnaZlDZaf62bFZX8O3y2PYh5RlIiuPYeDw=s96-c', '', '2025-01-28 19:38:29', 0),
(178, 'Ahmad Zaki Andarabi', 'azaki.andarabi@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJGjrv5uMIngpMRu32O-9ThyXEhzD5dPR3w9hQMqv51qmKmRM2N=s96-c', 0, '', '', '', '', 0, '', '', '67a6c687ef866', '2600:1003:b104:d372:', '2025-01-28 20:22:11', '', '', '', '105261632631202782044', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocJGjrv5uMIngpMRu32O-9ThyXEhzD5dPR3w9hQMqv51qmKmRM2N=s96-c', '', '2025-01-28 20:22:11', 0),
(179, 'aragsan cali', 'aamino1525@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLt4ByCYI3F4dG2sYi-HjJhOfQo-R6uVS1gG90k9RGADtbk53nl=s96-c', 9101923647, '', '', '', 'Mogadishu', 0, '', '', '6799e042c03b6', '41.78.74.34', '2024-12-30 08:09:56', '', '2.041145220560444', '45.307224880722046', '103956838525606113264', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocLt4ByCYI3F4dG2sYi-HjJhOfQo-R6uVS1gG90k9RGADtbk53nl=s96-c', '', '2025-01-29 08:01:06', 0),
(180, 'sakura demon', 'sakurademon350@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJBbGHphnx0DORzpe-5RrWGz_xtkh-sKXTYBBnrObZfRC4tZQ=s96-c', 0, '', '', '', '', 0, '', '', '679b3e43e29b6', '2401:4900:55b3:28e3:', '2025-01-30 08:54:27', '', '', '', '107075446806446440226', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocJBbGHphnx0DORzpe-5RrWGz_xtkh-sKXTYBBnrObZfRC4tZQ=s96-c', '', '2025-01-30 08:54:27', 0),
(181, 'Blueish_ Makeover', 'poojachauhan7104@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJpGgXlAT1_w6RZ2Wi_jBmp-cpAt1FQi8OjG3llMAeWN9UdQMen=s96-c', 8849867986, '', '', '', 'Khodiyar Nagar,Aspas char rasta ', 0, '', '', '679c3998515fc', '2405:201:2022:809a:2', '2025-01-01 02:49:27', '', '', '', '110153342931592679565', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocJpGgXlAT1_w6RZ2Wi_jBmp-cpAt1FQi8OjG3llMAeWN9UdQMen=s96-c', '', '2025-01-31 02:46:48', 0),
(182, 'Anjal Uchiaa', 'uchiaaanjal@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLVFWJ-wWSJMSMnssT6FgjJPolB-3jWmtN8OgN280q8OxKHYg=s96-c', 0, '', '', '', '', 0, '', '', '679c71d088609', '2400:1a00:baa0:8ab9:', '2025-01-31 06:46:40', '', '', '', '109137611805165758707', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocLVFWJ-wWSJMSMnssT6FgjJPolB-3jWmtN8OgN280q8OxKHYg=s96-c', '', '2025-01-31 06:46:40', 0),
(183, 'Halominaria Business', 'businesshalominaria@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJLafAbQFfTUzsWRCCoUpYjHfXpSRMKmUoJrzgaKX-eDlARnw=s96-c', 0, '', '', '', '', 0, '', '', '679ca0ea4046a', '45.118.159.103', '2025-01-31 10:07:38', '', '', '', '101559417067716329534', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocJLafAbQFfTUzsWRCCoUpYjHfXpSRMKmUoJrzgaKX-eDlARnw=s96-c', '', '2025-01-31 10:07:38', 0),
(184, 'shubham Kumar', 'shubham.0925170@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocIZAXAZ61Pxs832Ci5o_dfQE5tQg0WdMeyjuVixZlwr69lf3Q=s96-c', 7004136542, '', '', '', 'Patna', 0, '', '', '67a46ae06358d', '2409:40e5:1177:5347:', '2025-01-07 07:56:01', '', '25.6442779', '85.0982072', '113643341826104129709', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocIZAXAZ61Pxs832Ci5o_dfQE5tQg0WdMeyjuVixZlwr69lf3Q=s96-c', '', '2025-02-06 07:55:12', 0),
(185, 'Ahmad Zaki Andarabi', 'zakiandarabitech10@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocIqh7jDx-GUY9GvR7wxfI3tG7Wj6Ol1EN5cwWOzgiIdDgaZcQ=s96-c', 0, '', '', '', '', 0, '', '', '67a7551a0ab25', '173.79.213.196', '2025-02-08 12:59:06', '', '', '', '118141611848446290702', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocIqh7jDx-GUY9GvR7wxfI3tG7Wj6Ol1EN5cwWOzgiIdDgaZcQ=s96-c', '', '2025-02-08 12:59:06', 0),
(186, 'Zabi', 'newbiezabii4533@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocL8_pHGU7iE-X9eR6S2m0rAkD2UxQegryzUpoQJlamAb_0PPA=s96-c', 0, '', '', '', '', 0, '', '', '67a76ec1c2048', '37.111.143.188', '2025-02-08 14:48:33', '', '', '', '100087753601737087015', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocL8_pHGU7iE-X9eR6S2m0rAkD2UxQegryzUpoQJlamAb_0PPA=s96-c', '', '2025-02-08 14:48:33', 0),
(188, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', 7897854574, '', '', '', 'Civil Lines', 0, '', '$2y$10$eHgACGWx22UxVQLzSFUpDOSbJQLFTRCk0isBLnZh9l6IXz5JsCM1i', 'user_6a3610e6665a11.86323371', '103.108.5.247', '2025-02-09 02:28:42', '', '28.6654464', '77.1915776', '107567610488532904383', NULL, 'GDR', NULL, 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', '', '2025-02-09 02:28:42', 0),
(189, 'Saziya', 'miss.saziyaa@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJp7Ki-LXlkLYSEU4JFP2xef0UUOZWMcVqvRAqVwcbft9sLKg=s96-c', 6375836151, '', '', '', 'Rajasthan Jaisalmer ', 0, '', '', '67a85a3b761ce', '2409:40d4:205a:bb23:', '2025-01-12 07:36:26', '', '', '', '104884286776030128185', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocJp7Ki-LXlkLYSEU4JFP2xef0UUOZWMcVqvRAqVwcbft9sLKg=s96-c', '', '2025-02-09 02:52:51', 0),
(190, 'Ragini Rawat', 'raginiragrawat@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKrM2WbQ7Vik8Mqn_y5lk5JTEKVDuPdSlusO0_jUSGIIYec6w=s96-c', 9340295239, '', '', '', 'Indore ', 0, '', '$2y$10$CYYfQKHmMOUbzCjf3BOYSON5Boiufyp..ITICi.dD8olMF2xzv15O', '6866062e266ba', '2409:4081:9d95:ebce:', '2025-01-10 11:05:31', '', '', '', '109817035970589768733', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocKrM2WbQ7Vik8Mqn_y5lk5JTEKVDuPdSlusO0_jUSGIIYec6w=s96-c', '', '2025-02-09 11:03:40', 0),
(193, 'Adarsh Singh', 'adarshfinalchannel@gmail.com', 'uploads/adarshfinalchannel@gmail.com/Screenshot_2025-03-23-13-53-00-88_3aea4af51f236e4932235fdada7d1643.jpg', 9472153681, 'India', '', '', 'Civil Lines', 0, '', '$2y$10$kpjjywWz32qnHfZdJF8rUuV/wuW2fpuBq9nfzAZhoxl2EQWQh50d.', 'user_6a3a0573732016.68523341', '2401:4900:3c92:875f:', '2025-02-10 04:35:22', '', '28.6654464', '77.1915776', '114000931693797833432', NULL, 'Adarsh Singh', NULL, 'uploads/adarshfinalchannel@gmail.com/ACg8ocIikx352-eGDuN3w03OD52sYyhgz81xGPZrBJNtuTPLuG9aEQ=s96-c', '', '2025-02-10 04:35:22', 0),
(194, 'Abhinav Kumar', 'abhinav6204651@gmail.com', '', 9341337085, 'India', '', '', 'Durga Mandir Road Chanpatia Ward No 4', 0, '', '', '67ac5a912231b', '2409:40e4:1115:f76f:', '2025-01-15 08:25:18', '', '', '', '115964176522031687784', NULL, NULL, NULL, '', '', '2025-02-12 08:23:45', 0),
(195, 'Khushi Singh', 'khushisingh892210@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJh6UQYj9JOZkNtq559lwnh53EdHID6PM-d_hyPWt7Vc4cZqw=s96-c', 7761962802, 'India', '', '', 'khushisingh892210@gmail.com', 0, '', '$2y$10$ec9d55PSQ9CWOP4j9JccJ.vKPIMTa2eRkFYAEoQCjm4H8E2wimleO', '67af479a2c7cb', '111.93.173.114', '2025-01-15 10:12:05', '', '', '', '101404688280123772110', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocJh6UQYj9JOZkNtq559lwnh53EdHID6PM-d_hyPWt7Vc4cZqw=s96-c', '', '2025-02-14 09:52:52', 0),
(196, 'Adarsh', 'adarsh.singhvaishnu@gmail.com', NULL, 9472152687, '', '', '3990000', 'delhi', 0, 'order_PyCqhaReCXituj', '', '', '', '2025-02-21 03:07:24', '', '', '', NULL, NULL, NULL, NULL, NULL, '', '2025-02-21 03:07:24', 0),
(197, 'Adarsh Kumar Dubey', 'kumardubeyadarsh67@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLa4LMn7u01CQrLBfPb78YyNj6f4yZ9-PD57_ad_pRVr4PX3s8K=s96-c', 9534250452, 'India', '', '', 'D A V PUBLIC SCHOOL, CONTRACTORS AREA, BISTUPUR JAMSHEDPUR, EAST SINGHBHUM, JHARKHAND', 0, '', '', '67e552b525351', '2409:40e5:204f:d259:', '2025-03-27 13:29:25', '', '', '', '101874577983216110430', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocLa4LMn7u01CQrLBfPb78YyNj6f4yZ9-PD57_ad_pRVr4PX3s8K=s96-c', '', '2025-03-27 13:29:25', 0),
(198, 'CA BANTAI YT_69', 'atharvadevadkar@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLCiZyVlbPoF-Zipy--TZ6tQ7wnBttWGyLpJJ3AGAR7EKp64Ac=s96-c', 0, '', '', '', '', 0, '', '', '67e69b2e7f722', '111.125.253.45', '2025-03-28 12:50:54', '', '', '', '102375450819140825205', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocLCiZyVlbPoF-Zipy--TZ6tQ7wnBttWGyLpJJ3AGAR7EKp64Ac=s96-c', '', '2025-03-28 12:50:54', 0),
(199, 'Raj Singh', 'mr.rajsingh.student@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocIGQ9s5Seuqg2xELDPdgwmBH6VTL22SMOW3tJ9nRCxofF8RP1A=s96-c', 9795647253, 'American Samoa', '', '', 'Egbethfqwykenfehmstsrgrkgtrdhfgcbdnrnrbfrgdbwegnsenwgfbeyfbegeyhecehwtegbeg ok efjyj fgesm enskyhksd', 0, '', '', '693c1c6425f2e', '103.108.5.146', '2025-03-06 07:40:43', '', '', '', '109133759577445922181', NULL, 'Raj Singh', NULL, 'uploads/mr.rajsingh.student@gmail.com/ACg8ocIqP2A0rkXwDsyP6IC_TFubRqVi01FJyCoPoyO7YQNjfMXggplx=s96-c', '', '2025-04-05 07:36:56', 0),
(200, 'Yaar Gagat', 'yaargagat23@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocIkMXpTwtLQuyFUFpwWy-hpzPZ-LSsdB0SlCfRuABsFfuqI7aEE=s96-c', 6239889604, 'India', '', '', 'yaargagat23@gmail.com', 0, '', '', '67fe6a829fc9e', '223.184.204.12', '2025-04-15 14:15:26', '', '', '', '110372455490295458235', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocIkMXpTwtLQuyFUFpwWy-hpzPZ-LSsdB0SlCfRuABsFfuqI7aEE=s96-c', '', '2025-04-15 14:15:26', 0),
(201, 'Heline Heline', 'helinetutecalme@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLRHwQNUM9iCg72nxgIjc_OTY2vGY33Iqpy9GQtaXtLY_dPsw=s96-c', 618346136, 'France', '', '', 'auvraytanguy35310@gmail.com', 0, '', '', '6803a82a9132b', '2a02:8440:7143:1a02:', '2025-04-19 13:42:02', '', '', '', '116751063701851151208', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocLRHwQNUM9iCg72nxgIjc_OTY2vGY33Iqpy9GQtaXtLY_dPsw=s96-c', '', '2025-04-19 13:42:02', 0),
(202, 'Rahul Bisht', '12rahulbisht@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocIHbWgG3ydfqFIRt632KaM7CwbJ1IdqBGN1VMas_v9EeJFWsw=s96-c', 0, '', '', '', '', 0, '', '', '680616eabccd5', '2409:40d2:65:fc6:800', '2025-04-21 09:59:06', '', '', '', '115804194139936894353', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocIHbWgG3ydfqFIRt632KaM7CwbJ1IdqBGN1VMas_v9EeJFWsw=s96-c', '', '2025-04-21 09:59:06', 0),
(203, 'Fake account', 'itisreadxhub@gmail.com', 'uploads/itisreadxhub@gmail.com/red-devil-face-8ijyi31ij1qeudnc.jpg', 9472153687, 'India', '', '', 'Loni', 0, '', '$2y$10$mhdLDj.MBGPhsb9joz/WCO32QZpunD3bFdAhQV/y4WAsU7qbc6DeK', 'user_69030465cbcd23.20943218', '2409:40d0:27:961e:80', '2025-05-04 15:27:05', '', '28.7277056', '77.2931584', '118142639371343650256', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocKgA9MRKc4wOgvV7GxpdDliN08iZSBX_j1OLEimh6jGgQAafw=s96-c', '', '2025-05-04 15:27:05', 0),
(204, 'Level sabke niklenge', 'levelsabkeniklenge028@gmail.com', 'uploads/levelsabkeniklenge028@gmail.com/vishesh.jpg', 7827571466, 'India', '', '', 'Ghaziabad', 0, '', '', '6821645050107', '106.219.165.156', '2025-04-12 04:04:16', '', '28.6359552', '77.3357568', '107622540092361633801', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocKnFquTC_sj99vkdQvgpw_Jk3tYSmcTU_qh4RPtT3wy9yBM7g=s96-c', '', '2025-05-12 03:00:32', 0),
(205, 'Sneha Singh', 'ss3916443@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJxSb1B_D515Fe13CsVwHb0ebPJaCppQLXl-0iAwVKXhDqkJQ=s96-c', 0, '', '', '', '', 0, '', '', '68283c004335a', '139.5.242.44', '2025-05-17 07:34:24', '', '', '', '106588969749583071426', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocJxSb1B_D515Fe13CsVwHb0ebPJaCppQLXl-0iAwVKXhDqkJQ=s96-c', '', '2025-05-17 07:34:24', 0),
(206, 'Unknown User', 'adarshsingh22042006@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJmgHXcQCiuq6FzkNF6e1ujd02mDeMdGvi2eE7dcJ32EwgTTw=s96-c', 8794681105, 'India', '', '', 'Kapila Nagar, Hydershakote, Gandipet mandal, Ranga Reddy, Telangana, 500091, India', 0, '', '', '68ee2e302abb1', '103.108.5.139', '2025-06-21 14:46:06', '', '17.3674234', '78.3935333', '108827765641131061880', NULL, 'Shruti Deshmukh', NULL, 'uploads/adarshsingh22042006@gmail.com/ACg8ocI7QuJthRXcQasoD7D-ZpSQSbxI9XgH42vrNMk4OlSlEEOFGGc=s96-c', '', '2025-06-21 14:46:06', 0),
(207, 'AMAZON PRIME', 'amazonprimevdo2727@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocIicLRlikdaiWGt6cZz55oq8ygnU01TfuKz2X7YSn_OCxhMgw=s96-c', 11111111, 'India', '', '', 'Aaaaa', 0, '', '', '685fe360dc6c2', '117.214.90.125', '2025-06-27 15:44:23', '', '', '', '102373076089895001927', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocIicLRlikdaiWGt6cZz55oq8ygnU01TfuKz2X7YSn_OCxhMgw=s96-c', '', '2025-06-27 15:44:23', 0),
(208, 'Khushi Singh', 'khushivishnushankarsingh@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJoGqKBurlJGNVA_cBwU6lJQaneVqR48oJwI5uik5TsZzvRyIaA=s96-c', 8810560868, 'India', '', '', 'Padam Nagar, Civil Lines Tehsil, Delhi, Central Delhi, Delhi, 110006, India', 0, '', '', '685fd7c8d3f4e', '202.173.125.8', '2025-06-28 11:53:44', '', '28.6654464', '77.1915776', '107644282521055941310', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocJoGqKBurlJGNVA_cBwU6lJQaneVqR48oJwI5uik5TsZzvRyIaA=s96-c', '', '2025-06-28 11:53:44', 0),
(209, 'Udit kumar', 'labudit436@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocK-73eEcUh7YH6o0KnFh7MHlx8ZSVAqnPgFGG0_J5nuN35m92g=s96-c', 0, '', '', '', '', 0, '', '', '68694a8bdcf0d', '103.165.22.198', '2025-07-05 15:53:47', '', '', '', '117562140928302542267', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocK-73eEcUh7YH6o0KnFh7MHlx8ZSVAqnPgFGG0_J5nuN35m92g=s96-c', '', '2025-07-05 15:53:47', 0),
(210, 'Bertrand Cartiaux', 'bertrand.cartiaux1@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocI3KcWzLPhf1jUrrwciik9YTV9l6xqvdprA2iA1I2pouzeZ_g=s96-c', 0, '', '', '', '', 0, '', '', '687a371e25b9c', '92.154.24.212', '2025-07-18 11:59:26', '', '', '', '113005619343806079506', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocI3KcWzLPhf1jUrrwciik9YTV9l6xqvdprA2iA1I2pouzeZ_g=s96-c', '', '2025-07-18 11:59:26', 0);
INSERT INTO `coursebuyer` (`id`, `name`, `email`, `profile_image`, `phone`, `country`, `country_code`, `amount`, `address`, `day_count`, `order_id`, `password`, `device_id`, `ip_address`, `datetime`, `otp`, `latitude`, `longitude`, `google_id`, `google_access_token`, `google_name`, `date_of_birth`, `profile_picture`, `uniquecode`, `created_at`, `email_sent`) VALUES
(211, 'RUDRAKSH', 'rudra81785@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKT6UTST8u4I2ZFHY6e0ZfQC9uUMYt0EPqDcJOdsalPXzpe-w=s96-c', 9205489279, 'India', '', '', 'Uttam Nagar East, Dwarka Tehsil, South West Delhi, Delhi, 110059, India', 0, '', '', '687bd604ec90d', '2401:4900:a137:b14d:', '2025-07-19 17:29:40', '', '28.6212634', '77.0692139', '107971275245517331019', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocKT6UTST8u4I2ZFHY6e0ZfQC9uUMYt0EPqDcJOdsalPXzpe-w=s96-c', '', '2025-07-19 17:29:40', 0),
(212, 'Rekha devi Rana', 'ranarekhadevi20@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocK7-r6U_x4qTLtFfJXvntNYPEilVkNxqpaunELmSbdS31fclw=s96-c', 0, '', '', '', '', 0, '', '', '688878143e31a', '2409:40e4:1351:93b:8', '2025-07-29 07:28:20', '', '', '', '104532777561840147348', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocK7-r6U_x4qTLtFfJXvntNYPEilVkNxqpaunELmSbdS31fclw=s96-c', '', '2025-07-29 07:28:20', 0),
(213, 'Adarsh Bhai', 'adarshjisinghvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLaPXlO24ETboV96kZ-N_IeAA6KI--qfm1UIwJFNLTi6R9YYOg=s96-c', 9939914772, 'India', '', '', 'Paharganj, Karol Bagh Tehsil, Central Delhi, Delhi, 110055, India', 0, '', '', '691dc2cf2ab07', '103.108.5.123', '2025-09-05 06:45:43', '', '28.6425088', '77.2145152', '106560722237407588759', NULL, 'Adarsh Bhai', NULL, 'uploads/adarshjisinghvishnu@gmail.com/ACg8ocKri0lLDBC6lFecFwHyUNDt1PPMaVQ-tqU7DnAevdBiuetlXOxy=s96-c', '', '2025-09-05 06:45:43', 0),
(214, 'Ayushi Sharma', 'ayushisharma9972@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLowGLuDPkQXfo_BMRzdoJoMYXOn0BKuy73LbZ14TZgeJiGb48=s96-c', 9939914772, 'India', '', '', 'Surya Niketan, Vivek Vihar Tehsil, Shahdara, Delhi, 110095, India', 0, '', '', '68c550fe0dbed', '103.108.5.107', '2025-09-13 11:09:50', '', '28.655616', '77.3095424', '104712748052924294677', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocLowGLuDPkQXfo_BMRzdoJoMYXOn0BKuy73LbZ14TZgeJiGb48=s96-c', '', '2025-09-13 11:09:50', 0),
(215, 'Saziya 24', 'saziyasaziya3501@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocIrwa1XuhS1a49kY501u5Q8XNp7fXaTJ1gVlikoOLHENSGryA=s96-c', 0, '', '', '', '', 0, '', '', '68c68d9869f85', '2409:40d4:205c:e2d3:', '2025-09-14 09:39:44', '', '', '', '108919174523542899676', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocIrwa1XuhS1a49kY501u5Q8XNp7fXaTJ1gVlikoOLHENSGryA=s96-c', '', '2025-09-14 09:39:44', 0),
(216, 'Pravesh Yadav', 'praveshyadavahir07@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKzmhV_Yho3FoSDBkngIeVgiSLMJwZwd-S0hRQWnEtEJ-XUy8C-=s96-c', 8009349433, 'India', '', '', 'Azamgarh ', 0, '', '', '68c821c4629d0', '2409:40e3:3107:2e9e:', '2025-09-15 14:25:08', '', '', '', '100017603625376972715', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocKzmhV_Yho3FoSDBkngIeVgiSLMJwZwd-S0hRQWnEtEJ-XUy8C-=s96-c', '', '2025-09-15 14:25:08', 0),
(217, 'Rdx', 'rdx192842@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKpjWSiruJe_pH_i9qZ51VbuSfA8PJYKprSS6ZrKpFd2K8bkQ=s96-c', 3449907936, 'Pakistan', '', '', 'abulwahabkhan76@gmail.com', 0, '', '', '68cb83f9d9857', '2402:e000:62d:3a14::', '2025-09-18 04:00:57', '', '', '', '104535716168568534690', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocKpjWSiruJe_pH_i9qZ51VbuSfA8PJYKprSS6ZrKpFd2K8bkQ=s96-c', '', '2025-09-18 04:00:57', 0),
(218, 'snap course', 'readxhubai369@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJKWMve9dL-dBZKEqhKs9ESYkbWPhqwQRHMjbizxP4oUb5dKw=s96-c', 0, '', '', '', '', 0, '', '', '68ccce5dc58ae', '103.108.5.53', '2025-09-19 03:30:37', '', '', '', '115396298714836025843', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocJKWMve9dL-dBZKEqhKs9ESYkbWPhqwQRHMjbizxP4oUb5dKw=s96-c', '', '2025-09-19 03:30:37', 0),
(219, 'Piyush Dhuriya', 'dhuriyapiyush9@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLeIk_gpb2eAoEnj2EhSHSyueFyd-RjxSR7shKd6zhNxKpEtrwE=s96-c', 9892122018, 'India ', '', '', 'Noida sector 5 ', 0, '', '', 'user_6990af27750855.43622348', '2401:4900:a13a:1d58:', '2025-09-24 13:11:07', '', '', '', '104434653048572551031', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocLeIk_gpb2eAoEnj2EhSHSyueFyd-RjxSR7shKd6zhNxKpEtrwE=s96-c', '', '2025-09-24 13:11:07', 0),
(220, 'Late account', 'thisismeadarshokay@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJjVs1VKbrk2oTdQ3I385wF3x-TuZclYgLwDc7KMiA5-qJ89w=s96-c', 9939914772, 'India', '', '', 'Preet Vihar, Delhi, India', 0, '', '', 'user_68e90dd9d51b63.05390773', '103.108.5.118', '2025-10-10 12:31:01', '', '28.6523392', '77.2964352', '108926089652137381462', NULL, NULL, NULL, 'https://lh3.googleusercontent.com/a/ACg8ocJjVs1VKbrk2oTdQ3I385wF3x-TuZclYgLwDc7KMiA5-qJ89w=s96-c', '', '2025-10-10 12:31:01', 0),
(221, 'Temp', 'gagandevraj1@gmail.com', NULL, 9939914772, 'India', '', '', 'Preet Vihar, Delhi, India', 0, '', '', '690c1ea306713', '103.108.5.76', '2025-11-02 13:34:47', '', '28.6290572', '77.3197496', NULL, NULL, 'Temp', NULL, 'uploads/gagandevraj1@gmail.com/ACg8ocLUoTruYx_fPbuKnkNuJ23d8znVUnFHrIwlnnZjhbs9CQnM5w=s96-c', '', '2025-11-05 13:30:40', 0),
(222, 'Aniket', 'aniketjha2228@gmail.com', NULL, 0, '', '', '', '', 0, '', '', 'user_690c1e36386a00.06748211', '', '2025-11-06 04:04:06', '', '', '', NULL, NULL, NULL, NULL, NULL, '', '2025-11-06 04:04:06', 0),
(223, 'Ayushi Mishra', 'pm9825167@gmail.com', NULL, 0, '', '', '', '', 0, '', '', 'user_6936f72c436f85.82038821', '', '2025-12-08 16:05:00', '', '', '', NULL, NULL, NULL, NULL, NULL, '', '2025-12-08 16:05:00', 0),
(224, 'Mohamed Mokhtari', 'mohamedmokhtari402@gmail.com', NULL, 0, '', '', '', '', 0, '', '', 'user_6941f8f06ae1a8.77969549', '', '2025-12-17 00:27:28', '', '', '', NULL, NULL, NULL, NULL, NULL, '', '2025-12-17 00:27:28', 0),
(225, 'Babuni Devi', 'babunidevi10100@gmail.com', 'uploads/babunidevi10100@gmail.com/1000000665.jpg', 9939914772, 'India', '', '', 'Patahi, Bihar, India', 0, '', '', '6992ba0c02a5d', '2401:4900:73ec:21da:', '2026-02-02 06:07:02', '', '26.6289612', '85.1952087', NULL, NULL, 'Babuni Devi', NULL, 'uploads/babunidevi10100@gmail.com/ACg8ocJxdAqCMJpoKjFmp-Y1aLzRIZYRLQ-8KA55juShxR73aDp2OA=s96-c', '', '2026-02-02 06:07:02', 0),
(226, 'GaganDev Raj', 'gagandevraj0@gmail.com', NULL, 0, '', '', '', '', 0, '', '', 'user_699532cb364da7.18311559', '', '2026-02-18 03:32:27', '', '', '', NULL, NULL, NULL, NULL, NULL, '', '2026-02-18 03:32:27', 0),
(227, 'Rohan Tayade', 'rohantayade09@gmail.com', NULL, 0, '', '', '', '', 0, '', '', 'user_69bcdc2951bf24.02823145', '', '2026-03-20 05:33:29', '', '', '', NULL, NULL, NULL, NULL, NULL, '', '2026-03-20 05:33:29', 0);

-- --------------------------------------------------------

--
-- Table structure for table `creator_subscriptions`
--

CREATE TABLE `creator_subscriptions` (
  `id` int(11) NOT NULL,
  `creator_email` varchar(255) NOT NULL,
  `subscriber_email` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `creator_subscriptions`
--

INSERT INTO `creator_subscriptions` (`id`, `creator_email`, `subscriber_email`, `created_at`) VALUES
(2, 'adarshsingh22042006@gmail.com', 'adarsh.singhvishnu@gmail.com', '2026-06-23 08:25:52'),
(4, 'pm9825167@gmail.com', 'adarsh.singhvishnu@gmail.com', '2026-06-23 12:10:00'),
(5, 'adarsh.singhvishnu@gmail.com', 'adarshfinalchannel@gmail.com', '2026-06-23 15:15:39'),
(6, 'adarshfinalchannel@gmail.com', 'adarsh.singhvishnu@gmail.com', '2026-06-23 15:16:02'),
(7, 'dishayadav545@gmail.com', 'adarsh.singhvishnu@gmail.com', '2026-06-23 15:32:51'),
(8, 'adarsh.singhvishnu@gmail.com', 'pm9825167@gmail.com', '2026-06-24 02:57:25'),
(9, 'adarsh.singhvishnu@gmail.com', 'rohantayade09@gmail.com', '2026-06-24 05:53:34'),
(10, 'adarshfinalchannel@gmail.com', 'pm9825167@gmail.com', '2026-06-25 02:22:55');

-- --------------------------------------------------------

--
-- Table structure for table `day_table`
--

CREATE TABLE `day_table` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `email` varchar(255) NOT NULL,
  `day_count` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `day_table`
--

INSERT INTO `day_table` (`id`, `name`, `phone`, `email`, `day_count`, `created_at`) VALUES
(40, 'Adarsh', '9354774411', 'adarshfinalchannel@gmail.com', 1, '2024-08-21 07:18:28'),
(41, '', '', '', 1, '2024-08-21 07:58:02'),
(42, '', '', '', 1, '2024-08-21 07:58:25'),
(43, 'Adarsh', '8809974414', 'ninij78254@albarulo.com', 1, '2024-08-21 08:12:18'),
(44, '', '', '', 1, '2024-08-22 03:15:37'),
(45, 'Adarsh', '9289851174', 'ninij78254@albarulo.com', 1, '2024-08-22 07:55:58'),
(46, 'Raj ', '9795647253', 'rajheartkiller18110@gmail.com', 1, '2024-08-22 15:19:36'),
(47, 'Ceyafa', '9845751545', 'ceyafa8443@amxyy.com', 1, '2024-08-23 04:30:49'),
(48, 'Ceyafa', '9898784535', 'ceyafa8443@amxyy.com', 1, '2024-08-23 04:45:03'),
(49, '', '', '', 1, '2024-08-23 04:51:59'),
(50, 'ceyafa', '9876543210', 'ceyafa8443@amxyy.com', 1, '2024-08-23 04:53:28'),
(51, 'Adarsh', '9472153698', 'adarshfinalchannel@gmail.com', 1, '2024-08-23 12:26:50'),
(52, 'Gagandevraj', '9475137349', 'adarshsubhhu@gmail.com', 1, '2024-08-24 11:04:33'),
(53, 'Satish ranjan', '7481010522', 'bgmi73169@gmail.com', 1, '2024-08-25 04:01:43'),
(54, 'Rahul', '8839667422', 'anshu123@gmail.com', 1, '2024-08-25 04:37:27'),
(55, 'lucky', '9876543214', 'gagandevraj0@gmail.com', 1, '2024-08-25 15:05:37'),
(56, 'Adarsh Singh Rajput', '9472153674', 'Adarsh.singhvishnu@gmail.com', 1, '2024-08-26 11:25:06'),
(57, 'Adarsh', '9741789874', 'adarsh.singhvishnu@gmail.com', 1, '2024-08-26 11:32:55'),
(58, 'Gagan', '9456321578', 'adarsh.singhvishnu@gmail.com', 1, '2024-08-26 12:13:40'),
(59, 'Saubhagya Karunarathna', '9864213678', 'adarshsubhhu@gmail.com', 1, '2024-08-28 10:16:26'),
(60, 'Nipu', '91', 'nipudevi8801@gmail.com', 1, '2024-08-28 11:41:31'),
(61, 'Bongoni Devendar Goud', '7569208544', 'goudd461@gmail.com', 1, '2024-08-30 06:57:51'),
(62, 'srofan', '8457994565', 'ceyafa8443@amxyy.com', 1, '2024-08-30 07:23:02'),
(63, 'Muhammad Zohaib Amjad', '3495448578', 'zabiim02@gmail.com', 1, '2024-08-30 07:35:36'),
(64, 'Madhuri', '6206812463', 'contactcaadarshyt@gmail.com', 1, '2024-08-30 08:52:06'),
(65, 'Aniruďha Chaudhari', '7863858813', 'chaudharianirudha899@gmail.com', 1, '2024-08-30 11:33:12'),
(66, 'Amit kumar', '9263205072', 'sacik76359@kwalah.com', 1, '2024-08-30 17:46:16'),
(67, 'Hari', '918668181098', 'harikaran3123@gmail.com', 1, '2024-08-30 18:35:39'),
(68, 'Prince', '7261869603', 'princemth10@gmail.com', 1, '2024-08-30 18:39:01'),
(69, 'adarsh', '9472153681', 'kepof72801@amxyy.com', 1, '2024-09-03 03:18:17'),
(70, 'Supriya', '8143253698', 'supriyasruji@gmail.com', 1, '2024-09-05 05:41:53'),
(71, 'Raj', '9310659353', 'raj22293114@gmail.com', 1, '2024-09-05 12:20:26'),
(72, 'Omji', '9971731395', 'vinodkumary414@gmail.com', 1, '2024-09-05 17:37:48'),
(73, 'Farhan ', '9154556988', 'farhanian4u@gmail.com', 1, '2024-09-07 03:24:17'),
(74, 'Anurag', '84542153679', 'dhruv.gagandevraj@gmail.com', 1, '2024-09-18 02:05:07'),
(75, 'Shohan Khan', '8801621297636', 'kshohan.personal@gmail.com', 1, '2024-09-20 20:16:00'),
(76, 'Sanaya', '8521634215', 'pinkeedevi10100@gmail.com', 1, '2024-09-22 05:46:27'),
(77, 'Niraj Shaw', '8294354630', 'nirajshaw1320@gmail.com', 1, '2024-09-27 14:31:45'),
(78, 'Adarsh Singh Rajput', '0', 'adarsh.singhvishnu@gmail.com', 1, '2024-09-29 07:47:40'),
(79, 'Adarsh Singh Rajput', '0', 'adarsh.singhvishnu@gmail.com', 1, '2024-09-29 08:54:26'),
(80, 'Adarsh Singh Rajput', '0', 'adarsh.singhvishnu@gmail.com', 1, '2024-09-29 08:58:44'),
(81, 'Khushi Singh', '0', 'khushivishnushankarsingh@gmail.com', 1, '2024-09-30 00:37:43'),
(82, 'Utkarsh kumar', '0', 'khushisinghadarsh@gmail.com', 1, '2024-09-30 02:17:33'),
(83, 'Adarsh Singh Rajput', '0', 'adarsh.singhvishnu@gmail.com', 1, '2024-09-30 03:40:34'),
(84, 'Dhruv', '0', 'dhruv.gagandevraj@gmail.com', 1, '2024-09-30 04:43:58'),
(85, 'Adarsh Singh', '0', 'adarshfinalchannel@gmail.com', 1, '2024-10-02 01:59:16'),
(86, 'Ankush Kumar', '0', 'ankushkumar80176@gmail.com', 1, '2024-10-02 09:41:43'),
(87, 'Adarsh Singh', '0', 'adarshfinalchannel@gmail.com', 1, '2024-10-04 12:46:02'),
(88, 'Parmod ', '9920219054', 'gpramod09@gmail.com', 1, '2024-10-18 13:21:58'),
(89, 'Sanjeev Yadav', '8400760557', 'sanjeev8400yadav@gmail.com', 1, '2024-10-24 07:06:42'),
(90, 'Sreenu', '0', 's80752791@gmail.com', 1, '2024-10-25 05:09:28'),
(91, 'Madhu Priya', '0', 'madhupriya33447@gmail.com', 1, '2024-10-25 07:08:56'),
(92, 'Donthakur', '0', 'd822719@gmail.com', 1, '2024-10-25 07:09:04'),
(93, 'Sreenu Abhilash', '0', 'sreenuabhilash7464@gmail.com', 1, '2024-10-25 13:02:29'),
(94, 'Mharish', '6301316594', 'harish.76711@gmail.com', 1, '2024-10-26 15:19:36'),
(95, 'AKASH KUMAR', '7903230688', 'akashstark01@gmail.com', 1, '2024-10-29 14:43:52'),
(96, 'Waqas Ahmad', '923176345241', 'wj75377835@gmail.com', 1, '2024-10-31 13:50:50'),
(97, 'Che', '7175143219', 'leompena42@gmail.com', 1, '2024-11-04 01:38:27'),
(98, 'Youssef', '201210889966', 'youssefwblor@gmail.com', 1, '2024-11-04 02:26:46'),
(99, 'Ziya ', '6375836151', 'saziyasaziya3501@gmail.com', 1, '2024-11-19 08:13:12'),
(100, 'Goverdhan Bairagi ', '7879000938', 'goverdhanbairagi623@gmail.com', 1, '2024-11-20 09:01:29'),
(101, 'Rohit Rajput', '8239848549', 'rohitrs4504@gmail.com', 1, '2024-11-20 09:51:49'),
(102, 'Amit ', '8292785894', 'ourvlogsteam@gmail.com', 1, '2024-11-26 05:37:11'),
(103, 'Zakwan Ansari', '6351993135', 'zakwanansari70272@gmail.com', 1, '2024-11-27 23:48:13'),
(104, 'Lpwjhariya Golll', '8794681105', 'gollllpwjhariya@gmail.com', 1, '2024-11-29 15:59:36'),
(105, 'vishesh', '7889432732', 'v3344856@gmail.com', 1, '2024-12-01 12:55:29'),
(106, 'Adarsh Singh Rajput', '9472153687', 'adarsh.singhvishnu@gmail.com', 1, '2024-12-22 02:48:49'),
(107, 'Halominaria', '9128562587', 'halominaria@gmail.com', 1, '2025-01-02 11:08:41'),
(108, 'Ayushi', '7858961142', 'thissoundssuspicious@gmail.com', 1, '2025-01-17 07:06:22'),
(109, 'Ragini Rawat', '9340295239', 'raginiragrawat@gmail.com', 1, '2025-02-10 18:21:29'),
(110, 'Adarsh Singh Rajput', '7897854574', 'adarsh.singhvishnu@gmail.com', 1, '2025-02-14 08:08:14'),
(111, 'Khushi Singh', '7761962802', 'khushisingh892210@gmail.com', 1, '2025-02-14 10:14:18'),
(112, 'Adarsh Singh', '9472153681', 'adarshfinalchannel@gmail.com', 1, '2025-02-18 07:39:51'),
(113, 'Fake account', '9472153687', 'itisreadxhub@gmail.com', 1, '2025-05-14 13:34:13');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `subject` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`images`)),
  `location` text DEFAULT NULL,
  `submitted_at` timestamp NULL DEFAULT current_timestamp(),
  `latitude` varchar(50) DEFAULT NULL,
  `longitude` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`id`, `email`, `name`, `profile_image`, `subject`, `message`, `images`, `location`, `submitted_at`, `latitude`, `longitude`) VALUES
(22, 'adarshfinalchannel@gmail.com', '1739155449137.png', 'https://lh3.googleusercontent.com/a/ACg8ocIikx352-eGDuN3w03OD52sYyhgz81xGPZrBJNtuTPLuG9aEQ=s96-c', 'Hello Sir I\'ve A Problem', 'adass', '[\"uploads\\/adarshfinalchannel@gmail.com\\/1739155449137.png\"]', 'Lat: 28.6654464, Long: 77.1915776', '2025-02-10 04:42:10', NULL, NULL),
(23, 'khushisinghadarsh@gmail.com', '1000035590.jpg', 'https://lh3.googleusercontent.com/a/ACg8ocJWKpfb2SuZ5S1L2IhbdAXrkYkv55k95KJaSeY9XUa3eNhZhV-W=s96-c', 'Wow', 'Yay', '[\"uploads\\/khushisinghadarsh@gmail.com\\/1000035590.jpg\"]', NULL, '2025-08-24 15:35:56', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `google_users`
--

CREATE TABLE `google_users` (
  `id` int(11) NOT NULL,
  `google_id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `profile_picture` text DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `google_access_token` text DEFAULT NULL,
  `google_name` varchar(255) DEFAULT NULL,
  `datetime` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `sno` int(11) NOT NULL,
  `email_phone` varchar(40) NOT NULL,
  `password` varchar(100) NOT NULL,
  `datetime` timestamp NULL DEFAULT current_timestamp(),
  `device_id` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`sno`, `email_phone`, `password`, `datetime`, `device_id`) VALUES
(1, 'feedback@gagandevraj.com', 'adarsh@10100', '2024-05-02 12:06:24', '663662f898d2e');

-- --------------------------------------------------------

--
-- Table structure for table `login_data`
--

CREATE TABLE `login_data` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `profile_image` varchar(255) NOT NULL,
  `ipv4_address` varchar(45) NOT NULL,
  `ipv6_address` varchar(45) NOT NULL,
  `login_datetime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `login_data`
--

INSERT INTO `login_data` (`id`, `name`, `email`, `profile_picture`, `profile_image`, `ipv4_address`, `ipv6_address`, `login_datetime`) VALUES
(34, 'Khushi Singh', 'khushivishnushankarsingh@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocI5ohGYZHRFkH2hQEC_Up0P71SW0Xr6VDWXziFIBPK0NGkWtg=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocI5ohGYZHRFkH2hQEC_Up0P71SW0Xr6VDWXziFIBPK0NGkWtg=s96-c', '', '2405:204:3404:3320:88bc:7369:3e7:5fb0', '2024-11-30 07:24:46'),
(42, 'Tera bhai', 'deenukmwt277@gmail.com', 'uploads/deenukmwt277@gmail.com/ACg8ocICa6rgEwOyoxYldhU949jbx13wug64okZfB-MsVzqV-TNo3A=s96-c', 'uploads/deenukmwt277@gmail.com/Screenshot_2024_0713_171025.gif', '', '2409:4052:2e86:7f1::2dc8:f510', '2024-11-30 09:09:40'),
(44, 'adarsh singh', 'talk@gagandevraj.com', 'https://lh3.googleusercontent.com/a/ACg8ocKEo-i8u9F9fhnI6EXMCKbdokPbHPcuO3WR5DNoH9RrrhasfA=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocKEo-i8u9F9fhnI6EXMCKbdokPbHPcuO3WR5DNoH9RrrhasfA=s96-c', '', '2409:4050:2d02:e8cd:82d7:ca44:49:feb9', '2024-11-30 11:34:43'),
(45, 'adarsh singh', 'talk@gagandevraj.com', 'https://lh3.googleusercontent.com/a/ACg8ocKEo-i8u9F9fhnI6EXMCKbdokPbHPcuO3WR5DNoH9RrrhasfA=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocKEo-i8u9F9fhnI6EXMCKbdokPbHPcuO3WR5DNoH9RrrhasfA=s96-c', '', '2409:4050:2e0a:6304:3898:540a:e3f8:25e4', '2024-11-30 11:38:30'),
(46, 'adarsh singh', 'talk@gagandevraj.com', 'https://lh3.googleusercontent.com/a/ACg8ocKEo-i8u9F9fhnI6EXMCKbdokPbHPcuO3WR5DNoH9RrrhasfA=s96-c', 'uploads/talk@gagandevraj.com/bash2.png', '', '2409:4050:2e0a:6304:3898:540a:e3f8:25e4', '2024-11-30 11:39:04'),
(51, 'adarsh singh', 'talk@gagandevraj.com', 'https://lh3.googleusercontent.com/a/ACg8ocKEo-i8u9F9fhnI6EXMCKbdokPbHPcuO3WR5DNoH9RrrhasfA=s96-c', 'uploads/talk@gagandevraj.com/bash2.png', '', '2409:4050:2ec2:bbd3:efa1:7a16:aca8:3a64', '2024-11-30 16:25:49'),
(53, 'Lpwjhariya Golll', 'gollllpwjhariya@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocI-16lqaC9lRBeOLos33F2utVDcT9ams35_NS34WBJ7CTlw9g=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocI-16lqaC9lRBeOLos33F2utVDcT9ams35_NS34WBJ7CTlw9g=s96-c', '139.5.248.235', '', '2024-11-30 18:39:58'),
(57, 'Madhumala', 'madhumala902@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocID8roVN-xvpJrDRnPS9DfQ5X8T4E78WPos2eqzvfqHNAGgEg=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocID8roVN-xvpJrDRnPS9DfQ5X8T4E78WPos2eqzvfqHNAGgEg=s96-c', '', '2409:40e4:2002:1816:8000::', '2024-11-30 20:54:45'),
(58, 'Madhumala', 'madhumala902@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocID8roVN-xvpJrDRnPS9DfQ5X8T4E78WPos2eqzvfqHNAGgEg=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocID8roVN-xvpJrDRnPS9DfQ5X8T4E78WPos2eqzvfqHNAGgEg=s96-c', '', '2409:40e4:2002:1816:8000::', '2024-11-30 20:54:49'),
(59, 'Madhumala', 'madhumala902@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocID8roVN-xvpJrDRnPS9DfQ5X8T4E78WPos2eqzvfqHNAGgEg=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocID8roVN-xvpJrDRnPS9DfQ5X8T4E78WPos2eqzvfqHNAGgEg=s96-c', '', '2409:40e4:2002:1816:8000::', '2024-11-30 20:55:10'),
(60, 'Madhumala', 'madhumala902@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocID8roVN-xvpJrDRnPS9DfQ5X8T4E78WPos2eqzvfqHNAGgEg=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocID8roVN-xvpJrDRnPS9DfQ5X8T4E78WPos2eqzvfqHNAGgEg=s96-c', '', '2409:40e4:2002:1816:8000::', '2024-11-30 20:55:43'),
(61, 'Madhumala', 'madhumala902@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocID8roVN-xvpJrDRnPS9DfQ5X8T4E78WPos2eqzvfqHNAGgEg=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocID8roVN-xvpJrDRnPS9DfQ5X8T4E78WPos2eqzvfqHNAGgEg=s96-c', '', '2409:40e4:2002:1816:8000::', '2024-11-30 20:57:11'),
(62, 'Madhumala', 'madhumala902@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocID8roVN-xvpJrDRnPS9DfQ5X8T4E78WPos2eqzvfqHNAGgEg=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocID8roVN-xvpJrDRnPS9DfQ5X8T4E78WPos2eqzvfqHNAGgEg=s96-c', '', '2409:40e4:2002:1816:8000::', '2024-11-30 20:59:22'),
(63, 'Madhumala', 'madhumala902@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocID8roVN-xvpJrDRnPS9DfQ5X8T4E78WPos2eqzvfqHNAGgEg=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocID8roVN-xvpJrDRnPS9DfQ5X8T4E78WPos2eqzvfqHNAGgEg=s96-c', '', '2409:40e4:2002:1816:8000::', '2024-11-30 20:59:42'),
(64, 'Madhumala', 'madhumala902@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocID8roVN-xvpJrDRnPS9DfQ5X8T4E78WPos2eqzvfqHNAGgEg=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocID8roVN-xvpJrDRnPS9DfQ5X8T4E78WPos2eqzvfqHNAGgEg=s96-c', '', '2409:40e4:2002:1816:8000::', '2024-11-30 21:00:20'),
(65, 'Madhumala', 'madhumala902@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocID8roVN-xvpJrDRnPS9DfQ5X8T4E78WPos2eqzvfqHNAGgEg=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocID8roVN-xvpJrDRnPS9DfQ5X8T4E78WPos2eqzvfqHNAGgEg=s96-c', '', '2409:40e4:2002:1816:8000::', '2024-11-30 21:01:47'),
(67, 'Madhu Priya', 'madhupriya33447@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocK21fDtVqFmqQQ_NvrFdXAOTLWLHRpZV7fFp_bEld5Blt_FjA=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocK21fDtVqFmqQQ_NvrFdXAOTLWLHRpZV7fFp_bEld5Blt_FjA=s96-c', '', '2409:40e4:2002:1816:8000::', '2024-11-30 21:04:05'),
(106, 'Madhumala', 'madhumala902@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocID8roVN-xvpJrDRnPS9DfQ5X8T4E78WPos2eqzvfqHNAGgEg=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocID8roVN-xvpJrDRnPS9DfQ5X8T4E78WPos2eqzvfqHNAGgEg=s96-c', '', '2409:40e4:200a:d82c:8000::', '2024-12-01 07:25:31'),
(118, 'I Am', 'raginisharma198689@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJvB9-4zaEeGCHP3DH8oJ8uUwZBwd2SZjh0C2WkYSL8iNgDZw=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJvB9-4zaEeGCHP3DH8oJ8uUwZBwd2SZjh0C2WkYSL8iNgDZw=s96-c', '', '2401:4900:5f3a:8c9:ef97:4ff1:656f:6ccc', '2024-12-01 08:30:11'),
(119, 'I Am', 'raginisharma198689@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJvB9-4zaEeGCHP3DH8oJ8uUwZBwd2SZjh0C2WkYSL8iNgDZw=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJvB9-4zaEeGCHP3DH8oJ8uUwZBwd2SZjh0C2WkYSL8iNgDZw=s96-c', '', '2401:4900:5f3a:8c9:ef97:4ff1:656f:6ccc', '2024-12-01 08:30:14'),
(120, 'I Am', 'raginisharma198689@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJvB9-4zaEeGCHP3DH8oJ8uUwZBwd2SZjh0C2WkYSL8iNgDZw=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJvB9-4zaEeGCHP3DH8oJ8uUwZBwd2SZjh0C2WkYSL8iNgDZw=s96-c', '', '2401:4900:5f3a:8c9:ef97:4ff1:656f:6ccc', '2024-12-01 08:39:32'),
(121, 'I Am', 'raginisharma198689@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJvB9-4zaEeGCHP3DH8oJ8uUwZBwd2SZjh0C2WkYSL8iNgDZw=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJvB9-4zaEeGCHP3DH8oJ8uUwZBwd2SZjh0C2WkYSL8iNgDZw=s96-c', '', '2401:4900:5f3a:8c9:ef97:4ff1:656f:6ccc', '2024-12-01 08:39:35'),
(122, 'I Am', 'raginisharma198689@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJvB9-4zaEeGCHP3DH8oJ8uUwZBwd2SZjh0C2WkYSL8iNgDZw=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJvB9-4zaEeGCHP3DH8oJ8uUwZBwd2SZjh0C2WkYSL8iNgDZw=s96-c', '', '2401:4900:5f3a:8c9:ef97:4ff1:656f:6ccc', '2024-12-01 08:39:55'),
(123, 'I Am', 'raginisharma198689@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJvB9-4zaEeGCHP3DH8oJ8uUwZBwd2SZjh0C2WkYSL8iNgDZw=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJvB9-4zaEeGCHP3DH8oJ8uUwZBwd2SZjh0C2WkYSL8iNgDZw=s96-c', '', '2401:4900:5f3a:8c9:ef97:4ff1:656f:6ccc', '2024-12-01 08:48:31'),
(124, 'I Am', 'raginisharma198689@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJvB9-4zaEeGCHP3DH8oJ8uUwZBwd2SZjh0C2WkYSL8iNgDZw=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJvB9-4zaEeGCHP3DH8oJ8uUwZBwd2SZjh0C2WkYSL8iNgDZw=s96-c', '', '2401:4900:5f3a:8c9:ef97:4ff1:656f:6ccc', '2024-12-01 08:48:38'),
(125, 'I Am', 'raginisharma198689@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJvB9-4zaEeGCHP3DH8oJ8uUwZBwd2SZjh0C2WkYSL8iNgDZw=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJvB9-4zaEeGCHP3DH8oJ8uUwZBwd2SZjh0C2WkYSL8iNgDZw=s96-c', '', '2401:4900:5f3a:8c9:ef97:4ff1:656f:6ccc', '2024-12-01 08:48:51'),
(126, 'I Am', 'raginisharma198689@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJvB9-4zaEeGCHP3DH8oJ8uUwZBwd2SZjh0C2WkYSL8iNgDZw=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJvB9-4zaEeGCHP3DH8oJ8uUwZBwd2SZjh0C2WkYSL8iNgDZw=s96-c', '', '2401:4900:5f13:5397:1d9f:9098:e204:224a', '2024-12-01 09:39:07'),
(127, 'I Am', 'raginisharma198689@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJvB9-4zaEeGCHP3DH8oJ8uUwZBwd2SZjh0C2WkYSL8iNgDZw=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJvB9-4zaEeGCHP3DH8oJ8uUwZBwd2SZjh0C2WkYSL8iNgDZw=s96-c', '', '2401:4900:5f13:5397:1d9f:9098:e204:224a', '2024-12-01 09:39:09'),
(130, 'RANI DEVI', 'ranisyal1981@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocIS5e1Lw_nWtmcXD0Q-_v5ulztCE1coVZ6QyzCy9OTF-TEJGg=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocIS5e1Lw_nWtmcXD0Q-_v5ulztCE1coVZ6QyzCy9OTF-TEJGg=s96-c', '', '2401:4900:5f10:19da:4cbc:a579:2310:7614', '2024-12-01 10:48:12'),
(131, 'Babe We', 'babewe763@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocL7Q1mm6J03PBuNSpJbW5oK0I0csYqVjcZRF12LWZECObb_Dg=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocL7Q1mm6J03PBuNSpJbW5oK0I0csYqVjcZRF12LWZECObb_Dg=s96-c', '', '2401:4900:5d1f:b57:dc6b:44ff:fe0f:4e26', '2024-12-01 10:50:15'),
(132, 'Babe We', 'babewe763@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocL7Q1mm6J03PBuNSpJbW5oK0I0csYqVjcZRF12LWZECObb_Dg=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocL7Q1mm6J03PBuNSpJbW5oK0I0csYqVjcZRF12LWZECObb_Dg=s96-c', '', '2401:4900:5d1f:b57:dc6b:44ff:fe0f:4e26', '2024-12-01 10:50:25'),
(136, 'Babe We', 'babewe763@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocL7Q1mm6J03PBuNSpJbW5oK0I0csYqVjcZRF12LWZECObb_Dg=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocL7Q1mm6J03PBuNSpJbW5oK0I0csYqVjcZRF12LWZECObb_Dg=s96-c', '', '2401:4900:5d1f:b57:dc6b:44ff:fe0f:4e26', '2024-12-01 10:50:49'),
(137, 'Babe We', 'babewe763@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocL7Q1mm6J03PBuNSpJbW5oK0I0csYqVjcZRF12LWZECObb_Dg=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocL7Q1mm6J03PBuNSpJbW5oK0I0csYqVjcZRF12LWZECObb_Dg=s96-c', '', '2401:4900:5d1f:b57:dc6b:44ff:fe0f:4e26', '2024-12-01 10:51:03'),
(146, 'Resma Gangupam', 'resmagangupam@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLlnprsCJJZoFPUwA5TTcD5LnarM0VWkOlp_XUjZDnWzmJvqA=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocLlnprsCJJZoFPUwA5TTcD5LnarM0VWkOlp_XUjZDnWzmJvqA=s96-c', '', '2401:4900:6584:fa4f:659f:a8e8:7b2b:f6df', '2024-12-01 13:55:22'),
(148, 'Resma Gangupam', 'resmagangupam@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLlnprsCJJZoFPUwA5TTcD5LnarM0VWkOlp_XUjZDnWzmJvqA=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocLlnprsCJJZoFPUwA5TTcD5LnarM0VWkOlp_XUjZDnWzmJvqA=s96-c', '', '2401:4900:676b:cb0b:4ff7:8e65:e8b1:e118', '2024-12-01 13:58:27'),
(149, 'Resma Gangupam', 'resmagangupam@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLlnprsCJJZoFPUwA5TTcD5LnarM0VWkOlp_XUjZDnWzmJvqA=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocLlnprsCJJZoFPUwA5TTcD5LnarM0VWkOlp_XUjZDnWzmJvqA=s96-c', '', '2401:4900:676b:cb0b:4ff7:8e65:e8b1:e118', '2024-12-01 14:00:29'),
(150, 'Lpwjhariya Golll', 'gollllpwjhariya@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocI-16lqaC9lRBeOLos33F2utVDcT9ams35_NS34WBJ7CTlw9g=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocI-16lqaC9lRBeOLos33F2utVDcT9ams35_NS34WBJ7CTlw9g=s96-c', '139.5.248.128', '', '2024-12-01 16:16:56'),
(151, 'vishesh', 'v3344856@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLM8c06DKXwp_MqpWhghbaNACXcBcYRmbdYf0D5exQnRfgArBY=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocLM8c06DKXwp_MqpWhghbaNACXcBcYRmbdYf0D5exQnRfgArBY=s96-c', '', '2406:b400:71:5dc6:9cd2:4d4c:a709:f0a3', '2024-12-01 18:18:45'),
(152, 'vishesh', 'v3344856@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLM8c06DKXwp_MqpWhghbaNACXcBcYRmbdYf0D5exQnRfgArBY=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocLM8c06DKXwp_MqpWhghbaNACXcBcYRmbdYf0D5exQnRfgArBY=s96-c', '', '2406:b400:71:5dc6:9cd2:4d4c:a709:f0a3', '2024-12-01 18:19:11'),
(153, 'vishesh', 'v3344856@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLM8c06DKXwp_MqpWhghbaNACXcBcYRmbdYf0D5exQnRfgArBY=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocLM8c06DKXwp_MqpWhghbaNACXcBcYRmbdYf0D5exQnRfgArBY=s96-c', '', '2406:b400:71:5dc6:9cd2:4d4c:a709:f0a3', '2024-12-01 18:23:04'),
(154, 'vishesh', 'v3344856@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLM8c06DKXwp_MqpWhghbaNACXcBcYRmbdYf0D5exQnRfgArBY=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocLM8c06DKXwp_MqpWhghbaNACXcBcYRmbdYf0D5exQnRfgArBY=s96-c', '', '2406:b400:71:5dc6:9cd2:4d4c:a709:f0a3', '2024-12-01 18:23:22'),
(155, 'vishesh', 'v3344856@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLM8c06DKXwp_MqpWhghbaNACXcBcYRmbdYf0D5exQnRfgArBY=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocLM8c06DKXwp_MqpWhghbaNACXcBcYRmbdYf0D5exQnRfgArBY=s96-c', '', '2406:b400:71:5dc6:9cd2:4d4c:a709:f0a3', '2024-12-01 18:25:30'),
(156, 'vishesh', 'v3344856@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLM8c06DKXwp_MqpWhghbaNACXcBcYRmbdYf0D5exQnRfgArBY=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocLM8c06DKXwp_MqpWhghbaNACXcBcYRmbdYf0D5exQnRfgArBY=s96-c', '', '2406:b400:71:5dc6:9cd2:4d4c:a709:f0a3', '2024-12-01 18:26:11'),
(157, 'Vinay jha', 'jhavinay897@gmail.com', 'uploads/jhavinay897@gmail.com/ACg8ocKWj1UM43evKWhX1rTjJ94QbuUvZC_JaGtGDCWEdTwPtiY9pM0M=s96-c', 'uploads/jhavinay897@gmail.com/IMG_20241014_105142.jpg', '', '2405:204:3023:eaa8::1f95:40a0', '2024-12-01 20:08:49'),
(172, 'Lpwjhariya Golll', 'gollllpwjhariya@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocI-16lqaC9lRBeOLos33F2utVDcT9ams35_NS34WBJ7CTlw9g=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocI-16lqaC9lRBeOLos33F2utVDcT9ams35_NS34WBJ7CTlw9g=s96-c', '139.5.248.146', '', '2024-12-02 19:17:10'),
(174, 'Lpwjhariya Golll', 'gollllpwjhariya@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocI-16lqaC9lRBeOLos33F2utVDcT9ams35_NS34WBJ7CTlw9g=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocI-16lqaC9lRBeOLos33F2utVDcT9ams35_NS34WBJ7CTlw9g=s96-c', '139.5.248.201', '', '2024-12-08 13:47:42'),
(175, 'Lpwjhariya Golll', 'gollllpwjhariya@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocI-16lqaC9lRBeOLos33F2utVDcT9ams35_NS34WBJ7CTlw9g=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocI-16lqaC9lRBeOLos33F2utVDcT9ams35_NS34WBJ7CTlw9g=s96-c', '139.5.248.201', '', '2024-12-08 13:52:03'),
(176, 'Lpwjhariya Golll', 'gollllpwjhariya@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocI-16lqaC9lRBeOLos33F2utVDcT9ams35_NS34WBJ7CTlw9g=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocI-16lqaC9lRBeOLos33F2utVDcT9ams35_NS34WBJ7CTlw9g=s96-c', '139.5.248.201', '', '2024-12-08 13:57:40'),
(180, 'Lpwjhariya Golll', 'gollllpwjhariya@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocI-16lqaC9lRBeOLos33F2utVDcT9ams35_NS34WBJ7CTlw9g=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocI-16lqaC9lRBeOLos33F2utVDcT9ams35_NS34WBJ7CTlw9g=s96-c', '139.5.248.201', '', '2024-12-08 20:56:13'),
(181, 'Khushi Singh', 'khushivishnushankarsingh@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocI5ohGYZHRFkH2hQEC_Up0P71SW0Xr6VDWXziFIBPK0NGkWtg=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocI5ohGYZHRFkH2hQEC_Up0P71SW0Xr6VDWXziFIBPK0NGkWtg=s96-c', '', '2401:4900:5fb9:5635::425:bc9', '2024-12-09 14:16:50'),
(182, 'Lpwjhariya Golll', 'gollllpwjhariya@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocI-16lqaC9lRBeOLos33F2utVDcT9ams35_NS34WBJ7CTlw9g=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocI-16lqaC9lRBeOLos33F2utVDcT9ams35_NS34WBJ7CTlw9g=s96-c', '139.5.248.201', '', '2024-12-09 18:15:48'),
(183, 'Lpwjhariya Golll', 'gollllpwjhariya@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocI-16lqaC9lRBeOLos33F2utVDcT9ams35_NS34WBJ7CTlw9g=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocI-16lqaC9lRBeOLos33F2utVDcT9ams35_NS34WBJ7CTlw9g=s96-c', '139.5.248.201', '', '2024-12-09 18:19:03'),
(184, 'Khushi Singh', 'khushivishnushankarsingh@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocI5ohGYZHRFkH2hQEC_Up0P71SW0Xr6VDWXziFIBPK0NGkWtg=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocI5ohGYZHRFkH2hQEC_Up0P71SW0Xr6VDWXziFIBPK0NGkWtg=s96-c', '', '2401:4900:30e9:e60b:0:3e:5af4:d801', '2024-12-12 07:26:34'),
(185, 'Khushi Singh', 'khushivishnushankarsingh@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocI5ohGYZHRFkH2hQEC_Up0P71SW0Xr6VDWXziFIBPK0NGkWtg=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocI5ohGYZHRFkH2hQEC_Up0P71SW0Xr6VDWXziFIBPK0NGkWtg=s96-c', '', '2401:4900:30e9:e60b:0:3e:5af4:d801', '2024-12-12 07:29:36'),
(186, 'Khushi Singh', 'khushivishnushankarsingh@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocI5ohGYZHRFkH2hQEC_Up0P71SW0Xr6VDWXziFIBPK0NGkWtg=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocI5ohGYZHRFkH2hQEC_Up0P71SW0Xr6VDWXziFIBPK0NGkWtg=s96-c', '', '2401:4900:30e9:e60b:0:3e:5af4:d801', '2024-12-12 07:29:57'),
(197, 'Pradip more', 'pm4222570@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocL4ETqhsL12cGW_corF52MOuwG4Ee1INb-FpEPyIvKM6t-vsw=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocL4ETqhsL12cGW_corF52MOuwG4Ee1INb-FpEPyIvKM6t-vsw=s96-c', '', '2409:40c2:100c:7364:6c45:d5ff:fe7d:b63a', '2024-12-15 14:49:59'),
(198, 'Pradip more', 'pm4222570@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocL4ETqhsL12cGW_corF52MOuwG4Ee1INb-FpEPyIvKM6t-vsw=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocL4ETqhsL12cGW_corF52MOuwG4Ee1INb-FpEPyIvKM6t-vsw=s96-c', '', '2409:40c2:100c:7364:6c45:d5ff:fe7d:b63a', '2024-12-15 14:51:10'),
(199, 'vishesh', 'v3344856@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLM8c06DKXwp_MqpWhghbaNACXcBcYRmbdYf0D5exQnRfgArBY=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocLM8c06DKXwp_MqpWhghbaNACXcBcYRmbdYf0D5exQnRfgArBY=s96-c', '', '2406:b400:71:7b67:3545:ad16:aec2:170c', '2024-12-15 19:26:27'),
(207, 'Bot Suraj', 'botsuraj414@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocIs9eE-mhIkwQuhJyQA7W2SCMafuwFrDWtDKzZzbRp4Pc3ypw=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocIs9eE-mhIkwQuhJyQA7W2SCMafuwFrDWtDKzZzbRp4Pc3ypw=s96-c', '', '2401:4900:3bd4:535c:c81c:da88:efa1:b33', '2024-12-16 13:49:49'),
(208, 'Bot Suraj', 'botsuraj414@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocIs9eE-mhIkwQuhJyQA7W2SCMafuwFrDWtDKzZzbRp4Pc3ypw=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocIs9eE-mhIkwQuhJyQA7W2SCMafuwFrDWtDKzZzbRp4Pc3ypw=s96-c', '', '2401:4900:3bd4:535c:c81c:da88:efa1:b33', '2024-12-16 13:49:51'),
(209, 'Bot Suraj', 'botsuraj414@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocIs9eE-mhIkwQuhJyQA7W2SCMafuwFrDWtDKzZzbRp4Pc3ypw=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocIs9eE-mhIkwQuhJyQA7W2SCMafuwFrDWtDKzZzbRp4Pc3ypw=s96-c', '', '2401:4900:3bd4:535c:c81c:da88:efa1:b33', '2024-12-16 13:50:33'),
(210, 'Bot Suraj', 'botsuraj414@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocIs9eE-mhIkwQuhJyQA7W2SCMafuwFrDWtDKzZzbRp4Pc3ypw=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocIs9eE-mhIkwQuhJyQA7W2SCMafuwFrDWtDKzZzbRp4Pc3ypw=s96-c', '', '2401:4900:3bd4:535c:c81c:da88:efa1:b33', '2024-12-16 13:50:49'),
(211, 'Bot Suraj', 'botsuraj414@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocIs9eE-mhIkwQuhJyQA7W2SCMafuwFrDWtDKzZzbRp4Pc3ypw=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocIs9eE-mhIkwQuhJyQA7W2SCMafuwFrDWtDKzZzbRp4Pc3ypw=s96-c', '', '2401:4900:3bd4:535c:c81c:da88:efa1:b33', '2024-12-16 13:56:06'),
(217, 'Lpwjhariya Golll', 'gollllpwjhariya@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocI-16lqaC9lRBeOLos33F2utVDcT9ams35_NS34WBJ7CTlw9g=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocI-16lqaC9lRBeOLos33F2utVDcT9ams35_NS34WBJ7CTlw9g=s96-c', '139.5.248.251', '', '2024-12-16 18:22:55'),
(225, 'Adarsh Singh Rajput', 'contactcaadarshyt@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJ9Flm1pflRrg5EQ7y4zq4BqypjllkFd4ySPMINlwo2JDPrug=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJ9Flm1pflRrg5EQ7y4zq4BqypjllkFd4ySPMINlwo2JDPrug=s96-c', '202.173.125.179', '', '2024-12-28 19:05:03'),
(228, 'Adarsh Singh Rajput', 'contactcaadarshyt@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJ9Flm1pflRrg5EQ7y4zq4BqypjllkFd4ySPMINlwo2JDPrug=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJ9Flm1pflRrg5EQ7y4zq4BqypjllkFd4ySPMINlwo2JDPrug=s96-c', '139.5.242.61', '', '2025-01-02 12:33:59'),
(239, 'Adarsh Singh Rajput', 'contactcaadarshyt@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJ9Flm1pflRrg5EQ7y4zq4BqypjllkFd4ySPMINlwo2JDPrug=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJ9Flm1pflRrg5EQ7y4zq4BqypjllkFd4ySPMINlwo2JDPrug=s96-c', '139.5.242.61', '', '2025-01-02 12:42:15'),
(242, 'Khushi Singh', 'khushivishnushankarsingh@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocI5ohGYZHRFkH2hQEC_Up0P71SW0Xr6VDWXziFIBPK0NGkWtg=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocI5ohGYZHRFkH2hQEC_Up0P71SW0Xr6VDWXziFIBPK0NGkWtg=s96-c', '106.210.32.143', '', '2025-01-03 07:39:53'),
(243, 'Khushi Singh', 'khushivishnushankarsingh@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocI5ohGYZHRFkH2hQEC_Up0P71SW0Xr6VDWXziFIBPK0NGkWtg=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocI5ohGYZHRFkH2hQEC_Up0P71SW0Xr6VDWXziFIBPK0NGkWtg=s96-c', '106.210.32.143', '', '2025-01-03 07:40:39'),
(249, 'Halominaria', 'halominaria@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKxDlWgu2ogl_FG8QtMPF_PFDZdKpWD2R2aBUqWFe9IL0LOr7A=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocKxDlWgu2ogl_FG8QtMPF_PFDZdKpWD2R2aBUqWFe9IL0LOr7A=s96-c', '139.5.242.91', '', '2025-01-06 15:49:37'),
(253, 'Adarsh Singh Rajput', 'contactcaadarshyt@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJ9Flm1pflRrg5EQ7y4zq4BqypjllkFd4ySPMINlwo2JDPrug=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJ9Flm1pflRrg5EQ7y4zq4BqypjllkFd4ySPMINlwo2JDPrug=s96-c', '45.118.159.167', '', '2025-01-13 11:05:27'),
(344, 'Halominaria', 'halominaria@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKxDlWgu2ogl_FG8QtMPF_PFDZdKpWD2R2aBUqWFe9IL0LOr7A=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocKxDlWgu2ogl_FG8QtMPF_PFDZdKpWD2R2aBUqWFe9IL0LOr7A=s96-c', '139.5.242.26', '', '2025-01-21 14:48:16'),
(345, 'Halominaria', 'halominaria@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKxDlWgu2ogl_FG8QtMPF_PFDZdKpWD2R2aBUqWFe9IL0LOr7A=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocKxDlWgu2ogl_FG8QtMPF_PFDZdKpWD2R2aBUqWFe9IL0LOr7A=s96-c', '139.5.242.26', '', '2025-01-21 16:16:14'),
(354, 'Ayushi', 'thissoundssuspicious@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLQEZSx3emwJ-i6luAme9PIReTU0TyN35iumMneffW4vtosSw=s96-c', 'uploads/thissoundssuspicious@gmail.com/IMG_20250121_100837.png', '', '2409:40e4:1045:aeb3:8000::', '2025-01-22 20:37:39'),
(355, 'Halominaria', 'halominaria@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKxDlWgu2ogl_FG8QtMPF_PFDZdKpWD2R2aBUqWFe9IL0LOr7A=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocKxDlWgu2ogl_FG8QtMPF_PFDZdKpWD2R2aBUqWFe9IL0LOr7A=s96-c', '139.5.242.26', '', '2025-01-23 09:10:09'),
(356, 'Ayushi', 'thissoundssuspicious@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLQEZSx3emwJ-i6luAme9PIReTU0TyN35iumMneffW4vtosSw=s96-c', 'uploads/thissoundssuspicious@gmail.com/IMG_20250121_100837.png', '', '2409:40e4:1045:aeb3:8000::', '2025-01-23 11:00:08'),
(357, 'Ayushi', 'thissoundssuspicious@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLQEZSx3emwJ-i6luAme9PIReTU0TyN35iumMneffW4vtosSw=s96-c', 'uploads/thissoundssuspicious@gmail.com/IMG_20250121_100837.png', '', '2409:40e4:1045:aeb3:8000::', '2025-01-23 11:09:00'),
(358, 'Halominaria', 'halominaria@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKxDlWgu2ogl_FG8QtMPF_PFDZdKpWD2R2aBUqWFe9IL0LOr7A=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocKxDlWgu2ogl_FG8QtMPF_PFDZdKpWD2R2aBUqWFe9IL0LOr7A=s96-c', '139.5.242.26', '', '2025-01-24 10:25:38'),
(359, 'Ayushi', 'thissoundssuspicious@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLQEZSx3emwJ-i6luAme9PIReTU0TyN35iumMneffW4vtosSw=s96-c', 'uploads/thissoundssuspicious@gmail.com/IMG_20250121_100837.png', '', '2409:40e4:1045:aeb3:8000::', '2025-01-24 10:25:59'),
(362, 'Ayushi', 'thissoundssuspicious@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLQEZSx3emwJ-i6luAme9PIReTU0TyN35iumMneffW4vtosSw=s96-c', 'uploads/thissoundssuspicious@gmail.com/IMG_20250121_100837.png', '', '2409:40e4:6a:932e:8000::', '2025-01-25 10:16:26'),
(363, 'Ayushi', 'thissoundssuspicious@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLQEZSx3emwJ-i6luAme9PIReTU0TyN35iumMneffW4vtosSw=s96-c', 'uploads/thissoundssuspicious@gmail.com/IMG_20250121_100837.png', '', '2409:40e4:6a:932e:8000::', '2025-01-25 11:05:31'),
(364, 'Halominaria', 'halominaria@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKxDlWgu2ogl_FG8QtMPF_PFDZdKpWD2R2aBUqWFe9IL0LOr7A=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocKxDlWgu2ogl_FG8QtMPF_PFDZdKpWD2R2aBUqWFe9IL0LOr7A=s96-c', '139.5.242.26', '', '2025-01-25 16:44:45'),
(368, 'We Are champion', 'arechampionw@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLRfROCItO47Gy-ioCI9YnYL6VETvReSnmq4nyOZXNJNRKJlA=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocLRfROCItO47Gy-ioCI9YnYL6VETvReSnmq4nyOZXNJNRKJlA=s96-c', '', '2401:4900:5d9a:bdab:458e:8e65:9048:9de8', '2025-01-25 19:49:46'),
(369, 'Ayushi', 'thissoundssuspicious@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLQEZSx3emwJ-i6luAme9PIReTU0TyN35iumMneffW4vtosSw=s96-c', 'uploads/thissoundssuspicious@gmail.com/IMG_20250121_100837.png', '', '2409:40e4:6a:932e:8000::', '2025-01-27 08:05:46'),
(370, 'Halominaria', 'halominaria@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKxDlWgu2ogl_FG8QtMPF_PFDZdKpWD2R2aBUqWFe9IL0LOr7A=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocKxDlWgu2ogl_FG8QtMPF_PFDZdKpWD2R2aBUqWFe9IL0LOr7A=s96-c', '139.5.242.26', '', '2025-01-27 10:37:58'),
(371, 'Halominaria', 'halominaria@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKxDlWgu2ogl_FG8QtMPF_PFDZdKpWD2R2aBUqWFe9IL0LOr7A=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocKxDlWgu2ogl_FG8QtMPF_PFDZdKpWD2R2aBUqWFe9IL0LOr7A=s96-c', '139.5.242.26', '', '2025-01-27 10:38:10'),
(372, 'Himanshu Singh', 'singhhimanshu6477@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocI4D3anZI5GlADCCwte6VNXKototSTE_34Zl728lYDKzL94_w=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocI4D3anZI5GlADCCwte6VNXKototSTE_34Zl728lYDKzL94_w=s96-c', '', '2405:204:130a:c012::18be:68ad', '2025-01-28 09:47:10'),
(373, 'Ayushi', 'thissoundssuspicious@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLQEZSx3emwJ-i6luAme9PIReTU0TyN35iumMneffW4vtosSw=s96-c', 'uploads/thissoundssuspicious@gmail.com/IMG_20250121_100837.png', '', '2409:40e4:6a:932e:8000::', '2025-01-29 10:32:21'),
(374, 'Ayushi', 'thissoundssuspicious@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLQEZSx3emwJ-i6luAme9PIReTU0TyN35iumMneffW4vtosSw=s96-c', 'uploads/thissoundssuspicious@gmail.com/IMG_20250121_100837.png', '', '2409:40e4:6a:932e:8000::', '2025-01-29 10:58:27'),
(375, 'aragsan cali', 'aamino1525@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLt4ByCYI3F4dG2sYi-HjJhOfQo-R6uVS1gG90k9RGADtbk53nl=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocLt4ByCYI3F4dG2sYi-HjJhOfQo-R6uVS1gG90k9RGADtbk53nl=s96-c', '41.78.74.34', '', '2025-01-29 13:39:19'),
(376, 'aragsan cali', 'aamino1525@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLt4ByCYI3F4dG2sYi-HjJhOfQo-R6uVS1gG90k9RGADtbk53nl=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocLt4ByCYI3F4dG2sYi-HjJhOfQo-R6uVS1gG90k9RGADtbk53nl=s96-c', '41.78.74.34', '', '2025-01-29 13:40:03'),
(377, 'aragsan cali', 'aamino1525@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLt4ByCYI3F4dG2sYi-HjJhOfQo-R6uVS1gG90k9RGADtbk53nl=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocLt4ByCYI3F4dG2sYi-HjJhOfQo-R6uVS1gG90k9RGADtbk53nl=s96-c', '41.78.74.34', '', '2025-01-29 13:52:49'),
(386, 'Ankush Kumar', 'ankushkumar80176@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocI7Y9wFkX7AFc8Euc9FKcx22TqzQKjXQsBA_6KDL3Q5MYtKyg=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocI7Y9wFkX7AFc8Euc9FKcx22TqzQKjXQsBA_6KDL3Q5MYtKyg=s96-c', '', '2401:4900:71ce:3d08:906e:4f38:1c12:1392', '2025-01-30 18:48:08'),
(387, 'Blueish_ Makeover', 'poojachauhan7104@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJpGgXlAT1_w6RZ2Wi_jBmp-cpAt1FQi8OjG3llMAeWN9UdQMen=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJpGgXlAT1_w6RZ2Wi_jBmp-cpAt1FQi8OjG3llMAeWN9UdQMen=s96-c', '', '2405:201:2022:809a:2467:db32:18d6:31eb', '2025-01-31 08:19:08'),
(391, 'Blueish_ Makeover', 'poojachauhan7104@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJpGgXlAT1_w6RZ2Wi_jBmp-cpAt1FQi8OjG3llMAeWN9UdQMen=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJpGgXlAT1_w6RZ2Wi_jBmp-cpAt1FQi8OjG3llMAeWN9UdQMen=s96-c', '', '2405:201:2022:809a:2467:db32:18d6:31eb', '2025-01-31 08:22:08'),
(393, 'Blueish_ Makeover', 'poojachauhan7104@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJpGgXlAT1_w6RZ2Wi_jBmp-cpAt1FQi8OjG3llMAeWN9UdQMen=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJpGgXlAT1_w6RZ2Wi_jBmp-cpAt1FQi8OjG3llMAeWN9UdQMen=s96-c', '', '2405:201:2022:809a:2467:db32:18d6:31eb', '2025-01-31 08:24:30'),
(394, 'Halominaria', 'halominaria@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKxDlWgu2ogl_FG8QtMPF_PFDZdKpWD2R2aBUqWFe9IL0LOr7A=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocKxDlWgu2ogl_FG8QtMPF_PFDZdKpWD2R2aBUqWFe9IL0LOr7A=s96-c', '45.118.159.103', '', '2025-01-31 14:49:42'),
(401, 'Halominaria', 'halominaria@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKxDlWgu2ogl_FG8QtMPF_PFDZdKpWD2R2aBUqWFe9IL0LOr7A=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocKxDlWgu2ogl_FG8QtMPF_PFDZdKpWD2R2aBUqWFe9IL0LOr7A=s96-c', '45.118.159.207', '', '2025-02-04 12:04:28'),
(403, 'shubham Kumar', 'shubham.0925170@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocIZAXAZ61Pxs832Ci5o_dfQE5tQg0WdMeyjuVixZlwr69lf3Q=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocIZAXAZ61Pxs832Ci5o_dfQE5tQg0WdMeyjuVixZlwr69lf3Q=s96-c', '', '2409:40e5:1177:5347:496:80ff:fec0:cf6c', '2025-02-06 13:25:37'),
(404, 'shubham Kumar', 'shubham.0925170@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocIZAXAZ61Pxs832Ci5o_dfQE5tQg0WdMeyjuVixZlwr69lf3Q=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocIZAXAZ61Pxs832Ci5o_dfQE5tQg0WdMeyjuVixZlwr69lf3Q=s96-c', '', '2409:40e5:1177:5347:496:80ff:fec0:cf6c', '2025-02-06 13:26:04'),
(424, 'Ayushi', 'thissoundssuspicious@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLQEZSx3emwJ-i6luAme9PIReTU0TyN35iumMneffW4vtosSw=s96-c', 'uploads/thissoundssuspicious@gmail.com/IMG_20250121_100837.png', '', '2409:40e4:1157:5ea7:8bf:172e:672d:41ce', '2025-02-08 21:32:33'),
(427, 'Adarsh Kumar', 'adarsh.singhpersonal@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJZ54We60kYEufKwVn4niqDa9ydf3LHGMb5bK-2qAt_6DJbsH0=s96-c', 'uploads/adarsh.singhpersonal@gmail.com/Screenshot_2025-01-21_08_33_46.png', '', '2401:4900:5d82:eafe:0:2:3458:7001', '2025-02-09 07:48:42'),
(433, 'Saziya', 'miss.saziyaa@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJp7Ki-LXlkLYSEU4JFP2xef0UUOZWMcVqvRAqVwcbft9sLKg=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJp7Ki-LXlkLYSEU4JFP2xef0UUOZWMcVqvRAqVwcbft9sLKg=s96-c', '', '2409:40d4:205a:bb23:8000::', '2025-02-09 13:03:25'),
(434, 'Saziya', 'miss.saziyaa@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJp7Ki-LXlkLYSEU4JFP2xef0UUOZWMcVqvRAqVwcbft9sLKg=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJp7Ki-LXlkLYSEU4JFP2xef0UUOZWMcVqvRAqVwcbft9sLKg=s96-c', '', '2409:40d4:205a:bb23:8000::', '2025-02-09 13:38:32'),
(435, 'Saziya', 'miss.saziyaa@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJp7Ki-LXlkLYSEU4JFP2xef0UUOZWMcVqvRAqVwcbft9sLKg=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJp7Ki-LXlkLYSEU4JFP2xef0UUOZWMcVqvRAqVwcbft9sLKg=s96-c', '', '2409:40d4:205a:bb23:8000::', '2025-02-09 13:38:43'),
(436, 'Adarsh Kumar', 'adarsh.singhpersonal@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJZ54We60kYEufKwVn4niqDa9ydf3LHGMb5bK-2qAt_6DJbsH0=s96-c', 'uploads/adarsh.singhpersonal@gmail.com/Screenshot_2025-01-21_08_33_46.png', '', '2401:4900:5d82:eafe:0:2:3458:7001', '2025-02-09 16:34:38'),
(437, 'Adarsh Kumar', 'adarsh.singhpersonal@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJZ54We60kYEufKwVn4niqDa9ydf3LHGMb5bK-2qAt_6DJbsH0=s96-c', 'uploads/adarsh.singhpersonal@gmail.com/Screenshot_2025-01-21_08_33_46.png', '', '2401:4900:5d82:eafe:0:2:3458:7001', '2025-02-09 16:34:43'),
(438, 'Ragini Rawat', 'raginiragrawat@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKrM2WbQ7Vik8Mqn_y5lk5JTEKVDuPdSlusO0_jUSGIIYec6w=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocKrM2WbQ7Vik8Mqn_y5lk5JTEKVDuPdSlusO0_jUSGIIYec6w=s96-c', '', '2409:4081:818e:bfaf::2355:40ac', '2025-02-09 16:35:11'),
(439, 'Adarsh Kumar', 'adarsh.singhpersonal@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJZ54We60kYEufKwVn4niqDa9ydf3LHGMb5bK-2qAt_6DJbsH0=s96-c', 'uploads/adarsh.singhpersonal@gmail.com/Screenshot_2025-01-21_08_33_46.png', '', '2401:4900:5d82:eafe:0:2:3458:7001', '2025-02-09 16:35:28'),
(440, 'Adarsh Kumar', 'adarsh.singhpersonal@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJZ54We60kYEufKwVn4niqDa9ydf3LHGMb5bK-2qAt_6DJbsH0=s96-c', 'uploads/adarsh.singhpersonal@gmail.com/Screenshot_2025-01-21_08_33_46.png', '', '2401:4900:5d82:eafe:0:2:3458:7001', '2025-02-09 16:35:32'),
(441, 'Ragini Rawat', 'raginiragrawat@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKrM2WbQ7Vik8Mqn_y5lk5JTEKVDuPdSlusO0_jUSGIIYec6w=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocKrM2WbQ7Vik8Mqn_y5lk5JTEKVDuPdSlusO0_jUSGIIYec6w=s96-c', '', '2409:4081:818e:bfaf::2355:40ac', '2025-02-09 16:39:30'),
(447, 'Ragini Rawat', 'raginiragrawat@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKrM2WbQ7Vik8Mqn_y5lk5JTEKVDuPdSlusO0_jUSGIIYec6w=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocKrM2WbQ7Vik8Mqn_y5lk5JTEKVDuPdSlusO0_jUSGIIYec6w=s96-c', '106.219.86.239', '', '2025-02-10 23:44:06'),
(448, 'Ragini Rawat', 'raginiragrawat@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKrM2WbQ7Vik8Mqn_y5lk5JTEKVDuPdSlusO0_jUSGIIYec6w=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocKrM2WbQ7Vik8Mqn_y5lk5JTEKVDuPdSlusO0_jUSGIIYec6w=s96-c', '106.219.86.239', '', '2025-02-10 23:49:07'),
(449, 'Ragini Rawat', 'raginiragrawat@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKrM2WbQ7Vik8Mqn_y5lk5JTEKVDuPdSlusO0_jUSGIIYec6w=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocKrM2WbQ7Vik8Mqn_y5lk5JTEKVDuPdSlusO0_jUSGIIYec6w=s96-c', '106.219.86.239', '', '2025-02-10 23:51:29'),
(451, 'Abhinav Kumar', 'abhinav6204651@gmail.com', '', '', '', '2409:40e4:1115:f76f:31c8:b93:c7f9:dc62', '2025-02-12 13:54:54'),
(452, 'Adarsh Kumar', 'adarsh.singhpersonal@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJZ54We60kYEufKwVn4niqDa9ydf3LHGMb5bK-2qAt_6DJbsH0=s96-c', 'uploads/adarsh.singhpersonal@gmail.com/Screenshot_2025-01-21_08_33_46.png', '139.5.242.95', '', '2025-02-12 13:55:13'),
(453, 'Adarsh Kumar', 'adarsh.singhpersonal@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJZ54We60kYEufKwVn4niqDa9ydf3LHGMb5bK-2qAt_6DJbsH0=s96-c', 'uploads/adarsh.singhpersonal@gmail.com/Screenshot_2025-01-21_08_33_46.png', '139.5.242.95', '', '2025-02-12 13:55:22'),
(454, 'Abhinav Kumar', 'abhinav6204651@gmail.com', '', '', '', '2409:40e4:1115:f76f:31c8:b93:c7f9:dc62', '2025-02-12 13:55:47'),
(455, 'Adarsh Kumar', 'adarsh.singhpersonal@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJZ54We60kYEufKwVn4niqDa9ydf3LHGMb5bK-2qAt_6DJbsH0=s96-c', 'uploads/adarsh.singhpersonal@gmail.com/Screenshot_2025-01-21_08_33_46.png', '139.5.242.237', '', '2025-02-14 13:35:25'),
(462, 'Adarsh Kumar', 'adarsh.singhpersonal@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJZ54We60kYEufKwVn4niqDa9ydf3LHGMb5bK-2qAt_6DJbsH0=s96-c', 'uploads/adarsh.singhpersonal@gmail.com/Screenshot_2025-01-21_08_33_46.png', '139.5.242.237', '', '2025-02-14 15:41:59'),
(463, 'Adarsh Kumar', 'adarsh.singhpersonal@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJZ54We60kYEufKwVn4niqDa9ydf3LHGMb5bK-2qAt_6DJbsH0=s96-c', 'uploads/adarsh.singhpersonal@gmail.com/Screenshot_2025-01-21_08_33_46.png', '139.5.242.237', '', '2025-02-14 15:42:05'),
(464, 'Khushi Singh', 'khushisingh892210@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJh6UQYj9JOZkNtq559lwnh53EdHID6PM-d_hyPWt7Vc4cZqw=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJh6UQYj9JOZkNtq559lwnh53EdHID6PM-d_hyPWt7Vc4cZqw=s96-c', '111.93.173.114', '', '2025-02-14 15:44:18'),
(465, 'Khushi Singh', 'khushisingh892210@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJh6UQYj9JOZkNtq559lwnh53EdHID6PM-d_hyPWt7Vc4cZqw=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJh6UQYj9JOZkNtq559lwnh53EdHID6PM-d_hyPWt7Vc4cZqw=s96-c', '111.93.173.114', '', '2025-02-14 15:58:50'),
(466, 'Khushi Singh', 'khushisingh892210@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJh6UQYj9JOZkNtq559lwnh53EdHID6PM-d_hyPWt7Vc4cZqw=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJh6UQYj9JOZkNtq559lwnh53EdHID6PM-d_hyPWt7Vc4cZqw=s96-c', '111.93.173.114', '', '2025-02-14 19:09:39'),
(467, 'Khushi Singh', 'khushisingh892210@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJh6UQYj9JOZkNtq559lwnh53EdHID6PM-d_hyPWt7Vc4cZqw=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJh6UQYj9JOZkNtq559lwnh53EdHID6PM-d_hyPWt7Vc4cZqw=s96-c', '111.93.173.114', '', '2025-02-14 19:09:46'),
(468, 'Khushi Singh', 'khushisingh892210@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJh6UQYj9JOZkNtq559lwnh53EdHID6PM-d_hyPWt7Vc4cZqw=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJh6UQYj9JOZkNtq559lwnh53EdHID6PM-d_hyPWt7Vc4cZqw=s96-c', '111.93.173.114', '', '2025-02-14 19:10:16'),
(469, 'Khushi Singh', 'khushisingh892210@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJh6UQYj9JOZkNtq559lwnh53EdHID6PM-d_hyPWt7Vc4cZqw=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJh6UQYj9JOZkNtq559lwnh53EdHID6PM-d_hyPWt7Vc4cZqw=s96-c', '111.93.173.114', '', '2025-02-14 19:22:21'),
(470, 'Khushi Singh', 'khushisingh892210@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJh6UQYj9JOZkNtq559lwnh53EdHID6PM-d_hyPWt7Vc4cZqw=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJh6UQYj9JOZkNtq559lwnh53EdHID6PM-d_hyPWt7Vc4cZqw=s96-c', '111.93.173.114', '', '2025-02-14 19:38:21'),
(471, 'Khushi Singh', 'khushisingh892210@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJh6UQYj9JOZkNtq559lwnh53EdHID6PM-d_hyPWt7Vc4cZqw=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJh6UQYj9JOZkNtq559lwnh53EdHID6PM-d_hyPWt7Vc4cZqw=s96-c', '111.93.173.114', '', '2025-02-14 19:38:24'),
(472, 'Khushi Singh', 'khushisingh892210@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJh6UQYj9JOZkNtq559lwnh53EdHID6PM-d_hyPWt7Vc4cZqw=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJh6UQYj9JOZkNtq559lwnh53EdHID6PM-d_hyPWt7Vc4cZqw=s96-c', '111.93.173.114', '', '2025-02-14 19:40:13'),
(473, 'Khushi Singh', 'khushisingh892210@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJh6UQYj9JOZkNtq559lwnh53EdHID6PM-d_hyPWt7Vc4cZqw=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJh6UQYj9JOZkNtq559lwnh53EdHID6PM-d_hyPWt7Vc4cZqw=s96-c', '111.93.173.114', '', '2025-02-14 19:40:19'),
(509, 'Tera bhai', 'deenukmwt277@gmail.com', 'uploads/deenukmwt277@gmail.com/ACg8ocICa6rgEwOyoxYldhU949jbx13wug64okZfB-MsVzqV-TNo3A=s96-c', 'uploads/deenukmwt277@gmail.com/IMG_20241119_085932_137.webp', '', '2409:4085:2e86:b163::2dc8:9a02', '2025-03-18 09:09:33'),
(510, 'Tera bhai', 'deenukmwt277@gmail.com', 'uploads/deenukmwt277@gmail.com/ACg8ocICa6rgEwOyoxYldhU949jbx13wug64okZfB-MsVzqV-TNo3A=s96-c', 'uploads/deenukmwt277@gmail.com/file-GpBCZdtaju8yWSGcEFrctZ.webp', '', '2409:4085:2e86:b163::2dc8:9a02', '2025-03-18 09:09:57'),
(511, 'Tera bhai', 'deenukmwt277@gmail.com', 'uploads/deenukmwt277@gmail.com/ACg8ocICa6rgEwOyoxYldhU949jbx13wug64okZfB-MsVzqV-TNo3A=s96-c', 'uploads/deenukmwt277@gmail.com/file-GpBCZdtaju8yWSGcEFrctZ.webp', '', '2409:4085:2e86:b163::2dc8:9a02', '2025-03-18 09:10:00'),
(512, 'Tera bhai', 'deenukmwt277@gmail.com', 'uploads/deenukmwt277@gmail.com/ACg8ocICa6rgEwOyoxYldhU949jbx13wug64okZfB-MsVzqV-TNo3A=s96-c', 'uploads/deenukmwt277@gmail.com/file-GpBCZdtaju8yWSGcEFrctZ.webp', '', '2409:4085:2e86:b163::2dc8:9a02', '2025-03-18 09:10:25'),
(513, 'Tera bhai', 'deenukmwt277@gmail.com', 'uploads/deenukmwt277@gmail.com/ACg8ocICa6rgEwOyoxYldhU949jbx13wug64okZfB-MsVzqV-TNo3A=s96-c', 'uploads/deenukmwt277@gmail.com/file-GpBCZdtaju8yWSGcEFrctZ.webp', '', '2409:4085:2e86:b163::2dc8:9a02', '2025-03-18 09:10:37'),
(519, 'Adarsh Kumar Dubey', 'kumardubeyadarsh67@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLa4LMn7u01CQrLBfPb78YyNj6f4yZ9-PD57_ad_pRVr4PX3s8K=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocLa4LMn7u01CQrLBfPb78YyNj6f4yZ9-PD57_ad_pRVr4PX3s8K=s96-c', '', '2409:40e5:204f:d259:8000::', '2025-03-27 18:59:43'),
(524, 'Khushi Singh', 'khushivishnushankarsingh@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocI5ohGYZHRFkH2hQEC_Up0P71SW0Xr6VDWXziFIBPK0NGkWtg=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocI5ohGYZHRFkH2hQEC_Up0P71SW0Xr6VDWXziFIBPK0NGkWtg=s96-c', '139.5.242.183', '', '2025-04-01 10:12:28'),
(528, 'Raj Singh', 'mr.rajsingh.student@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocIGQ9s5Seuqg2xELDPdgwmBH6VTL22SMOW3tJ9nRCxofF8RP1A=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocIGQ9s5Seuqg2xELDPdgwmBH6VTL22SMOW3tJ9nRCxofF8RP1A=s96-c', '', '2401:4900:8848:4170:4033:d0bc:7274:9d82', '2025-04-05 13:07:19'),
(531, 'Raj Singh', 'mr.rajsingh.student@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocIGQ9s5Seuqg2xELDPdgwmBH6VTL22SMOW3tJ9nRCxofF8RP1A=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocIGQ9s5Seuqg2xELDPdgwmBH6VTL22SMOW3tJ9nRCxofF8RP1A=s96-c', '', '2401:4900:8848:4170:4033:d0bc:7274:9d82', '2025-04-05 13:11:01'),
(541, 'Yaar Gagat', 'yaargagat23@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocIkMXpTwtLQuyFUFpwWy-hpzPZ-LSsdB0SlCfRuABsFfuqI7aEE=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocIkMXpTwtLQuyFUFpwWy-hpzPZ-LSsdB0SlCfRuABsFfuqI7aEE=s96-c', '223.184.204.12', '', '2025-04-15 19:46:29'),
(543, 'Heline Heline', 'helinetutecalme@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLRHwQNUM9iCg72nxgIjc_OTY2vGY33Iqpy9GQtaXtLY_dPsw=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocLRHwQNUM9iCg72nxgIjc_OTY2vGY33Iqpy9GQtaXtLY_dPsw=s96-c', '', '2a02:8440:7143:1a02:6dfa:1ddc:b0dc:cf8', '2025-04-19 19:12:46'),
(551, 'Level sabke niklenge', 'levelsabkeniklenge028@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKnFquTC_sj99vkdQvgpw_Jk3tYSmcTU_qh4RPtT3wy9yBM7g=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocKnFquTC_sj99vkdQvgpw_Jk3tYSmcTU_qh4RPtT3wy9yBM7g=s96-c', '106.219.165.156', '', '2025-05-12 08:30:46'),
(552, 'Level sabke niklenge', 'levelsabkeniklenge028@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKnFquTC_sj99vkdQvgpw_Jk3tYSmcTU_qh4RPtT3wy9yBM7g=s96-c', 'uploads/levelsabkeniklenge028@gmail.com/vishesh.jpg', '106.219.165.156', '', '2025-05-12 08:33:44'),
(553, 'Level sabke niklenge', 'levelsabkeniklenge028@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKnFquTC_sj99vkdQvgpw_Jk3tYSmcTU_qh4RPtT3wy9yBM7g=s96-c', 'uploads/levelsabkeniklenge028@gmail.com/vishesh.jpg', '106.219.165.156', '', '2025-05-14 08:13:46'),
(554, 'Level sabke niklenge', 'levelsabkeniklenge028@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKnFquTC_sj99vkdQvgpw_Jk3tYSmcTU_qh4RPtT3wy9yBM7g=s96-c', 'uploads/levelsabkeniklenge028@gmail.com/vishesh.jpg', '106.219.165.156', '', '2025-05-14 08:14:00'),
(559, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '139.5.242.44', '', '2025-05-18 10:41:37'),
(562, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '45.118.159.238', '', '2025-05-29 14:48:18'),
(572, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '202.173.125.3', '', '2025-06-24 07:00:23'),
(576, 'Raj Singh', 'mr.rajsingh.student@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocIGQ9s5Seuqg2xELDPdgwmBH6VTL22SMOW3tJ9nRCxofF8RP1A=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocIGQ9s5Seuqg2xELDPdgwmBH6VTL22SMOW3tJ9nRCxofF8RP1A=s96-c', '', '2401:4900:88d3:d61:b8b3:4191:30eb:3d0d', '2025-06-26 12:39:09'),
(578, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '202.173.125.8', '', '2025-06-28 15:10:40'),
(582, 'Khushi Singh', 'khushivishnushankarsingh@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJoGqKBurlJGNVA_cBwU6lJQaneVqR48oJwI5uik5TsZzvRyIaA=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJoGqKBurlJGNVA_cBwU6lJQaneVqR48oJwI5uik5TsZzvRyIaA=s96-c', '202.173.125.8', '', '2025-06-28 18:06:03'),
(583, 'AMAZON PRIME', 'amazonprimevdo2727@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocIicLRlikdaiWGt6cZz55oq8ygnU01TfuKz2X7YSn_OCxhMgw=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocIicLRlikdaiWGt6cZz55oq8ygnU01TfuKz2X7YSn_OCxhMgw=s96-c', '117.214.90.125', '', '2025-06-28 18:14:03'),
(584, 'Ragini Rawat', 'raginiragrawat@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKrM2WbQ7Vik8Mqn_y5lk5JTEKVDuPdSlusO0_jUSGIIYec6w=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocKrM2WbQ7Vik8Mqn_y5lk5JTEKVDuPdSlusO0_jUSGIIYec6w=s96-c', '', '2409:4081:9d95:ebce::508:b918', '2025-07-03 09:55:18'),
(585, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '139.5.242.106', '', '2025-07-03 11:01:02'),
(586, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '202.173.125.23', '', '2025-07-04 17:52:07'),
(587, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '202.173.125.78', '', '2025-07-05 23:32:36'),
(588, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '202.173.125.78', '', '2025-07-05 23:36:24'),
(589, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '202.173.125.78', '', '2025-07-05 23:38:07'),
(590, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '202.173.125.78', '', '2025-07-06 08:50:24'),
(591, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '139.5.242.55', '', '2025-07-06 17:49:25'),
(592, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '139.5.242.151', '', '2025-07-08 08:20:09'),
(593, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '139.5.242.151', '', '2025-07-08 08:20:25'),
(594, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '139.5.242.151', '', '2025-07-08 15:27:40'),
(595, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '139.5.242.151', '', '2025-07-08 15:29:17'),
(596, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '139.5.242.151', '', '2025-07-08 15:36:50'),
(597, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '139.5.242.151', '', '2025-07-08 15:44:23'),
(598, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '139.5.242.151', '', '2025-07-08 15:45:54');
INSERT INTO `login_data` (`id`, `name`, `email`, `profile_picture`, `profile_image`, `ipv4_address`, `ipv6_address`, `login_datetime`) VALUES
(599, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '139.5.242.151', '', '2025-07-08 15:48:40'),
(600, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '139.5.242.151', '', '2025-07-08 15:49:57'),
(601, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '139.5.242.201', '', '2025-07-08 20:00:35'),
(604, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '139.5.242.98', '', '2025-07-10 18:07:45'),
(605, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '139.5.242.98', '', '2025-07-10 18:08:09'),
(606, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '139.5.242.98', '', '2025-07-10 18:08:22'),
(607, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '139.5.242.98', '', '2025-07-12 06:51:05'),
(608, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '45.118.159.206', '', '2025-07-14 22:28:36'),
(609, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '45.118.159.230', '', '2025-07-15 12:30:11'),
(610, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '45.118.159.96', '', '2025-07-15 12:48:42'),
(611, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '202.173.125.161', '', '2025-07-15 13:50:05'),
(613, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '139.5.242.34', '', '2025-07-17 16:57:38'),
(614, 'Fake account', 'itisreadxhub@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKgA9MRKc4wOgvV7GxpdDliN08iZSBX_j1OLEimh6jGgQAafw=s96-c', 'uploads/itisreadxhub@gmail.com/red-devil-face-8ijyi31ij1qeudnc.jpg', '139.5.242.34', '', '2025-07-18 01:57:39'),
(615, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '139.5.242.34', '', '2025-07-18 10:07:52'),
(616, 'Fake account', 'itisreadxhub@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKgA9MRKc4wOgvV7GxpdDliN08iZSBX_j1OLEimh6jGgQAafw=s96-c', 'uploads/itisreadxhub@gmail.com/red-devil-face-8ijyi31ij1qeudnc.jpg', '139.5.242.34', '', '2025-07-19 15:39:55'),
(617, 'RUDRAKSH', 'rudra81785@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKT6UTST8u4I2ZFHY6e0ZfQC9uUMYt0EPqDcJOdsalPXzpe-w=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocKT6UTST8u4I2ZFHY6e0ZfQC9uUMYt0EPqDcJOdsalPXzpe-w=s96-c', '', '2401:4900:a137:b14d:6af8:2521:2bae:8291', '2025-07-19 23:00:12'),
(618, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '139.5.242.34', '', '2025-07-20 02:12:12'),
(619, 'Fake account', 'itisreadxhub@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKgA9MRKc4wOgvV7GxpdDliN08iZSBX_j1OLEimh6jGgQAafw=s96-c', 'uploads/itisreadxhub@gmail.com/red-devil-face-8ijyi31ij1qeudnc.jpg', '', '2409:40d0:100f:59cc:8000::', '2025-07-20 15:11:06'),
(620, 'Fake account', 'itisreadxhub@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKgA9MRKc4wOgvV7GxpdDliN08iZSBX_j1OLEimh6jGgQAafw=s96-c', 'uploads/itisreadxhub@gmail.com/red-devil-face-8ijyi31ij1qeudnc.jpg', '', '2409:40d0:1021:dba5:8000::', '2025-07-23 00:34:44'),
(621, 'Fake account', 'itisreadxhub@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKgA9MRKc4wOgvV7GxpdDliN08iZSBX_j1OLEimh6jGgQAafw=s96-c', 'uploads/itisreadxhub@gmail.com/red-devil-face-8ijyi31ij1qeudnc.jpg', '', '2409:40d0:1b:c781:8000::', '2025-07-24 10:54:26'),
(622, 'Fake account', 'itisreadxhub@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKgA9MRKc4wOgvV7GxpdDliN08iZSBX_j1OLEimh6jGgQAafw=s96-c', 'uploads/itisreadxhub@gmail.com/red-devil-face-8ijyi31ij1qeudnc.jpg', '45.118.159.66', '', '2025-07-24 22:20:05'),
(623, 'Fake account', 'itisreadxhub@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKgA9MRKc4wOgvV7GxpdDliN08iZSBX_j1OLEimh6jGgQAafw=s96-c', 'uploads/itisreadxhub@gmail.com/red-devil-face-8ijyi31ij1qeudnc.jpg', '45.118.159.139', '', '2025-07-25 11:53:03'),
(624, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '45.118.159.139', '', '2025-07-29 13:55:37'),
(626, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '45.118.159.139', '', '2025-07-30 09:53:29'),
(628, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '139.5.242.122', '', '2025-08-09 14:23:55'),
(629, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '139.5.242.122', '', '2025-08-09 14:26:03'),
(630, 'Utkarsh kumar', 'khushisinghadarsh@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJWKpfb2SuZ5S1L2IhbdAXrkYkv55k95KJaSeY9XUa3eNhZhV-W=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJWKpfb2SuZ5S1L2IhbdAXrkYkv55k95KJaSeY9XUa3eNhZhV-W=s96-c', '139.5.242.178', '', '2025-08-19 18:05:07'),
(631, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.43', '', '2025-08-22 09:42:57'),
(632, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.162', '', '2025-08-24 16:52:25'),
(633, 'Utkarsh kumar', 'khushisinghadarsh@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJWKpfb2SuZ5S1L2IhbdAXrkYkv55k95KJaSeY9XUa3eNhZhV-W=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJWKpfb2SuZ5S1L2IhbdAXrkYkv55k95KJaSeY9XUa3eNhZhV-W=s96-c', '103.108.5.162', '', '2025-08-24 21:04:23'),
(634, 'Utkarsh kumar', 'khushisinghadarsh@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJWKpfb2SuZ5S1L2IhbdAXrkYkv55k95KJaSeY9XUa3eNhZhV-W=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJWKpfb2SuZ5S1L2IhbdAXrkYkv55k95KJaSeY9XUa3eNhZhV-W=s96-c', '103.108.5.162', '', '2025-08-24 21:05:18'),
(636, 'Tera bhai', 'deenukmwt277@gmail.com', 'uploads/deenukmwt277@gmail.com/ACg8ocICa6rgEwOyoxYldhU949jbx13wug64okZfB-MsVzqV-TNo3A=s96-c', 'uploads/deenukmwt277@gmail.com/file-GpBCZdtaju8yWSGcEFrctZ.webp', '', '2405:201:5c20:504f:740d:16b8:e616:47eb', '2025-08-28 15:51:44'),
(637, 'Tera bhai', 'deenukmwt277@gmail.com', 'uploads/deenukmwt277@gmail.com/ACg8ocICa6rgEwOyoxYldhU949jbx13wug64okZfB-MsVzqV-TNo3A=s96-c', 'uploads/deenukmwt277@gmail.com/file-GpBCZdtaju8yWSGcEFrctZ.webp', '', '2405:201:5c20:504f:740d:16b8:e616:47eb', '2025-08-28 15:51:48'),
(638, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.235', '', '2025-08-31 01:08:16'),
(639, 'Fake account', 'itisreadxhub@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKgA9MRKc4wOgvV7GxpdDliN08iZSBX_j1OLEimh6jGgQAafw=s96-c', 'uploads/itisreadxhub@gmail.com/red-devil-face-8ijyi31ij1qeudnc.jpg', '103.108.5.104', '', '2025-09-04 08:43:24'),
(640, 'Adarsh Bhai', 'adarshjisinghvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLaPXlO24ETboV96kZ-N_IeAA6KI--qfm1UIwJFNLTi6R9YYOg=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocLaPXlO24ETboV96kZ-N_IeAA6KI--qfm1UIwJFNLTi6R9YYOg=s96-c', '103.108.5.104', '', '2025-09-05 12:17:49'),
(641, 'Adarsh Bhai', 'adarshjisinghvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLaPXlO24ETboV96kZ-N_IeAA6KI--qfm1UIwJFNLTi6R9YYOg=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocLaPXlO24ETboV96kZ-N_IeAA6KI--qfm1UIwJFNLTi6R9YYOg=s96-c', '103.108.5.104', '', '2025-09-05 12:18:06'),
(642, 'Adarsh Bhai', 'adarshjisinghvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLaPXlO24ETboV96kZ-N_IeAA6KI--qfm1UIwJFNLTi6R9YYOg=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocLaPXlO24ETboV96kZ-N_IeAA6KI--qfm1UIwJFNLTi6R9YYOg=s96-c', '103.108.5.104', '', '2025-09-05 13:54:49'),
(643, 'Adarsh Bhai', 'adarshjisinghvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLaPXlO24ETboV96kZ-N_IeAA6KI--qfm1UIwJFNLTi6R9YYOg=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocLaPXlO24ETboV96kZ-N_IeAA6KI--qfm1UIwJFNLTi6R9YYOg=s96-c', '103.108.5.104', '', '2025-09-05 16:45:31'),
(644, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.104', '', '2025-09-06 18:42:29'),
(645, 'Fake account', 'itisreadxhub@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKgA9MRKc4wOgvV7GxpdDliN08iZSBX_j1OLEimh6jGgQAafw=s96-c', 'uploads/itisreadxhub@gmail.com/red-devil-face-8ijyi31ij1qeudnc.jpg', '103.108.5.104', '', '2025-09-07 10:07:40'),
(646, 'Adarsh Bhai', 'adarshjisinghvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLaPXlO24ETboV96kZ-N_IeAA6KI--qfm1UIwJFNLTi6R9YYOg=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocLaPXlO24ETboV96kZ-N_IeAA6KI--qfm1UIwJFNLTi6R9YYOg=s96-c', '103.108.5.104', '', '2025-09-07 13:45:30'),
(647, 'Adarsh Bhai', 'adarshjisinghvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLaPXlO24ETboV96kZ-N_IeAA6KI--qfm1UIwJFNLTi6R9YYOg=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocLaPXlO24ETboV96kZ-N_IeAA6KI--qfm1UIwJFNLTi6R9YYOg=s96-c', '103.108.5.104', '', '2025-09-07 13:46:09'),
(648, 'Raj Singh', 'mr.rajsingh.student@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocIGQ9s5Seuqg2xELDPdgwmBH6VTL22SMOW3tJ9nRCxofF8RP1A=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocIGQ9s5Seuqg2xELDPdgwmBH6VTL22SMOW3tJ9nRCxofF8RP1A=s96-c', '', '2401:4900:88d2:c2c7:c5da:2569:90e6:951d', '2025-09-07 18:27:06'),
(649, 'Unknown User', 'adarshsingh22042006@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJmgHXcQCiuq6FzkNF6e1ujd02mDeMdGvi2eE7dcJ32EwgTTw=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJmgHXcQCiuq6FzkNF6e1ujd02mDeMdGvi2eE7dcJ32EwgTTw=s96-c', '139.5.248.244', '', '2025-09-07 19:36:45'),
(650, 'Raj Singh', 'mr.rajsingh.student@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocIGQ9s5Seuqg2xELDPdgwmBH6VTL22SMOW3tJ9nRCxofF8RP1A=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocIGQ9s5Seuqg2xELDPdgwmBH6VTL22SMOW3tJ9nRCxofF8RP1A=s96-c', '', '2401:4900:88d2:c2c7:c087:e27a:28d4:6a96', '2025-09-07 19:42:55'),
(651, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.104', '', '2025-09-07 22:28:29'),
(652, 'Adarsh Bhai', 'adarshjisinghvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLaPXlO24ETboV96kZ-N_IeAA6KI--qfm1UIwJFNLTi6R9YYOg=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocLaPXlO24ETboV96kZ-N_IeAA6KI--qfm1UIwJFNLTi6R9YYOg=s96-c', '103.108.5.33', '', '2025-09-08 13:33:59'),
(653, 'Utkarsh kumar', 'khushisinghadarsh@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJWKpfb2SuZ5S1L2IhbdAXrkYkv55k95KJaSeY9XUa3eNhZhV-W=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJWKpfb2SuZ5S1L2IhbdAXrkYkv55k95KJaSeY9XUa3eNhZhV-W=s96-c', '103.108.5.33', '', '2025-09-10 08:55:17'),
(654, 'Ayushi Sharma', 'ayushisharma9972@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLowGLuDPkQXfo_BMRzdoJoMYXOn0BKuy73LbZ14TZgeJiGb48=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocLowGLuDPkQXfo_BMRzdoJoMYXOn0BKuy73LbZ14TZgeJiGb48=s96-c', '103.108.5.107', '', '2025-09-13 16:40:11'),
(655, 'Ayushi Sharma', 'ayushisharma9972@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLowGLuDPkQXfo_BMRzdoJoMYXOn0BKuy73LbZ14TZgeJiGb48=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocLowGLuDPkQXfo_BMRzdoJoMYXOn0BKuy73LbZ14TZgeJiGb48=s96-c', '103.108.5.107', '', '2025-09-13 16:40:46'),
(656, 'Unknown User', 'adarshsingh22042006@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJmgHXcQCiuq6FzkNF6e1ujd02mDeMdGvi2eE7dcJ32EwgTTw=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJmgHXcQCiuq6FzkNF6e1ujd02mDeMdGvi2eE7dcJ32EwgTTw=s96-c', '139.5.248.155', '', '2025-09-13 22:20:39'),
(657, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.24', '', '2025-09-15 11:53:55'),
(658, 'Utkarsh kumar', 'khushisinghadarsh@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJWKpfb2SuZ5S1L2IhbdAXrkYkv55k95KJaSeY9XUa3eNhZhV-W=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJWKpfb2SuZ5S1L2IhbdAXrkYkv55k95KJaSeY9XUa3eNhZhV-W=s96-c', '', '2409:40d0:2e:1576:8000::', '2025-09-15 14:53:33'),
(659, 'Utkarsh kumar', 'khushisinghadarsh@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJWKpfb2SuZ5S1L2IhbdAXrkYkv55k95KJaSeY9XUa3eNhZhV-W=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJWKpfb2SuZ5S1L2IhbdAXrkYkv55k95KJaSeY9XUa3eNhZhV-W=s96-c', '', '2409:40d0:2e:1576:8000::', '2025-09-15 14:53:34'),
(660, 'Utkarsh kumar', 'khushisinghadarsh@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJWKpfb2SuZ5S1L2IhbdAXrkYkv55k95KJaSeY9XUa3eNhZhV-W=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJWKpfb2SuZ5S1L2IhbdAXrkYkv55k95KJaSeY9XUa3eNhZhV-W=s96-c', '', '2409:40d0:2e:1576:8000::', '2025-09-15 14:54:26'),
(661, 'Utkarsh kumar', 'khushisinghadarsh@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJWKpfb2SuZ5S1L2IhbdAXrkYkv55k95KJaSeY9XUa3eNhZhV-W=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJWKpfb2SuZ5S1L2IhbdAXrkYkv55k95KJaSeY9XUa3eNhZhV-W=s96-c', '', '2409:40d0:2e:1576:8000::', '2025-09-15 14:54:36'),
(662, 'Pravesh Yadav', 'praveshyadavahir07@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKzmhV_Yho3FoSDBkngIeVgiSLMJwZwd-S0hRQWnEtEJ-XUy8C-=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocKzmhV_Yho3FoSDBkngIeVgiSLMJwZwd-S0hRQWnEtEJ-XUy8C-=s96-c', '', '2409:40e3:3107:2e9e:8000::', '2025-09-15 19:55:54'),
(663, 'Pravesh Yadav', 'praveshyadavahir07@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKzmhV_Yho3FoSDBkngIeVgiSLMJwZwd-S0hRQWnEtEJ-XUy8C-=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocKzmhV_Yho3FoSDBkngIeVgiSLMJwZwd-S0hRQWnEtEJ-XUy8C-=s96-c', '', '2409:40e3:3107:2e9e:8000::', '2025-09-15 20:03:38'),
(664, 'Pravesh Yadav', 'praveshyadavahir07@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKzmhV_Yho3FoSDBkngIeVgiSLMJwZwd-S0hRQWnEtEJ-XUy8C-=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocKzmhV_Yho3FoSDBkngIeVgiSLMJwZwd-S0hRQWnEtEJ-XUy8C-=s96-c', '', '2409:40e3:3107:2e9e:8000::', '2025-09-15 20:04:22'),
(665, 'Utkarsh kumar', 'khushisinghadarsh@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJWKpfb2SuZ5S1L2IhbdAXrkYkv55k95KJaSeY9XUa3eNhZhV-W=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJWKpfb2SuZ5S1L2IhbdAXrkYkv55k95KJaSeY9XUa3eNhZhV-W=s96-c', '', '2a00:7c80:0:3b9::14', '2025-09-17 15:42:02'),
(666, 'Utkarsh kumar', 'khushisinghadarsh@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocJWKpfb2SuZ5S1L2IhbdAXrkYkv55k95KJaSeY9XUa3eNhZhV-W=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocJWKpfb2SuZ5S1L2IhbdAXrkYkv55k95KJaSeY9XUa3eNhZhV-W=s96-c', '', '2a00:7c80:0:3b9::14', '2025-09-17 15:42:53'),
(667, 'Rdx', 'rdx192842@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKpjWSiruJe_pH_i9qZ51VbuSfA8PJYKprSS6ZrKpFd2K8bkQ=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocKpjWSiruJe_pH_i9qZ51VbuSfA8PJYKprSS6ZrKpFd2K8bkQ=s96-c', '', '2402:e000:62d:3a14::1', '2025-09-18 09:31:22'),
(668, 'Rdx', 'rdx192842@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKpjWSiruJe_pH_i9qZ51VbuSfA8PJYKprSS6ZrKpFd2K8bkQ=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocKpjWSiruJe_pH_i9qZ51VbuSfA8PJYKprSS6ZrKpFd2K8bkQ=s96-c', '', '2402:e000:62d:3a14::1', '2025-09-18 09:37:13'),
(669, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.118', '', '2025-09-19 08:09:40'),
(670, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKkbTI_WuM09yl13Wf0ZgDTWj3q_aTG0X9u3tXYaH38RKBfv7uT=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.118', '', '2025-09-19 08:10:23'),
(671, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.118', '', '2025-09-19 08:19:43'),
(672, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.53', '', '2025-09-19 09:00:15'),
(673, 'Adarsh Bhai', 'adarshjisinghvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLaPXlO24ETboV96kZ-N_IeAA6KI--qfm1UIwJFNLTi6R9YYOg=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocLaPXlO24ETboV96kZ-N_IeAA6KI--qfm1UIwJFNLTi6R9YYOg=s96-c', '103.108.5.240', '', '2025-09-21 11:10:54'),
(674, 'Adarsh Bhai', 'adarshjisinghvishnu@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLaPXlO24ETboV96kZ-N_IeAA6KI--qfm1UIwJFNLTi6R9YYOg=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocLaPXlO24ETboV96kZ-N_IeAA6KI--qfm1UIwJFNLTi6R9YYOg=s96-c', '103.108.5.240', '', '2025-09-21 11:11:14'),
(678, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.240', '', '2025-09-24 10:58:56'),
(679, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.240', '', '2025-09-24 11:01:12'),
(680, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.240', '', '2025-09-24 11:04:15'),
(681, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.240', '', '2025-09-24 11:04:34'),
(682, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.240', '', '2025-09-24 11:04:44'),
(683, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.240', '', '2025-09-24 11:24:01'),
(684, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.240', '', '2025-09-24 11:25:28'),
(685, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.240', '', '2025-09-24 11:26:09'),
(688, 'Piyush Dhuriya', 'dhuriyapiyush9@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLeIk_gpb2eAoEnj2EhSHSyueFyd-RjxSR7shKd6zhNxKpEtrwE=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocLeIk_gpb2eAoEnj2EhSHSyueFyd-RjxSR7shKd6zhNxKpEtrwE=s96-c', '', '2401:4900:a13a:1d58:d0dc:1cff:fed9:7ee5', '2025-09-24 18:41:47'),
(689, 'Piyush Dhuriya', 'dhuriyapiyush9@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocLeIk_gpb2eAoEnj2EhSHSyueFyd-RjxSR7shKd6zhNxKpEtrwE=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocLeIk_gpb2eAoEnj2EhSHSyueFyd-RjxSR7shKd6zhNxKpEtrwE=s96-c', '', '2401:4900:a13a:1d58:d0dc:1cff:fed9:7ee5', '2025-09-24 18:43:20'),
(690, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.91', '', '2025-09-24 19:11:46'),
(691, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.55', '', '2025-09-27 08:20:26'),
(692, 'Tera bhai', 'deenukmwt277@gmail.com', 'uploads/deenukmwt277@gmail.com/ACg8ocICa6rgEwOyoxYldhU949jbx13wug64okZfB-MsVzqV-TNo3A=s96-c', 'uploads/deenukmwt277@gmail.com/file-GpBCZdtaju8yWSGcEFrctZ.webp', '', '2409:4085:4e18:da1::2d48:cf0c', '2025-09-30 19:46:16'),
(693, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.241', '', '2025-10-04 11:51:13'),
(694, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.241', '', '2025-10-04 11:53:02'),
(695, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.241', '', '2025-10-04 11:54:31'),
(696, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.241', '', '2025-10-04 11:55:15'),
(697, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.241', '', '2025-10-04 11:55:32'),
(698, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.241', '', '2025-10-04 11:55:55'),
(699, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.241', '', '2025-10-04 11:59:10'),
(703, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '', '2401:4900:83a1:7667:6b42:16bd:10f:420a', '2025-10-10 13:54:19'),
(704, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.118', '', '2025-10-10 18:07:18'),
(705, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.118', '', '2025-10-10 18:08:13'),
(706, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.118', '', '2025-10-10 18:11:54'),
(707, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.118', '', '2025-10-10 18:12:01'),
(709, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.118', '', '2025-10-10 19:07:56'),
(710, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.118', '', '2025-10-10 19:08:40'),
(711, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.118', '', '2025-10-10 19:11:15'),
(712, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.118', '', '2025-10-10 19:11:28'),
(713, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.118', '', '2025-10-10 19:11:43'),
(714, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.118', '', '2025-10-10 19:15:31'),
(715, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.118', '', '2025-10-10 19:17:42'),
(716, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.118', '', '2025-10-10 19:21:11'),
(717, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.118', '', '2025-10-10 19:21:16'),
(718, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.118', '', '2025-10-10 19:21:58'),
(719, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.118', '', '2025-10-10 19:22:12'),
(720, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.118', '', '2025-10-10 19:29:36'),
(721, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.118', '', '2025-10-10 19:29:51'),
(722, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.118', '', '2025-10-10 19:35:34'),
(723, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.118', '', '2025-10-10 19:37:19'),
(724, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.118', '', '2025-10-10 19:38:23'),
(725, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.118', '', '2025-10-10 19:44:37'),
(726, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.118', '', '2025-10-10 19:44:56'),
(728, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.118', '', '2025-10-10 21:24:35'),
(729, 'Adarsh Singh', 'adarshfinalchannel@gmail.com', 'uploads/adarshfinalchannel@gmail.com/ACg8ocIikx352-eGDuN3w03OD52sYyhgz81xGPZrBJNtuTPLuG9aEQ=s96-c', 'uploads/adarshfinalchannel@gmail.com/Screenshot_2025-03-23-13-53-00-88_3aea4af51f236e4932235fdada7d1643.jpg', '103.108.5.118', '', '2025-10-11 10:44:06'),
(730, 'Adarsh Singh', 'adarshfinalchannel@gmail.com', 'uploads/adarshfinalchannel@gmail.com/ACg8ocIikx352-eGDuN3w03OD52sYyhgz81xGPZrBJNtuTPLuG9aEQ=s96-c', 'uploads/adarshfinalchannel@gmail.com/Screenshot_2025-03-23-13-53-00-88_3aea4af51f236e4932235fdada7d1643.jpg', '103.108.5.118', '', '2025-10-11 10:45:59'),
(731, 'Raj Singh', 'mr.rajsingh.student@gmail.com', 'uploads/mr.rajsingh.student@gmail.com/ACg8ocJrat2yWaldJo4FDZsTVLMHlkapmjnVwT4osu9mfShpFGowwEMz=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocIGQ9s5Seuqg2xELDPdgwmBH6VTL22SMOW3tJ9nRCxofF8RP1A=s96-c', '', '2401:4900:88d3:3644:4d2c:1d8f:37ef:63d', '2025-10-11 11:53:10'),
(732, 'Raj Singh', 'mr.rajsingh.student@gmail.com', 'uploads/mr.rajsingh.student@gmail.com/ACg8ocJrat2yWaldJo4FDZsTVLMHlkapmjnVwT4osu9mfShpFGowwEMz=s96-c', 'https://lh3.googleusercontent.com/a/ACg8ocIGQ9s5Seuqg2xELDPdgwmBH6VTL22SMOW3tJ9nRCxofF8RP1A=s96-c', '103.108.5.139', '', '2025-10-12 20:59:44'),
(733, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '', '2401:4900:839f:f4c7:3676:6b67:ec5c:a9a', '2025-10-13 12:38:02'),
(734, 'Adarsh Singh', 'adarshfinalchannel@gmail.com', 'uploads/adarshfinalchannel@gmail.com/ACg8ocIikx352-eGDuN3w03OD52sYyhgz81xGPZrBJNtuTPLuG9aEQ=s96-c', 'uploads/adarshfinalchannel@gmail.com/Screenshot_2025-03-23-13-53-00-88_3aea4af51f236e4932235fdada7d1643.jpg', '103.108.5.139', '', '2025-10-14 10:42:25'),
(735, 'Adarsh Singh', 'adarshfinalchannel@gmail.com', 'uploads/adarshfinalchannel@gmail.com/ACg8ocIikx352-eGDuN3w03OD52sYyhgz81xGPZrBJNtuTPLuG9aEQ=s96-c', 'uploads/adarshfinalchannel@gmail.com/Screenshot_2025-03-23-13-53-00-88_3aea4af51f236e4932235fdada7d1643.jpg', '103.108.5.139', '', '2025-10-14 10:42:31'),
(736, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.208', '', '2025-10-15 19:38:02'),
(737, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.208', '', '2025-10-15 19:57:48'),
(738, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.208', '', '2025-10-15 19:58:21'),
(739, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.208', '', '2025-10-15 20:01:40'),
(740, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.208', '', '2025-10-16 09:37:53'),
(741, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.208', '', '2025-10-16 09:40:40'),
(742, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.208', '', '2025-10-16 09:41:49'),
(743, 'Adarsh Singh', 'adarshfinalchannel@gmail.com', 'uploads/adarshfinalchannel@gmail.com/ACg8ocIikx352-eGDuN3w03OD52sYyhgz81xGPZrBJNtuTPLuG9aEQ=s96-c', 'uploads/adarshfinalchannel@gmail.com/Screenshot_2025-03-23-13-53-00-88_3aea4af51f236e4932235fdada7d1643.jpg', '103.108.5.247', '', '2025-10-17 09:54:43'),
(744, 'Adarsh Singh', 'adarshfinalchannel@gmail.com', 'uploads/adarshfinalchannel@gmail.com/ACg8ocIikx352-eGDuN3w03OD52sYyhgz81xGPZrBJNtuTPLuG9aEQ=s96-c', 'uploads/adarshfinalchannel@gmail.com/Screenshot_2025-03-23-13-53-00-88_3aea4af51f236e4932235fdada7d1643.jpg', '103.108.5.247', '', '2025-10-17 19:22:27'),
(745, 'Adarsh Singh', 'adarshfinalchannel@gmail.com', 'uploads/adarshfinalchannel@gmail.com/ACg8ocIikx352-eGDuN3w03OD52sYyhgz81xGPZrBJNtuTPLuG9aEQ=s96-c', 'uploads/adarshfinalchannel@gmail.com/Screenshot_2025-03-23-13-53-00-88_3aea4af51f236e4932235fdada7d1643.jpg', '103.108.5.247', '', '2025-10-17 19:22:33'),
(746, 'Adarsh Singh', 'adarshfinalchannel@gmail.com', 'uploads/adarshfinalchannel@gmail.com/ACg8ocIikx352-eGDuN3w03OD52sYyhgz81xGPZrBJNtuTPLuG9aEQ=s96-c', 'uploads/adarshfinalchannel@gmail.com/Screenshot_2025-03-23-13-53-00-88_3aea4af51f236e4932235fdada7d1643.jpg', '103.108.5.247', '', '2025-10-17 19:22:37'),
(747, 'Adarsh Singh', 'adarshfinalchannel@gmail.com', 'uploads/adarshfinalchannel@gmail.com/ACg8ocIikx352-eGDuN3w03OD52sYyhgz81xGPZrBJNtuTPLuG9aEQ=s96-c', 'uploads/adarshfinalchannel@gmail.com/Screenshot_2025-03-23-13-53-00-88_3aea4af51f236e4932235fdada7d1643.jpg', '103.108.5.247', '', '2025-10-17 19:22:38'),
(748, 'Adarsh Singh', 'adarshfinalchannel@gmail.com', 'uploads/adarshfinalchannel@gmail.com/ACg8ocIikx352-eGDuN3w03OD52sYyhgz81xGPZrBJNtuTPLuG9aEQ=s96-c', 'uploads/adarshfinalchannel@gmail.com/Screenshot_2025-03-23-13-53-00-88_3aea4af51f236e4932235fdada7d1643.jpg', '103.108.5.247', '', '2025-10-17 19:22:39'),
(749, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '', '2409:40d0:1332:df5a:1f4a:f487:17f9:186', '2025-10-21 10:23:59'),
(750, 'Vinay jha', 'jhavinay897@gmail.com', 'uploads/jhavinay897@gmail.com/ACg8ocKWj1UM43evKWhX1rTjJ94QbuUvZC_JaGtGDCWEdTwPtiY9pM0M=s96-c', 'uploads/jhavinay897@gmail.com/IMG_20241014_105142.jpg', '103.43.35.199', '', '2025-10-21 16:15:07'),
(751, 'Vinay jha', 'jhavinay897@gmail.com', 'uploads/jhavinay897@gmail.com/ACg8ocKWj1UM43evKWhX1rTjJ94QbuUvZC_JaGtGDCWEdTwPtiY9pM0M=s96-c', 'uploads/jhavinay897@gmail.com/IMG_20241014_105142.jpg', '103.43.35.199', '', '2025-10-21 16:18:01'),
(752, 'Vinay jha', 'jhavinay897@gmail.com', 'uploads/jhavinay897@gmail.com/ACg8ocKWj1UM43evKWhX1rTjJ94QbuUvZC_JaGtGDCWEdTwPtiY9pM0M=s96-c', 'uploads/jhavinay897@gmail.com/IMG_20241014_105142.jpg', '', '2401:4900:1c66:78be:d59e:1b8c:ba71:1d6c', '2025-10-23 14:05:29'),
(753, 'Vinay jha', 'jhavinay897@gmail.com', 'uploads/jhavinay897@gmail.com/ACg8ocKWj1UM43evKWhX1rTjJ94QbuUvZC_JaGtGDCWEdTwPtiY9pM0M=s96-c', 'uploads/jhavinay897@gmail.com/IMG_20241014_105142.jpg', '', '2401:4900:1c66:78be:d59e:1b8c:ba71:1d6c', '2025-10-23 14:08:19'),
(754, 'Vinay jha', 'jhavinay897@gmail.com', 'uploads/jhavinay897@gmail.com/ACg8ocKWj1UM43evKWhX1rTjJ94QbuUvZC_JaGtGDCWEdTwPtiY9pM0M=s96-c', 'uploads/jhavinay897@gmail.com/IMG_20241014_105142.jpg', '', '2401:4900:1c66:78be:d59e:1b8c:ba71:1d6c', '2025-10-23 14:11:28'),
(755, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.36', '', '2025-10-24 09:05:21'),
(756, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.36', '', '2025-10-24 09:05:22'),
(757, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.36', '', '2025-10-24 09:05:25'),
(758, 'Vinay jha', 'jhavinay897@gmail.com', 'uploads/jhavinay897@gmail.com/ACg8ocKWj1UM43evKWhX1rTjJ94QbuUvZC_JaGtGDCWEdTwPtiY9pM0M=s96-c', 'uploads/jhavinay897@gmail.com/IMG_20241014_105142.jpg', '', '2401:4900:1c65:4e00:d569:b3c1:db46:77af', '2025-10-24 10:11:06'),
(759, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '', '2401:4900:5d96:874d::6a15:dd01', '2025-10-24 17:16:30'),
(760, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.36', '', '2025-10-25 10:45:45'),
(761, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.36', '', '2025-10-25 11:34:32'),
(762, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.36', '', '2025-10-25 11:50:39'),
(763, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.36', '', '2025-10-25 11:50:55'),
(764, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.36', '', '2025-10-25 12:46:42'),
(765, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '110.225.70.135', '', '2025-10-27 19:29:00'),
(766, 'Fake account', 'itisreadxhub@gmail.com', 'https://lh3.googleusercontent.com/a/ACg8ocKgA9MRKc4wOgvV7GxpdDliN08iZSBX_j1OLEimh6jGgQAafw=s96-c', 'uploads/itisreadxhub@gmail.com/red-devil-face-8ijyi31ij1qeudnc.jpg', '', '2409:40d0:1008:6737:8000::', '2025-10-30 11:53:37'),
(767, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.0', '', '2025-10-30 22:27:18'),
(768, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.76', '', '2025-11-05 18:00:35'),
(769, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', 'uploads/adarsh.singhvishnu@gmail.com/ACg8ocI6BblCRw8jgOPGrwgdd0GAQHXYd_Yb5UscKFiJeIFQfzr6dAM=s96-c', 'uploads/adarsh.singhvishnu@gmail.com/WhatsApp Image 2025-02-07 at 8.37.46 AM.jpeg', '103.108.5.76', '', '2025-11-05 18:59:17');

-- --------------------------------------------------------

--
-- Table structure for table `pending_users`
--

CREATE TABLE `pending_users` (
  `id` int(11) NOT NULL,
  `google_id` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `google_access_token` text DEFAULT NULL,
  `google_name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pending_users`
--

INSERT INTO `pending_users` (`id`, `google_id`, `name`, `email`, `profile_picture`, `date_of_birth`, `google_access_token`, `google_name`, `created_at`) VALUES
(12, '107644282521055941310', 'Khushi Singh', 'khushivishnushankarsingh@gmail.com', 'uploads/pending/ACg8ocI5ohGYZHRFkH2hQEC_Up0P71SW0Xr6VDWXziFIBPK0NGkWtg=s96-c', NULL, 'eyJhbGciOiJSUzI1NiIsImtpZCI6ImE0OTM5MWJmNTJiNThjMWQ1NjAyNTVjMmYyYTA0ZTU5ZTIyYTdiNjUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI5Mzk0NjcxODg1MTQtOTZtZ3E0aXJpZzAxMDBsamRmMWNscG5lbTM3dmVqNjAuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI5Mzk0NjcxODg1MTQtOTZtZ3E0aXJpZzAxMDBsamRmMWNscG5lbTM3dmVqNjAuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMDc2NDQyODI1MjEwNTU5NDEzMTAiLCJlbWFpbCI6ImtodXNoaXZpc2hudXNoYW5rYXJzaW5naEBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwibmJmIjoxNzI0NTAxMTQwLCJuYW1lIjoiS2h1c2hpIFNpbmdoIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FDZzhvY0k1b2hHWVpIUkZrSDJoUUVDX1VwMFA3MVNXMFhyNlZEV1h6aUZJQlBLME5Ha1d0Zz1zOTYtYyIsImdpdmVuX25hbWUiOiJLaHVzaGkiLCJmYW1pbHlfbmFtZSI6IlNpbmdoIiwiaWF0IjoxNzI0NTAxNDQwLCJleHAiOjE3MjQ1MDUwNDAsImp0aSI6IjUzMmIzYzQxZDZiZTczMDBlYWU1NTc0MjhlNDU4NjhmNjQ5ZmJhZDkifQ.aLs0CvM5u17E47QPnJTu7urPAhGA-bjvumCDnavBOMDyL4onqnLU-wiiOGEwJF6fr1lFtFdt9YAXJm2jNPcMP5CyxXmFN0mJmWlc-lotltiv51xKtT1lXbZQtAiadVBdGbXo7F76h_WtzegajzCHNIP0Mjlk0AVKLUikMYlnLVIYixBPRkl7_cHkO2B6qCXZ4DhyzqJxoakIK_dYqd_Bw5Rmb9NTGsjLai3zKU4eUflXI2v05S9GVB4SLOwYyt59ZrWjTmC7jzds8aDXCI_mAyDOlmzCqh2XkucSbdUPSX0OiUSOCzBYTWU94gNY8SS2aFNaG1ZJMWvAgpOLPxLXuQ', NULL, '2024-08-24 12:10:43'),
(15, '101716764204712777912', 'Nipu devi', 'nipudevi8801@gmail.com', 'uploads/pending/ACg8ocLKSPiZQtgcmNuUa3YYBesf7uwlQQzM21Q8UaqSh8dL2yTQJXc=s96-c', NULL, 'eyJhbGciOiJSUzI1NiIsImtpZCI6ImE0OTM5MWJmNTJiNThjMWQ1NjAyNTVjMmYyYTA0ZTU5ZTIyYTdiNjUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI5Mzk0NjcxODg1MTQtOTZtZ3E0aXJpZzAxMDBsamRmMWNscG5lbTM3dmVqNjAuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI5Mzk0NjcxODg1MTQtOTZtZ3E0aXJpZzAxMDBsamRmMWNscG5lbTM3dmVqNjAuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMDE3MTY3NjQyMDQ3MTI3Nzc5MTIiLCJlbWFpbCI6Im5pcHVkZXZpODgwMUBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwibmJmIjoxNzI0NTAzMTE4LCJuYW1lIjoiTmlwdSBkZXZpIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FDZzhvY0xLU1BpWlF0Z2NtTnVVYTNZWUJlc2Y3dXdsUVF6TTIxUThVYXFTaDhkTDJ5VFFKWGM9czk2LWMiLCJnaXZlbl9uYW1lIjoiTmlwdSIsImZhbWlseV9uYW1lIjoiZGV2aSIsImlhdCI6MTcyNDUwMzQxOCwiZXhwIjoxNzI0NTA3MDE4LCJqdGkiOiJhYTkwNGQ3YzA4YmZlYzY3ZmU3MGJiODg2ZWI0Yzg5ZmFjNWE1N2RjIn0.MjygqoalyPOcOohsztv6vJjvoqg8wNfVLPEblbLYu9D6DiE6xuDh75umf9PNUJWNorFvhfiYM1Gdxqi1Mv_JnHZoTm_PfQE5C5Ub2C2jWcqCgydiEPLH7UM4nrYFVSUdhTbX2ioqW4DsYPeoEzdhwu05DjvBIN5pEQgmGUDLAaqIwfM-gAIjF7AOp4CedVMySgMQiOdKvKYos00_CMncgXphLG3VWmx-Dqk8v3lTbBNLDWStWXKGNpBTGXPvVrHVK3BQq6W9phk_aAUnh59Nqntstou8vMfLegsKIxgBa19rLYk5Fqost8O0k-5xzqHrUHhgSVshgi2nqFu02e7pfw', NULL, '2024-08-24 12:43:41'),
(16, '102293505113754474586', 'Roshan Pandat', 'roshanpandat60@gmail.com', 'uploads/pending/ACg8ocJAsIwwnfme0VugrGgm3cdWy7t0mDA4DxgWvNYaUxjBfQCfBW20=s96-c', NULL, 'eyJhbGciOiJSUzI1NiIsImtpZCI6ImE0OTM5MWJmNTJiNThjMWQ1NjAyNTVjMmYyYTA0ZTU5ZTIyYTdiNjUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI5Mzk0NjcxODg1MTQtOTZtZ3E0aXJpZzAxMDBsamRmMWNscG5lbTM3dmVqNjAuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI5Mzk0NjcxODg1MTQtOTZtZ3E0aXJpZzAxMDBsamRmMWNscG5lbTM3dmVqNjAuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMDIyOTM1MDUxMTM3NTQ0NzQ1ODYiLCJlbWFpbCI6InJvc2hhbnBhbmRhdDYwQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJuYmYiOjE3MjQ1MDcwMDQsIm5hbWUiOiJSb3NoYW4gUGFuZGF0IiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FDZzhvY0pBc0l3d25mbWUwVnVnckdnbTNjZFd5N3QwbURBNER4Z1d2TllhVXhqQmZRQ2ZCVzIwPXM5Ni1jIiwiZ2l2ZW5fbmFtZSI6IlJvc2hhbiIsImZhbWlseV9uYW1lIjoiUGFuZGF0IiwiaWF0IjoxNzI0NTA3MzA0LCJleHAiOjE3MjQ1MTA5MDQsImp0aSI6ImFkNjRmYTYzMjQ5ZTUwMWQ3ZWM0MTNjOWU2NmY2OTAzYmZkNDgxMDEifQ.ciX8dsPr_YkoULaJpOpIMmoAfcgB26RvfnXrPhE7O6YK1c-WCBBnlueqYL9c67Fxn5F0v0bY8U6PhWs7ubMKkoHFJb8BvsESXkDbbacQ3C0dW45-oaLnTjYHkCXS_uNDYlBdG-rKF1yDNOMlxh3CTACO--mUSJDc5f50h35k0zw_03tsgV2YRH0FK2_AVvDxZZNPVxmRYPOGEX0dj92wL5x9CNAxCqyLBpQK4uxWzstWRGz8ugIGGQVChN3KPvjSUf34_betlBPbBUhNpt5i6vqd2pXmzW4B05ypsITXMuzxzUf20FRhWy2YCFsVAwiYsK1iapE4mN9kMDZnxRnspQ', NULL, '2024-08-24 13:48:28'),
(18, '103314441096086695209', 'Hacker', 'fackhacker20024@gmail.com', 'uploads/pending/ACg8ocIKKTWqm_316hWG87rj4fcWghV2D3q_XfD9ehiB7NJEFttOFA=s96-c', NULL, 'eyJhbGciOiJSUzI1NiIsImtpZCI6ImE0OTM5MWJmNTJiNThjMWQ1NjAyNTVjMmYyYTA0ZTU5ZTIyYTdiNjUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI5Mzk0NjcxODg1MTQtOTZtZ3E0aXJpZzAxMDBsamRmMWNscG5lbTM3dmVqNjAuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI5Mzk0NjcxODg1MTQtOTZtZ3E0aXJpZzAxMDBsamRmMWNscG5lbTM3dmVqNjAuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMDMzMTQ0NDEwOTYwODY2OTUyMDkiLCJlbWFpbCI6ImZhY2toYWNrZXIyMDAyNEBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwibmJmIjoxNzI0NTU3NjM0LCJuYW1lIjoiSGFja2VyIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FDZzhvY0lLS1RXcW1fMzE2aFdHODdyajRmY1dnaFYyRDNxX1hmRDllaGlCN05KRUZ0dE9GQT1zOTYtYyIsImdpdmVuX25hbWUiOiJIYWNrZXIiLCJpYXQiOjE3MjQ1NTc5MzQsImV4cCI6MTcyNDU2MTUzNCwianRpIjoiYzE1MGYwYmRjNzk0OWY1ZTM5ZDE5YjAwMWI4ZTcyMWM4YzcxMTQ4NyJ9.ql78CKeGFyK22owjwHHVL56bBTGhK6SjrlW2E7Gn3eeIbE_hvHZ9xGca2mcPoYkVc9oA2kTUc1v5St3HDMibFTKPWXnHWK_dOc-CDd9Q9w2OUugauLvd5FVMnVQoZo1RgIBl2wd-uJKsh7RkUu4p4fXeP-xo1SWPgLphUg7FBgirUWNAJ1RgfHsbPFggp--kPo7T9b-5hQ415rA4Czm5yuKPEY66jvb91rIQX6z5vJr164HlKkXXqJ-NLs6gAMSOoStfkX7wuQr561P8Q_yzjv_UXZ_gwhYkOejvlbiF7wgwQzCY-4j0cws3THtIDKQExCUM55vYeAtMNgmHBU7ywA', NULL, '2024-08-25 03:52:18'),
(19, '116319961505183024759', 'Self User', 'uself2530@gmail.com', 'uploads/pending/ACg8ocI46OXxqYd7xH912XPwsnovKMGNmWbUpAeC_KmTnS7qAMwBgw=s96-c', NULL, 'eyJhbGciOiJSUzI1NiIsImtpZCI6ImE0OTM5MWJmNTJiNThjMWQ1NjAyNTVjMmYyYTA0ZTU5ZTIyYTdiNjUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI5Mzk0NjcxODg1MTQtOTZtZ3E0aXJpZzAxMDBsamRmMWNscG5lbTM3dmVqNjAuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI5Mzk0NjcxODg1MTQtOTZtZ3E0aXJpZzAxMDBsamRmMWNscG5lbTM3dmVqNjAuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTYzMTk5NjE1MDUxODMwMjQ3NTkiLCJlbWFpbCI6InVzZWxmMjUzMEBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwibmJmIjoxNzI0NTYwMDQ3LCJuYW1lIjoiU2VsZiBVc2VyIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FDZzhvY0k0Nk9YeHFZZDd4SDkxMlhQd3Nub3ZLTUdObVdiVXBBZUNfS21UblM3cUFNd0Jndz1zOTYtYyIsImdpdmVuX25hbWUiOiJTZWxmIiwiZmFtaWx5X25hbWUiOiJVc2VyIiwiaWF0IjoxNzI0NTYwMzQ3LCJleHAiOjE3MjQ1NjM5NDcsImp0aSI6IjJlYjRiNjI1YmVlZmM5YjEyOTZmMmU4YWI2ZmI1MjVkMWMzOGU5ZWQifQ.NRu9jO11OrR9tr03JOfSud6gxyBjcXb9ryBZKu7O5TgSLoao0bxDJqtyBgOUg1FaUI2-Dwt7__tzWqybSspEmPSgLsDkDPC0A9fggV60EKS_lSBR-Ikup7Jv3LGROYs2Cc8dUYRuf-josI7HlEvaEQt0KM_0Drni_emD-n80Uonsglh-xfyFpjiTJRBdHTa9TV3WrXWHl_H55GpOd8CREUaS3hRzUejfVi6mMJNHzfuit78F5IfNgAr-13Sn1WuTRXCYcL6jy_JDwONKf8JhR-q8TfV05tSEhMBDPDjhtARkip2dcoAU65dh0ze2Fm94RS_5E4e28GC0EJ_l-YiF_w', NULL, '2024-08-25 04:32:31'),
(30, '105913328155677262688', 'Adarsh', 'adarshsubhhu@gmail.com', 'uploads/pending/ACg8ocKjjveIhTU1P2GlEphkA1AIMIL5Ol0drJdLrpBI_3bpvJ55kg=s96-c', NULL, 'eyJhbGciOiJSUzI1NiIsImtpZCI6ImE0OTM5MWJmNTJiNThjMWQ1NjAyNTVjMmYyYTA0ZTU5ZTIyYTdiNjUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI5Mzk0NjcxODg1MTQtOTZtZ3E0aXJpZzAxMDBsamRmMWNscG5lbTM3dmVqNjAuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI5Mzk0NjcxODg1MTQtOTZtZ3E0aXJpZzAxMDBsamRmMWNscG5lbTM3dmVqNjAuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMDU5MTMzMjgxNTU2NzcyNjI2ODgiLCJlbWFpbCI6ImFkYXJzaHN1YmhodUBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwibmJmIjoxNzI0ODM5NzU1LCJuYW1lIjoiQWRhcnNoIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FDZzhvY0tqanZlSWhUVTFQMkdsRXBoa0ExQUlNSUw1T2wwZHJKZExycEJJXzNicHZKNTVrZz1zOTYtYyIsImdpdmVuX25hbWUiOiJBZGFyc2giLCJpYXQiOjE3MjQ4NDAwNTUsImV4cCI6MTcyNDg0MzY1NSwianRpIjoiYWY3NDRmMDRlODhmZjFmMzYyZmMyNTQ3MDIwNDM0NWI0NzFkMTA1ZCJ9.khBrkGxPO7QL6sNn6z7LXwc_uwUaw2_bcbP3SUZGczSZwuxUrhUxNZ5DS1WnPnnhLO8XJPXXWEsDSAQdL8hZZChyrrBI81P6RYEdjFiWTpP-CpEHlJ3lgLDrNqztQweYioxl6XyTbThE0yrnrdbeuonPdZe5yIy-zuIwniKzzao08SV59y_6k5lXUAFEkI6Y0-uc6Cj-Gj92NRSa6tPQfxR1LGwNfU1KksCbKaCZJKapya6AXrHQXbWpvqqFIKN0LOVx0RHSR7Y8dfBeRRpcMTB3UPqNEZEsLFIr-36iFGO_ZapJ5k5tz3i2I0E3e7xfqVm-m6uMe0WiPoCEXHkBgA', NULL, '2024-08-28 10:14:19'),
(31, '116285561522932863751', 'Gagan Dev Raj', 'feedback@gagandevraj.com', 'uploads/pending/ACg8ocLmpn2NTXK8fZ-Zhr3PfMpUn37SVtorSO6SkN7bhs6AYBgziz0=s96-c', NULL, 'eyJhbGciOiJSUzI1NiIsImtpZCI6ImE0OTM5MWJmNTJiNThjMWQ1NjAyNTVjMmYyYTA0ZTU5ZTIyYTdiNjUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI5Mzk0NjcxODg1MTQtOTZtZ3E0aXJpZzAxMDBsamRmMWNscG5lbTM3dmVqNjAuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI5Mzk0NjcxODg1MTQtOTZtZ3E0aXJpZzAxMDBsamRmMWNscG5lbTM3dmVqNjAuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTYyODU1NjE1MjI5MzI4NjM3NTEiLCJlbWFpbCI6ImZlZWRiYWNrQGdhZ2FuZGV2cmFqLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJuYmYiOjE3MjQ5MDAyOTgsIm5hbWUiOiJHYWdhbiBEZXYgUmFqIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FDZzhvY0xtcG4yTlRYSzhmWi1aaHIzUGZNcFVuMzdTVnRvclNPNlNrTjdiaHM2QVlCZ3ppejA9czk2LWMiLCJnaXZlbl9uYW1lIjoiR2FnYW4gRGV2IFJhaiIsImlhdCI6MTcyNDkwMDU5OCwiZXhwIjoxNzI0OTA0MTk4LCJqdGkiOiIwYTFkOWFlYmNhOTczZjFlYzg2ZWUyNTQyYzVmZDliN2RjYzdlMmVlIn0.GAQtoLvpvaA4zO8XBWwv_BJ0zCAEdtywXHnD0QVXOQb8aTnpKlcIi6rDkvltDIHmzUdfgR1Y9FWLQSZgQ4rffSO2AcSkEeAMuX7lvqp-_Xq32aviF4IRqPIigopqnHINslVAzOJTUURL8cQnL0PICLxQ3Toe9egZ2oetqMC6GpJmfvBR53HgAc4Pr1anCsl2y39T7jVnZmqs9aTbkZ0blTk2fH5ilzM34P0TcpoCieglL-8ho3GjU4Rixq7n0N9bLfIvRrCsN4kbpvfy-XyQ1RACdUSSWusmy1pzfHt8B4iaGErZTnavV_okfK3RCxXZPDA-vahy6pEMErdqATFUTw', NULL, '2024-08-29 03:03:22'),
(32, '109372146138619396706', 'Adarsh Singh Rajput', 'contactcaadarshyt@gmail.com', 'uploads/pending/ACg8ocJ9Flm1pflRrg5EQ7y4zq4BqypjllkFd4ySPMINlwo2JDPrug=s96-c', NULL, 'eyJhbGciOiJSUzI1NiIsImtpZCI6ImIyZjgwYzYzNDYwMGVkMTMwNzIxMDFhOGI0MjIwNDQzNDMzZGIyODIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI5Mzk0NjcxODg1MTQtOTZtZ3E0aXJpZzAxMDBsamRmMWNscG5lbTM3dmVqNjAuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI5Mzk0NjcxODg1MTQtOTZtZ3E0aXJpZzAxMDBsamRmMWNscG5lbTM3dmVqNjAuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMDkzNzIxNDYxMzg2MTkzOTY3MDYiLCJlbWFpbCI6ImNvbnRhY3RjYWFkYXJzaHl0QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJuYmYiOjE3MjUwMDc1MTcsIm5hbWUiOiJBZGFyc2ggU2luZ2ggUmFqcHV0IiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FDZzhvY0o5RmxtMXBmbFJyZzVFUTd5NHpxNEJxeXBqbGxrRmQ0eVNQTUlObHdvMkpEUHJ1Zz1zOTYtYyIsImdpdmVuX25hbWUiOiJBZGFyc2ggU2luZ2giLCJmYW1pbHlfbmFtZSI6IlJhanB1dCIsImlhdCI6MTcyNTAwNzgxNywiZXhwIjoxNzI1MDExNDE3LCJqdGkiOiIyMjBjMmYzNTBlYWQ4NjU2ZDZmOTcxNzVlZjU5ODA5YmJlNjNmYjQyIn0.CC6eKxPuuJ7dUpcMC_eoBOwAkQExNQe4tCMm3H8xBBWL79EgaR4cpA2bdiVcCjB321ygGps1Jfl8CjxD1KxRGcZ4I0_U3Fz8DWLBQ7AKtO4e8_vDzYnMzTD5m9ff2DslCskttAgdfAvofvLM03qYmCFftx2JHU1bdLfb6ZeL1VsccmCdUfFqghWQS2eqadSAhroZMj4sEp0J7z1kC9oPcV_57wfsF3yDrqY20tv_QBMqlJn4crK5O9Pino9z-XXoquqx1py_f0TlPSXtH-vTlM99GRLJ59VV2ZtWyILuKLuxirOoieYegQngQH8q4goFTiaH7kj9PmLguD5C4byUpw', NULL, '2024-08-30 08:50:20'),
(34, '106560722237407588759', 'Adarsh Bhai', 'adarshjisinghvishnu@gmail.com', 'uploads/pending/ACg8ocLaPXlO24ETboV96kZ-N_IeAA6KI--qfm1UIwJFNLTi6R9YYOg=s96-c', NULL, 'eyJhbGciOiJSUzI1NiIsImtpZCI6ImIyZjgwYzYzNDYwMGVkMTMwNzIxMDFhOGI0MjIwNDQzNDMzZGIyODIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI5Mzk0NjcxODg1MTQtOTZtZ3E0aXJpZzAxMDBsamRmMWNscG5lbTM3dmVqNjAuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI5Mzk0NjcxODg1MTQtOTZtZ3E0aXJpZzAxMDBsamRmMWNscG5lbTM3dmVqNjAuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMDY1NjA3MjIyMzc0MDc1ODg3NTkiLCJlbWFpbCI6ImFkYXJzaGppc2luZ2h2aXNobnVAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsIm5iZiI6MTcyNTE2MTA4MCwibmFtZSI6IkFkYXJzaCBCaGFpIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FDZzhvY0xhUFhsTzI0RVRib1Y5NmtaLU5fSWVBQTZLSS0tcWZtMVVJd0pGTkxUaTZSOVlZT2c9czk2LWMiLCJnaXZlbl9uYW1lIjoiQWRhcnNoIiwiZmFtaWx5X25hbWUiOiJCaGFpIiwiaWF0IjoxNzI1MTYxMzgwLCJleHAiOjE3MjUxNjQ5ODAsImp0aSI6ImZmYjhmYmQ2Y2NhZWM3ZGNhZjkxYmRiNjllZmRmZjUzZTgxODE5N2EifQ.YfnoutYUKqG5p7XWK0QKfBUpAzMbHxP4pJ7I-B2TvUH-WYU1VKSwo5yd1ujDGJyu87yitOsypylMGHQuY9jwPkUnxPmYvThjPwJtgWEoJNcItveXVviA8l626pVtvvjLBDeuOEZjM6BfHz5z6ywnTcYAS2x-kDfIcGmbSxosI0lCuwFcS54WX4yrw45hyx-Qg4n-u6US9337ycXdKzsstYwlYOnJOmbSCcdOpVx6kAJihQWZAjvew6XVmChF5e63RN3xeHfzZIzBpt1COniyOcYnXJrc9YSzVaaTs-8qwv9xWHgmFbsCYNkEeG3dWDzXIaEjz94cxa6NT1jMWcW4Kg', NULL, '2024-09-01 03:29:44'),
(36, '114018935575322099933', 'Shivam Kumar', 'hemlatadevi8130@gmail.com', 'uploads/pending/ACg8ocKVp0Eop6X7aSvL1Cijm295PFjuHeXuphg81dwPBpLb4WroMC9u=s96-c', NULL, 'eyJhbGciOiJSUzI1NiIsImtpZCI6Ijg4NDg5MjEyMmUyOTM5ZmQxZjMxMzc1YjJiMzYzZWM4MTU3MjNiYmIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI5Mzk0NjcxODg1MTQtOTZtZ3E0aXJpZzAxMDBsamRmMWNscG5lbTM3dmVqNjAuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI5Mzk0NjcxODg1MTQtOTZtZ3E0aXJpZzAxMDBsamRmMWNscG5lbTM3dmVqNjAuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTQwMTg5MzU1NzUzMjIwOTk5MzMiLCJlbWFpbCI6ImhlbWxhdGFkZXZpODEzMEBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwibmJmIjoxNzYxMzA0NjQ5LCJuYW1lIjoiU2hpdmFtIEt1bWFyIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FDZzhvY0tWcDBFb3A2WDdhU3ZMMUNpam0yOTVQRmp1SGVYdXBoZzgxZHdQQnBMYjRXcm9NQzl1PXM5Ni1jIiwiZ2l2ZW5fbmFtZSI6IlNoaXZhbSIsImZhbWlseV9uYW1lIjoiS3VtYXIiLCJpYXQiOjE3NjEzMDQ5NDksImV4cCI6MTc2MTMwODU0OSwianRpIjoiMzBlYzk0MzhjNjY0NGQ4NmMzMWZiMjA5ZDU4MGJjNzI4MDM1YmYzMyJ9.xwEmJLdJnN8NBf6_sLHQapmX-Y5B-XiQtLI8Yb0jFT87FUEN9c_3f4m3pYndDXea-yjYAg1VNz79miHdpIqvaV7VHjdTc7bmDbAcQhRLU_5U3VKq8Ef1gdSVi3LUAthNXKII87oh9UyPMOky6bE5UCTEAItC25IKZVU-uw9GUgD2Hq9iBBwDh7qAkTa_RyCc1-Jg_lun1QKGmcxnFgchJVgvGFls89BrdOXUwSwf_WcDsk3B8VAeI57Ll8RR18SV65LHP5Jy7bV0-GyxH_nx0Uz-fLNkUyWG0y0XR7wT_8caR6d2qVW2hGkJYOXmY4Kx6-fveZ3TNWxM9K0OCB6fSQ', NULL, '2025-10-24 11:22:33'),
(37, '109310326695225739706', 'Mohamed Mokhtari', 'mohamedmokhtari402@gmail.com', 'uploads/pending/ACg8ocKcPLKYEV1H850mlTl7bF1aF_9c9708uGPyMGTIKHsVO4QKdg=s96-c', NULL, 'eyJhbGciOiJSUzI1NiIsImtpZCI6IjEzMGZkY2VmY2M4ZWQ3YmU2YmVkZmE2ZmM4Nzk3MjIwNDBjOTJiMzgiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI5Mzk0NjcxODg1MTQtOTZtZ3E0aXJpZzAxMDBsamRmMWNscG5lbTM3dmVqNjAuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI5Mzk0NjcxODg1MTQtOTZtZ3E0aXJpZzAxMDBsamRmMWNscG5lbTM3dmVqNjAuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMDkzMTAzMjY2OTUyMjU3Mzk3MDYiLCJlbWFpbCI6Im1vaGFtZWRtb2todGFyaTQwMkBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwibmJmIjoxNzY1OTMwOTI1LCJuYW1lIjoiTW9oYW1lZCBNb2todGFyaSIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS9BQ2c4b2NLY1BMS1lFVjFIODUwbWxUbDdiRjFhRl85Yzk3MDh1R1B5TUdUSUtIc1ZPNFFLZGc9czk2LWMiLCJnaXZlbl9uYW1lIjoiTW9oYW1lZCIsImZhbWlseV9uYW1lIjoiTW9raHRhcmkiLCJpYXQiOjE3NjU5MzEyMjUsImV4cCI6MTc2NTkzNDgyNSwianRpIjoiZmQwYzFmMjhkYTVkMjVlMWRjYjdiMWZkMWQ5MzgxYTYzZDNiZWMyMCJ9.gu2j3ARLsAsRji_oeM85f3M48I87H5A7xqgdKBKU6PySRNuwvaL4Wh7Xz9N8PwhMr-tb9j3Dqi4cZm8f8H2QBGfSH7hl8Z5Io__0FcH7y6j2OIFt9S_4NJkUC506KBnSTupWMZ8DEaW7SVo0etxgs2Qfy47g-qQsd-WJN7xRRe-1Grj1LhcFv39_Fcj7PnjKgecsmsH0U7U3BGq89FFa__fbaRnDM4QIIN4CkJhlGqG_TyO31lmoin4CJSL_SRD24N5UI6aMPQ3VMdJN68w9IneRqEL1VCDppMazqWHaMXu2isFQzx5F8NYV0U0-l5StYkxaTxoFJ1UxwHDbD_3nCQ', NULL, '2025-12-17 00:27:07');

-- --------------------------------------------------------

--
-- Table structure for table `recover_password`
--

CREATE TABLE `recover_password` (
  `id` int(11) NOT NULL,
  `name` varchar(70) DEFAULT NULL,
  `email` varchar(80) DEFAULT NULL,
  `otp` varchar(10) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `recover_password`
--

INSERT INTO `recover_password` (`id`, `name`, `email`, `otp`, `password`, `created_at`) VALUES
(29, 'Niraj Shaw', 'nirajshaw1320@gmail.com', '7157', NULL, '2024-09-27 14:31:56'),
(33, 'Parmod ', 'gpramod09@gmail.com', '3436', NULL, '2024-10-18 13:22:11'),
(42, 'vishesh', 'v3344856@gmail.com', '5486', NULL, '2024-12-15 13:56:45'),
(44, 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', '9041', NULL, '2025-02-08 14:21:18'),
(45, 'Adarsh Bhai', 'adarshjisinghvishnu@gmail.com', '9706', NULL, '2025-09-05 08:25:34'),
(46, 'Babuni Devi', 'babunidevi10100@gmail.com', '9180', NULL, '2026-02-14 05:58:44');

-- --------------------------------------------------------

--
-- Table structure for table `usersgoogle`
--

CREATE TABLE `usersgoogle` (
  `id` int(11) NOT NULL,
  `auth0_id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `usersgoogle`
--

INSERT INTO `usersgoogle` (`id`, `auth0_id`, `name`, `email`, `created_at`) VALUES
(3, 'google-oauth2|114000931693797833432', 'Adarsh Singh', 'adarshfinalchannel@gmail.com', '2025-02-11 09:09:46'),
(5, 'google-oauth2|107567610488532904383', 'Adarsh Singh Rajput', 'adarsh.singhvishnu@gmail.com', '2025-02-13 02:25:44'),
(7, 'google-oauth2|103570570526000618264', 'Halominaria', 'halominaria@gmail.com', '2025-02-13 10:08:43'),
(9, 'google-oauth2|103921628581790343411', 'adarsh singh', 'talk@gagandevraj.com', '2025-02-14 13:41:47'),
(10, 'google-oauth2|114341725494889151648', 'Adarsh', 'adarshhumaithik@gmail.com', '2025-02-14 14:08:10'),
(11, 'google-oauth2|111561238149428700652', 'Cobra Army', 'cobraarmyff@gmail.com', '2025-02-14 15:41:30'),
(12, 'google-oauth2|107644282521055941310', 'Khushi Singh', 'khushivishnushankarsingh@gmail.com', '2025-02-15 06:35:00'),
(13, 'google-oauth2|108813988757654962472', 'Madhumala Adarsh', 'adarshmadhumala@gmail.com', '2025-02-18 08:27:12'),
(14, 'google-oauth2|109817035970589768733', 'Ragini Rawat', 'raginiragrawat@gmail.com', '2025-02-18 08:56:09'),
(15, 'github|141423800', 'CA ADARSH YT', 'contactcaadarshyt@gmail.com', '2025-02-18 09:31:17'),
(16, 'google-oauth2|115737475668453717305', 'Resma Gangupam', 'resmagangupam@gmail.com', '2025-02-18 14:57:59'),
(17, 'google-oauth2|112038562159300320016', 'Ayushi', 'thissoundssuspicious@gmail.com', '2025-02-18 15:08:36'),
(18, 'google-oauth2|106516177863554823437', 'Raj Singh', 'rajheartkiller18110@gmail.com', '2025-02-19 08:06:34'),
(19, 'google-oauth2|117853605011008455859', 'disha yadav', 'dishayadav545@gmail.com', '2025-02-20 15:32:02'),
(20, 'google-oauth2|103493991769977992484', 'Sita', 'sitaji10100@gmail.com', '2025-02-20 18:10:10'),
(21, 'google-oauth2|114796789635822640540', 'ReadXHub', 'no-reply@readxhub.in', '2025-02-21 05:52:11');

-- --------------------------------------------------------

--
-- Table structure for table `user_activity`
--

CREATE TABLE `user_activity` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `device_id` varchar(255) NOT NULL,
  `login_date` date NOT NULL,
  `login_time` time NOT NULL,
  `logout_time` time DEFAULT NULL,
  `time_spent` time DEFAULT NULL,
  `learning_progress` varchar(255) DEFAULT NULL,
  `last_activity` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_activity`
--

INSERT INTO `user_activity` (`id`, `user_id`, `email`, `name`, `ip_address`, `device_id`, `login_date`, `login_time`, `logout_time`, `time_spent`, `learning_progress`, `last_activity`) VALUES
(4, NULL, 'adarsh.singhvishnu@gmail.com', 'Adarsh', '2409:4050:2e84:c87d:3c38:46a5:e3e7:4b09', '66c6d9341dde5', '2024-08-22', '07:27:17', NULL, NULL, NULL, '2024-08-22 15:54:41'),
(5, NULL, 'ninij78254@albarulo.com', 'Adarsh', '2409:4050:2e84:c87d:3c38:46a5:e3e7:4b09', 'Unknown', '2024-08-22', '07:55:40', NULL, NULL, NULL, '2024-08-22 08:16:24'),
(6, NULL, 'annieallen88328@gmail.com', 'Inha', '2401:4900:7b2c:cdf8:16d4:1399:a5f0:ba84', 'Unknown', '2024-08-22', '13:41:44', NULL, NULL, NULL, '2024-08-22 13:44:45'),
(7, NULL, 'adarsh.singhvishnu@gmail.com', 'Adarsh', '2409:4050:2ec0:df72:edb0:5b5f:9fd9:a74c', 'Unknown', '2024-08-23', '02:39:23', NULL, NULL, NULL, '2024-08-23 08:58:49'),
(8, NULL, 'adarshfinalchannel@gmail.com', 'Adarsh', '2405:204:3403:36ae:b884:e2cd:9eef:f1e7', 'Unknown', '2024-08-23', '12:27:01', NULL, NULL, NULL, '2024-08-23 12:27:01'),
(9, NULL, 'adarsh.singhvishnu@gmail.com', 'Adarsh', '2409:4050:2d12:e375:b12f:c63:e574:c6c2', 'Unknown', '2024-08-24', '06:23:36', NULL, NULL, NULL, '2024-08-24 19:33:16'),
(10, NULL, 'jhavinay897@gmail.com', 'Vinay jha', '2405:204:1386:62fd::e8f:b8b0', 'Unknown', '2024-08-24', '18:18:08', NULL, NULL, NULL, '2024-08-24 18:18:08'),
(11, NULL, 'bgmi73169@gmail.com', 'Satish ranjan', '2401:4900:73fd:6d5f:4dd:3cff:fea8:b622', 'Unknown', '2024-08-25', '04:02:20', NULL, NULL, NULL, '2024-08-25 04:05:10'),
(12, NULL, 'anshu123@gmail.com', 'Rahul', '2409:40c4:1002:67b1:570:8ef6:ebe4:1d4a', 'Unknown', '2024-08-25', '05:07:10', NULL, NULL, NULL, '2024-08-25 05:07:10'),
(13, NULL, 'deenukmwt277@gmail.com', 'Tera bhai', '2409:4052:4d83:624b::2d48:8311', 'Unknown', '2024-08-26', '08:55:48', NULL, NULL, NULL, '2024-08-26 08:57:40'),
(14, NULL, 'gagandevraj0@gmail.com', 'lucky', '2409:4050:2e4c:8bad:f082:bf33:fcc3:82ad', 'Unknown', '2024-08-26', '09:40:59', NULL, NULL, NULL, '2024-08-26 09:40:59'),
(15, NULL, 'adarsh.singhvishnu@gmail.com', 'Adarsh', '2409:4050:2e4c:8bad:c97f:cc7c:e462:6d46', 'Unknown', '2024-08-26', '11:33:05', NULL, NULL, NULL, '2024-08-26 12:14:05'),
(16, NULL, 'adarsh.singhvishnu@gmail.com', 'Gagan', '2405:204:138e:17d7:c863:5cd8:971:8d2f', 'Unknown', '2024-08-27', '02:47:49', NULL, NULL, NULL, '2024-08-27 07:34:08'),
(17, NULL, 'adarsh.singhvishnu@gmail.com', 'Gagan', '2405:204:32aa:2d8f:29a5:59a5:1944:db69', 'Unknown', '2024-08-28', '03:00:23', NULL, NULL, NULL, '2024-08-28 09:50:10'),
(18, NULL, 'anshu123@gmail.com', 'Rahul', '2409:4050:2dcd:90e5:7546:41f0:97ec:e651', 'Unknown', '2024-08-28', '08:40:06', NULL, NULL, NULL, '2024-08-28 08:59:36'),
(19, NULL, 'rajheartkiller18110@gmail.com', 'Raj ', '2409:4050:2dcd:90e5:7546:41f0:97ec:e651', 'Unknown', '2024-08-28', '09:01:32', NULL, NULL, NULL, '2024-08-28 09:14:20');

-- --------------------------------------------------------

--
-- Table structure for table `user_profile`
--

CREATE TABLE `user_profile` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  `self_introduction` text DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `native_language` varchar(255) DEFAULT NULL,
  `hobbies` text DEFAULT NULL,
  `goal` text DEFAULT NULL,
  `hometown` varchar(255) DEFAULT NULL,
  `education` varchar(255) DEFAULT NULL,
  `school` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `zodiac` varchar(255) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_profiles`
--

CREATE TABLE `user_profiles` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `age` int(11) NOT NULL,
  `gender` enum('Male','Female','Other') NOT NULL,
  `country` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `phone` varchar(20) DEFAULT NULL,
  `current_location` text DEFAULT NULL,
  `nickname` varchar(50) DEFAULT NULL,
  `profile_picture` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_profiles`
--

INSERT INTO `user_profiles` (`id`, `name`, `age`, `gender`, `country`, `email`, `created_at`, `phone`, `current_location`, `nickname`, `profile_picture`) VALUES
(2, 'Adarsh', 17, 'Male', 'India', 'adarshfinalchannel@gmail.com', '2025-02-11 10:53:34', NULL, NULL, NULL, NULL),
(6, 'Ayushi', 18, 'Female', 'India', 'adarsh.singhvishnu@gmail.com', '2025-02-13 03:03:03', '9966447788', '28.7014912, 77.3095424', 'sukuna ', 'uploads/img/1740146588_sad.png'),
(7, 'shivam', 34, 'Male', 'Pakistan', 'halominaria@gmail.com', '2025-02-13 10:09:15', '9128562587', '28.6949376, 77.2571136', 'dhruv', 'uploads/img/1739441399_pubg.png'),
(8, 'roshan', 23, 'Male', 'India', 'talk@gagandevraj.com', '2025-02-14 13:42:07', NULL, NULL, NULL, NULL),
(9, 'saziya', 32, 'Female', 'Pakistan', 'adarshhumaithik@gmail.com', '2025-02-14 14:08:23', NULL, NULL, NULL, NULL),
(10, 'Ayushi', 23, 'Female', 'India', 'cobraarmyff@gmail.com', '2025-02-14 15:41:48', '7898784514', '28.6982144, 77.2636672', 'Me', 'uploads/img/1739548180_welcome.jpeg'),
(11, 'Khushi', 16, 'Female', 'India', 'khushivishnushankarsingh@gmail.com', '2025-02-15 06:35:12', NULL, NULL, NULL, NULL),
(12, 'Madhubala', 19, 'Female', 'India', 'adarshmadhumala@gmail.com', '2025-02-18 08:27:34', '9939914772', '28.6290512, 77.3197571', 'Adarsh', 'uploads/img/1739867317_download (2).jpeg'),
(13, 'Ragini Rawat', 19, 'Female', 'India', 'raginiragrawat@gmail.com', '2025-02-18 08:56:44', '9340295239', '22.737871, 75.7899613', 'Ragu ', 'uploads/img/1739871902_IMG_20250103_142159.jpg'),
(14, 'Manshi', 19, 'Female', 'India', 'contactcaadarshyt@gmail.com', '2025-02-18 09:32:26', '9878414756', 'Unknown', 'adarsh', 'uploads/img/1739872311_logo.png'),
(15, 'adarsh', 12, 'Male', 'Barbados', 'undefined', '2025-02-18 10:32:29', NULL, NULL, NULL, NULL),
(16, 'Gangupam resma', 17, 'Female', 'India', 'resmagangupam@gmail.com', '2025-02-18 14:58:51', NULL, NULL, NULL, NULL),
(17, 'Ayushi ', 17, 'Female', 'India', 'thissoundssuspicious@gmail.com', '2025-02-18 15:09:54', NULL, NULL, NULL, NULL),
(18, 'mr.raj', 16, 'Male', 'India', 'rajheartkiller18110@gmail.com', '2025-02-19 08:07:05', '9795647253', '26.8466937, 80.946166', 'xxx', NULL),
(19, 'Shreya', 15, 'Female', 'Bangladesh', 'sitaji10100@gmail.com', '2025-02-20 18:10:33', '9402153687', 'Unknown', 'Shree', 'uploads/img/1740075152_images.jpeg');

-- --------------------------------------------------------

--
-- Table structure for table `visitor_info`
--

CREATE TABLE `visitor_info` (
  `id` int(11) NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  `user_agent` text NOT NULL,
  `device_brand` varchar(50) DEFAULT NULL,
  `visit_time` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `visitor_info`
--

INSERT INTO `visitor_info` (`id`, `ip_address`, `user_agent`, `device_brand`, `visit_time`) VALUES
(32700, '2401:4900:a4c1:c268:b94f:6626:4079:c06', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-03-09 07:41:06'),
(32701, '2409:4050:e09:8ff7::7cb:bc00', 'WhatsApp/2.23.20.0', 'Unknown', '2025-03-09 07:44:43'),
(32702, '15.188.8.249', 'Mozilla/5.0 (Linux; Android 7.0; SM-G892A Build/NRD90M; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/60.0.3112.107 Mobile Safari/537.36', 'Android Device', '2025-03-09 10:09:56'),
(32704, '35.87.181.117', 'Mozilla/5.0 (X11; Linux i686 on x86_64; rv:48.0) Gecko/20100101 Firefox/48.0', 'Unknown', '2025-03-09 11:06:35'),
(32707, '34.34.73.154', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4.1 Safari/605.1.15 RDDocuments/8.8.4.999', 'Apple', '2025-03-10 06:00:29'),
(32711, '149.57.180.198', 'Mozilla/5.0 (X11; Linux i686; rv:109.0) Gecko/20100101 Firefox/120.0', 'Unknown', '2025-03-10 10:45:36'),
(32712, '159.203.141.219', 'Mozilla/5.0 (compatible)', 'Unknown', '2025-03-10 18:18:46'),
(32716, '202.173.125.237', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36', 'Unknown', '2025-03-11 08:03:35'),
(32717, '139.59.157.166', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:67.0) Gecko/20100101 Firefox/67.0', 'Windows', '2025-03-11 16:20:32'),
(32719, '46.17.174.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:98.0) Gecko/20100101 Firefox/98.0', 'Apple', '2025-03-12 05:15:06'),
(32721, '180.163.220.95', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36 Edg/120.0.0.0', 'Apple', '2025-03-12 12:55:14'),
(32723, '64.225.28.37', 'Mozilla/5.0 (compatible)', 'Unknown', '2025-03-13 02:03:04'),
(32726, '23.27.145.4', 'Mozilla/5.0 (X11; Linux i686; rv:109.0) Gecko/20100101 Firefox/120.0', 'Unknown', '2025-03-13 10:52:56'),
(32729, '2405:204:129f:4a61::1f50:48a1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-03-13 12:49:07'),
(32731, '34.223.41.165', 'Mozilla/5.0 (compatible; wpbot/1.3; +https://forms.gle/ajBaxygz9jSR8p8G9)', 'Unknown', '2025-03-13 23:56:48'),
(32734, '2401:4900:62d3:ede2:4ced:2dae:b863:6c94', 'Mozilla/5.0 (Linux; Android 14; SM-A235F Build/UP1A.231005.007; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/133.0.6943.137 Mobile Safari/537.36 Instagram 369.0.0.46.101 Android (34/14; 450dpi; 1080x2207; samsung; SM-A235F; a23; qcom; en_IN; 701943557)', 'Android Device', '2025-03-14 01:25:11'),
(32736, '46.205.196.24', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.97 Safari/537.36', 'Windows', '2025-03-14 08:44:31'),
(32737, '83.24.167.245', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.97 Safari/537.36', 'Windows', '2025-03-14 08:44:32'),
(32738, '2402:3a80:40ad:899e:8cd1:ebff:fe97:8c3e', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-03-14 09:57:01'),
(32739, '66.249.79.166', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.6943.141 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Android Device', '2025-03-14 12:04:42'),
(32741, '66.249.79.168', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Unknown', '2025-03-14 12:10:20'),
(32742, '45.118.159.159', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36', 'Unknown', '2025-03-14 14:38:46'),
(32744, '106.161.65.206', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'Apple', '2025-03-15 04:06:26'),
(32745, '179.61.240.47', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36 Edg/132.0.0.0', 'Windows', '2025-03-15 04:06:26'),
(32746, '103.224.53.136', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36 Edg/130.0.0.0', 'Windows', '2025-03-15 04:06:26'),
(32747, '103.9.79.191', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'Apple', '2025-03-15 04:09:18'),
(32749, '2409:40d0:30bd:4e4c:e1b5:daf0:7023:9e82', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-03-15 15:53:15'),
(32750, '104.152.52.66', 'curl/7.61.1', 'Unknown', '2025-03-15 20:52:37'),
(32753, '64.225.54.172', 'Mozilla/5.0 (compatible)', 'Unknown', '2025-03-16 07:52:09'),
(32754, '149.57.180.64', 'Mozilla/5.0 (X11; Linux i686; rv:109.0) Gecko/20100101 Firefox/120.0', 'Unknown', '2025-03-16 11:02:17'),
(32758, '23.27.145.17', 'Mozilla/5.0 (X11; Linux i686; rv:109.0) Gecko/20100101 Firefox/120.0', 'Unknown', '2025-03-17 16:58:13'),
(32759, '149.57.180.88', 'Mozilla/5.0 (X11; Linux i686; rv:109.0) Gecko/20100101 Firefox/120.0', 'Unknown', '2025-03-17 17:06:01'),
(32763, '2409:4085:2e86:b163::2dc8:9a02', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-03-18 03:41:40'),
(32771, '2a06:4882:1000::24', 'Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)', 'Unknown', '2025-03-20 00:33:17'),
(32775, '91.84.87.137', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-03-20 09:07:15'),
(32776, '23.27.145.126', 'Mozilla/5.0 (X11; Linux i686; rv:109.0) Gecko/20100101 Firefox/120.0', 'Unknown', '2025-03-20 11:24:17'),
(32779, '139.5.242.102', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36', 'Unknown', '2025-03-21 04:11:04'),
(32784, '104.152.52.64', 'curl/7.61.1', 'Unknown', '2025-03-22 22:07:40'),
(32787, '54.202.99.69', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:48.0) Gecko/20100101 Firefox/48.0', 'Windows', '2025-03-23 11:35:45'),
(32792, '202.62.92.69', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36', 'Windows', '2025-03-26 05:13:07'),
(32794, '2409:40e4:30:6372:f50b:a8d5:cc78:70a1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-03-26 09:39:14'),
(32795, '66.249.68.32', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Unknown', '2025-03-26 10:44:10'),
(32796, '66.249.68.38', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Android Device', '2025-03-26 10:44:12'),
(32798, '34.32.161.52', 'Scrapy/2.12.0 (+https://scrapy.org)', 'Unknown', '2025-03-26 15:59:44'),
(32799, '46.17.174.174', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:98.0) Gecko/20100101 Firefox/98.0', 'Apple', '2025-03-27 00:04:34'),
(32802, '64.227.122.101', 'Mozilla/5.0 (compatible)', 'Unknown', '2025-03-27 11:15:02'),
(32803, '2409:40e5:204f:d259:8000::', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-03-27 13:29:12'),
(32804, '205.169.39.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.5938.132 Safari/537.36', 'Windows', '2025-03-27 22:07:37'),
(32807, '202.173.125.104', 'WhatsApp/2.23.20.0', 'Unknown', '2025-03-28 12:49:31'),
(32809, '111.125.253.45', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_0_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.0.1 Mobile/15E148 Safari/604.1', 'Apple', '2025-03-28 12:50:32'),
(32812, '139.5.242.29', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36', 'Unknown', '2025-03-29 11:08:58'),
(32817, '2401:4900:81e1:23b:5d8e:1982:6968:1890', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-03-30 03:47:43'),
(32818, '165.227.229.92', 'Mozilla/5.0 (compatible)', 'Unknown', '2025-03-30 11:28:22'),
(32819, '2001:4860:7:405::a0', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36', 'Unknown', '2025-03-31 04:59:22'),
(32821, '45.118.159.19', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36', 'Unknown', '2025-03-31 06:22:29'),
(32823, '139.5.242.183', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36', 'Unknown', '2025-04-01 04:42:23'),
(32828, '45.118.159.67', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'Unknown', '2025-04-02 14:06:08'),
(32829, '2409:40e4:4c:8080:3019:a781:3a33:7087', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-04-02 15:24:57'),
(32831, '2401:4900:81ed:9ec6:fdd5:e3fa:c8e6:55cf', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-04-02 16:05:58'),
(32834, '2401:4900:742e:62ed:92fa:ced1:ddf3:d9d9', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-04-02 16:37:15'),
(32837, '34.147.27.237', 'Scrapy/2.12.0 (+https://scrapy.org)', 'Unknown', '2025-04-03 08:41:53'),
(32838, '2001:4860:7:405::b1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'Unknown', '2025-04-03 15:49:28'),
(32845, '34.254.174.173', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2025-04-05 01:23:02'),
(32846, '3.250.180.6', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2025-04-05 02:34:09'),
(32848, '2401:4900:8848:4170:38b2:7009:5644:e477', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36', 'Windows', '2025-04-05 07:30:36'),
(32849, '2401:4900:81f2:7c50:1d3a:b924:3b81:1f80', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-04-05 07:32:55'),
(32851, '66.102.6.38', 'Mozilla/5.0 (Linux; Android 7.0; SM-G930V Build/NRD90M) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.125 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Android Device', '2025-04-05 07:35:13'),
(32853, '2401:4900:8848:4170:4033:d0bc:7274:9d82', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-04-05 07:36:48'),
(32856, '23.27.145.173', 'Mozilla/5.0 (X11; Linux i686; rv:109.0) Gecko/20100101 Firefox/120.0', 'Unknown', '2025-04-05 11:59:31'),
(32857, '45.118.159.252', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'Unknown', '2025-04-05 12:40:49'),
(32858, '104.152.52.68', 'curl/7.61.1', 'Unknown', '2025-04-05 16:05:40'),
(32860, '66.249.79.203', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Android Device', '2025-04-06 02:24:31'),
(32863, '2405:201:6021:48fd:2d90:121c:6ed1:4e3a', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-04-06 09:43:49'),
(32866, '18.201.26.210', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2025-04-07 16:48:11'),
(32867, '63.34.170.155', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2025-04-07 18:50:21'),
(32868, '35.94.162.239', 'Mozilla/5.0 (compatible; wpbot/1.3; +https://forms.gle/ajBaxygz9jSR8p8G9)', 'Unknown', '2025-04-08 03:12:37'),
(32871, '49.44.78.164', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36', 'Windows', '2025-04-08 08:39:19'),
(32872, '49.44.84.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36', 'Windows', '2025-04-08 08:39:19'),
(32873, '72.14.199.205', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.96 Mobile Safari/537.36 (compatible; Google-Safety; +http://www.google.com/bot.html)', 'Android Device', '2025-04-08 08:39:21'),
(32874, '49.44.82.134', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36', 'Windows', '2025-04-08 08:39:22'),
(32878, '2a06:4883:7000::7d', 'Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)', 'Unknown', '2025-04-09 16:24:52'),
(32881, '164.90.207.170', 'Mozilla/5.0 (compatible)', 'Unknown', '2025-04-10 12:08:14'),
(32886, '104.152.52.62', 'curl/7.61.1', 'Unknown', '2025-04-12 20:04:15'),
(32889, '159.89.89.9', 'Mozilla/5.0 (compatible)', 'Unknown', '2025-04-13 10:24:59'),
(32893, '2401:4900:b3dd:1c43:1284:e40b:a58d:e07', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-04-14 06:15:17'),
(32894, '45.118.159.154', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'Unknown', '2025-04-14 12:19:50'),
(32897, '2a06:4882:b000::d1', 'Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)', 'Unknown', '2025-04-15 08:58:48'),
(32899, '149.154.161.251', 'TelegramBot (like TwitterBot)', 'Unknown', '2025-04-15 13:52:24'),
(32903, '223.184.204.12', 'Mozilla/5.0 (Linux; Android 11; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.6998.135 Mobile Safari/537.36', 'Android Device', '2025-04-15 14:17:33'),
(32904, '2a06:4883:9000::99', 'Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)', 'Unknown', '2025-04-16 04:54:18'),
(32907, '13.38.45.33', 'Mozilla/5.0 (Linux; Android 7.0; SM-G892A Build/NRD90M; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/60.0.3112.107 Mobile Safari/537.36', 'Android Device', '2025-04-16 20:22:28'),
(32912, '154.28.229.129', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Apple', '2025-04-17 11:43:39'),
(32913, '154.28.229.109', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36', 'Unknown', '2025-04-17 12:10:42'),
(32915, '154.28.229.219', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36', 'Apple', '2025-04-17 18:35:18'),
(32917, '154.47.16.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36', 'Windows', '2025-04-18 03:43:38'),
(32920, '152.42.255.153', 'Mozilla/5.0 (Linux; Android 5.1.1; SM-J111F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.90 Mobile Safari/537.36', 'Android Device', '2025-04-18 15:37:40'),
(32921, '154.28.229.37', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36', 'Unknown', '2025-04-19 00:55:33'),
(32925, '79.95.86.153', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_3_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3.1 Mobile/15E148 Safari/604.1', 'Apple', '2025-04-19 13:35:38'),
(32926, '159.203.5.234', 'Mozilla/5.0 (compatible)', 'Unknown', '2025-04-19 13:37:37'),
(32927, '5.135.58.203', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0', 'Unknown', '2025-04-19 22:53:12'),
(32931, '3.84.192.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3', 'Windows', '2025-04-21 01:33:53'),
(32934, '2409:40d2:65:fc6:8000::', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-04-21 09:58:30'),
(32935, '103.59.200.100', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-04-21 09:58:35'),
(32936, '66.102.6.40', 'Mozilla/5.0 (Linux; Android 7.0; SM-G930V Build/NRD90M) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.125 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Android Device', '2025-04-21 09:58:41'),
(32937, '66.102.6.39', 'Mozilla/5.0 (Linux; Android 7.0; SM-G930V Build/NRD90M) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.125 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Android Device', '2025-04-21 09:58:41'),
(32938, '18.141.219.173', 'Mozilla/5.0 (X11; Linux i686 on x86_64; rv:2.0.1) Gecko/20100101 Firefox/4.0.1', 'Unknown', '2025-04-21 13:45:19'),
(32939, '143.198.126.198', 'Mozilla/5.0 (compatible)', 'Unknown', '2025-04-21 13:57:21'),
(32940, '3.238.104.250', 'Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:24.0) Gecko/20100101 Firefox/24.0', 'Unknown', '2025-04-22 04:22:14'),
(32945, '139.59.2.39', 'Mozilla/5.0 (compatible)', 'Unknown', '2025-04-23 13:19:24'),
(32949, '188.166.171.33', 'Mozilla/5.0 (compatible)', 'Unknown', '2025-04-24 12:46:26'),
(32952, '206.189.3.244', 'Mozilla/5.0 (compatible)', 'Unknown', '2025-04-25 14:02:57'),
(32953, '35.222.248.104', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2224.3 Safari/537.36', 'Windows', '2025-04-25 23:41:09'),
(32956, '66.249.79.205', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Android Device', '2025-04-26 19:20:55'),
(32957, '66.249.79.204', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Unknown', '2025-04-26 19:20:56'),
(32958, '64.227.148.25', 'Mozilla/5.0 (compatible)', 'Unknown', '2025-04-27 02:00:56'),
(32962, '2a03:2880:30ff:1::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Unknown', '2025-04-27 11:13:47'),
(32963, '2a03:2880:30ff:6::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Unknown', '2025-04-27 11:14:24'),
(32964, '202.173.125.20', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'Unknown', '2025-04-27 11:14:34'),
(32966, '2401:4900:5b91:be4f:c086:75ff:fe1e:4687', 'Mozilla/5.0 (Linux; Android 15; CPH2487 Build/AP3A.240617.008; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/135.0.7049.100 Mobile Safari/537.36 Instagram 376.1.0.55.68 Android (35/15; 560dpi; 1240x2772; OnePlus; CPH2487; OP5961L1; qcom; en_GB; 722818376; IABMV/1)', 'Android Device', '2025-04-27 11:20:05'),
(32967, '2409:40e4:1118:6136:3019:a781:3a33:7087', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-04-27 12:16:22'),
(32968, '104.197.6.114', 'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.2 Safari/537.36', 'Windows', '2025-04-27 19:59:51'),
(32972, '2a06:4882:1000::17', 'Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)', 'Unknown', '2025-04-28 14:25:41'),
(32977, '2401:4900:a065:78c2:2355:b8af:1dcd:ce81', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-04-29 04:47:15'),
(32978, '2a03:2880:32ff:9::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Unknown', '2025-04-29 11:25:47'),
(32979, '2a03:2880:32ff:72::', 'facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Unknown', '2025-04-29 11:25:48'),
(32980, '34.13.145.130', 'Scrapy/2.12.0 (+https://scrapy.org)', 'Unknown', '2025-04-30 00:16:24'),
(32982, '139.5.242.253', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'Windows', '2025-04-30 01:57:26'),
(32987, '139.5.242.28', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'Unknown', '2025-05-01 12:26:47'),
(32988, '54.36.148.147', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-05-02 00:12:18'),
(32991, '172.213.21.126', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko); compatible; ChatGPT-User/1.0; +https://openai.com/bot', 'Unknown', '2025-05-02 06:25:50'),
(32992, '34.147.28.155', 'Scrapy/2.12.0 (+https://scrapy.org)', 'Unknown', '2025-05-02 16:06:06'),
(32993, '45.129.35.96', 'Go-http-client/1.1', 'Unknown', '2025-05-03 02:19:53'),
(32995, '3.250.235.59', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2025-05-03 06:30:19'),
(32997, '34.241.141.3', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2025-05-03 08:44:57'),
(33001, '54.36.148.216', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-05-04 12:01:07'),
(33008, '154.28.229.241', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Apple', '2025-05-05 07:47:22'),
(33010, '104.164.173.94', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36', 'Apple', '2025-05-05 07:47:37'),
(33011, '205.169.39.114', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36', 'Windows', '2025-05-05 07:49:53'),
(33012, '2a01:4f9:c013:86e::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36 GLS/100.10.9939.100', 'Windows', '2025-05-05 07:51:46'),
(33013, '205.169.39.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.5938.132 Safari/537.36', 'Windows', '2025-05-05 07:54:44'),
(33014, '34.116.161.121', 'Mozilla/5.0 (iPhone13,2; U; CPU iPhone OS 14_0 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) Version/10.0 Mobile/15E148 Safari/602.1', 'Apple', '2025-05-05 07:55:39'),
(33015, '104.164.173.31', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Windows', '2025-05-05 07:58:44'),
(33017, '104.164.173.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Windows', '2025-05-05 07:58:58'),
(33019, '154.28.229.96', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Unknown', '2025-05-05 08:59:00'),
(33021, '154.28.229.89', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36', 'Unknown', '2025-05-05 08:59:14'),
(33023, '44.245.236.41', 'Mozilla/5.0 (iPhone; CPU iPhone OS 14_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.4 Mobile/15E148 Safari/604.1', 'Apple', '2025-05-05 09:03:41'),
(33025, '35.163.210.11', 'Mozilla/5.0 (iPhone; CPU iPhone OS 14_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.4 Mobile/15E148 Safari/604.1', 'Apple', '2025-05-05 09:03:46'),
(33027, '147.182.204.39', 'Mozilla/5.0', 'Unknown', '2025-05-05 15:55:40'),
(33028, '15.236.144.144', 'Mozilla/5.0 (Linux; Android 7.0; SM-G892A Build/NRD90M; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/60.0.3112.107 Mobile Safari/537.36', 'Android Device', '2025-05-05 17:18:58'),
(33029, '20.163.59.113', 'Mozilla/5.0 (SMART-TV; X11; Linux armv7l) AppleWebkit/537.42 (KHTML, like Gecko) Chromium/25.0.1349.2 Chrome/25.0.1349.2 Safari/537.42', 'Unknown', '2025-05-05 17:52:14'),
(33030, '193.32.248.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36', 'Windows', '2025-05-05 19:50:30'),
(33031, '64.227.78.106', 'Mozilla/5.0 (X11; Linux x86_64; rv:136.0) Gecko/20100101 Firefox/136.0', 'Unknown', '2025-05-05 20:12:46'),
(33034, '5.95.217.101', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', 'Apple', '2025-05-06 11:51:02'),
(33035, '2607:f298:6:a014::8f:c232', 'Mozilla/5.0 (X11; Linux x86_64; rv:83.0) Gecko/20100101 Firefox/83.0', 'Unknown', '2025-05-06 15:11:12'),
(33036, '202.173.125.190', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'Unknown', '2025-05-06 16:13:11'),
(33037, '5.135.58.206', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0', 'Unknown', '2025-05-06 18:30:04'),
(33038, '44.197.101.52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3', 'Windows', '2025-05-06 21:18:15'),
(33041, '104.152.52.100', 'curl/7.61.1', 'Unknown', '2025-05-07 06:50:26'),
(33042, '2600:1f14:3165:dd00:59d6:2c78:9500:da7c', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3', 'Windows', '2025-05-07 09:10:58'),
(33043, '3.25.227.200', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/109.0.5414.46 Safari/537.36', 'Unknown', '2025-05-07 19:07:49'),
(33044, '139.59.176.251', 'Mozilla/5.0 (X11; Linux x86_64; rv:136.0) Gecko/20100101 Firefox/136.0', 'Unknown', '2025-05-07 19:34:01'),
(33047, '64.227.47.72', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'Unknown', '2025-05-08 08:03:07'),
(33048, '46.17.174.193', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36', 'Apple', '2025-05-08 16:21:33'),
(33053, '54.36.148.103', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-05-09 17:32:54'),
(33054, '165.232.185.106', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'Unknown', '2025-05-09 21:14:09'),
(33055, '196.251.69.172', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/65.0.3325.181 Chrome/65.0.3325.181 Safari/537.36', 'Unknown', '2025-05-10 00:15:58'),
(33057, '27.115.124.33', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36 Edg/120.0.0.0', 'Apple', '2025-05-10 06:00:44'),
(33059, '179.43.145.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3', 'Windows', '2025-05-10 20:30:20'),
(33061, '34.253.204.75', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2025-05-11 01:40:36'),
(33064, '52.18.117.98', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2025-05-11 09:22:14'),
(33066, '138.197.181.61', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'Unknown', '2025-05-11 15:23:28'),
(33067, '165.227.162.45', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'Unknown', '2025-05-11 18:52:28'),
(33068, '106.219.165.156', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Windows', '2025-05-12 02:59:53'),
(33077, '2401:4900:b474:51:857:91ff:fe50:20fb', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-05-12 08:25:35'),
(33078, '45.118.159.173', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'Unknown', '2025-05-12 08:58:14'),
(33079, '35.94.82.129', 'Mozilla/5.0 (compatible; wpbot/1.3; +https://forms.gle/ajBaxygz9jSR8p8G9)', 'Unknown', '2025-05-12 22:38:13'),
(33082, '2001:4860:7:152d::f1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-05-13 15:06:38'),
(33084, '74.125.210.108', 'Mozilla/5.0 (Linux; Android 7.0; SM-G930V Build/NRD90M) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.125 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Android Device', '2025-05-13 15:06:49'),
(33085, '74.125.210.107', 'Mozilla/5.0 (Linux; Android 7.0; SM-G930V Build/NRD90M) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.125 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'Android Device', '2025-05-13 15:06:49'),
(33088, '79.156.152.153', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-05-13 15:43:42'),
(33089, '188.166.175.229', 'Mozilla/5.0 (X11; Linux x86_64; rv:136.0) Gecko/20100101 Firefox/136.0', 'Unknown', '2025-05-13 19:34:10'),
(33093, '202.173.125.37', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'Unknown', '2025-05-14 13:33:48'),
(33096, '159.89.166.92', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'Unknown', '2025-05-15 13:26:37'),
(33099, '54.36.149.17', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-05-16 20:19:40'),
(33102, '2a06:4883:9000::9e', 'Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)', 'Unknown', '2025-05-17 09:18:49'),
(33105, '54.36.149.75', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-05-17 11:10:55'),
(33106, '159.89.95.77', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'Unknown', '2025-05-17 12:40:53'),
(33107, '138.197.119.63', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'Unknown', '2025-05-17 13:08:07'),
(33111, '139.5.242.44', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'Unknown', '2025-05-18 05:11:45'),
(33113, '15.236.247.198', 'Mozilla/5.0 (Linux; Android 7.0; SM-G892A Build/NRD90M; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/60.0.3112.107 Mobile Safari/537.36', 'Android Device', '2025-05-18 06:03:33'),
(33115, '27.115.124.3', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.56 Safari/535.11', 'Apple', '2025-05-19 11:11:46'),
(33116, '27.115.124.4', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36 Edg/120.0.0.0', 'Apple', '2025-05-19 11:17:29'),
(33118, '2a06:4882:9000::ad', 'Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)', 'Unknown', '2025-05-19 18:29:45'),
(33120, '2a06:4883:7000::84', 'Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)', 'Unknown', '2025-05-20 01:02:12'),
(33123, '66.249.66.12', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Unknown', '2025-05-20 17:40:49'),
(33124, '66.249.66.14', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Android Device', '2025-05-20 17:41:32'),
(33129, '49.44.76.134', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/28.0 Chrome/130.0.0.0 Mobile Safari/537.36', 'Samsung', '2025-05-22 09:24:43'),
(33130, '178.62.234.12', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'Unknown', '2025-05-22 10:30:56'),
(33133, '54.36.148.140', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-05-23 17:16:51'),
(33134, '143.110.188.209', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'Unknown', '2025-05-23 20:11:03'),
(33136, '54.36.149.57', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-05-24 08:22:01'),
(33138, '167.71.239.207', 'Mozilla/5.0 (X11; Linux x86_64; rv:136.0) Gecko/20100101 Firefox/136.0', 'Unknown', '2025-05-25 03:41:37'),
(33141, '159.203.23.101', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'Unknown', '2025-05-25 12:42:28'),
(33142, '143.110.190.251', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'Unknown', '2025-05-25 20:37:46'),
(33148, '165.227.116.58', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'Unknown', '2025-05-27 15:01:30'),
(33150, '2404:7c80:34:6533:d1b7:5af6:2020:2819', 'python-requests/2.31.0', 'Unknown', '2025-05-27 15:51:35'),
(33153, '45.118.159.238', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Unknown', '2025-05-29 07:39:13'),
(33156, '139.59.56.199', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'Unknown', '2025-05-29 13:39:42'),
(33158, '2400:c600:5356:dc6c:24f4:8c30:98b8:591c', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Windows', '2025-05-30 05:27:24'),
(33162, '77.74.177.114', 'Mozilla/5.0 (Linux; arm_64; Android 12; CPH2205) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 YaBrowser/23.3.3.86.00 SA/3 Mobile Safari/537.36', 'Android Device', '2025-05-31 11:13:57'),
(33163, '206.189.124.119', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'Unknown', '2025-05-31 12:38:32'),
(33164, '20.171.207.69', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', 'Unknown', '2025-05-31 18:51:42'),
(33166, '52.215.254.21', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2025-06-01 10:08:56'),
(33168, '3.249.3.157', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2025-06-01 12:31:16'),
(33170, '20.171.207.90', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', 'Unknown', '2025-06-01 19:04:55'),
(33177, '157.245.107.56', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'Unknown', '2025-06-05 04:05:32'),
(33178, '149.154.161.235', 'TelegramBot (like TwitterBot)', 'Unknown', '2025-06-05 06:16:20'),
(33179, '2401:4900:8848:2120:4ddc:c95:18cc:90c9', 'Mozilla/5.0 (Linux; Android 13; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.7103.125 Mobile Safari/537.36', 'Android Device', '2025-06-05 06:16:44'),
(33187, '2001:4860:7:1518::f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36', 'Windows', '2025-06-06 05:21:06'),
(33188, '2a02:b125:8f07:f01d:b5bb:3196:c5ce:337b', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', 'Apple', '2025-06-06 06:31:44'),
(33189, '20.171.207.151', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', 'Unknown', '2025-06-07 02:34:19'),
(33192, '34.255.10.92', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2025-06-07 10:35:02'),
(33193, '3.254.66.163', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2025-06-07 13:26:41'),
(33196, '159.223.186.159', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'Unknown', '2025-06-08 00:52:30'),
(33219, '151.83.57.77', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1', 'Apple', '2025-06-10 22:24:40'),
(33223, '20.171.207.6', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', 'Unknown', '2025-06-11 02:13:51'),
(33225, '44.234.71.216', 'Mozilla/5.0 (compatible; wpbot/1.3; +https://forms.gle/ajBaxygz9jSR8p8G9)', 'Unknown', '2025-06-11 05:25:27'),
(33226, '35.88.47.5', 'Mozilla/5.0 (compatible; wpbot/1.3; +https://forms.gle/ajBaxygz9jSR8p8G9)', 'Unknown', '2025-06-11 10:46:03'),
(33229, '54.36.148.16', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-06-12 04:07:37'),
(33232, '2401:4900:47f6:e082:9771:68d8:d562:f36f', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Unknown', '2025-06-12 10:24:35'),
(33240, '202.173.125.187', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Unknown', '2025-06-14 07:24:51'),
(33241, '2a02:8428:21e5:ea01:95d9:514b:2913:5600', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', 'Apple', '2025-06-14 07:36:39'),
(33255, '142.252.248.134', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:131.0) Gecko/20100101 Firefox/131.0', 'Windows', '2025-06-17 08:21:08'),
(33257, '205.169.39.94', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.79 Safari/537.36', 'Windows', '2025-06-17 08:21:16'),
(33258, '23.234.111.26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'Windows', '2025-06-17 08:21:20'),
(33259, '2a03:b0c0:3:d0::1047:b001', 'Mozilla/5.0 (Linux; Android 6.0; HTC One M9 Build/MRA58K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.98 Mobile Safari/537.3', 'Android Device', '2025-06-17 08:21:32'),
(33260, '34.116.185.152', 'Mozilla/5.0 (iPhone13,2; U; CPU iPhone OS 14_0 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) Version/10.0 Mobile/15E148 Safari/602.1', 'Apple', '2025-06-17 08:21:42'),
(33262, '205.169.39.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.5938.132 Safari/537.36', 'Windows', '2025-06-17 08:31:17'),
(33264, '178.128.18.34', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:89.0) Gecko/20100101 Firefox/89.0', 'Unknown', '2025-06-17 12:27:09'),
(33266, '34.222.182.158', 'Mozilla/5.0 (Linux; Android 12; Pixel 6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-06-18 03:01:16'),
(33267, '44.243.78.106', 'Mozilla/5.0 (Linux; Android 12; Pixel 6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-06-18 03:01:48'),
(33268, '202.173.125.103', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Unknown', '2025-06-18 05:23:56'),
(33271, '3.135.224.60', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3', 'Windows', '2025-06-18 09:21:00'),
(33273, '146.70.59.167', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'Unknown', '2025-06-18 11:55:15'),
(33275, '54.214.125.198', 'Mozilla/5.0 (Linux; Android 9; Redmi Note 4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.80 Mobile Safari/537.36', 'Android Device', '2025-06-18 13:49:37'),
(33276, '34.63.49.169', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2025-06-18 13:56:25'),
(33277, '35.84.195.255', 'Mozilla/5.0 (Linux; Android 12; Pixel 6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-06-18 13:58:02'),
(33278, '35.86.197.30', 'Mozilla/5.0 (Linux; Android 12; Pixel 6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-06-18 13:58:48'),
(33279, '54.174.93.141', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:55.0) Gecko/20100101 Firefox/55.0', 'Apple', '2025-06-18 17:29:44'),
(33282, '167.172.41.177', 'Mozilla/5.0 (X11; Linux x86_64; rv:137.0) Gecko/20100101 Firefox/137.0', 'Unknown', '2025-06-19 05:59:20'),
(33286, '45.118.159.10', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Unknown', '2025-06-19 16:18:04'),
(33287, '91.231.89.38', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0', 'Unknown', '2025-06-19 18:06:52'),
(33293, '216.73.216.168', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; ClaudeBot/1.0; +claudebot@anthropic.com)', 'Unknown', '2025-06-20 11:32:17'),
(33294, '167.71.141.35', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'Unknown', '2025-06-20 12:22:22'),
(33299, '198.203.28.215', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3', 'Windows', '2025-06-20 16:51:27'),
(33301, '2a03:2880:f800:8::', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Unknown', '2025-06-21 04:45:50'),
(33305, '139.5.248.137', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-06-21 14:45:25'),
(33306, '103.225.178.165', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-06-21 14:45:33'),
(33307, '45.148.10.248', 'Bloglines/3.1 (http://www.bloglines.com)', 'Unknown', '2025-06-21 17:14:13'),
(33311, '54.36.148.30', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-06-22 13:03:09'),
(33312, '209.38.77.63', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'Unknown', '2025-06-22 13:41:54'),
(33313, '139.59.14.86', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'Unknown', '2025-06-22 17:24:30'),
(33314, '167.71.102.253', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36', 'Windows', '2025-06-22 20:12:27'),
(33316, '165.22.36.123', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Apple', '2025-06-23 03:59:24'),
(33319, '93.165.251.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'Windows', '2025-06-23 07:48:06'),
(33320, '64.225.1.218', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'Apple', '2025-06-23 08:28:58'),
(33322, '5.90.68.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0', 'Windows', '2025-06-23 12:10:26'),
(33325, '202.173.125.3', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Unknown', '2025-06-24 01:29:31'),
(33330, '202.173.125.184', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Unknown', '2025-06-24 11:53:53'),
(33334, '2405:204:348b:8f47:186c:bcdd:f1e5:dbfa', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Unknown', '2025-06-25 05:16:38'),
(33340, '2405:204:348b:8f47::abf:e8a4', 'WhatsApp/2.23.20.0', 'Unknown', '2025-06-26 07:08:48'),
(33341, '2401:4900:88d3:d61:b8b3:4191:30eb:3d0d', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-06-26 07:09:00'),
(33343, '34.58.209.59', 'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.2 Safari/537.36', 'Windows', '2025-06-26 09:11:16'),
(33345, '223.181.33.122', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-06-26 14:45:18'),
(33351, '74.7.35.125', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko); compatible; ChatGPT-User/1.0; +https://openai.com/bot', 'Unknown', '2025-06-27 10:39:13'),
(33354, '2409:40d5:58:9645:ccc2:d2d:59fc:5ce0', 'Mozilla/5.0 (Linux; Android 12; AC2001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-06-27 23:14:35'),
(33358, '2001:4860:7:805::a0', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Unknown', '2025-06-28 09:15:32'),
(33361, '149.154.161.216', 'TelegramBot (like TwitterBot)', 'Unknown', '2025-06-28 09:41:49'),
(33365, '202.173.125.8', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Unknown', '2025-06-28 11:53:12'),
(33366, '149.154.161.212', 'TelegramBot (like TwitterBot)', 'Unknown', '2025-06-28 11:54:02'),
(33367, '117.199.92.181', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'Windows', '2025-06-28 11:55:58'),
(33369, '2604:3d09:a173:a700:e989:49b4:2b21:10e2', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Safari/605.1.15', 'Apple', '2025-06-28 18:12:46'),
(33375, '87.236.176.95', 'Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)', 'Unknown', '2025-06-30 01:59:45'),
(33378, '34.90.66.217', 'Scrapy/2.12.0 (+https://scrapy.org)', 'Unknown', '2025-06-30 07:32:44'),
(33380, '106.75.138.202', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'Windows', '2025-06-30 10:26:51'),
(33381, '106.75.128.229', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'Windows', '2025-06-30 10:26:53'),
(33382, '2001:4860:7:218::e1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Windows', '2025-06-30 12:36:22'),
(33383, '2001:4860:7:218::f3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Windows', '2025-06-30 12:36:26'),
(33384, '2001:4860:7:1718::f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Windows', '2025-06-30 12:54:31'),
(33385, '74.7.36.82', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko); compatible; ChatGPT-User/1.0; +https://openai.com/bot', 'Unknown', '2025-06-30 21:57:41'),
(33389, '202.173.125.124', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Windows', '2025-07-01 09:54:22'),
(33391, '150.129.64.186', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'Windows', '2025-07-01 14:34:50'),
(33392, '18.237.230.227', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.142 Safari/537.36', 'Windows', '2025-07-01 20:23:15'),
(33395, '35.204.134.146', 'Scrapy/2.12.0 (+https://scrapy.org)', 'Unknown', '2025-07-02 01:56:49'),
(33399, '2a01:cb06:801f:53bf:85ab:94de:6d75:f06a', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', 'Apple', '2025-07-02 11:33:11'),
(33401, '34.240.11.215', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2025-07-02 17:02:05'),
(33403, '2001:4860:7:505::fb', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Windows', '2025-07-02 18:29:24'),
(33409, '2a01:7e01::2000:96ff:fef2:7eb9', 'Fuzz Faster U Fool v2.1.0-dev', 'Unknown', '2025-07-03 00:13:39'),
(33411, '20.171.207.133', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', 'Unknown', '2025-07-03 01:24:21'),
(33412, '2a02:4780:11:c0de::21', 'Go-http-client/2.0', 'Unknown', '2025-07-03 02:07:56'),
(33413, '2409:4081:9d95:ebce::508:b918', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-07-03 04:25:06'),
(33414, '162.243.167.247', 'Mozilla/5.0 (X11; Linux x86_64; rv:137.0) Gecko/20100101 Firefox/137.0', 'Unknown', '2025-07-03 04:30:35'),
(33417, '139.5.242.106', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Windows', '2025-07-03 05:30:53'),
(33420, '2a01:7e01::2000:7cff:fe12:277', 'Fuzz Faster U Fool v2.1.0-dev', 'Unknown', '2025-07-03 06:41:31'),
(33421, '172.104.154.210', 'Fuzz Faster U Fool v2.1.0-dev', 'Unknown', '2025-07-03 07:32:35'),
(33425, '2a01:7e01::2000:f9ff:feeb:1b', 'Fuzz Faster U Fool v2.1.0-dev', 'Unknown', '2025-07-03 14:38:26');
INSERT INTO `visitor_info` (`id`, `ip_address`, `user_agent`, `device_brand`, `visit_time`) VALUES
(33426, '167.94.138.176', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'Unknown', '2025-07-03 23:10:45'),
(33427, '2602:80d:1006::60', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'Unknown', '2025-07-03 23:11:17'),
(33428, '2604:a880:cad:d0::dd0:b001', 'Mozilla/5.0 (Linux; Android 6.0; HTC One M9 Build/MRA58K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.98 Mobile Safari/537.3', 'Android Device', '2025-07-04 06:54:12'),
(33431, '103.4.250.22', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Windows', '2025-07-04 06:59:40'),
(33433, '104.164.173.111', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36', 'Unknown', '2025-07-04 07:00:04'),
(33436, '151.40.102.104', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', 'Apple', '2025-07-04 20:24:18'),
(33437, '139.59.65.14', 'Mozilla/5.0 (X11; Linux x86_64; rv:137.0) Gecko/20100101 Firefox/137.0', 'Unknown', '2025-07-04 20:44:19'),
(33441, '44.242.245.7', 'Mozilla/5.0 (Linux; Android 12; Pixel 6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-07-05 02:14:56'),
(33443, '35.87.53.239', 'Mozilla/5.0 (Linux; Android 12; Pixel 6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-07-05 02:15:54'),
(33446, '122.161.76.169', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Windows', '2025-07-05 15:21:50'),
(33447, '49.205.41.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'Windows', '2025-07-05 15:22:46'),
(33448, '3.141.116.179', 'getstream.io/opengraph-bot (like TwitterBot) facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)', 'Unknown', '2025-07-05 15:47:12'),
(33452, '103.145.19.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Windows', '2025-07-05 15:48:50'),
(33456, '2401:4900:1c64:9a0d:41c6:15eb:f7c2:bac0', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Safari/605.1.15', 'Apple', '2025-07-05 15:50:09'),
(33459, '103.165.22.198', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0', 'Windows', '2025-07-05 15:53:04'),
(33462, '35.87.205.207', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.80 Safari/537.36', 'Windows', '2025-07-05 16:00:06'),
(33463, '45.118.156.112', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Windows', '2025-07-05 16:20:59'),
(33466, '202.173.125.78', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Unknown', '2025-07-05 18:07:19'),
(33468, '72.152.84.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'Windows', '2025-07-06 02:41:12'),
(33469, '170.39.218.50', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/121.0.0.0', 'Windows', '2025-07-06 03:33:43'),
(33470, '2a01:cb08:93be:c300:6dea:52a1:79b1:8e96', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:140.0) Gecko/20100101 Firefox/140.0', 'Windows', '2025-07-06 08:12:40'),
(33471, '142.250.32.33', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:140.0) Gecko/20100101 Firefox/140.0,gzip(gfe)', 'Windows', '2025-07-06 08:13:44'),
(33472, '2a01:e0a:d0c:2dc0:3088:60a9:4ed9:e6b0', 'Mozilla/5.0 (Android 15; Mobile; rv:135.0) Gecko/135.0 Firefox/135.0', 'Android Device', '2025-07-06 08:40:54'),
(33474, '80.215.194.103', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/138.0.7204.119 Mobile/15E148 Safari/604.1', 'Apple', '2025-07-06 09:21:51'),
(33475, '67.205.146.147', 'Mozilla/5.0 (X11; Linux x86_64; rv:137.0) Gecko/20100101 Firefox/137.0', 'Unknown', '2025-07-06 13:38:10'),
(33476, '138.197.111.72', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'Unknown', '2025-07-06 20:26:35'),
(33477, '52.167.144.17', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2025-07-06 23:29:57'),
(33479, '122.161.50.76', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Windows', '2025-07-07 05:52:31'),
(33480, '47.254.16.187', 'Mozilla/5.0 (Linux; Android 11; M2004J15SC) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Mobile Safari/537.36', 'Android Device', '2025-07-07 06:26:01'),
(33481, '47.251.14.232', 'Mozilla/5.0 (Linux; Android 11; M2004J15SC) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Mobile Safari/537.36', 'Android Device', '2025-07-07 06:26:09'),
(33483, '18.223.169.80', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36 Edg/131.0.0.0', 'Windows', '2025-07-07 08:05:43'),
(33484, '52.167.144.161', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2025-07-07 09:29:42'),
(33485, '34.60.19.30', 'Mozilla/5.0 (Windows NT 4.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2049.0 Safari/537.36', 'Windows', '2025-07-07 09:52:18'),
(33486, '52.167.144.174', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2025-07-07 11:54:50'),
(33488, '2a01:7e01::2000:e5ff:fea6:32b0', 'Fuzz Faster U Fool v2.1.0-dev', 'Unknown', '2025-07-07 17:30:20'),
(33489, '2a03:b0c0:2:d0::1713:9001', 'Mozilla/5.0 (Linux; Android 6.0; HTC One M9 Build/MRA58K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.98 Mobile Safari/537.3', 'Android Device', '2025-07-07 17:37:11'),
(33490, '185.254.75.31', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'Windows', '2025-07-07 17:39:52'),
(33492, '104.164.173.142', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Windows', '2025-07-07 18:19:54'),
(33493, '104.164.173.95', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Windows', '2025-07-07 18:20:14'),
(33495, '104.164.126.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36', 'Windows', '2025-07-07 18:37:36'),
(33496, '103.4.251.34', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Windows', '2025-07-07 18:37:52'),
(33497, '104.252.191.35', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36', 'Apple', '2025-07-07 18:48:32'),
(33499, '104.164.173.194', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36', 'Unknown', '2025-07-07 18:48:51'),
(33500, '34.245.72.60', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2025-07-07 18:49:37'),
(33501, '103.4.251.255', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36', 'Unknown', '2025-07-07 19:24:17'),
(33503, '154.28.229.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Windows', '2025-07-07 19:24:21'),
(33504, '34.247.105.110', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2025-07-07 19:57:31'),
(33507, '44.249.193.98', 'Mozilla/5.0 (Linux; Android 12; Pixel 6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-07-08 02:07:59'),
(33508, '35.93.52.200', 'Mozilla/5.0 (compatible; wpbot/1.3; +https://forms.gle/ajBaxygz9jSR8p8G9)', 'Unknown', '2025-07-08 03:21:54'),
(33509, '54.202.130.237', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.142 Safari/537.36', 'Apple', '2025-07-08 05:08:00'),
(33510, '103.4.251.203', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36', 'Windows', '2025-07-08 05:45:07'),
(33512, '104.164.126.144', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36', 'Unknown', '2025-07-08 05:45:26'),
(33514, '205.169.39.0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.5938.132 Safari/537.36', 'Windows', '2025-07-08 08:07:21'),
(33515, '44.250.149.192', 'Mozilla/5.0 (compatible; wpbot/1.3; +https://forms.gle/ajBaxygz9jSR8p8G9)', 'Unknown', '2025-07-08 08:38:51'),
(33517, '2001:4860:7:805::9e', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Unknown', '2025-07-08 09:52:35'),
(33518, '139.5.242.151', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Unknown', '2025-07-08 09:52:49'),
(33519, '213.37.65.24', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/375.1.776343893 Mobile/15E148 Safari/604.1', 'Apple', '2025-07-08 11:05:28'),
(33521, '34.82.223.151', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2025-07-08 13:50:48'),
(33522, '34.93.157.27', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2025-07-08 14:09:30'),
(33523, '46.8.225.111', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 'Windows', '2025-07-08 14:17:09'),
(33524, '139.5.242.201', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Unknown', '2025-07-08 17:23:03'),
(33525, '40.77.167.52', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2025-07-08 19:24:34'),
(33526, '2405:204:3481:3ec6:3812:b79c:449d:16d0', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Unknown', '2025-07-09 01:29:04'),
(33527, '52.167.144.217', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2025-07-09 15:47:59'),
(33528, '34.68.246.64', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2025-07-09 19:22:26'),
(33529, '45.148.10.249', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.129 Safari/537.36', 'Unknown', '2025-07-10 01:59:10'),
(33530, '34.21.4.135', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2025-07-10 04:37:42'),
(33531, '2001:863:213:b475:6534:e05:b689:b485', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', 'Apple', '2025-07-10 05:30:28'),
(33534, '159.223.104.178', 'Mozilla/5.0 (X11; Linux x86_64; rv:137.0) Gecko/20100101 Firefox/137.0', 'Unknown', '2025-07-10 18:59:11'),
(33537, '54.36.148.13', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-07-11 05:09:26'),
(33541, '2001:4860:7:141e::fd', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-07-12 13:44:35'),
(33542, '157.55.39.197', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2025-07-12 15:02:20'),
(33544, '2a01:7e01::2000:f6ff:fea9:fed4', 'Fuzz Faster U Fool v2.1.0-dev', 'Unknown', '2025-07-12 19:46:54'),
(33546, '72.251.3.70', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'Apple', '2025-07-12 22:53:19'),
(33547, '103.58.153.144', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-07-13 03:37:05'),
(33552, '185.124.31.82', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-07-13 11:12:47'),
(33555, '20.171.207.171', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', 'Unknown', '2025-07-13 18:08:59'),
(33556, '20.117.22.237', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko); compatible; ChatGPT-User/1.0; +https://openai.com/bot', 'Unknown', '2025-07-13 21:04:46'),
(33562, '207.46.13.160', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2025-07-15 09:44:19'),
(33563, '2001:4860:7:140f::e3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Windows', '2025-07-15 12:29:04'),
(33565, '49.0.237.195', 'Java/1.8.0_322', 'Unknown', '2025-07-15 15:26:25'),
(33566, '119.8.41.86', 'Mozilla/5.0 (Windows NT 6.1; WOW64; iPhone) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.5051.99 Safari/537.36 HuaweiCrawler', 'Apple', '2025-07-15 15:26:25'),
(33569, '2a02:aa7:4118:94e2:14c8:b614:1295:2940', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) EdgiOS/135.0.3179.85 Version/18.0 Mobile/15E148 Safari/604.1', 'Apple', '2025-07-16 09:34:27'),
(33570, '35.223.181.46', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2025-07-16 10:55:27'),
(33571, '83.32.177.152', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', 'Apple', '2025-07-16 14:28:01'),
(33575, '159.223.184.242', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'Unknown', '2025-07-17 11:25:59'),
(33577, '20.171.207.13', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', 'Unknown', '2025-07-18 00:43:31'),
(33578, '207.241.235.168', 'Mozilla/5.0 (compatible; archive.org_bot +http://archive.org/details/archive.org_bot) Zeno/d03bbe0 warc/v0.8.84', 'Unknown', '2025-07-18 04:43:58'),
(33581, '92.154.24.212', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:140.0) Gecko/20100101 Firefox/140.0', 'Apple', '2025-07-18 11:56:54'),
(33586, '5.9.94.125', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/135.0.0.0 Safari/537.36', 'Unknown', '2025-07-19 06:46:08'),
(33587, '139.5.242.34', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-07-19 10:09:46'),
(33589, '2001:4860:7:20f::fc', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-07-19 13:18:39'),
(33590, '157.55.39.192', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2025-07-19 15:07:39'),
(33591, '2401:4900:a137:b14d:6af8:2521:2bae:8291', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-07-19 17:29:29'),
(33592, '2401:4900:b3fb:6825:2a7e:251a:2d12:2051', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-07-19 19:32:03'),
(33594, '206.189.60.189', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'Unknown', '2025-07-20 02:35:22'),
(33596, '2a02:8440:f50e:76e1::3773:3143', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-07-20 07:37:50'),
(33597, '47.79.243.232', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36 Edg/114.0.1823.43', 'Windows', '2025-07-20 15:28:38'),
(33598, '2001:4860:7:60f::fc', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-07-20 16:39:13'),
(33599, '2409:40e5:10:a64f:5c90:4d1f:a5fb:2eb0', 'Mozilla/5.0 (Linux; Android 11; RMX3231 Build/RP1A.201005.001) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.7204.67 Mobile Safari/537.36', 'Android Device', '2025-07-21 00:22:32'),
(33601, '2a0d:e487:154f:e252:add0:565e:ba09:c768', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', 'Apple', '2025-07-21 07:15:49'),
(33603, '2001:4860:7:20f::e6', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-07-21 12:03:26'),
(33606, '2a01:cb1a:403f:44d5:0:59:11d9:4c01', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-07-21 16:19:04'),
(33608, '173.212.240.93', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.82 Safari/537.36', 'Unknown', '2025-07-21 16:32:51'),
(33609, '54.36.149.33', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-07-21 21:23:05'),
(33612, '2a01:cb09:a002:fb6e:b861:96e2:e255:d113', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', 'Apple', '2025-07-22 18:22:15'),
(33614, '2a0d:e487:65f:3a6f:215b:780d:a02d:b09', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', 'Apple', '2025-07-23 06:54:36'),
(33617, '20.171.207.215', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', 'Unknown', '2025-07-23 13:58:31'),
(33621, '47.82.11.73', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36 Edg/114.0.1823.43', 'Windows', '2025-07-24 03:30:08'),
(33623, '2a01:cb05:6dc:1d00:56e5:ed86:2e67:72f4', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-07-24 15:36:06'),
(33625, '2001:4860:7:60f::ff', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'Windows', '2025-07-25 07:37:24'),
(33626, '2001:4860:7:170f::f0', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'Windows', '2025-07-25 07:38:08'),
(33629, '2001:4860:7:1711::fb', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Windows', '2025-07-25 13:27:47'),
(33631, '37.160.191.226', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-07-25 20:48:28'),
(33633, '20.171.207.253', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', 'Unknown', '2025-07-26 04:40:51'),
(33634, '45.118.159.139', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-07-26 07:42:38'),
(33636, '2a02:9130:9c31:b5a:d49a:91ce:1b06:f3bf', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', 'Apple', '2025-07-26 08:55:13'),
(33637, '176.83.44.57', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', 'Apple', '2025-07-26 09:27:48'),
(33641, '93.34.59.53', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/138.0.7204.119 Mobile/15E148 Safari/604.1', 'Apple', '2025-07-26 10:43:12'),
(33642, '2a00:801:737:eb51:29ad:8f3f:5113:88de', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/378.0.783859256 Mobile/15E148 Safari/604.1', 'Apple', '2025-07-26 12:22:46'),
(33643, '93.38.253.99', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/377.0.781279791 Mobile/15E148 Safari/604.1', 'Apple', '2025-07-26 19:26:55'),
(33644, '93.159.230.84', 'Mozilla/5.0 (Linux; arm_64; Android 12; CPH2205) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 YaBrowser/23.3.3.86.00 SA/3 Mobile Safari/537.36', 'Android Device', '2025-07-26 21:29:09'),
(33646, '20.171.207.93', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', 'Unknown', '2025-07-27 01:41:10'),
(33648, '44.243.222.194', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/113.0.5672.121 Mobile/15E148 Safari/604.1', 'Apple', '2025-07-27 14:53:27'),
(33649, '84.125.103.184', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/138.0.7204.156 Mobile/15E148 Safari/604.1', 'Apple', '2025-07-27 14:53:28'),
(33650, '2001:4860:7:22d::f9', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-07-27 19:13:01'),
(33651, '2001:4860:7:614::f6', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-07-27 19:13:41'),
(33652, '2a02:9130:94a9:77e9:c099:5dff:feff:761d', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-07-27 19:13:45'),
(33653, '2001:4860:7:152d::fe', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-07-27 23:17:10'),
(33655, '80.11.125.233', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', 'Windows', '2025-07-28 06:39:08'),
(33660, '2409:40e4:1351:93b:8000::', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-07-29 07:28:08'),
(33661, '169.61.14.3', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:41.0) Gecko/20100101 Firefox/41.0', 'Windows', '2025-07-29 08:18:25'),
(33662, '49.37.40.16', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', 'Apple', '2025-07-29 09:16:24'),
(33665, '2001:4860:7:b12::ed', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Apple', '2025-07-29 15:02:31'),
(33667, '20.171.207.140', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', 'Unknown', '2025-07-29 19:09:05'),
(33670, '217.171.70.248', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/138.0.7204.156 Mobile/15E148 Safari/604.1', 'Apple', '2025-07-30 11:04:47'),
(33671, '2001:861:4983:1ac0:91a7:aeb2:e10e:8002', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', 'Apple', '2025-07-30 17:30:43'),
(33673, '34.141.254.56', 'Scrapy/2.12.0 (+https://scrapy.org)', 'Unknown', '2025-07-31 02:39:29'),
(33674, '161.35.167.146', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'Unknown', '2025-07-31 07:36:01'),
(33675, '64.227.99.138', 'Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)', 'Unknown', '2025-07-31 08:41:13'),
(33676, '138.197.1.119', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.2 Safari/605.1.15', 'Apple', '2025-07-31 09:52:17'),
(33678, '202.170.91.69', 'Java/1.8.0_322', 'Unknown', '2025-07-31 12:25:50'),
(33679, '150.40.242.182', 'Mozilla/5.0 (Windows NT 6.1; WOW64; Android) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.4544.7 Safari/537.36 HuaweiCrawler', 'Huawei', '2025-07-31 12:25:50'),
(33680, '79.40.153.192', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', 'Apple', '2025-07-31 13:14:28'),
(33681, '2a01:cb01:2036:3a86:35c1:751b:a98e:da29', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/379.0.786762118 Mobile/15E148 Safari/604.1', 'Apple', '2025-07-31 20:51:36'),
(33683, '52.167.144.238', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2025-08-01 07:14:16'),
(33686, '2001:861:4502:1830:94d2:fb3a:6e34:f1e3', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/335.0.676534794 Mobile/15E148 Safari/604.1', 'Apple', '2025-08-01 14:28:53'),
(33687, '2a01:cb1c:e27:5200:b322:e484:639e:6264', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-08-01 15:32:13'),
(33688, '2401:4900:a068:dfcf:cb06:e8f5:fe3c:229b', 'Mozilla/5.0 (Linux; U; Android 11; en-gb; RMX2189 Build/RP1A.200720.011) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.116 Mobile Safari/537.36 HeyTapBrowser/45.8.2.9', 'Android Device', '2025-08-01 17:46:11'),
(33689, '159.65.243.105', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Apple', '2025-08-01 18:22:24'),
(33692, '2001:1308:4300:e4f8:a8b7:7ec7:8aea:709d', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-08-02 21:19:45'),
(33695, '87.250.224.74', 'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)', 'Unknown', '2025-08-02 21:59:42'),
(33696, '185.177.72.144', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36', 'Windows', '2025-08-02 23:05:36'),
(33698, '20.171.207.89', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', 'Unknown', '2025-08-03 03:15:39'),
(33700, '185.177.72.210', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36', 'Windows', '2025-08-03 09:17:42'),
(33702, '2a09:bac2:d36d:18c8::278:2', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', 'Apple', '2025-08-03 14:36:07'),
(33703, '185.177.72.10', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36', 'Windows', '2025-08-03 14:55:58'),
(33704, '138.68.136.65', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'Unknown', '2025-08-03 14:58:46'),
(33705, '17.241.219.68', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Apple', '2025-08-04 03:52:48'),
(33707, '37.161.200.200', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-08-04 07:20:48'),
(33709, '34.91.100.6', 'Scrapy/2.12.0 (+https://scrapy.org)', 'Unknown', '2025-08-04 16:54:08'),
(33711, '3.239.168.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36', 'Windows', '2025-08-04 19:46:35'),
(33712, '104.236.98.177', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', 'Apple', '2025-08-04 23:53:36'),
(33714, '68.183.54.192', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', 'Apple', '2025-08-05 01:04:05'),
(33715, '17.241.75.174', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Apple', '2025-08-05 03:56:21'),
(33716, '134.209.173.235', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', 'Apple', '2025-08-05 05:20:48'),
(33719, '2001:861:4983:1ac0:9cac:7737:fca4:6e', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', 'Apple', '2025-08-05 20:10:10'),
(33721, '18.234.227.75', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36', 'Windows', '2025-08-05 21:43:10'),
(33723, '2001:4860:7:80e::db', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Windows', '2025-08-06 03:15:24'),
(33725, '2a04:ee41:84:d196:c16:6256:6634:f7a', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', 'Apple', '2025-08-06 13:54:42'),
(33726, '2001:4860:7:805::5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Windows', '2025-08-06 15:37:34'),
(33727, '2001:4860:7:805::3f', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Windows', '2025-08-06 15:38:01'),
(33728, '20.171.207.54', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', 'Unknown', '2025-08-06 16:56:15'),
(33729, '90.166.43.37', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/138.0.7204.156 Mobile/15E148 Safari/604.1', 'Apple', '2025-08-06 17:33:15'),
(33730, '91.117.33.86', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', 'Apple', '2025-08-06 17:43:07'),
(33731, '185.177.72.179', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36', 'Windows', '2025-08-06 18:44:19'),
(33732, '2001:4860:7:152d::ff', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-08-06 18:49:06'),
(33733, '2001:4860:7:610::e5', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-08-06 18:49:20'),
(33736, '54.36.148.223', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-08-07 07:39:30'),
(33737, '44.249.166.219', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.25 Safari/537.36 Core/1.70.3704.400 QQBrowser/10.4.3587.400', 'Windows', '2025-08-07 08:29:25'),
(33738, '35.240.186.105', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:89.0) Gecko/20100101 Firefox/89.0', 'Unknown', '2025-08-07 16:22:46'),
(33739, '213.55.247.38', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', 'Apple', '2025-08-07 17:20:45'),
(33740, '5.91.174.227', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/380.0.788317806 Mobile/15E148 Safari/604.1', 'Apple', '2025-08-07 19:33:05'),
(33741, '3.254.185.210', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2025-08-07 20:48:32'),
(33742, '52.51.66.34', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2025-08-07 23:06:33'),
(33745, '78.211.16.49', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-08-08 05:39:37'),
(33751, '45.118.159.33', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Unknown', '2025-08-08 06:56:17'),
(33752, '2409:40d0:29:30e7:8000::', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Unknown', '2025-08-08 15:01:38'),
(33753, '52.167.144.141', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2025-08-08 20:14:00'),
(33756, '79.44.130.43', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', 'Apple', '2025-08-09 19:18:13'),
(33758, '2001:4860:7:c05::f0', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-08-10 07:53:17'),
(33759, '183.83.155.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-08-10 07:53:23'),
(33760, '2001:4860:7:80f::', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-08-10 08:14:09'),
(33762, '91.173.212.169', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', 'Apple', '2025-08-10 13:49:01'),
(33763, '40.77.167.149', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2025-08-10 17:18:47'),
(33766, '168.187.178.170', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Windows', '2025-08-11 07:14:28'),
(33767, '34.252.227.114', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2025-08-11 07:58:33'),
(33768, '37.65.54.167', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/139.0.7258.76 Mobile/15E148 Safari/604.1', 'Apple', '2025-08-11 09:01:55'),
(33771, '193.187.128.76', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/139.0.7258.76 Mobile/15E148 Safari/604.1', 'Apple', '2025-08-11 09:41:20'),
(33773, '31.201.36.130', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/601.2.4 (KHTML, like Gecko) Version/9.0.1 Safari/601.2.4 facebookexternalhit/1.1 Facebot Twitterbot/1.0', 'Apple', '2025-08-11 09:41:34'),
(33774, '52.210.88.38', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2025-08-11 12:27:17'),
(33775, '34.55.42.234', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2025-08-11 20:15:57'),
(33776, '44.248.202.74', 'Mozilla/5.0 (compatible; wpbot/1.3; +https://forms.gle/ajBaxygz9jSR8p8G9)', 'Unknown', '2025-08-11 23:45:24'),
(33779, '34.223.59.98', 'Mozilla/5.0 (compatible; wpbot/1.3; +https://forms.gle/ajBaxygz9jSR8p8G9)', 'Unknown', '2025-08-12 06:56:23'),
(33780, '18.97.9.97', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; PerplexityBot/1.0; +https://perplexity.ai/perplexitybot)', 'Unknown', '2025-08-12 07:05:34'),
(33782, '188.12.189.149', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/139.0.7258.76 Mobile/15E148 Safari/604.1', 'Apple', '2025-08-12 12:03:24'),
(33783, '139.5.242.33', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Unknown', '2025-08-12 12:50:22'),
(33785, '2a02:8440:451d:80a5:c899:aedf:e4be:94f6', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', 'Apple', '2025-08-13 07:42:53'),
(33787, '2a02:8440:450d:8c16:e988:ab0b:8953:4fd8', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'Apple', '2025-08-13 10:50:16'),
(33788, '2001:4860:7:505::fc', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-08-13 14:22:21'),
(33791, '159.65.231.218', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Unknown', '2025-08-14 05:19:53'),
(33793, '151.0.254.80', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-08-14 07:12:38'),
(33795, '2401:4900:88d0:1b2:f07f:78b4:fe23:2a24', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-08-14 10:46:16'),
(33796, '40.77.167.26', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2025-08-14 12:47:36'),
(33797, '2409:40d0:30ba:b1ba:8000::', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-08-14 13:00:42'),
(33798, '34.63.97.164', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2025-08-14 16:09:26'),
(33799, '139.5.248.245', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-08-14 17:29:36'),
(33800, '34.170.66.128', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2025-08-14 18:42:48'),
(33802, '212.22.129.141', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/139.0.7258.76 Mobile/15E148 Safari/604.1', 'Apple', '2025-08-15 06:04:28'),
(33804, '2a02:8440:f50c:e6d0:419d:5deb:4c75:ee28', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', 'Apple', '2025-08-15 17:32:17'),
(33806, '207.46.13.155', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2025-08-16 07:04:42'),
(33813, '107.172.195.89', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Apple', '2025-08-17 03:50:15'),
(33814, '185.195.232.153', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'Windows', '2025-08-17 03:50:17'),
(33817, '2a03:b0c0:3:d0::fae:a001', 'Mozilla/5.0 (Linux; Android 6.0; HTC One M9 Build/MRA58K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.98 Mobile Safari/537.3', 'Android Device', '2025-08-17 03:51:11'),
(33818, '205.169.39.21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.5938.132 Safari/537.36', 'Windows', '2025-08-17 03:52:24'),
(33820, '205.169.39.128', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.79 Safari/537.36', 'Windows', '2025-08-17 03:52:38'),
(33821, '205.169.39.28', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.5938.132 Safari/537.36', 'Windows', '2025-08-17 03:52:42'),
(33822, '34.118.75.217', 'Mozilla/5.0 (iPhone13,2; U; CPU iPhone OS 14_0 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) Version/10.0 Mobile/15E148 Safari/602.1', 'Apple', '2025-08-17 03:52:57'),
(33823, '159.223.163.53', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Unknown', '2025-08-17 04:18:06'),
(33824, '103.4.251.45', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Windows', '2025-08-17 04:31:07'),
(33827, '154.28.229.157', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Windows', '2025-08-17 04:31:24'),
(33828, '107.172.195.102', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36', 'Apple', '2025-08-17 04:45:43'),
(33831, '154.28.229.143', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36', 'Windows', '2025-08-17 04:46:11'),
(33837, '134.122.76.120', 'Mozilla/5.0 (X11; Linux x86_64; rv:139.0) Gecko/20100101 Firefox/139.0', 'Unknown', '2025-08-17 15:04:34'),
(33838, '34.72.51.50', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2025-08-17 15:27:01'),
(33839, '185.239.237.216', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', 'Windows', '2025-08-17 17:29:07'),
(33850, '34.187.164.224', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/114.0.5735.99 Mobile/15E148 Safari/604.1', 'Apple', '2025-08-18 05:49:20'),
(33851, '34.82.53.201', 'Mozilla/5.0 (Linux; Android 12; Pixel 6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-08-18 09:34:50'),
(33853, '34.70.139.221', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2025-08-18 11:02:04'),
(33855, '159.203.133.13', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Apple', '2025-08-18 13:26:25'),
(33857, '20.171.207.229', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', 'Unknown', '2025-08-18 14:27:28'),
(33858, '2001:4860:7:805::ff', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Windows', '2025-08-18 15:15:28'),
(33859, '159.65.41.122', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Apple', '2025-08-18 15:15:34'),
(33861, '83.60.0.75', 'Mozilla/5.0 (iPhone; CPU iPhone OS 19_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0 Mobile/15E148 Safari/604.1', 'Apple', '2025-08-19 06:59:55'),
(33864, '24.144.93.30', 'Mozilla/5.0 (X11; Linux x86_64; rv:139.0) Gecko/20100101 Firefox/139.0', 'Unknown', '2025-08-19 12:52:46'),
(33868, '139.5.242.178', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Unknown', '2025-08-20 05:05:45'),
(33872, '52.167.144.225', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2025-08-21 07:55:12'),
(33873, '2a02:a446:df6f:1:7108:7a9d:828b:8de1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-08-21 12:03:50'),
(33874, '31.186.166.197', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36 OPR/89.0.0.0', 'Android Device', '2025-08-21 12:03:53'),
(33875, '138.197.135.25', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Unknown', '2025-08-21 12:54:58'),
(33879, '146.196.38.231', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-08-22 10:40:11'),
(33882, '2400:c600:5357:8bcd:21ef:410d:709b:8f87', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Windows', '2025-08-22 12:18:20'),
(33883, '106.219.212.188', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-08-22 13:12:28'),
(33884, '95.108.213.212', 'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)', 'Unknown', '2025-08-22 15:10:18'),
(33887, '20.171.207.46', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', 'Unknown', '2025-08-23 11:11:14'),
(33889, '40.77.167.10', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2025-08-23 15:43:15'),
(33892, '103.108.5.162', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Unknown', '2025-08-24 11:22:29'),
(33893, '49.44.81.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Windows', '2025-08-24 11:22:34'),
(33894, '40.77.167.143', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2025-08-24 23:40:32'),
(33897, '43.134.225.208', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36', 'Windows', '2025-08-25 08:58:14'),
(33898, '2001:4860:7:142d::e6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Windows', '2025-08-25 09:37:31'),
(33899, '83.50.172.146', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Windows', '2025-08-25 09:43:40'),
(33903, '103.108.5.110', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Unknown', '2025-08-26 14:27:34'),
(33907, '37.11.48.35', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', 'Apple', '2025-08-27 07:16:16'),
(33910, '5.39.1.247', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-08-28 00:39:48'),
(33913, '103.108.5.40', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Unknown', '2025-08-28 10:19:44'),
(33914, '2401:4900:83af:de31:ea15:5004:2a51:899d', 'WhatsApp/2.23.20.0', 'Unknown', '2025-08-28 10:20:02'),
(33917, '2405:201:5c20:504f:740d:16b8:e616:47eb', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-08-28 10:21:29'),
(33918, '143.244.138.19', 'Mozilla/5.0 (X11; Linux x86_64; rv:139.0) Gecko/20100101 Firefox/139.0', 'Unknown', '2025-08-28 12:47:14'),
(33921, '103.108.5.196', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Unknown', '2025-08-28 17:54:48'),
(33922, '2a01:e0a:4a9:2cc0:4db4:6c9e:3df2:77e9', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/383.0.797833943 Mobile/15E148 Safari/604.1', 'Apple', '2025-08-28 18:27:33'),
(33931, '9.169.121.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.7204.92 Safari/537.36', 'Windows', '2025-08-29 15:54:02'),
(33934, '34.91.212.219', 'Scrapy/2.12.0 (+https://scrapy.org)', 'Unknown', '2025-08-30 15:54:55'),
(33936, '103.108.5.235', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Unknown', '2025-08-30 19:38:08'),
(33937, '209.38.255.250', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Unknown', '2025-08-31 01:59:42'),
(33942, '35.205.205.186', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2025-09-01 11:58:29'),
(33943, '90.166.65.40', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', 'Apple', '2025-09-01 14:04:30'),
(33944, '198.244.226.63', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-09-01 19:42:29'),
(33945, '54.194.161.45', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2025-09-02 01:31:18'),
(33946, '52.215.6.159', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2025-09-02 05:01:47'),
(33949, '103.4.251.100', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36', 'Apple', '2025-09-02 06:03:23'),
(33951, '103.4.250.147', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Unknown', '2025-09-02 06:03:29');
INSERT INTO `visitor_info` (`id`, `ip_address`, `user_agent`, `device_brand`, `visit_time`) VALUES
(33952, '2a03:b0c0:3:d0::402:d001', 'Mozilla/5.0 (Linux; Android 6.0; HTC One M9 Build/MRA58K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.98 Mobile Safari/537.3', 'Android Device', '2025-09-02 07:34:22'),
(33953, '34.125.49.122', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2025-09-02 08:20:00'),
(33956, '172.255.125.169', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36 Edg/131.0.0.0', 'Windows', '2025-09-02 11:48:44'),
(33957, '68.183.245.101', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-09-02 11:48:45'),
(33958, '2400:6180:100:d0::9d64:1', 'Mozilla/5.0 (X11; U; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/115.0.5810.222 Chrome/115.0.5810.222 Safari/537.36', 'Unknown', '2025-09-02 11:48:51'),
(33959, '203.188.183.73', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 open_news/6.3.1.2 JsSdk/2.0 NetType/WIFI (open_news 6.3.1.2 18.500000) FalconTag/', 'Apple', '2025-09-02 11:50:12'),
(33960, '34.150.210.53', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2025-09-02 18:58:15'),
(33961, '34.74.130.181', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2025-09-02 19:16:37'),
(33962, '178.128.165.8', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Unknown', '2025-09-02 21:10:14'),
(33963, '154.26.128.67', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3', 'Windows', '2025-09-02 22:14:45'),
(33966, '79.152.83.119', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', 'Windows', '2025-09-03 11:45:32'),
(33967, '35.190.162.1', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2025-09-03 14:52:16'),
(33969, '34.172.189.29', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4240.193 Safari/537.36', 'Windows', '2025-09-03 18:18:23'),
(33971, '2001:4860:7:c05::a9', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Unknown', '2025-09-04 03:13:17'),
(33976, '2a09:bac2:325e:14e6::215:ec', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Safari/605.1.15', 'Apple', '2025-09-04 11:16:41'),
(33978, '2a09:bac3:325a:1c82::2d7:18', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Safari/605.1.15', 'Apple', '2025-09-04 11:23:38'),
(33980, '34.105.35.114', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4240.193 Safari/537.36', 'Windows', '2025-09-04 11:42:12'),
(33981, '192.178.4.102', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.7204.183 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Android Device', '2025-09-04 17:29:04'),
(33982, '165.227.193.27', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Unknown', '2025-09-04 19:54:04'),
(33983, '78.208.205.137', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/384.1.800981714 Mobile/15E148 Safari/604.1', 'Apple', '2025-09-04 23:08:41'),
(33984, '103.124.105.225', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'Windows', '2025-09-05 01:51:41'),
(33985, '148.253.49.205', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'Apple', '2025-09-05 03:17:14'),
(33986, '101.47.11.150', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.66 Safari/537.36', 'Windows', '2025-09-05 03:17:15'),
(33987, '2001:4860:7:805::4d', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Unknown', '2025-09-05 06:42:59'),
(33989, '2405:204:1107:3f71::733:38a0', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-09-05 08:12:43'),
(33991, '88.149.181.243', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-09-05 13:27:45'),
(33993, '213.37.167.169', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'Apple', '2025-09-05 13:51:25'),
(33994, '178.51.58.123', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'Apple', '2025-09-05 14:11:48'),
(33995, '35.240.252.63', 'Mozilla/5.0 (Linux; Android 5.1.1; SM-J111F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.90 Mobile Safari/537.36', 'Android Device', '2025-09-05 16:13:39'),
(33996, '34.141.189.20', 'Scrapy/2.12.0 (+https://scrapy.org)', 'Unknown', '2025-09-06 03:06:43'),
(33997, '203.192.239.42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Windows', '2025-09-06 05:05:59'),
(33998, '27.115.124.109', 'Mozilla/5.0 (Linux; Android 11; V2055A) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.101 Mobile Safari/537.36', 'Android Device', '2025-09-06 05:06:09'),
(33999, '27.115.124.118', 'Mozilla/5.0 (Linux; U; Android 8.1.0; zh-cn; MI 8 Build/OPM1.171019.011) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/57.0.2987.108 Mobile Safari/537.36', 'Android Device', '2025-09-06 05:06:18'),
(34000, '5.90.146.194', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/372.0.765951532 Mobile/15E148 Safari/604.1', 'Apple', '2025-09-06 06:43:53'),
(34005, '192.64.113.146', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36 Edg/121.0.0.0', 'Apple', '2025-09-06 13:20:06'),
(34006, '154.28.229.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Windows', '2025-09-06 13:20:07'),
(34009, '2a05:9403::5f9', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36', 'Apple', '2025-09-06 13:20:09'),
(34010, '104.164.173.6', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36', 'Unknown', '2025-09-06 13:20:24'),
(34011, '2a03:b0c0:3:d0::1413:d001', 'Mozilla/5.0 (Linux; Android 6.0; HTC One M9 Build/MRA58K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.98 Mobile Safari/537.3', 'Android Device', '2025-09-06 13:21:08'),
(34013, '2a03:b0c0:3:d0::fef:2001', 'Mozilla/5.0 (Linux; Android 6.0; HTC One M9 Build/MRA58K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.98 Mobile Safari/537.3', 'Android Device', '2025-09-06 13:21:09'),
(34015, '134.209.25.199', 'Go-http-client/1.1', 'Unknown', '2025-09-06 13:21:18'),
(34017, '138.68.86.32', 'Go-http-client/1.1', 'Unknown', '2025-09-06 13:21:23'),
(34018, '128.192.12.125', 'Mozilla/5.0 (compatible; UGAResearchAgent/1.0; Please visit: NISLabUGA.github.io)', 'Unknown', '2025-09-06 13:21:43'),
(34020, '2401:4900:88d1:a0b:d66:c53b:f46c:f685', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-09-06 13:34:55'),
(34021, '2401:4900:81f5:77c6:1239:79be:199:449e', 'WhatsApp/2.23.20.0', 'Unknown', '2025-09-06 14:42:48'),
(34024, '217.201.146.10', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'Apple', '2025-09-06 17:22:51'),
(34025, '159.65.180.217', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Unknown', '2025-09-06 20:12:42'),
(34026, '109.202.99.36', 'Go-http-client/1.1', 'Unknown', '2025-09-06 23:52:37'),
(34027, '2409:40d1:d:879e:8000::', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-09-07 04:34:18'),
(34029, '44.251.56.49', 'Mozilla/5.0 (Linux; Android 8.1.0; CPH1823 Build/O11019) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Mobile Safari/537.36', 'Android Device', '2025-09-07 06:34:02'),
(34030, '51.45.2.103', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/536.10 (KHTML, like Gecko) Chrome/25.0.320.80 Safari/535.23', 'Windows', '2025-09-07 07:43:37'),
(34031, '103.108.5.104', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Unknown', '2025-09-07 08:10:13'),
(34033, '188.152.178.188', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/372.0.765951532 Mobile/15E148 Safari/604.1', 'Apple', '2025-09-07 12:49:45'),
(34034, '2401:4900:88d2:c2c7:c5da:2569:90e6:951d', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Unknown', '2025-09-07 12:56:52'),
(34035, '2401:4900:88d2:c2c7:c087:e27a:28d4:6a96', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-09-07 14:12:41'),
(34036, '2001:4860:7:1501::fa', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-09-07 14:43:30'),
(34037, '34.23.19.56', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2025-09-07 18:26:07'),
(34038, '34.6.52.158', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2025-09-07 19:23:32'),
(34041, '91.196.152.229', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0', 'Unknown', '2025-09-08 08:59:22'),
(34042, '2a0c:5a82:730a:7500:112a:e037:6fd8:5b8b', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/384.1.800981714 Mobile/15E148 Safari/604.1', 'Apple', '2025-09-08 09:15:00'),
(34043, '68.221.67.161', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko); compatible; ChatGPT-User/1.0; +https://openai.com/bot', 'Unknown', '2025-09-08 09:19:14'),
(34044, '79.117.14.91', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-09-08 09:58:07'),
(34045, '51.254.49.97', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0', 'Unknown', '2025-09-08 10:29:41'),
(34047, '185.247.137.134', 'Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)', 'Unknown', '2025-09-08 11:29:11'),
(34049, '151.45.174.143', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'Apple', '2025-09-08 17:52:59'),
(34050, '159.203.171.69', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Unknown', '2025-09-08 19:21:09'),
(34051, '77.98.202.208', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Apple', '2025-09-08 21:31:38'),
(34053, '34.168.72.25', 'Mozilla/5.0 (Linux; Android 12; Pixel 6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-09-09 01:12:04'),
(34055, '199.187.211.25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3', 'Windows', '2025-09-09 01:12:10'),
(34057, '103.35.65.45', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36', 'Unknown', '2025-09-09 05:52:22'),
(34068, '34.182.39.108', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/114.0.5735.99 Mobile/15E148 Safari/604.1', 'Apple', '2025-09-09 06:02:33'),
(34070, '34.19.105.249', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4240.193 Safari/537.36', 'Windows', '2025-09-09 09:13:46'),
(34072, '172.213.21.116', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko); compatible; ChatGPT-User/1.0; +https://openai.com/bot', 'Unknown', '2025-09-09 09:43:30'),
(34073, '172.182.195.59', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36; compatible; OAI-SearchBot/1.0; +https://openai.com/searchbot', 'Apple', '2025-09-09 09:44:19'),
(34075, '192.178.4.104', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Unknown', '2025-09-09 22:33:39'),
(34076, '192.178.4.105', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Android Device', '2025-09-09 22:33:43'),
(34077, '2a02:26f7:c9d0:6406:0:7000:0:f', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', 'Apple', '2025-09-10 02:45:23'),
(34078, '128.192.12.122', 'Mozilla/5.0 (compatible; UGAResearchAgent/1.0; Please visit: NISLabUGA.github.io)', 'Unknown', '2025-09-10 06:30:00'),
(34079, '205.169.39.15', 'Mozilla/5.0 (Windows NT 10.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36', 'Windows', '2025-09-10 06:33:22'),
(34082, '188.166.242.55', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4240.193 Safari/537.36', 'Windows', '2025-09-10 09:13:53'),
(34083, '87.250.224.27', 'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)', 'Unknown', '2025-09-10 09:41:31'),
(34085, '34.243.18.28', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2025-09-10 15:21:40'),
(34086, '161.35.79.69', 'Mozilla/5.0 (X11; Linux x86_64; rv:139.0) Gecko/20100101 Firefox/139.0', 'Unknown', '2025-09-10 19:54:20'),
(34087, '34.254.66.235', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2025-09-10 21:09:21'),
(34088, '18.116.73.202', 'curl/8.3.0', 'Unknown', '2025-09-11 00:00:37'),
(34092, '103.108.5.33', 'Wget/1.25.0', 'Unknown', '2025-09-11 08:48:55'),
(34103, '128.199.9.155', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Unknown', '2025-09-11 12:47:28'),
(34104, '52.91.217.203', 'Mozilla/5.0', 'Unknown', '2025-09-12 04:52:26'),
(34131, '103.108.5.107', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Unknown', '2025-09-12 05:29:09'),
(34132, '2001:4860:7:805::3a', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Unknown', '2025-09-12 05:31:20'),
(34133, '92.136.71.16', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-09-12 06:18:35'),
(34137, '199.45.155.79', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'Unknown', '2025-09-13 01:56:02'),
(34139, '35.240.187.117', 'Mozilla/5.0 (Linux; Android 5.1.1; SM-J111F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.90 Mobile Safari/537.36', 'Android Device', '2025-09-13 06:04:48'),
(34140, '2a01:e0a:91d:3080:fcac:abb0:5852:a9e8', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'Apple', '2025-09-13 06:49:29'),
(34141, '106.219.160.32', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-09-13 07:56:15'),
(34143, '162.142.125.114', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'Unknown', '2025-09-13 14:17:59'),
(34145, '43.224.129.133', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-09-14 09:40:55'),
(34146, '146.190.132.181', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Unknown', '2025-09-14 10:01:21'),
(34149, '162.142.125.121', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'Unknown', '2025-09-14 14:59:52'),
(34150, '3.77.43.101', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36', 'Windows', '2025-09-14 21:10:30'),
(34152, '103.108.5.24', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Unknown', '2025-09-15 06:23:48'),
(34156, '2409:40e3:3107:2e9e:8000::', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-09-15 14:25:13'),
(34157, '34.87.189.237', 'Mozilla/5.0 (Linux; Android 5.1.1; SM-J111F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.90 Mobile Safari/537.36', 'Android Device', '2025-09-15 16:48:17'),
(34158, '17.241.227.207', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Apple', '2025-09-15 22:15:09'),
(34164, '44.193.254.10', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 'Windows', '2025-09-17 02:40:19'),
(34169, '2402:e000:62d:3a14::1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-09-18 03:59:50'),
(34172, '35.189.245.197', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4240.193 Safari/537.36', 'Windows', '2025-09-18 08:26:40'),
(34174, '34.22.154.81', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4240.193 Safari/537.36', 'Windows', '2025-09-18 11:02:22'),
(34179, '115.69.254.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Windows', '2025-09-19 02:57:35'),
(34184, '2a01:827:3bbd:8701:355e:1a05:ba21:f86d', 'Mozilla/5.0 (iPhone; CPU iPhone OS 26_0_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/385.0.802777482 Mobile/15E148 Safari/604.1', 'Apple', '2025-09-19 11:43:10'),
(34187, '35.197.145.241', 'Mozilla/5.0 (Linux; Android 5.1.1; SM-J111F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.90 Mobile Safari/537.36', 'Android Device', '2025-09-20 04:20:18'),
(34194, '103.108.5.240', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Unknown', '2025-09-21 09:40:25'),
(34195, '49.44.85.71', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Windows', '2025-09-21 11:59:06'),
(34196, '34.86.16.192', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2025-09-21 16:02:18'),
(34197, '35.185.185.85', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2025-09-21 19:14:36'),
(34202, '77.74.177.118', 'Mozilla/5.0 (Linux; arm_64; Android 12; CPH2205) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 YaBrowser/23.3.3.86.00 SA/3 Mobile Safari/537.36', 'Android Device', '2025-09-23 21:20:39'),
(34204, '2401:4900:a130:bba4:c2f4:f2f0:50f2:969f', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-09-24 06:01:28'),
(34206, '66.249.68.135', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Android Device', '2025-09-24 06:42:21'),
(34207, '2401:4900:a50a:a89a:1d01:c84b:209e:1ed3', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-09-24 07:49:39'),
(34209, '2409:40d0:27:961e:8000::', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-09-24 08:25:14'),
(34211, '35.226.49.30', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4240.193 Safari/537.36', 'Windows', '2025-09-24 11:48:53'),
(34212, '2401:4900:a13a:1d58:d0dc:1cff:fed9:7ee5', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-09-24 13:10:56'),
(34213, '2a01:cb19:8a77:e00:55d6:be8a:8141:69af', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'Apple', '2025-09-24 14:09:34'),
(34214, '54.38.147.75', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-09-24 21:40:17'),
(34216, '198.244.168.150', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-09-25 00:46:34'),
(34218, '134.122.120.128', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Unknown', '2025-09-25 14:40:24'),
(34222, '20.171.207.92', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', 'Unknown', '2025-09-26 11:52:28'),
(34223, '2001:4860:7:b05::cf', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Unknown', '2025-09-26 16:57:19'),
(34225, '138.201.135.169', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/138.0.0.0 Safari/537.36', 'Unknown', '2025-09-26 17:33:59'),
(34226, '2a0b:4142:bbe::2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36', 'Windows', '2025-09-26 19:01:56'),
(34227, '4.196.198.81', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko); compatible; ChatGPT-User/1.0; +https://openai.com/bot', 'Unknown', '2025-09-27 02:10:24'),
(34230, '2a04:cec0:c008:e25e:38bf:c5ff:fe9d:8ce8', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-09-27 13:17:33'),
(34233, '34.78.216.13', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2025-09-28 11:51:47'),
(34234, '67.207.89.98', 'Mozilla/5.0 (X11; Linux x86_64; rv:139.0) Gecko/20100101 Firefox/139.0', 'Unknown', '2025-09-28 12:42:10'),
(34235, '34.124.239.182', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2025-09-28 16:16:36'),
(34236, '17.241.227.195', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Apple', '2025-09-29 02:45:15'),
(34237, '52.187.246.142', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko); compatible; ChatGPT-User/1.0; +https://openai.com/bot', 'Unknown', '2025-09-29 06:52:49'),
(34238, '52.187.246.142', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko); compatible; ChatGPT-User/1.0; +https://openai.com/bot', 'Unknown', '2025-09-29 06:52:49'),
(34241, '35.204.197.107', 'Scrapy/2.13.3 (+https://scrapy.org)', 'Unknown', '2025-09-29 14:00:27'),
(34242, '206.168.34.59', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'Unknown', '2025-09-29 16:19:41'),
(34243, '95.108.213.106', 'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)', 'Unknown', '2025-09-29 19:24:27'),
(34245, '20.194.1.11', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko); compatible; ChatGPT-User/1.0; +https://openai.com/bot', 'Unknown', '2025-09-30 03:28:23'),
(34247, '2409:4085:4e18:da1::2d48:cf0c', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-09-30 14:15:54'),
(34248, '16.176.158.147', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 11_4_3) Gecko/20011204 Firefox/19.0', 'Apple', '2025-10-01 01:15:59'),
(34250, '138.91.30.49', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko); compatible; ChatGPT-User/1.0; +https://openai.com/bot', 'Unknown', '2025-10-01 07:06:37'),
(34252, '51.89.129.27', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-10-01 16:56:43'),
(34255, '54.38.147.148', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-10-02 06:53:53'),
(34256, '91.134.127.24', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36', 'Unknown', '2025-10-02 18:59:56'),
(34264, '67.218.249.183', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Apple', '2025-10-05 15:35:06'),
(34266, '2001:999:710:eb11:f909:644:1427:8491', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_1_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/382.0.794785026 Mobile/15E148 Safari/604.1', 'Apple', '2025-10-06 11:23:33'),
(34268, '34.147.91.161', 'Scrapy/2.13.3 (+https://scrapy.org)', 'Unknown', '2025-10-06 15:23:24'),
(34273, '103.108.5.12', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'Unknown', '2025-10-07 03:28:48'),
(34274, '66.249.68.136', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.7339.207 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Android Device', '2025-10-07 05:37:37'),
(34279, '45.55.151.3', 'Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)', 'Unknown', '2025-10-07 12:31:20'),
(34280, '20.194.157.189', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko); compatible; ChatGPT-User/1.0; +https://openai.com/bot', 'Unknown', '2025-10-07 13:58:10'),
(34283, '198.244.226.108', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-10-08 02:09:52'),
(34284, '68.218.30.113', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko); compatible; ChatGPT-User/1.0; +https://openai.com/bot', 'Unknown', '2025-10-08 08:54:41'),
(34286, '66.249.68.134', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.7339.207 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Android Device', '2025-10-09 02:16:44'),
(34287, '146.190.40.121', 'Mozilla/5.0 (X11; Linux x86_64; rv:139.0) Gecko/20100101 Firefox/139.0', 'Unknown', '2025-10-09 04:07:56'),
(34291, '172.204.16.68', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko); compatible; ChatGPT-User/1.0; +https://openai.com/bot', 'Unknown', '2025-10-09 10:44:34'),
(34292, '95.108.213.109', 'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)', 'Unknown', '2025-10-09 11:15:10'),
(34293, '198.244.183.64', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-10-09 12:04:43'),
(34294, '52.215.219.10', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2025-10-09 13:29:22'),
(34295, '54.229.173.121', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2025-10-09 18:11:10'),
(34297, '2401:4900:83a1:7667:6b42:16bd:10f:420a', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-10-10 08:24:06'),
(34363, '103.58.152.112', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'Windows', '2025-10-11 05:09:29'),
(34368, '2401:4900:88d3:3644:4d2c:1d8f:37ef:63d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'Windows', '2025-10-11 06:23:07'),
(34369, '52.208.37.250', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2025-10-11 08:58:44'),
(34370, '52.49.51.26', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2025-10-11 14:01:42'),
(34371, '2401:4900:81f8:2b70:7dff:ab9b:685d:83f7', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-10-11 15:13:00'),
(34373, '161.35.74.44', 'Mozilla/5.0 (X11; Linux x86_64; rv:139.0) Gecko/20100101 Firefox/139.0', 'Unknown', '2025-10-12 02:13:25'),
(34375, '176.180.88.126', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1', 'Apple', '2025-10-12 13:01:02'),
(34376, '103.55.61.31', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-10-13 00:23:46'),
(34377, '54.229.231.132', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2025-10-13 02:13:47'),
(34379, '103.119.184.21', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-10-13 05:17:56'),
(34380, '34.244.20.103', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2025-10-13 06:05:17'),
(34383, '34.255.1.18', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2025-10-14 01:17:06'),
(34387, '198.244.242.155', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-10-14 08:32:26'),
(34388, '3.249.12.46', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2025-10-14 09:52:04'),
(34393, '103.108.5.139', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'Unknown', '2025-10-14 12:05:32'),
(34395, '44.250.151.146', 'Mozilla/5.0 (compatible; wpbot/1.3; +https://forms.gle/ajBaxygz9jSR8p8G9)', 'Unknown', '2025-10-14 20:23:38'),
(34396, '17.246.15.136', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Apple', '2025-10-14 22:09:00'),
(34398, '44.250.141.238', 'Mozilla/5.0 (compatible; wpbot/1.3; +https://forms.gle/ajBaxygz9jSR8p8G9)', 'Unknown', '2025-10-15 06:29:03'),
(34401, '195.113.172.13', 'Mozilla/5.0 (X11; Linux x86_64; rv:131.0) Gecko/20100101 Firefox/131.0', 'Unknown', '2025-10-15 19:15:35'),
(34402, '103.108.5.208', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'Unknown', '2025-10-16 04:08:03'),
(34405, '17.246.19.8', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Apple', '2025-10-16 13:05:58'),
(34406, '51.89.129.201', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-10-16 15:17:43'),
(34408, '2a02:8424:7766:c601:887d:f987:2f7c:d8b0', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/390.0.817388646 Mobile/15E148 Safari/604.1', 'Apple', '2025-10-17 03:38:57'),
(34410, '106.75.157.207', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'Windows', '2025-10-17 04:30:25'),
(34411, '106.75.177.16', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'Windows', '2025-10-17 04:30:25'),
(34413, '106.75.137.81', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36', 'Windows', '2025-10-17 04:30:49'),
(34414, '103.196.9.41', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Apple', '2025-10-17 04:31:49'),
(34417, '104.164.126.243', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Unknown', '2025-10-17 04:32:16'),
(34420, '104.164.126.202', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Windows', '2025-10-17 05:42:30'),
(34421, '103.4.250.126', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36', 'Unknown', '2025-10-17 05:42:45'),
(34422, '20.171.207.123', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', 'Unknown', '2025-10-17 06:16:16'),
(34423, '34.77.196.86', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2025-10-17 09:44:26'),
(34424, '44.243.113.135', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/109.0', 'Windows', '2025-10-17 10:31:53'),
(34426, '34.143.253.145', 'Mozilla/5.0 (Linux; Android 5.1.1; SM-J111F)', 'Android Device', '2025-10-17 16:54:42'),
(34427, '146.70.22.215', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'Windows', '2025-10-17 21:36:43'),
(34428, '136.117.89.213', 'Mozilla/5.0 (Linux; Android 12; Pixel 6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-10-18 01:03:28'),
(34429, '136.117.251.50', 'Mozilla/5.0 (Linux; Android 12; Pixel 6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-10-18 01:04:33'),
(34430, '34.145.92.62', 'Mozilla/5.0 (Linux; Android 12; Pixel 6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-10-18 01:12:13'),
(34431, '93.158.90.142', 'Mozilla/5.0 (Android 14; Mobile; rv:123.0) Gecko/123.0 Firefox/123', 'Android Device', '2025-10-18 01:17:22'),
(34443, '34.168.236.99', 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/114.0.5735.99 Mobile/15E148 Safari/604.1', 'Apple', '2025-10-18 05:20:21'),
(34445, '47.88.94.28', 'Mozilla/5.0 (Linux; Android 11; M2004J15SC) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Mobile Safari/537.36', 'Android Device', '2025-10-18 08:50:26'),
(34446, '47.88.6.178', 'Mozilla/5.0 (Linux; Android 11; M2004J15SC) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Mobile Safari/537.36', 'Android Device', '2025-10-18 08:50:28'),
(34447, '44.244.173.157', 'Mozilla/5.0 (X11; Fedora; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3178.0 Safari/537.36', 'Unknown', '2025-10-18 09:59:37'),
(34448, '3.104.63.95', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/91.0.4472.124', 'Windows', '2025-10-18 11:15:53'),
(34449, '45.55.81.157', 'Mozilla/5.0 (X11; Linux x86_64; rv:139.0) Gecko/20100101 Firefox/139.0', 'Unknown', '2025-10-18 13:23:51'),
(34465, '141.148.153.213', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1', 'Apple', '2025-10-18 20:19:36'),
(34470, '52.90.11.247', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3', 'Windows', '2025-10-19 08:49:20'),
(34472, '78.213.18.88', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/390.0.817388646 Mobile/15E148 Safari/604.1', 'Apple', '2025-10-19 11:06:14'),
(34473, '136.117.51.29', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2025-10-19 13:35:49'),
(34474, '52.167.144.150', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2025-10-19 15:01:16'),
(34475, '136.117.143.145', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2025-10-19 16:26:58'),
(34478, '202.91.72.72', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36', 'Apple', '2025-10-19 21:37:06'),
(34479, '202.91.72.39', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'Windows', '2025-10-19 21:37:18'),
(34482, '202.91.72.23', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36', 'Apple', '2025-10-19 22:42:21'),
(34483, '202.91.72.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'Windows', '2025-10-19 22:42:31'),
(34484, '3.99.151.131', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/91.0.4472.124', 'Windows', '2025-10-19 23:49:33'),
(34487, '92.222.104.207', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-10-20 07:25:20'),
(34488, '2409:40d0:1012:5782:20d7:5356:782b:3342', 'Mozilla/5.0 (Linux; Android 8.1.0; vivo 1820 Build/O11019) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/123.0.6312.118 Mobile Safari/537.36 VivoBrowser/14.7.2.0', 'Android Device', '2025-10-20 07:30:08'),
(34490, '104.248.122.53', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Unknown', '2025-10-20 12:26:04'),
(34491, '204.76.203.25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.3', 'Windows', '2025-10-20 21:51:59'),
(34492, '103.108.5.31', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'Unknown', '2025-10-21 02:06:48'),
(34494, '2409:40d0:1332:df5a:1f4a:f487:17f9:186', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'Unknown', '2025-10-21 05:49:55'),
(34495, '2a02:6ea0:d33b:2406::12', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-10-21 07:28:06'),
(34496, '103.43.35.199', 'Mozilla/5.0 (Linux; Android 8.1.0; vivo 1820 Build/O11019) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/123.0.6312.118 Mobile Safari/537.36 VivoBrowser/14.7.2.0', 'Android Device', '2025-10-21 10:43:50'),
(34497, '80.64.24.66', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.37 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36', 'Windows', '2025-10-21 21:02:35'),
(34498, '93.159.230.28', 'Mozilla/5.0 (Linux; arm_64; Android 12; CPH2205) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 YaBrowser/23.3.3.86.00 SA/3 Mobile Safari/537.36', 'Android Device', '2025-10-21 21:46:09'),
(34500, '2409:40d0:1399:76e1:dc70:2741:95f4:d662', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'Unknown', '2025-10-22 07:34:44'),
(34501, '34.1.26.69', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'Apple', '2025-10-22 08:57:13'),
(34503, '34.1.25.168', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'Apple', '2025-10-22 14:20:32'),
(34504, '34.1.23.22', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'Apple', '2025-10-23 00:41:14'),
(34505, '137.184.84.179', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Unknown', '2025-10-23 01:03:51'),
(34507, '94.23.188.216', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-10-23 16:19:27'),
(34508, '47.237.51.23', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.85 Safari/537.36', 'Apple', '2025-10-23 23:10:17'),
(34510, '13.218.111.30', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36', 'Windows', '2025-10-23 23:31:21'),
(34517, '2401:4900:1c65:4e00:4820:f99d:69c:ecc8', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-10-24 04:41:05'),
(34525, '34.1.26.228', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'Apple', '2025-10-24 05:16:33'),
(34537, '2405:204:111f:72da::24c2:78ad', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-10-24 11:32:48'),
(34538, '143.198.8.155', 'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.118 Safari/537.36', 'Windows', '2025-10-24 19:48:06'),
(34540, '146.70.185.32', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3', 'Windows', '2025-10-25 01:30:38'),
(34550, '103.108.5.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'Windows', '2025-10-25 06:20:51'),
(34551, '2001:4860:7:405::fa', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'Windows', '2025-10-25 06:22:32'),
(34555, '2405:204:102e:feac::24ab:78a4', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-10-26 07:47:14'),
(34556, '94.23.188.202', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-10-26 09:09:45'),
(34557, '123.6.49.15', 'Mozilla/5.0 (Linux; U; Android 8.1.0; zh-cn; MI 8 Build/OPM1.171019.011) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/57.0.2987.108 Mobile Safari/537.36', 'Android Device', '2025-10-26 11:19:15'),
(34558, '123.6.49.12', 'Mozilla/5.0 (Linux; Android 11; V2055A) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.101 Mobile Safari/537.36', 'Android Device', '2025-10-26 11:19:39'),
(34559, '176.31.139.17', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-10-26 15:30:27'),
(34560, '198.244.226.52', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-10-26 20:22:46'),
(34561, '198.244.240.193', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-10-27 01:17:20'),
(34564, '103.88.223.9', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'Windows', '2025-10-27 13:58:51'),
(34565, '110.225.70.135', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'Windows', '2025-10-27 13:58:57'),
(34566, '191.235.99.93', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko); compatible; ChatGPT-User/1.0; +https://openai.com/bot', 'Unknown', '2025-10-27 15:59:58'),
(34581, '165.154.20.207', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/537.36 (KHTML, like Gecko) CriOS/127.0.6533.136 Mobile/15E148 Safari/537.36', 'Apple', '2025-10-27 19:17:17'),
(34584, '2a03:2880:f802:3::', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Unknown', '2025-10-28 05:48:16'),
(34586, '2409:40d0:28:39cf:e954:3652:7bbf:b850', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-10-28 16:56:03'),
(34587, '34.126.96.180', 'Mozilla/5.0 (Linux; Android 5.1.1; SM-J111F)', 'Android Device', '2025-10-29 01:42:55'),
(34588, '157.55.39.204', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2025-10-29 04:09:50'),
(34591, '51.91.151.213', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Apple', '2025-10-29 08:11:06'),
(34593, '107.172.195.95', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36', 'Unknown', '2025-10-29 12:06:42'),
(34595, '154.28.229.61', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36', 'Apple', '2025-10-29 12:07:13'),
(34596, '2a03:b0c0:1:d0::d83:3001', 'Mozilla/5.0 (Linux; Android 6.0; HTC One M9 Build/MRA58K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.98 Mobile Safari/537.3', 'Android Device', '2025-10-29 12:09:12'),
(34597, '51.81.167.146', 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_1_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.1 Mobile/15E148 Safari/604.1', 'Apple', '2025-10-29 12:09:41'),
(34599, '20.171.207.165', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.2; +https://openai.com/gptbot)', 'Unknown', '2025-10-29 13:46:02'),
(34600, '207.46.13.36', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2025-10-29 14:39:03'),
(34601, '34.141.215.197', 'Scrapy/2.13.3 (+https://scrapy.org)', 'Unknown', '2025-10-29 15:10:03'),
(34602, '34.148.0.0', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2025-10-29 15:40:17'),
(34603, '18.141.225.240', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3', 'Windows', '2025-10-30 04:49:13'),
(34605, '2409:40d0:1008:6737:8000::', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'Unknown', '2025-10-30 06:23:20'),
(34608, '138.197.167.23', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Unknown', '2025-10-30 14:21:22'),
(34609, '34.26.231.8', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2025-10-30 15:22:59'),
(34610, '34.140.198.214', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2025-10-30 16:00:10'),
(34612, '156.67.94.156', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'Unknown', '2025-10-30 21:36:57'),
(34614, '51.89.129.127', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-10-31 09:12:52'),
(34616, '2405:204:1489:13b4::2203:a0a5', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-11-01 03:19:19'),
(34619, '2409:40d6:1087:42b:a96b:677:c28:551b', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-11-01 08:50:52'),
(34620, '188.0.169.149', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', 'Windows', '2025-11-01 08:55:14'),
(34621, '137.184.57.100', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Unknown', '2025-11-01 15:20:09'),
(34622, '40.77.167.78', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2025-11-02 01:50:12'),
(34624, '34.207.84.218', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3', 'Windows', '2025-11-02 19:31:52'),
(34626, '51.75.236.155', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-11-03 15:05:02'),
(34627, '185.213.213.12', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', 'Windows', '2025-11-03 19:53:21'),
(34629, '34.247.182.186', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2025-11-03 23:38:43'),
(34630, '92.222.104.221', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-11-03 23:40:44'),
(34633, '34.38.145.136', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2025-11-04 13:15:01'),
(34634, '34.41.252.107', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2025-11-04 14:41:34'),
(34635, '2a03:2880:f80e:43::', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Unknown', '2025-11-04 17:59:31'),
(34637, '93.159.230.85', 'Mozilla/5.0 (Linux; arm_64; Android 12; CPH2205) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 YaBrowser/23.3.3.86.00 SA/3 Mobile Safari/537.36', 'Android Device', '2025-11-05 04:51:18'),
(34645, '35.193.175.53', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2025-11-05 14:32:26'),
(34646, '34.238.126.90', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3', 'Windows', '2025-11-05 14:55:47'),
(34649, '35.232.196.132', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4240.193 Safari/537.36', 'Windows', '2025-11-05 20:29:44'),
(34650, '2001:4860:7:405::f9', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'Windows', '2025-11-06 04:03:29');
INSERT INTO `visitor_info` (`id`, `ip_address`, `user_agent`, `device_brand`, `visit_time`) VALUES
(34653, '103.108.5.76', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-11-06 04:05:54'),
(34655, '137.184.189.153', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Unknown', '2025-11-06 09:53:19'),
(34656, '103.88.57.45', 'Mozilla/5.0 (iPhone; CPU iPhone OS 26_0_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/393.0.825685754 Mobile/15E148 Safari/604.1', 'Apple', '2025-11-06 12:51:18'),
(34658, '2409:40c4:2030:d355:8000::', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-11-06 16:49:52'),
(34660, '2a03:2880:f80e:e::', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Unknown', '2025-11-07 09:28:21'),
(34661, '205.169.39.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.5938.132 Safari/537.36', 'Windows', '2025-11-07 10:31:24'),
(34662, '3.106.166.181', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/91.0.4472.124', 'Windows', '2025-11-07 18:42:30'),
(34665, '66.249.73.102', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.7390.122 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Android Device', '2025-11-08 13:54:48'),
(34666, '198.244.183.69', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-11-08 22:26:53'),
(34670, '17.241.75.195', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Apple', '2025-11-09 15:32:31'),
(34671, '16.63.25.83', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/91.0.4472.124', 'Windows', '2025-11-10 04:18:08'),
(34673, '103.166.159.131', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-11-10 08:13:24'),
(34674, '94.32.48.169', 'Mozilla/5.0 (iPhone; CPU iPhone OS 26_0_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/139.0.7258.76 Mobile/15E148 Safari/604.1', 'Apple', '2025-11-10 10:32:14'),
(34675, '66.249.73.103', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Android Device', '2025-11-10 10:32:17'),
(34678, '103.108.5.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Windows', '2025-11-10 15:02:42'),
(34679, '2409:40d0:200d:973c:8000::', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-11-11 00:58:07'),
(34681, '35.87.92.76', 'Mozilla/5.0 (compatible; wpbot/1.3; +https://forms.gle/ajBaxygz9jSR8p8G9)', 'Unknown', '2025-11-11 13:28:36'),
(34682, '44.250.184.117', 'Mozilla/5.0 (compatible; wpbot/1.3; +https://forms.gle/ajBaxygz9jSR8p8G9)', 'Unknown', '2025-11-11 15:38:14'),
(34684, '51.195.244.215', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-11-12 12:43:34'),
(34685, '3.9.188.161', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/91.0.4472.124', 'Windows', '2025-11-12 17:04:31'),
(34688, '2a04:cec0:c015:8b71:74dc:5c1d:e559:843b', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', 'Apple', '2025-11-13 02:54:50'),
(34689, '194.103.212.184', 'Mozilla/5.0 (Linux; Android 14; SM-S901B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.6099.280 Mobile Safari/537.36 OPR/80.4.4244.7786', 'Android Device', '2025-11-13 02:59:03'),
(34690, '2a03:2880:f80e:2e::', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Unknown', '2025-11-13 04:34:27'),
(34691, '40.77.167.159', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2025-11-13 05:39:56'),
(34693, '40.77.167.30', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2025-11-13 20:30:58'),
(34695, '56.228.31.94', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/91.0.4472.124', 'Windows', '2025-11-14 18:37:28'),
(34696, '35.181.5.146', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/91.0.4472.124', 'Windows', '2025-11-14 19:19:42'),
(34700, '159.223.55.5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4859.172 Safari/537.36', 'Windows', '2025-11-14 23:30:07'),
(34701, '207.46.13.78', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2025-11-15 01:34:55'),
(34702, '46.137.7.233', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2025-11-15 03:28:35'),
(34704, '45.55.158.168', 'Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)', 'Unknown', '2025-11-15 13:28:38'),
(34707, '103.108.5.9', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Windows', '2025-11-16 03:00:59'),
(34708, '20.191.45.212', 'DuckDuckBot/1.1; (+http://duckduckgo.com/duckduckbot.html)', 'Unknown', '2025-11-16 15:32:40'),
(34709, '51.195.215.249', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-11-16 22:10:28'),
(34710, '207.46.13.51', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2025-11-17 08:05:07'),
(34713, '66.249.73.96', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.7390.122 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Android Device', '2025-11-18 08:26:04'),
(34714, '2a14:7c1::2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.3', 'Windows', '2025-11-18 18:56:57'),
(34715, '51.195.244.55', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-11-19 04:25:06'),
(34720, '103.108.5.123', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Windows', '2025-11-19 13:14:55'),
(34722, '2405:204:1099:3611::1265:68ac', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-11-19 16:51:44'),
(34724, '74.7.241.1', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Unknown', '2025-11-19 21:06:07'),
(34725, '2a03:2880:25ff:59::', 'meta-webindexer/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Unknown', '2025-11-20 04:33:50'),
(34727, '2a03:2880:f80e:3b::', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Unknown', '2025-11-20 07:15:59'),
(34728, '164.90.196.120', 'Mozilla/5.0 (X11; Linux x86_64; rv:139.0) Gecko/20100101 Firefox/139.0', 'Unknown', '2025-11-20 10:34:05'),
(34738, '103.108.5.94', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-11-22 11:07:06'),
(34744, '74.7.242.168', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36; compatible; OAI-SearchBot/1.3; +https://openai.com/searchbot', 'Apple', '2025-11-24 08:10:41'),
(34746, '17.246.15.6', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Apple', '2025-11-24 16:33:07'),
(34747, '2401:4900:884b:f85d:88ab:4bcf:1d07:8b2f', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-11-25 02:43:32'),
(34748, '34.10.220.158', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2224.3 Safari/537.36', 'Windows', '2025-11-25 03:46:24'),
(34754, '103.108.5.118', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Windows', '2025-11-25 09:36:46'),
(34755, '54.214.52.21', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/91.0.4472.124', 'Windows', '2025-11-25 18:20:43'),
(34759, '40.77.167.74', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2025-11-26 07:57:25'),
(34762, '103.108.5.127', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Windows', '2025-11-27 09:37:43'),
(34763, '198.244.242.136', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-11-28 01:32:32'),
(34765, '54.38.147.26', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-11-28 07:26:07'),
(34766, '3.92.179.178', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/91.0.4472.124', 'Windows', '2025-11-28 18:49:22'),
(34767, '37.59.204.133', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-11-28 23:31:56'),
(34769, '13.211.162.190', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/91.0.4472.124', 'Windows', '2025-11-29 17:49:56'),
(34771, '13.48.192.52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/91.0.4472.124', 'Windows', '2025-11-30 01:32:48'),
(34772, '103.108.5.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Windows', '2025-11-30 03:26:56'),
(34774, '2405:204:10a9:fea6::2344:28b1', 'Mozilla/5.0 (Linux; Android 8.1.0; vivo 1820 Build/O11019) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/123.0.6312.118 Mobile Safari/537.36 VivoBrowser/15.0.0.0', 'Android Device', '2025-12-01 06:09:54'),
(34776, '103.108.5.207', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-12-02 02:02:39'),
(34779, '2a03:2880:f800:37::', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Unknown', '2025-12-03 12:47:12'),
(34781, '68.183.87.109', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Unknown', '2025-12-04 11:01:23'),
(34782, '103.108.5.135', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Windows', '2025-12-04 11:31:50'),
(34786, '202.91.72.9', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36', 'Windows', '2025-12-05 00:03:41'),
(34788, '198.244.168.167', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-12-05 02:50:59'),
(34791, '66.249.75.194', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.7390.122 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Android Device', '2025-12-05 12:05:29'),
(34792, '66.249.75.196', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.7390.122 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Android Device', '2025-12-05 14:33:03'),
(34793, '2401:4900:884a:21fb:f0be:d201:8f81:3621', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-12-06 00:11:44'),
(34794, '198.244.168.53', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-12-06 05:27:08'),
(34798, '157.66.144.49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Windows', '2025-12-06 16:32:46'),
(34799, '2401:4900:81ea:2881:8a5:40ff:fe8f:85', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-12-06 16:41:44'),
(34800, '5.161.205.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36', 'Windows', '2025-12-06 22:05:37'),
(34804, '66.249.75.195', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.7390.122 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Android Device', '2025-12-07 22:38:33'),
(34807, '152.56.134.129', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Android Device', '2025-12-08 16:04:21'),
(34810, '3.255.154.140', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2025-12-10 00:58:57'),
(34811, '2405:201:5c20:5812:25a9:cd51:a3b8:7091', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-12-10 06:27:05'),
(34813, '52.167.144.209', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2025-12-10 08:25:07'),
(34814, '2a03:2880:f800:17::', 'meta-externalagent/1.1 (+https://developers.facebook.com/docs/sharing/webmasters/crawler)', 'Unknown', '2025-12-10 10:24:01'),
(34817, '103.108.5.59', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Windows', '2025-12-10 13:32:46'),
(34820, '54.78.28.56', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2025-12-11 05:04:14'),
(34822, '103.108.5.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Windows', '2025-12-11 05:19:36'),
(34823, '103.108.5.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Windows', '2025-12-11 07:26:30'),
(34825, '198.244.242.137', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-12-11 07:55:00'),
(34827, '3.82.163.255', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36', 'Windows', '2025-12-11 10:27:30'),
(34829, '35.159.70.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36 Assetnote/1.0.0', 'Windows', '2025-12-11 18:55:02'),
(34830, '52.167.144.23', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2025-12-12 10:02:50'),
(34835, '103.108.5.146', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Windows', '2025-12-12 15:05:02'),
(34837, '157.55.39.203', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2025-12-13 05:05:25'),
(34839, '216.73.216.6', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; ClaudeBot/1.0; +claudebot@anthropic.com)', 'Unknown', '2025-12-13 21:10:06'),
(34843, '103.108.5.91', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Windows', '2025-12-14 12:06:20'),
(34845, '74.7.241.42', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Unknown', '2025-12-16 00:06:01'),
(34847, '128.192.12.100', 'Mozilla/5.0 (compatible; UGAResearchAgent/1.0; Please visit: NISLabUGA.github.io)', 'Unknown', '2025-12-16 05:22:44'),
(34848, '205.169.39.17', 'Mozilla/5.0 (Windows NT 10.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36', 'Windows', '2025-12-16 05:22:53'),
(34849, '34.173.119.122', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0 Safari/537.36', 'Unknown', '2025-12-16 07:36:21'),
(34851, '193.19.82.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36', 'Windows', '2025-12-16 09:23:10'),
(34852, '34.23.101.142', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2025-12-16 14:47:28'),
(34853, '149.88.22.132', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'Windows', '2025-12-16 18:24:52'),
(34854, '66.249.77.231', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.7390.122 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Android Device', '2025-12-16 23:43:18'),
(34856, '66.249.77.229', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Unknown', '2025-12-16 23:43:36'),
(34858, '46.6.245.147', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_6_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/398.0.839721620 Mobile/15E148 Safari/604.1', 'Apple', '2025-12-17 00:27:06'),
(34860, '18.212.182.85', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36 Assetnote/1.0.0', 'Windows', '2025-12-17 01:16:12'),
(34862, '52.47.143.118', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36 Assetnote/1.0.0', 'Windows', '2025-12-17 05:03:00'),
(34864, '54.227.205.118', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36', 'Windows', '2025-12-17 05:51:48'),
(34865, '54.202.103.84', 'Mozilla/5.0 (X11; Linux i686; rv:124.0) Gecko/20100101 Firefox/124.0', 'Unknown', '2025-12-17 09:27:39'),
(34866, '34.16.113.1', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2025-12-17 10:04:44'),
(34867, '104.164.173.64', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36', 'Windows', '2025-12-17 12:27:03'),
(34868, '104.164.173.84', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Unknown', '2025-12-17 12:27:05'),
(34869, '154.28.229.148', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Apple', '2025-12-17 13:08:07'),
(34871, '104.164.126.188', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Apple', '2025-12-17 13:08:34'),
(34872, '52.167.144.230', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2025-12-17 13:35:24'),
(34874, '154.28.229.137', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Windows', '2025-12-17 13:49:16'),
(34876, '104.252.191.107', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36', 'Apple', '2025-12-17 13:49:31'),
(34877, '167.99.200.40', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Unknown', '2025-12-17 15:16:22'),
(34878, '198.244.226.40', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-12-17 16:23:30'),
(34879, '34.182.105.235', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2025-12-17 16:56:12'),
(34880, '44.197.205.108', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.92 Safari/537.36', 'Windows', '2025-12-17 21:09:17'),
(34881, '3.137.156.36', 'Mozilla/5.0 (X11; Linux i686; rv:124.0) Gecko/20100101 Firefox/124.0', 'Unknown', '2025-12-18 00:25:10'),
(34883, '18.184.186.215', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36 Assetnote/1.0.0', 'Windows', '2025-12-18 01:38:24'),
(34884, '104.164.173.96', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Apple', '2025-12-18 03:04:37'),
(34886, '104.164.173.221', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Unknown', '2025-12-18 03:04:49'),
(34888, '104.164.173.50', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Windows', '2025-12-18 04:01:17'),
(34890, '104.164.126.95', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Windows', '2025-12-18 04:01:40'),
(34892, '54.93.199.230', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36 Assetnote/1.0.0', 'Windows', '2025-12-18 06:24:58'),
(34893, '104.252.191.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Windows', '2025-12-18 06:28:06'),
(34895, '104.164.126.112', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36', 'Windows', '2025-12-18 06:28:27'),
(34896, '167.172.137.5', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Unknown', '2025-12-18 09:45:17'),
(34898, '35.227.61.63', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2025-12-18 15:44:25'),
(34902, '134.199.149.230', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36', 'Windows', '2025-12-18 18:25:01'),
(34903, '34.82.60.109', 'Mozilla/5.0 (Linux; Android 12; Pixel 6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-12-18 19:53:36'),
(34904, '35.185.208.135', 'Mozilla/5.0 (Linux; Android 12; Pixel 6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-12-18 19:58:40'),
(34906, '142.93.223.75', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Unknown', '2025-12-19 13:40:58'),
(34908, '98.91.174.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36 Assetnote/1.0.0', 'Windows', '2025-12-20 02:45:22'),
(34911, '154.28.229.213', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36', 'Apple', '2025-12-20 05:16:35'),
(34913, '107.172.195.41', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36', 'Windows', '2025-12-20 05:16:38'),
(34915, '35.94.165.244', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36 Assetnote/1.0.0', 'Windows', '2025-12-20 10:20:41'),
(34917, '18.216.116.206', 'curl/8.3.0', 'Unknown', '2025-12-21 11:39:04'),
(34918, '137.135.190.251', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko); compatible; ChatGPT-User/1.0; +https://openai.com/bot', 'Unknown', '2025-12-21 12:39:44'),
(34919, '54.38.147.215', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-12-21 18:49:01'),
(34923, '54.38.147.199', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2025-12-23 19:20:50'),
(34924, '44.244.126.184', 'Mozilla/5.0 (compatible; wpbot/1.3; +https://forms.gle/ajBaxygz9jSR8p8G9)', 'Unknown', '2025-12-23 19:42:42'),
(34927, '35.206.142.164', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36', 'Windows', '2025-12-24 08:04:59'),
(34931, '52.200.109.58', 'Mozilla/5.0 (X11; Linux i686; rv:124.0) Gecko/20100101 Firefox/124.0', 'Unknown', '2025-12-27 07:16:01'),
(34935, '66.249.77.167', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Android Device', '2025-12-28 21:13:34'),
(34937, '66.249.77.166', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.7390.122 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Android Device', '2025-12-29 01:46:08'),
(34939, '2405:204:30ad:4b4::1331:60b1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Mobile Safari/537.36', 'Android Device', '2025-12-29 04:28:28'),
(34944, '103.108.5.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Windows', '2025-12-31 11:01:36'),
(34946, '207.46.13.52', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2026-01-01 04:39:47'),
(34948, '159.203.162.156', 'Mozilla/5.0 (X11; Linux x86_64; rv:139.0) Gecko/20100101 Firefox/139.0', 'Unknown', '2026-01-01 09:49:27'),
(34949, '192.71.12.156', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Agency/93.8.2357.5', 'Windows', '2026-01-01 22:04:46'),
(34951, '34.90.249.5', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2026-01-02 20:23:11'),
(34952, '54.229.232.235', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2026-01-03 01:43:49'),
(34955, '37.59.204.137', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2026-01-05 00:31:49'),
(34956, '2401:4900:385d:31e5:95c3:60ff:e728:79c0', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Mobile Safari/537.36', 'Android Device', '2026-01-05 02:49:44'),
(34959, '119.252.211.198', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.2 Safari/605.1.15', 'Apple', '2026-01-05 14:43:19'),
(34960, '34.48.118.0', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2026-01-05 16:35:38'),
(34961, '5.39.109.183', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2026-01-05 19:21:36'),
(34963, '34.71.47.248', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2026-01-06 16:59:17'),
(34965, '54.92.235.5', 'python-requests/2.32.5', 'Unknown', '2026-01-06 22:03:56'),
(34967, '52.167.144.167', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2026-01-07 16:48:17'),
(34972, '52.167.144.192', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2026-01-09 08:31:48'),
(34973, '3.252.222.148', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2026-01-09 09:00:52'),
(34974, '102.52.43.162', 'Opera/9.86.(Windows CE; lo-LA) Presto/2.9.186 Version/12.00', 'Windows', '2026-01-09 22:14:28'),
(34975, '64.15.129.122', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Windows', '2026-01-10 07:00:37'),
(34976, '192.175.111.240', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Windows', '2026-01-10 07:00:38'),
(34977, '192.175.111.231', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Windows', '2026-01-10 07:00:42'),
(34978, '64.15.129.108', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Windows', '2026-01-10 07:00:43'),
(34979, '64.15.129.104', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Windows', '2026-01-10 07:00:44'),
(34981, '51.195.244.106', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2026-01-10 19:03:19'),
(34982, '207.46.13.6', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2026-01-11 03:54:01'),
(34984, '139.5.248.132', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Mobile Safari/537.36', 'Android Device', '2026-01-11 16:32:04'),
(34988, '157.55.39.57', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2026-01-13 08:19:27'),
(34989, '35.84.199.114', 'Mozilla/5.0 (compatible; wpbot/1.4; +https://forms.gle/ajBaxygz9jSR8p8G9)', 'Unknown', '2026-01-13 18:47:14'),
(34990, '191.5.121.57', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:121.0) Gecko/20100101 Firefox/121.0', 'Windows', '2026-01-13 19:04:10'),
(34995, '40.77.167.152', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2026-01-16 12:01:58'),
(35003, '139.5.248.221', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Windows', '2026-01-18 16:47:25'),
(35005, '40.77.167.44', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2026-01-19 08:39:22'),
(35006, '147.185.132.42', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'Unknown', '2026-01-20 05:06:07'),
(35009, '74.7.227.155', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'Unknown', '2026-01-20 13:03:08'),
(35011, '95.108.213.192', 'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)', 'Unknown', '2026-01-21 20:10:15'),
(35012, '3.18.186.238', 'air.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36', 'Apple', '2026-01-21 21:38:27'),
(35013, '106.222.168.69', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Mobile Safari/537.36', 'Android Device', '2026-01-22 03:51:55'),
(35021, '172.204.16.78', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko); compatible; ChatGPT-User/1.0; +https://openai.com/bot', 'Unknown', '2026-01-25 10:34:33'),
(35022, '172.204.16.78', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko); compatible; ChatGPT-User/1.0; +https://openai.com/bot', 'Unknown', '2026-01-25 10:34:33'),
(35023, '18.219.251.114', 'curl/8.3.0', 'Unknown', '2026-01-25 21:51:34'),
(35025, '52.167.144.187', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2026-01-26 13:15:13'),
(35027, '51.89.129.87', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2026-01-28 00:22:49'),
(35029, '52.167.144.204', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2026-01-28 01:58:27'),
(35030, '198.244.168.80', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2026-01-28 12:55:08'),
(35032, '157.245.119.238', 'Mozilla/5.0 (X11; Linux x86_64; rv:142.0) Gecko/20100101 Firefox/142.0', 'Unknown', '2026-01-29 11:57:52'),
(35033, '40.77.167.13', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2026-01-29 14:16:26'),
(35035, '173.214.176.97', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Windows', '2026-01-30 03:39:56'),
(35039, '40.77.167.48', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2026-02-01 16:53:49'),
(35041, '54.38.147.116', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2026-02-03 01:10:00'),
(35042, '104.164.173.110', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36', 'Windows', '2026-02-03 03:39:16'),
(35045, '2409:40e1:3445:a725:6cc1:30ff:feb7:a7ed', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36', 'Android Device', '2026-02-03 13:48:42'),
(35047, '52.167.144.149', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2026-02-04 18:16:16'),
(35049, '66.249.69.71', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Android Device', '2026-02-05 21:16:27'),
(35050, '66.249.69.70', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Unknown', '2026-02-05 21:16:28'),
(35052, '40.77.167.243', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2026-02-06 07:43:53'),
(35053, '84.247.60.216', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Windows', '2026-02-06 08:42:26'),
(35055, '5.255.231.2', 'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)', 'Unknown', '2026-02-07 07:38:13'),
(35056, '2401:4900:8087:1c42:14db:5bff:febe:3d4b', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36', 'Android Device', '2026-02-07 10:51:28'),
(35057, '40.77.167.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2026-02-07 23:16:57'),
(35062, '2401:4900:8087:1c42:4078:15ff:fe95:54b5', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36', 'Android Device', '2026-02-09 15:49:15'),
(35063, '37.59.204.131', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2026-02-09 22:40:00'),
(35064, '18.201.158.222', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2026-02-09 22:59:17'),
(35067, '66.249.69.64', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.7559.132 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Android Device', '2026-02-10 13:40:57'),
(35068, '44.242.148.56', 'Mozilla/5.0 (compatible; wpbot/1.4; +https://forms.gle/ajBaxygz9jSR8p8G9)', 'Unknown', '2026-02-10 15:58:07'),
(35069, '52.167.144.202', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2026-02-11 07:33:21'),
(35070, '95.108.213.79', 'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)', 'Unknown', '2026-02-11 08:42:23'),
(35072, '136.115.209.97', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2026-02-11 18:49:38'),
(35074, '159.203.107.232', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Unknown', '2026-02-12 11:18:35'),
(35076, '195.201.168.79', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'Windows', '2026-02-12 20:36:59'),
(35078, '166.88.69.182', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Apple', '2026-02-13 11:43:16'),
(35079, '159.148.54.105', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Apple', '2026-02-13 11:53:38'),
(35080, '3.249.7.122', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2026-02-13 13:14:44'),
(35081, '35.239.228.252', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2026-02-13 15:47:41'),
(35083, '2a03:b0c0:3:d0::14a4:1001', 'Mozilla/5.0 (l9scan/2.0.33a366438336a3836626a303a353733313a31313a303837343a323031623; +https://leakix.net)', 'Unknown', '2026-02-14 03:30:48'),
(35084, '2804:6418:4000:d5cc:be24:11ff:fe8f:419a', 'Go-http-client/1.1', 'Unknown', '2026-02-14 03:33:25'),
(35086, '154.28.229.151', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Windows', '2026-02-14 03:47:43'),
(35088, '154.28.229.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36', 'Windows', '2026-02-14 03:48:07'),
(35089, '91.231.89.103', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0', 'Unknown', '2026-02-14 04:01:21'),
(35090, '54.146.147.52', 'axios/1.13.5', 'Unknown', '2026-02-14 04:23:19'),
(35092, '104.164.173.182', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36', 'Apple', '2026-02-14 04:34:31'),
(35094, '107.172.195.118', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Unknown', '2026-02-14 04:34:49'),
(35098, '2401:4900:3b15:1fac:90b3:5bff:fe86:4b48', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Android Device', '2026-02-14 05:57:28'),
(35099, '2607:5300:205:200::5542', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36 Vivaldi/6.1.3035.300', 'Windows', '2026-02-14 06:04:52'),
(35100, '216.73.216.4', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; ClaudeBot/1.0; +claudebot@anthropic.com)', 'Unknown', '2026-02-14 06:28:27'),
(35101, '2401:4900:81f5:37d8:48ea:dff:fed0:bf9', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36', 'Android Device', '2026-02-14 17:21:21'),
(35102, '35.91.179.129', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; Amazing-SearchBot/0.1; +https://amazing.com/bot.html) Chrome/119.0.6045.214 Safari/537.36', 'Unknown', '2026-02-15 03:28:03'),
(35104, '174.138.74.45', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Apple', '2026-02-15 09:32:28'),
(35105, '45.55.251.229', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Unknown', '2026-02-15 14:31:57'),
(35106, '34.219.25.169', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; Amazing-SearchBot/0.1; +https://amazing.com/bot.html) Chrome/119.0.6045.214 Safari/537.36', 'Unknown', '2026-02-16 05:21:34'),
(35108, '2401:4900:73ec:21da:20f9:98ff:fe66:af03', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Android Device', '2026-02-16 06:32:43'),
(35110, '2401:4900:73e2:40b9:f4c2:b76f:b331:ff04', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36', 'Android Device', '2026-02-16 15:02:42'),
(35111, '18.222.252.142', 'curl/8.3.0', 'Unknown', '2026-02-16 20:42:03'),
(35113, '143.244.186.29', 'Mozilla/5.0 (X11; Linux x86_64; rv:142.0) Gecko/20100101 Firefox/142.0', 'Unknown', '2026-02-17 12:25:11'),
(35116, '104.252.191.221', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Unknown', '2026-02-18 04:30:13'),
(35118, '103.4.251.101', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36', 'Apple', '2026-02-18 04:30:19'),
(35119, '34.26.93.59', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2026-02-18 06:11:48'),
(35120, '3.16.108.157', 'curl/8.3.0', 'Unknown', '2026-02-18 13:37:10'),
(35122, '203.218.5.171', 'Mozilla/5.0', 'Unknown', '2026-02-19 01:58:03'),
(35124, '4.240.76.171', 'Mozilla/5.0', 'Unknown', '2026-02-19 04:13:42'),
(35126, '23.88.44.245', 'Mozilla/5.0', 'Unknown', '2026-02-19 06:17:29'),
(35127, '34.29.65.84', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2026-02-19 08:05:27'),
(35129, '34.55.163.137', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2026-02-19 11:07:02'),
(35130, '2a07:e05:3:2c::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', 'Apple', '2026-02-19 14:08:55'),
(35131, '17.246.23.197', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Apple', '2026-02-19 17:07:16'),
(35136, '2402:3a80:43e5:54e3:596e:c732:8d7c:fe93', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36', 'Android Device', '2026-02-20 05:33:21'),
(35138, '139.5.248.249', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Android Device', '2026-02-20 17:29:57'),
(35139, '142.44.220.162', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2026-02-20 20:20:03'),
(35140, '49.36.123.75', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Windows', '2026-02-20 21:25:02'),
(35141, '2602:fb54:1200::16e', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36', 'Windows', '2026-02-20 22:27:30'),
(35143, '2a07:e05:3:11::1', 'Mozilla/5.0 (Linux; Android 14; Pixel 8) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Mobile Safari/537.36', 'Android Device', '2026-02-21 19:04:42'),
(35147, '167.114.139.66', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2026-02-22 09:57:50'),
(35150, '98.88.203.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.122 Safari/537.36', 'Windows', '2026-02-25 03:53:28'),
(35152, '2803:7d80:a014:13:7a2b:928f:bf5d:cd5e', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/139.0.7258.5 Safari/537.36', 'Unknown', '2026-02-25 09:32:19'),
(35153, '2803:7d80:a014:13:d252:e8dd:c1b8:9928', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/139.0.7258.5 Safari/537.36', 'Unknown', '2026-02-25 10:43:26'),
(35155, '143.198.169.95', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Unknown', '2026-02-26 12:28:14'),
(35156, '54.39.6.2', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2026-02-26 14:39:05'),
(35157, '45.151.161.142', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Apple', '2026-02-27 08:15:51'),
(35159, '34.69.165.18', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2026-02-27 16:06:24'),
(35161, '35.204.190.106', 'Scrapy/2.13.4 (+https://scrapy.org)', 'Unknown', '2026-02-28 07:43:50'),
(35162, '82.29.223.242', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Windows', '2026-02-28 14:30:00'),
(35164, '38.154.200.154', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Apple', '2026-03-01 16:48:06'),
(35166, '2401:4900:3c92:875f:ad30:d398:386d:3d57', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36', 'Android Device', '2026-03-02 04:10:45'),
(35168, '17.241.227.254', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)', 'Apple', '2026-03-02 20:18:40'),
(35176, '37.59.204.139', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2026-03-05 05:30:22'),
(35180, '34.122.101.12', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2026-03-06 15:16:45'),
(35181, '34.254.159.16', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2026-03-06 21:43:03'),
(35187, '108.130.131.126', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'Apple', '2026-03-08 08:58:45'),
(35188, '157.55.39.63', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2026-03-08 13:52:46'),
(35190, '85.254.130.199', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Apple', '2026-03-09 17:05:04'),
(35191, '204.93.209.220', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.2 Safari/605.1.15', 'Apple', '2026-03-09 17:05:04'),
(35192, '154.29.237.174', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Apple', '2026-03-09 17:05:05'),
(35194, '18.246.19.212', 'Mozilla/5.0 (compatible; wpbot/1.4; +https://forms.gle/ajBaxygz9jSR8p8G9)', 'Unknown', '2026-03-10 14:42:40'),
(35195, '2605:a140:2307:7067::1', 'python-requests/2.31.0', 'Unknown', '2026-03-10 17:17:58'),
(35197, '54.39.0.60', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2026-03-11 09:00:14'),
(35198, '18.117.90.85', 'curl/8.3.0', 'Unknown', '2026-03-11 13:53:47'),
(35199, '108.130.201.48', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2026-03-12 03:18:15'),
(35201, '46.101.218.115', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Unknown', '2026-03-12 08:28:05'),
(35202, '3.249.45.152', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2026-03-12 23:46:55'),
(35204, '110.235.228.245', 'Mozilla/5.0 (Linux; Android 7.0) AppleWebKit/531.1 (KHTML, like Gecko) Chrome/23.0.841.0 Safari/531.1', 'Android Device', '2026-03-13 18:33:55'),
(35205, '90.212.216.106', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_5_1) AppleWebKit/536.0 (KHTML, like Gecko) Chrome/53.0.856.0 Safari/536.0', 'Apple', '2026-03-14 01:13:35'),
(35207, '40.77.167.136', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2026-03-14 17:19:15'),
(35208, '2a14:7c1:400::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.3', 'Windows', '2026-03-14 20:39:17'),
(35214, '51.195.183.117', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2026-03-17 11:55:53'),
(35216, '34.28.203.153', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Windows', '2026-03-18 09:53:53'),
(35217, '2001:4860:7:405::eb', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Windows', '2026-03-18 15:12:56'),
(35220, '4.196.118.123', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko); compatible; ChatGPT-User/1.0; +https://openai.com/bot', 'Unknown', '2026-03-19 09:08:18'),
(35221, '74.7.229.18', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36; compatible; OAI-SearchBot/1.3; +https://openai.com/searchbot', 'Apple', '2026-03-19 09:16:45'),
(35222, '51.89.129.120', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2026-03-19 09:30:42'),
(35223, '2402:8100:3116:632d:9d53:91c6:6b05:a911', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Windows', '2026-03-20 05:32:50'),
(35227, '20.227.140.35', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko); compatible; ChatGPT-User/1.0; +https://openai.com/bot', 'Unknown', '2026-03-21 06:51:39'),
(35228, '20.227.140.33', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko); compatible; ChatGPT-User/1.0; +https://openai.com/bot', 'Unknown', '2026-03-21 06:51:41'),
(35231, '103.160.27.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', 'Windows', '2026-03-22 15:05:22');
INSERT INTO `visitor_info` (`id`, `ip_address`, `user_agent`, `device_brand`, `visit_time`) VALUES
(35232, '103.108.5.250', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Windows', '2026-03-22 15:32:35'),
(35236, '198.244.168.241', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2026-03-23 15:12:51'),
(35238, '66.249.72.236', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.7680.153 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Android Device', '2026-03-24 22:34:04'),
(35241, '157.230.183.191', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Unknown', '2026-03-26 07:16:16'),
(35244, '192.71.126.27', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:123.0) Gecko/20100101 Firefox/123', 'Windows', '2026-03-28 20:04:03'),
(35246, '198.244.168.72', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2026-03-29 15:14:11'),
(35251, '51.195.244.79', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2026-03-31 17:51:17'),
(35255, '3.254.150.172', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2026-04-03 20:33:35'),
(35257, '37.59.204.151', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2026-04-04 21:50:41'),
(35259, '2409:40c1:1017:8b69:5da2:737e:b2c6:3d3', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Mobile Safari/537.36', 'Android Device', '2026-04-05 05:45:01'),
(35262, '2a09:bac3:3130:191::28:157', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.2 Mobile/15E148 Safari/604.1', 'Apple', '2026-04-06 14:33:38'),
(35264, '14.232.208.159', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36', 'Android Device', '2026-04-07 12:17:39'),
(35265, '44.250.183.197', 'Mozilla/5.0 (compatible; wpbot/1.4; +https://forms.gle/ajBaxygz9jSR8p8G9)', 'Unknown', '2026-04-07 13:22:20'),
(35266, '2a09:bac3:3131:37d::59:45', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.2 Mobile/15E148 Safari/604.1', 'Apple', '2026-04-07 19:37:11'),
(35268, '74.125.216.235', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.96 Mobile Safari/537.36 (compatible; Google-Safety; +http://www.google.com/bot.html)', 'Android Device', '2026-04-08 08:38:32'),
(35271, '103.215.74.185', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36', 'Windows', '2026-04-08 10:13:28'),
(35273, '134.122.18.200', 'Mozilla/5.0 (X11; Linux x86_64; rv:142.0) Gecko/20100101 Firefox/142.0', 'Unknown', '2026-04-09 04:50:17'),
(35276, '2a02:4780:5e:59e9::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36', 'Windows', '2026-04-09 16:18:23'),
(35277, '34.244.1.219', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2026-04-10 06:43:53'),
(35283, '2001:4860:7:505::f6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Windows', '2026-04-11 07:04:20'),
(35287, '103.108.5.247', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Windows', '2026-04-11 08:03:18'),
(35289, '52.167.144.206', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2026-04-12 20:50:37'),
(35291, '103.108.5.29', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Windows', '2026-04-13 14:43:57'),
(35293, '2409:40c4:2032:1686:9802:b63d:5384:15e8', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Unknown', '2026-04-14 14:14:55'),
(35294, '82.78.98.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36', 'Windows', '2026-04-14 14:46:38'),
(35298, '2a03:b0c0:3:d0::34e:b001', 'Mozilla/5.0 (l9scan/2.0.33a366438336a3836626a303a353733313a31313a303837343a323031623; +https://leakix.net)', 'Unknown', '2026-04-15 02:41:14'),
(35301, '195.164.49.144', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', 'Android Device', '2026-04-15 05:21:57'),
(35303, '216.73.216.219', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; ClaudeBot/1.0; +claudebot@anthropic.com)', 'Unknown', '2026-04-15 05:48:02'),
(35305, '2401:4900:7051:64fd:c822:e6d4:90fc:9913', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Windows', '2026-04-15 06:03:10'),
(35306, '133.242.174.119', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'Android Device', '2026-04-15 08:11:47'),
(35307, '34.173.73.235', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2026-04-15 14:53:52'),
(35309, '34.83.197.38', 'Mozilla/5.0 (Linux; Android 12; Pixel 6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Mobile Safari/537.36', 'Android Device', '2026-04-16 03:28:12'),
(35310, '34.187.137.118', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2026-04-16 13:42:39'),
(35311, '104.248.33.108', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Unknown', '2026-04-16 14:23:02'),
(35312, '136.112.115.236', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2026-04-16 14:39:41'),
(35313, '5.39.1.230', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2026-04-17 08:20:42'),
(35315, '34.9.4.211', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2026-04-17 16:31:06'),
(35316, '87.250.224.224', 'Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)', 'Unknown', '2026-04-17 20:39:41'),
(35318, '157.245.69.223', 'Mozilla/5.0 (X11; Linux x86_64; rv:142.0) Gecko/20100101 Firefox/142.0', 'Unknown', '2026-04-18 15:08:51'),
(35319, '34.82.37.116', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'Windows', '2026-04-18 21:45:58'),
(35320, '52.167.144.160', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2026-04-18 23:14:48'),
(35321, '2a02:4780:75:6860::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Windows', '2026-04-19 09:10:25'),
(35326, '2401:4900:b50c:c742:3025:edff:feda:d71c', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', 'Android Device', '2026-04-22 16:14:41'),
(35327, '2a02:4780:5e:a902::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36', 'Windows', '2026-04-22 17:47:36'),
(35329, '92.222.108.127', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)', 'Unknown', '2026-04-23 06:11:07'),
(35330, '159.203.142.166', 'Mozilla/5.0 (X11; Linux x86_64; rv:142.0) Gecko/20100101 Firefox/142.0', 'Unknown', '2026-04-23 09:23:23'),
(35331, '205.169.39.54', 'Mozilla/5.0 (Windows NT 10.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36', 'Windows', '2026-04-24 00:19:14'),
(35333, '2a14:7c1:400:3f::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Windows', '2026-04-24 11:39:26'),
(35335, '185.254.75.29', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/601.4.4 (KHTML, like Gecko) Version/9.0.3 Safari/537.86.4', 'Apple', '2026-04-25 23:35:08'),
(35337, '66.249.72.235', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Android Device', '2026-04-26 09:15:44'),
(35340, '2a14:7c1:400:3a::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Windows', '2026-04-27 14:37:48'),
(35345, '34.13.247.228', 'Scrapy/2.13.4 (+https://scrapy.org)', 'Unknown', '2026-04-30 02:59:07'),
(35348, '2a0b:8bc0:2:b9fe::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Safari/605.1.15', 'Apple', '2026-04-30 09:14:20'),
(35349, '159.203.24.74', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Unknown', '2026-04-30 13:10:48'),
(35350, '34.152.118.113', 'Mozilla/5.0 (X11; U; Linux x86_64; sv-SE; rv:1.8.1.12) Gecko/20080207 Ubuntu/7.10 (gutsy) Firefox/2.0.0.12', 'Unknown', '2026-04-30 15:44:54'),
(35352, '66.249.72.237', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.7727.137 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Android Device', '2026-05-01 05:01:14'),
(35353, '2a02:4780:5e:f977::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36', 'Windows', '2026-05-02 04:08:04'),
(35355, '159.65.149.19', 'Mozilla/5.0 (X11; Linux x86_64; rv:142.0) Gecko/20100101 Firefox/142.0', 'Unknown', '2026-05-02 13:37:04'),
(35357, '34.162.57.40', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0 Safari/537.36', 'Unknown', '2026-05-03 16:03:01'),
(35362, '2a02:4780:75:5abe::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 15_7_5) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0 Safari/605.1.15', 'Apple', '2026-05-04 05:32:26'),
(35364, '107.175.132.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Windows', '2026-05-04 11:06:38'),
(35365, '143.198.156.178', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Unknown', '2026-05-04 14:06:54'),
(35366, '35.233.149.152', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2026-05-04 14:12:55'),
(35367, '34.59.198.240', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2026-05-04 15:38:02'),
(35368, '34.6.215.245', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0 Safari/537.36', 'Unknown', '2026-05-04 19:21:03'),
(35369, '34.126.195.183', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 Chrome/124.0 Safari/537.36', 'Unknown', '2026-05-04 19:52:55'),
(35371, '54.216.142.65', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2026-05-05 02:07:26'),
(35374, '206.189.238.194', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Unknown', '2026-05-07 04:58:59'),
(35378, '66.249.77.230', 'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Android Device', '2026-05-10 17:28:47'),
(35379, '66.249.77.232', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Unknown', '2026-05-10 17:28:47'),
(35381, '3.252.42.108', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2026-05-11 16:49:18'),
(35383, '32.184.5.158', 'Mozilla/5.0 (compatible; wpbot/1.4; +https://forms.gle/ajBaxygz9jSR8p8G9)', 'Unknown', '2026-05-12 12:01:23'),
(35384, '104.197.189.82', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2026-05-12 15:39:39'),
(35385, '83.140.109.213', 'Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.3', 'Unknown', '2026-05-12 21:14:52'),
(35388, '167.99.76.73', 'WP-Safe-Scanner/2.0', 'Unknown', '2026-05-14 19:33:41'),
(35392, '223.181.126.118', 'Mr.X safe research bot', 'Unknown', '2026-05-17 16:23:25'),
(35393, '2401:4900:88d3:f119:5a3:4f30:bc23:e5', 'Mr.X safe research bot', 'Unknown', '2026-05-18 01:29:21'),
(35395, '34.29.121.138', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2026-05-18 15:24:43'),
(35396, '35.227.120.160', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2026-05-18 16:18:27'),
(35400, '2a14:1ec7:1031:e65c:216:3eff:fec1:25fe', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 15_7_5) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0 Safari/605.1.15', 'Apple', '2026-05-18 21:27:32'),
(35402, '40.77.167.116', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2026-05-20 02:06:46'),
(35405, '103.108.5.211', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'Windows', '2026-05-21 11:17:56'),
(35406, '178.62.226.110', 'Mozilla/5.0 (X11; Linux x86_64; rv:142.0) Gecko/20100101 Firefox/142.0', 'Unknown', '2026-05-21 13:36:17'),
(35407, '34.71.6.79', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2026-05-21 17:01:55'),
(35408, '34.1.20.213', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'Apple', '2026-05-21 23:25:06'),
(35410, '140.228.47.189', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'Apple', '2026-05-22 13:39:31'),
(35414, '103.108.5.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'Windows', '2026-05-23 12:25:50'),
(35419, '104.197.220.3', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2026-05-24 13:52:52'),
(35420, '40.77.167.42', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2026-05-25 00:07:42'),
(35422, '185.148.3.222', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.1.2 Safari/605.1.15', 'Apple', '2026-05-25 14:24:33'),
(35424, '71.208.90.250', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'Apple', '2026-05-26 17:17:06'),
(35426, '5.78.204.170', 'Mozilla/5.0', 'Unknown', '2026-05-27 23:12:01'),
(35431, '2604:a00:50:170:985a:9e54:2a52:ff2a', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36', 'Windows', '2026-05-31 07:35:53'),
(35434, '130.193.45.75', 'Mozilla/5.0', 'Unknown', '2026-06-01 21:10:48'),
(35436, '2604:a00:50:210:f375:5ab7:c7a4:171d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36', 'Windows', '2026-06-02 13:08:11'),
(35437, '45.3.34.73', 'Mozilla/5.0 (compatible; bulk-validator/1.0)', 'Unknown', '2026-06-03 01:47:23'),
(35439, '104.252.191.212', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', 'Unknown', '2026-06-03 01:58:30'),
(35441, '103.108.5.128', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'Windows', '2026-06-03 13:43:35'),
(35442, '167.71.68.212', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Unknown', '2026-06-04 02:30:51'),
(35444, '103.4.251.23', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', 'Unknown', '2026-06-04 22:28:04'),
(35447, '192.178.6.8', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Unknown', '2026-06-05 09:16:12'),
(35448, '3.18.212.83', 'curl/8.3.0', 'Unknown', '2026-06-05 13:24:22'),
(35451, '209.97.135.110', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0', 'Windows', '2026-06-07 07:24:38'),
(35452, '165.245.191.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0', 'Windows', '2026-06-07 07:46:51'),
(35454, '18.200.251.112', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2026-06-08 20:55:06'),
(35456, '35.80.18.98', 'Mozilla/5.0 (compatible; wpbot/1.4; +https://forms.gle/ajBaxygz9jSR8p8G9)', 'Unknown', '2026-06-09 14:48:23'),
(35460, '54.170.115.52', 'Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)', 'Unknown', '2026-06-12 17:26:31'),
(35462, '2a03:b0c0:1:d0::c6d:c001', 'Mozilla/5.0 (l9scan/2.0.33a366438336a3836626a303a353733313a31313a303837343a323031623; +https://leakix.net)', 'Unknown', '2026-06-14 01:47:59'),
(35464, '104.164.126.98', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', 'Windows', '2026-06-14 01:48:06'),
(35466, '103.4.251.119', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'Unknown', '2026-06-14 01:48:16'),
(35468, '205.169.39.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.79 Safari/537.36', 'Windows', '2026-06-14 01:49:12'),
(35469, '205.169.39.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.5938.132 Safari/537.36', 'Windows', '2026-06-14 01:51:03'),
(35470, '103.196.9.179', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'Unknown', '2026-06-14 02:11:02'),
(35473, '104.164.173.74', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'Windows', '2026-06-14 02:11:19'),
(35474, '91.231.89.36', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0', 'Unknown', '2026-06-14 02:29:51'),
(35476, '104.164.173.5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', 'Windows', '2026-06-14 02:45:19'),
(35478, '103.4.250.209', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'Windows', '2026-06-14 02:45:29'),
(35480, '103.196.9.169', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', 'Windows', '2026-06-14 03:23:32'),
(35482, '107.172.195.31', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', 'Apple', '2026-06-14 03:23:58'),
(35485, '104.164.126.85', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', 'Apple', '2026-06-14 03:40:08'),
(35487, '103.196.9.251', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'Windows', '2026-06-14 03:40:12'),
(35488, '51.254.49.108', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0', 'Unknown', '2026-06-14 04:29:53'),
(35490, '185.225.69.187', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36', 'Android Device', '2026-06-14 06:31:20'),
(35492, '104.252.191.132', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', 'Windows', '2026-06-14 10:21:21'),
(35494, '103.4.251.110', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'Unknown', '2026-06-14 10:21:33'),
(35495, '34.9.213.41', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2026-06-14 15:00:14'),
(35499, '216.73.216.230', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; ClaudeBot/1.0; +claudebot@anthropic.com)', 'Unknown', '2026-06-15 09:48:07'),
(35500, '14.245.104.208', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36', 'Windows', '2026-06-15 11:26:31'),
(35501, '34.90.8.4', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2026-06-15 13:07:50'),
(35502, '165.245.217.171', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Unknown', '2026-06-15 13:24:04'),
(35503, '34.55.152.181', 'Mozilla/5.0 (compatible; CMS-Checker/1.0; +https://example.com)', 'Unknown', '2026-06-15 14:36:39'),
(35506, '3.93.37.243', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36', 'Apple', '2026-06-16 23:35:05'),
(35508, '134.122.19.191', 'Mozilla/5.0 (X11; Linux x86_64; rv:142.0) Gecko/20100101 Firefox/142.0', 'Unknown', '2026-06-17 14:25:58'),
(35510, '161.35.121.30', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'Unknown', '2026-06-18 09:08:34'),
(35512, '104.239.40.201', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Unknown', '2026-06-19 17:29:21'),
(35513, '2a01:239:211:3900::1', 'Mozilla/5.0 (compatible;)', 'Unknown', '2026-06-19 17:58:37'),
(35515, '2401:4900:8397:38ad:847b:1ff:fe3d:77ec', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Mobile Safari/537.36', 'Android Device', '2026-06-20 04:02:33'),
(35516, '192.178.6.9', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Unknown', '2026-06-20 04:04:00'),
(35519, '34.174.175.174', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36', 'Windows', '2026-06-20 04:59:46'),
(35520, '206.206.122.7', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Unknown', '2026-06-20 09:11:32'),
(35522, '192.178.6.7', 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', 'Unknown', '2026-06-20 16:03:38'),
(35524, '2604:a880:800:10::904:4001', 'Mozilla/5.0 (l9scan/2.0.33a366438336a3836626a303a353733313a31313a303837343a323031623; +https://leakix.net)', 'Unknown', '2026-06-21 20:28:49'),
(35526, '52.167.144.199', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36', 'Unknown', '2026-06-22 06:10:41'),
(35527, '168.235.203.253', 'Mozilla/5.0 (Linux; U; Android 8.1.0; en-US; CPH1909 Build/O11019) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/123.0.6312.80 UCBrowser/15.1.6.1392 Mobile Safari/537.36', 'Android Device', '2026-06-23 02:18:42'),
(35528, '52.241.146.222', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko); compatible; ChatGPT-User/1.0; +https://openai.com/bot', 'Unknown', '2026-06-23 05:05:44'),
(35529, '2a02:4780:11:c0de::e', 'Go-http-client/2.0', 'Unknown', '2026-06-23 06:31:32'),
(35530, '46.17.174.173', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:98.0) Gecko/20100101 Firefox/98.0', 'Apple', '2026-06-23 22:36:43'),
(35532, '103.108.5.157', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'Unknown', '2026-06-24 08:18:24'),
(35533, '2a02:4780:5d:c0de::10', 'Go-http-client/2.0', 'Unknown', '2026-06-25 01:55:15'),
(35534, '20.193.233.244', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko); compatible; ChatGPT-User/1.0; +https://openai.com/bot', 'Unknown', '2026-06-25 03:21:49');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admingglogin`
--
ALTER TABLE `admingglogin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin_users`
--
ALTER TABLE `admin_users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_name` (`user_name`);

--
-- Indexes for table `blogcomment`
--
ALTER TABLE `blogcomment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blogs`
--
ALTER TABLE `blogs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blog_creators`
--
ALTER TABLE `blog_creators`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `blog_posts`
--
ALTER TABLE `blog_posts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `blog_reactions`
--
ALTER TABLE `blog_reactions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_blog_user` (`blog_id`,`user_email`);

--
-- Indexes for table `blog_views`
--
ALTER TABLE `blog_views`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_ip_slug` (`ip`,`slug`);

--
-- Indexes for table `chat_messages`
--
ALTER TABLE `chat_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contact_messages`
--
ALTER TABLE `contact_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contact_submissions`
--
ALTER TABLE `contact_submissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `coursebuyer`
--
ALTER TABLE `coursebuyer`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `email_2` (`email`),
  ADD UNIQUE KEY `google_id` (`google_id`);

--
-- Indexes for table `creator_subscriptions`
--
ALTER TABLE `creator_subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_sub` (`creator_email`,`subscriber_email`);

--
-- Indexes for table `day_table`
--
ALTER TABLE `day_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `google_users`
--
ALTER TABLE `google_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `login_data`
--
ALTER TABLE `login_data`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pending_users`
--
ALTER TABLE `pending_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `recover_password`
--
ALTER TABLE `recover_password`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `usersgoogle`
--
ALTER TABLE `usersgoogle`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth0_id` (`auth0_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_activity`
--
ALTER TABLE `user_activity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `user_profile`
--
ALTER TABLE `user_profile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_profiles`
--
ALTER TABLE `user_profiles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `visitor_info`
--
ALTER TABLE `visitor_info`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admingglogin`
--
ALTER TABLE `admingglogin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `admin_users`
--
ALTER TABLE `admin_users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `blogcomment`
--
ALTER TABLE `blogcomment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT for table `blogs`
--
ALTER TABLE `blogs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `blog_creators`
--
ALTER TABLE `blog_creators`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `blog_posts`
--
ALTER TABLE `blog_posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `blog_reactions`
--
ALTER TABLE `blog_reactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `blog_views`
--
ALTER TABLE `blog_views`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10212;

--
-- AUTO_INCREMENT for table `chat_messages`
--
ALTER TABLE `chat_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `contact_messages`
--
ALTER TABLE `contact_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `contact_submissions`
--
ALTER TABLE `contact_submissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `coursebuyer`
--
ALTER TABLE `coursebuyer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=228;

--
-- AUTO_INCREMENT for table `creator_subscriptions`
--
ALTER TABLE `creator_subscriptions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `day_table`
--
ALTER TABLE `day_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=114;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `google_users`
--
ALTER TABLE `google_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `login`
--
ALTER TABLE `login`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `login_data`
--
ALTER TABLE `login_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=770;

--
-- AUTO_INCREMENT for table `pending_users`
--
ALTER TABLE `pending_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `recover_password`
--
ALTER TABLE `recover_password`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `usersgoogle`
--
ALTER TABLE `usersgoogle`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `user_activity`
--
ALTER TABLE `user_activity`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `user_profile`
--
ALTER TABLE `user_profile`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_profiles`
--
ALTER TABLE `user_profiles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `visitor_info`
--
ALTER TABLE `visitor_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35535;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `user_activity`
--
ALTER TABLE `user_activity`
  ADD CONSTRAINT `user_activity_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `coursebuyer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_profile`
--
ALTER TABLE `user_profile`
  ADD CONSTRAINT `user_profile_ibfk_1` FOREIGN KEY (`email`) REFERENCES `coursebuyer` (`email`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
