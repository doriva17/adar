-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 26, 2019 at 04:03 PM
-- Server version: 10.1.38-MariaDB
-- PHP Version: 7.3.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `adar`
--

-- --------------------------------------------------------

--
-- Table structure for table `cluster`
--

CREATE TABLE `cluster` (
  `clusterId` int(11) NOT NULL,
  `clustername` varchar(255) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `CID` int(11) NOT NULL,
  `FamilyName` varchar(164) NOT NULL,
  `GivenName` varchar(224) NOT NULL,
  `Type` set('m','f','u','c') NOT NULL COMMENT '(m)ale, (f)emale, (u)ndefined, (c)ompany',
  `Street` varchar(164) NOT NULL,
  `Housenr` varchar(16) NOT NULL,
  `ZIP` varchar(16) NOT NULL,
  `City` varchar(164) NOT NULL,
  `Country` varchar(2) NOT NULL,
  `Phone` varchar(64) NOT NULL,
  `Fax` varchar(64) NOT NULL,
  `Mail` varchar(164) NOT NULL,
  `URL` varchar(150) NOT NULL,
  `Notes` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`CID`, `FamilyName`, `GivenName`, `Type`, `Street`, `Housenr`, `ZIP`, `City`, `Country`, `Phone`, `Fax`, `Mail`, `URL`, `Notes`) VALUES
(1, 'Andrew', 'Muteka', 'm', 'home', 'home', 'home', 'home', 'NA', '1111111', '111111', 'doriva17@gmail.com', 'www.gmail.com', 'test'),
(2, '', '', 'u', '', '', '', '', 'DE', '', '', '', '', ''),
(3, 'Andrew', 'Muteka', 'c', 'home', '', 'home', 'home', 'NA', '1111111', '111111', 'doriva17@gmail.com', 'www.gmail.com', 'test'),
(4, 'Andrew', 'Muteka', 'c', 'home', '', 'home', 'home', 'NA', '1111111', '111111', 'doriva17@gmail.com', 'www.gmail.com', 'test'),
(5, 'Andrew', 'Muteka', 'c', 'home', '', 'home', 'home', 'NA', '1111111', '111111', 'doriva17@gmail.com', 'www.gmail.com', 'test'),
(6, 'test', 'Testing', 'u', 'test', 'test', 'test', 'test', 'NA', '1111111', '111111', 'doriva17@gmail.com', 'www.gmail.com', 'test'),
(7, 'test', 'test', 'u', 'test', 'test', 'test', 'test', 'NA', '1111111', '111111', 'doriva17@gmail.com', 'www.gmail.com', 'test'),
(8, 'test', 'test', 'u', 'test', 'test', 'test', 'test', 'NA', '1111111', '111111', 'doriva17@gmail.com', 'www.gmail.com', 'test'),
(9, 'test', 'test', 'u', 'test', 'test', 'test', 'test', 'NA', '1111111', '111111', 'doriva17@gmail.com', 'www.gmail.com', 'test'),
(10, 'test', 'test', 'u', 'test', 'test', 'test', 'test', 'NA', '1111111', '111111', 'doriva17@gmail.com', 'www.gmail.com', 'test'),
(11, 'test', 'test', 'u', 'test', 'test', 'test', 'test', 'NA', '1111111', '111111', 'doriva17@gmail.com', 'www.gmail.com', 'test'),
(12, 'Rendy', 'Amputu', 'm', 'home', 'home', 'home', 'home', 'NA', '1111111', '', 'amputur@gmail.com ', '', 'amputur@gmail.com '),
(13, 'Rendy', 'Amputu', 'm', 'home', 'home', 'home', 'home', 'NA', '1111111', '', 'amputur@gmail.com ', '', 'amputur@gmail.com '),
(14, 'Muhepa', 'Mafo', 'm', 'here', '22', '9000', 'home', 'NA', '2546813', '', 'abc@zyx.co', '', 'test'),
(15, 'Muhepa', 'Testing', 'm', 'here', '22', '9000', 'home', 'NA', '2546813', '', 'abc@zyx.co', '', 'test');

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE `countries` (
  `Alpha2` varchar(2) NOT NULL,
  `Name` varchar(128) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Source: http://www.iso.org/iso/country_codes/iso_3166_code_l';

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`Alpha2`, `Name`) VALUES
('AF', 'AFGHANISTAN'),
('AX', 'ÅLAND ISLANDS'),
('AL', 'ALBANIA'),
('DZ', 'ALGERIA'),
('AS', 'AMERICAN SAMOA'),
('AD', 'ANDORRA'),
('AO', 'ANGOLA'),
('AI', 'ANGUILLA'),
('AQ', 'ANTARCTICA'),
('AG', 'ANTIGUA AND BARBUDA'),
('AR', 'ARGENTINA'),
('AM', 'ARMENIA'),
('AW', 'ARUBA'),
('AU', 'AUSTRALIA'),
('AT', 'AUSTRIA'),
('AZ', 'AZERBAIJAN'),
('BS', 'BAHAMAS'),
('BH', 'BAHRAIN'),
('BD', 'BANGLADESH'),
('BB', 'BARBADOS'),
('BY', 'BELARUS'),
('BE', 'BELGIUM'),
('BZ', 'BELIZE'),
('BJ', 'BENIN'),
('BM', 'BERMUDA'),
('BT', 'BHUTAN'),
('BO', 'BOLIVIA, PLURINATIONAL STATE OF'),
('BQ', 'BONAIRE, SINT EUSTATIUS AND SABA'),
('BA', 'BOSNIA AND HERZEGOVINA'),
('BW', 'BOTSWANA'),
('BV', 'BOUVET ISLAND'),
('BR', 'BRAZIL'),
('IO', 'BRITISH INDIAN OCEAN TERRITORY'),
('BN', 'BRUNEI DARUSSALAM'),
('BG', 'BULGARIA'),
('BF', 'BURKINA FASO'),
('BI', 'BURUNDI'),
('KH', 'CAMBODIA'),
('CM', 'CAMEROON'),
('CA', 'CANADA'),
('CV', 'CAPE VERDE'),
('KY', 'CAYMAN ISLANDS'),
('CF', 'CENTRAL AFRICAN REPUBLIC'),
('TD', 'CHAD'),
('CL', 'CHILE'),
('CN', 'CHINA'),
('CX', 'CHRISTMAS ISLAND'),
('CC', 'COCOS (KEELING) ISLANDS'),
('CO', 'COLOMBIA'),
('KM', 'COMOROS'),
('CG', 'CONGO'),
('CD', 'CONGO, THE DEMOCRATIC REPUBLIC OF THE'),
('CK', 'COOK ISLANDS'),
('CR', 'COSTA RICA'),
('CI', 'CÔTE D\'IVOIRE'),
('HR', 'CROATIA'),
('CU', 'CUBA'),
('CW', 'CURAÇAO'),
('CY', 'CYPRUS'),
('CZ', 'CZECH REPUBLIC'),
('DK', 'DENMARK'),
('DJ', 'DJIBOUTI'),
('DM', 'DOMINICA'),
('DO', 'DOMINICAN REPUBLIC'),
('EC', 'ECUADOR'),
('EG', 'EGYPT'),
('SV', 'EL SALVADOR'),
('GQ', 'EQUATORIAL GUINEA'),
('ER', 'ERITREA'),
('EE', 'ESTONIA'),
('ET', 'ETHIOPIA'),
('FK', 'FALKLAND ISLANDS (MALVINAS)'),
('FO', 'FAROE ISLANDS'),
('FJ', 'FIJI'),
('FI', 'FINLAND'),
('FR', 'FRANCE'),
('GF', 'FRENCH GUIANA'),
('PF', 'FRENCH POLYNESIA'),
('TF', 'FRENCH SOUTHERN TERRITORIES'),
('GA', 'GABON'),
('GM', 'GAMBIA'),
('GE', 'GEORGIA'),
('DE', 'GERMANY'),
('GH', 'GHANA'),
('GI', 'GIBRALTAR'),
('GR', 'GREECE'),
('GL', 'GREENLAND'),
('GD', 'GRENADA'),
('GP', 'GUADELOUPE'),
('GU', 'GUAM'),
('GT', 'GUATEMALA'),
('GG', 'GUERNSEY'),
('GN', 'GUINEA'),
('GW', 'GUINEA-BISSAU'),
('GY', 'GUYANA'),
('HT', 'HAITI'),
('HM', 'HEARD ISLAND AND MCDONALD ISLANDS'),
('VA', 'HOLY SEE (VATICAN CITY STATE)'),
('HN', 'HONDURAS'),
('HK', 'HONG KONG'),
('HU', 'HUNGARY'),
('IS', 'ICELAND'),
('IN', 'INDIA'),
('ID', 'INDONESIA'),
('IR', 'IRAN, ISLAMIC REPUBLIC OF'),
('IQ', 'IRAQ'),
('IE', 'IRELAND'),
('IM', 'ISLE OF MAN'),
('IL', 'ISRAEL'),
('IT', 'ITALY'),
('JM', 'JAMAICA'),
('JP', 'JAPAN'),
('JE', 'JERSEY'),
('JO', 'JORDAN'),
('KZ', 'KAZAKHSTAN'),
('KE', 'KENYA'),
('KI', 'KIRIBATI'),
('KP', 'KOREA, DEMOCRATIC PEOPLE\'S REPUBLIC OF'),
('KR', 'KOREA, REPUBLIC OF'),
('KW', 'KUWAIT'),
('KG', 'KYRGYZSTAN'),
('LA', 'LAO PEOPLE\'S DEMOCRATIC REPUBLIC'),
('LV', 'LATVIA'),
('LB', 'LEBANON'),
('LS', 'LESOTHO'),
('LR', 'LIBERIA'),
('LY', 'LIBYA'),
('LI', 'LIECHTENSTEIN'),
('LT', 'LITHUANIA'),
('LU', 'LUXEMBOURG'),
('MO', 'MACAO'),
('MK', 'MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF'),
('MG', 'MADAGASCAR'),
('MW', 'MALAWI'),
('MY', 'MALAYSIA'),
('MV', 'MALDIVES'),
('ML', 'MALI'),
('MT', 'MALTA'),
('MH', 'MARSHALL ISLANDS'),
('MQ', 'MARTINIQUE'),
('MR', 'MAURITANIA'),
('MU', 'MAURITIUS'),
('YT', 'MAYOTTE'),
('MX', 'MEXICO'),
('FM', 'MICRONESIA, FEDERATED STATES OF'),
('MD', 'MOLDOVA, REPUBLIC OF'),
('MC', 'MONACO'),
('MN', 'MONGOLIA'),
('ME', 'MONTENEGRO'),
('MS', 'MONTSERRAT'),
('MA', 'MOROCCO'),
('MZ', 'MOZAMBIQUE'),
('MM', 'MYANMAR'),
('NA', 'NAMIBIA'),
('NR', 'NAURU'),
('NP', 'NEPAL'),
('NL', 'NETHERLANDS'),
('NC', 'NEW CALEDONIA'),
('NZ', 'NEW ZEALAND'),
('NI', 'NICARAGUA'),
('NE', 'NIGER'),
('NG', 'NIGERIA'),
('NU', 'NIUE'),
('NF', 'NORFOLK ISLAND'),
('MP', 'NORTHERN MARIANA ISLANDS'),
('NO', 'NORWAY'),
('OM', 'OMAN'),
('PK', 'PAKISTAN'),
('PW', 'PALAU'),
('PS', 'PALESTINIAN TERRITORY, OCCUPIED'),
('PA', 'PANAMA'),
('PG', 'PAPUA NEW GUINEA'),
('PY', 'PARAGUAY'),
('PE', 'PERU'),
('PH', 'PHILIPPINES'),
('PN', 'PITCAIRN'),
('PL', 'POLAND'),
('PT', 'PORTUGAL'),
('PR', 'PUERTO RICO'),
('QA', 'QATAR'),
('RE', 'RÉUNION'),
('RO', 'ROMANIA'),
('RU', 'RUSSIAN FEDERATION'),
('RW', 'RWANDA'),
('BL', 'SAINT BARTHÉLEMY'),
('SH', 'SAINT HELENA, ASCENSION AND TRISTAN DA CUNHA'),
('KN', 'SAINT KITTS AND NEVIS'),
('LC', 'SAINT LUCIA'),
('MF', 'SAINT MARTIN (FRENCH PART)'),
('PM', 'SAINT PIERRE AND MIQUELON'),
('VC', 'SAINT VINCENT AND THE GRENADINES'),
('WS', 'SAMOA'),
('SM', 'SAN MARINO'),
('ST', 'SAO TOME AND PRINCIPE'),
('SA', 'SAUDI ARABIA'),
('SN', 'SENEGAL'),
('RS', 'SERBIA'),
('SC', 'SEYCHELLES'),
('SL', 'SIERRA LEONE'),
('SG', 'SINGAPORE'),
('SX', 'SINT MAARTEN (DUTCH PART)'),
('SK', 'SLOVAKIA'),
('SI', 'SLOVENIA'),
('SB', 'SOLOMON ISLANDS'),
('SO', 'SOMALIA'),
('ZA', 'SOUTH AFRICA'),
('GS', 'SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS'),
('SS', 'SOUTH SUDAN'),
('ES', 'SPAIN'),
('LK', 'SRI LANKA'),
('SD', 'SUDAN'),
('SR', 'SURINAME'),
('SJ', 'SVALBARD AND JAN MAYEN'),
('SZ', 'SWAZILAND'),
('SE', 'SWEDEN'),
('CH', 'SWITZERLAND'),
('SY', 'SYRIAN ARAB REPUBLIC'),
('TW', 'TAIWAN, PROVINCE OF CHINA'),
('TJ', 'TAJIKISTAN'),
('TZ', 'TANZANIA, UNITED REPUBLIC OF'),
('TH', 'THAILAND'),
('TL', 'TIMOR-LESTE'),
('TG', 'TOGO'),
('TK', 'TOKELAU'),
('TO', 'TONGA'),
('TT', 'TRINIDAD AND TOBAGO'),
('TN', 'TUNISIA'),
('TR', 'TURKEY'),
('TM', 'TURKMENISTAN'),
('TC', 'TURKS AND CAICOS ISLANDS'),
('TV', 'TUVALU'),
('UG', 'UGANDA'),
('UA', 'UKRAINE'),
('AE', 'UNITED ARAB EMIRATES'),
('GB', 'UNITED KINGDOM'),
('US', 'UNITED STATES'),
('UM', 'UNITED STATES MINOR OUTLYING ISLANDS'),
('UY', 'URUGUAY'),
('UZ', 'UZBEKISTAN'),
('VU', 'VANUATU'),
('VE', 'VENEZUELA, BOLIVARIAN REPUBLIC OF'),
('VN', 'VIET NAM'),
('VG', 'VIRGIN ISLANDS, BRITISH'),
('VI', 'VIRGIN ISLANDS, U.S.'),
('WF', 'WALLIS AND FUTUNA'),
('EH', 'WESTERN SAHARA'),
('YE', 'YEMEN'),
('ZM', 'ZAMBIA'),
('ZW', 'ZIMBABWE');

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `ItemID` varchar(10) NOT NULL COMMENT 'using users short-id and a >=4-digit-sequential number - example: FK_0003',
  `Caption` varchar(100) NOT NULL COMMENT 'Freetext to describe the document',
  `Description` longtext COMMENT 'Contains detailed description and data gathered from EXIF or OCR',
  `Format` varchar(25) DEFAULT NULL COMMENT 'Freetext to describe physical source of this document - (letter, photo, whatever)',
  `Date` date DEFAULT NULL COMMENT 'originals date',
  `Sender` int(11) DEFAULT NULL COMMENT 'source (needs to be changed)',
  `Receiver` int(11) NOT NULL,
  `ScanUser` int(11) NOT NULL COMMENT 'scanning user',
  `ScanDate` date NOT NULL COMMENT 'scanning date',
  `SourceSHA256` varchar(64) NOT NULL COMMENT 'SHA256 of archived document to check for corrupted files',
  `OCRStatus` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`ItemID`, `Caption`, `Description`, `Format`, `Date`, `Sender`, `Receiver`, `ScanUser`, `ScanDate`, `SourceSHA256`, `OCRStatus`) VALUES
('AD_0001', 'children', 'test', 'children', '2019-08-08', 6, 12, 1, '2019-03-08', 'd55b9a442886c5e05678754320d27cdff8a8e96439d4877d6dd623d10fdbe541', 1),
('AD_0002', 'PDF test', 'PDF test', 'pdf file', '2019-03-08', 1, 12, 1, '2019-03-08', '70ecb628ada069214ab8ff5e9f368fc7c3b86073c5d8259e5349921b98e2f854', 1),
('AD_0003', 'project plan', 'project plan', 'project plan', '2019-03-09', 12, 6, 1, '2019-03-09', '1fb7c63c18a2ee28320510cce7e83908fef19f70a1501e5ce1d8834cdc2599ba', 1),
('AD_0004', 'Sonic', 'Sonic and Tails', 'project plan', '2019-03-10', 1, 6, 1, '2019-03-10', '5df5107d71b5eeab44a3bb87daa7c4a54f7f3b6f64209492d2fde2039554df37', 1),
('AD_0005', 'character_wallpaper_tails - Copy.png', '', 'something else', '2019-03-11', 12, 12, 1, '2019-03-11', 'c6fe184d653276954aced1d3f1545ab8c1f6cdc0a99c109acc5ab77d74552b49', 1);

-- --------------------------------------------------------

--
-- Table structure for table `papers`
--

CREATE TABLE `papers` (
  `paperId` int(11) NOT NULL,
  `dateUpload` date DEFAULT NULL,
  `dateModerated` date DEFAULT NULL,
  `lecturerId` varchar(255) DEFAULT NULL,
  `moderatorId` varchar(255) DEFAULT NULL,
  `studentNumber` varchar(255) DEFAULT NULL,
  `coordinatorId` varchar(255) DEFAULT NULL,
  `clusterId` varchar(255) DEFAULT NULL,
  `publishedStatus` varchar(255) DEFAULT NULL,
  `abstract` mediumtext
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `papers`
--

INSERT INTO `papers` (`paperId`, `dateUpload`, `dateModerated`, `lecturerId`, `moderatorId`, `studentNumber`, `coordinatorId`, `clusterId`, `publishedStatus`, `abstract`) VALUES
(1, '2019-03-31', '2019-03-31', '1', '2', '200608444', '3', '4', 'NO', 'testing 1 2 3'),
(2, '2019-03-31', '2019-03-31', '1', '2', '2140578', '3', '4', 'NO', 'testing 1 2 3'),
(3, '2019-03-31', '2019-03-31', '1', '2', '2160578', '3', '4', 'NO', 'testing 1 2 3'),
(4, '2019-03-16', '2019-03-22', '1', '2', '2140511', '3', '4', 'NO', 'testing 1 2 3');

-- --------------------------------------------------------

--
-- Table structure for table `paperstatus`
--

CREATE TABLE `paperstatus` (
  `statusID` int(11) NOT NULL,
  `statusName` varchar(255) DEFAULT NULL COMMENT 'who can view which paper',
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `roleID` int(11) NOT NULL,
  `roleName` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`roleID`, `roleName`) VALUES
(1, 'administrator'),
(2, 'moderator'),
(3, 'supervisor'),
(4, 'coordinator'),
(5, 'student');

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `studentID` int(11) NOT NULL,
  `studentNumber` int(11) DEFAULT NULL,
  `firstName` varchar(255) DEFAULT NULL,
  `surname` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `course` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`studentID`, `studentNumber`, `firstName`, `surname`, `gender`, `course`) VALUES
(1, 200608444, 'Andrew', 'Muteka', 'male', 'Software Development'),
(2, 21100458, 'Amputu', 'Rendy', 'male', '08BHIS');

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE `tags` (
  `TagID` int(11) NOT NULL,
  `ItemID` varchar(10) NOT NULL,
  `TagValue` varchar(150) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tags`
--

INSERT INTO `tags` (`TagID`, `ItemID`, `TagValue`) VALUES
(1, 'AD_0001', 'children'),
(2, 'AD_0001', 'book');

-- --------------------------------------------------------

--
-- Table structure for table `userloginaccount`
--

CREATE TABLE `userloginaccount` (
  `UserId` int(11) NOT NULL,
  `Username` varchar(255) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `UserID` int(11) NOT NULL,
  `Title` varchar(20) DEFAULT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Surname` varchar(50) DEFAULT NULL,
  `Gender` varchar(20) DEFAULT NULL,
  `Username` varchar(50) DEFAULT NULL COMMENT 'aka loginname',
  `Password` varchar(100) DEFAULT NULL COMMENT 'salted SHA256',
  `EMail` varchar(150) DEFAULT NULL,
  `ContactNo` varchar(20) DEFAULT NULL,
  `Image` varchar(255) DEFAULT NULL,
  `Active` varchar(10) DEFAULT '',
  `Level` int(11) DEFAULT '0' COMMENT 'binary system, not really documented yet'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`UserID`, `Title`, `Name`, `Surname`, `Gender`, `Username`, `Password`, `EMail`, `ContactNo`, `Image`, `Active`, `Level`) VALUES
(1, '', 'admin', 'Alfred', NULL, 'admin', '3469b67ebf2b71177c3fdb9da2c3fb0e0dec73a9e9a7e3e3516f6ba4813e52dc3f283c57', 'doriva17@gmail.com', NULL, NULL, 'Yes', 1),
(11, '', 'Mike', 'Mike', NULL, 'mike', '2e7c142bbf94a9986206222a269ff3c7a660fdb7fd3ab7a0d5258339a1b9c0bc80a5970c', 'mike@abc.com', NULL, NULL, 'Yes', 2),
(10, '', 'Andrew', 'Andrew', NULL, 'Andrew', '05cbb39769ed982e1f7c54d7f6c15fcc7a5e24d1026c796e72cec018d465d0e8c6dbc652', 'Andrew@abc.com', NULL, NULL, 'Yes', 1),
(9, '', 'aj', 'Schmidt', NULL, 'aj', '1a661b7d4e0c89eb66bc17e05a75b5d46522d7d8f6543a41f4f6f4995689b094b594da69', 'aj', NULL, NULL, 'Yes', 255),
(12, '', 'Peter', 'Peter', NULL, 'Peter', '1ff93a32e9e764f4a2a00ae9b0d954e2d227d7f30ec8a16f489319fe5fd89acf7f8aca53', 'Peter', NULL, NULL, 'Yes', 5),
(13, '', 'Amputu', 'Rendy', NULL, 'Rendy', '58118992ad95b683d36ca511fceadf5e7f756154167ac388df9d3840bf1c64483eb425e0', 'amputur@gmail.com', NULL, NULL, 'Yes', 1),
(14, '', 'Noah', 'Noah', NULL, 'Noah', '6e2f4e4ffbbc2629deeb84de23aa681facaeee6e955936cab467073db36543aaf273471e', 'Noah', NULL, NULL, 'Yes', 3),
(15, '', 'Nehale', 'Muteka', NULL, 'Nehale', '41844e3f033b2511a912e4f3a01345e7305e375f49c9d348995f37964fbcf8ed52e3d54d', 'Nehale', NULL, NULL, 'Yes', 1),
(16, '', 'Lolo', 'Lolo', NULL, 'Lolo', '098fcb2596a0caae713417e2b46f887f4b2e1ce998cc44185741cc522060311ba0570b53', 'Lolo', NULL, NULL, 'Yes', 2),
(17, 'Mr.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 0),
(18, 'Ms.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 0),
(19, 'Mr.', 'Pombili', 'Pombili', NULL, 'Pombili', 'Pombili', 'Pombili@abc.com', '222222', 'header.png', 'Yes', 1),
(20, 'Prof.', 'Frans', 'Frans', 'male', 'Frans', '3f206fd5c8fd50b5306575a860d7f85474347d06d201ee6d368c90551761132441a51a20', 'Frans@gmail.com', '222222', 'header.png', 'Yes', 1),
(21, 'Mr.', 'Gatsen', 'Gatsen', 'male', 'Gatsen', '31ec70f67e8ef04becd28177ef8f3ef15841656871fc3fabcdac054febba3f681ca27318', 'Gatsen@abc.com.na', '222222', '', 'Yes', 2),
(22, 'Mr.', 'Colin', 'Colin', 'male', 'Colin', '37615dc8882384b2b301c27cce0407019221aad811c4d67c0a2c851705997ae1caf70c14', 'Colin@table.com', '1111111', 'header.png', 'Yes', 3),
(23, 'Mr.', 'Niclas', 'Shilongo', 'male', 'nshilongo', '09754dffd74685c60a16ea6bc253372aca9b359a0bf184f5141a665896247eb72c8b8ddc', 'nshilongo78@gmail.com', '0811', '', 'Yes', 5);

-- --------------------------------------------------------

--
-- Table structure for table `usertype`
--

CREATE TABLE `usertype` (
  `userTypeId` int(11) NOT NULL,
  `typeName` varchar(255) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cluster`
--
ALTER TABLE `cluster`
  ADD PRIMARY KEY (`clusterId`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`CID`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`Alpha2`),
  ADD UNIQUE KEY `Name` (`Name`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`ItemID`),
  ADD UNIQUE KEY `SourceSHA256` (`SourceSHA256`),
  ADD KEY `Caption` (`Caption`),
  ADD KEY `Format` (`Format`),
  ADD KEY `Sender` (`Sender`),
  ADD KEY `Receiver` (`Receiver`);
ALTER TABLE `items` ADD FULLTEXT KEY `Description` (`Description`);

--
-- Indexes for table `papers`
--
ALTER TABLE `papers`
  ADD PRIMARY KEY (`paperId`);

--
-- Indexes for table `paperstatus`
--
ALTER TABLE `paperstatus`
  ADD PRIMARY KEY (`statusID`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`roleID`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`studentID`);

--
-- Indexes for table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`TagID`),
  ADD UNIQUE KEY `ItemID_2` (`ItemID`,`TagValue`),
  ADD KEY `TagCategory` (`TagValue`),
  ADD KEY `ItemID` (`ItemID`),
  ADD KEY `TagValue` (`TagValue`);

--
-- Indexes for table `userloginaccount`
--
ALTER TABLE `userloginaccount`
  ADD PRIMARY KEY (`UserId`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserID`),
  ADD UNIQUE KEY `Name` (`Name`),
  ADD UNIQUE KEY `Nickname` (`Username`),
  ADD UNIQUE KEY `Login` (`Username`,`Password`),
  ADD UNIQUE KEY `EMail` (`EMail`);

--
-- Indexes for table `usertype`
--
ALTER TABLE `usertype`
  ADD PRIMARY KEY (`userTypeId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cluster`
--
ALTER TABLE `cluster`
  MODIFY `clusterId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `CID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `papers`
--
ALTER TABLE `papers`
  MODIFY `paperId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `paperstatus`
--
ALTER TABLE `paperstatus`
  MODIFY `statusID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `roleID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
  MODIFY `studentID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `TagID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `userloginaccount`
--
ALTER TABLE `userloginaccount`
  MODIFY `UserId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `usertype`
--
ALTER TABLE `usertype`
  MODIFY `userTypeId` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
