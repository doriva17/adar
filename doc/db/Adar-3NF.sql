
-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 01, 2019 at 04:27 PM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 5.6.40

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
  `ClusterId` int(11) NOT NULL,
  `Clustername` varchar(255) DEFAULT NULL,
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
  `Gender` set('m','f','u','c') NOT NULL COMMENT '(m)ale, (f)emale, (u)ndefined, (c)ompany',
  `Street` varchar(164) NOT NULL,
  `Housenr` varchar(16) NOT NULL,
  `LocationId` int(164) NOT NULL,
  `Phone` varchar(64) NOT NULL,
  `Fax` varchar(64) NOT NULL,
  `Mail` varchar(164) NOT NULL,
  `URL` varchar(150) NOT NULL,
  `Notes` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`CID`, `FamilyName`, `GivenName`, `Gender`, `Street`, `Housenr`, `LocationId`, `Phone`, `Fax`, `Mail`, `URL`, `Notes`) VALUES
(1, 'Andrew', 'Muteka', 'm', 'home', 'home', 0, '1111111', '111111', 'doriva17@gmail.com', 'www.gmail.com', 'test'),
(2, '', '', 'u', '', '', 0, '', '', '', '', ''),
(3, 'Andrew', 'Muteka', 'c', 'home', '', 0, '1111111', '111111', 'doriva17@gmail.com', 'www.gmail.com', 'test'),
(4, 'Andrew', 'Muteka', 'c', 'home', '', 0, '1111111', '111111', 'doriva17@gmail.com', 'www.gmail.com', 'test'),
(5, 'Andrew', 'Muteka', 'c', 'home', '', 0, '1111111', '111111', 'doriva17@gmail.com', 'www.gmail.com', 'test'),
(6, 'test', 'test', 'u', 'test', 'test', 0, '1111111', '111111', 'doriva17@gmail.com', 'www.gmail.com', 'test'),
(7, 'test', 'test', 'u', 'test', 'test', 0, '1111111', '111111', 'doriva17@gmail.com', 'www.gmail.com', 'test'),
(8, 'test', 'test', 'u', 'test', 'test', 0, '1111111', '111111', 'doriva17@gmail.com', 'www.gmail.com', 'test'),
(9, 'test', 'test', 'u', 'test', 'test', 0, '1111111', '111111', 'doriva17@gmail.com', 'www.gmail.com', 'test'),
(10, 'test', 'test', 'u', 'test', 'test', 0, '1111111', '111111', 'doriva17@gmail.com', 'www.gmail.com', 'test'),
(11, 'test', 'test', 'u', 'test', 'test', 0, '1111111', '111111', 'doriva17@gmail.com', 'www.gmail.com', 'test'),
(12, 'Rendy', 'Amputu', 'm', 'home', 'home', 0, '1111111', '', 'amputur@gmail.com ', '', 'amputur@gmail.com '),
(13, 'Rendy', 'Amputu', 'm', 'home', 'home', 0, '1111111', '', 'amputur@gmail.com ', '', 'amputur@gmail.com '),
(14, 'Muhepa', 'Mafo', 'm', 'here', '22', 0, '2546813', '', 'abc@zyx.co', '', 'test');

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE `countries` (
  `CountryCode` varchar(255) NOT NULL,
  `Name` varchar(128) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Source: http://www.iso.org/iso/country_codes/iso_3166_code_l';

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`CountryCode`, `Name`) VALUES
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
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `CourseId` int(11) NOT NULL,
  `CourseDescription` varchar(255) NOT NULL,
  `CourseName` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
-- Table structure for table `lecturer`
--

CREATE TABLE `lecturer` (
  `LecturerId` int(11) NOT NULL,
  `UserId` int(11) NOT NULL,
  `UserTypeId` int(11) NOT NULL,
  `CourseId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE `location` (
  `LocationId` int(10) NOT NULL,
  `CountryCode` varchar(255) NOT NULL,
  `Town` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `papers`
--

CREATE TABLE `papers` (
  `PaperId` int(11) NOT NULL,
  `DateUpload` date DEFAULT NULL,
  `DateModerated` date DEFAULT NULL,
  `LecturerId` varchar(255) DEFAULT NULL,
  `ModeratorId` varchar(255) DEFAULT NULL,
  `StudentNumber` varchar(255) DEFAULT NULL,
  `CoordinatorId` varchar(255) DEFAULT NULL,
  `ClusterId` varchar(255) DEFAULT NULL,
  `PaperStatusID` int(255) DEFAULT NULL,
  `Abstract` blob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `paperstatus`
--

CREATE TABLE `paperstatus` (
  `PaperStatusID` int(11) NOT NULL,
  `StatusName` varchar(255) DEFAULT NULL COMMENT 'who can view which paper',
  `Description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `RoleID` int(11) NOT NULL,
  `RoleName` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`RoleID`, `RoleName`) VALUES
(1, 'admin'),
(2, 'moderator'),
(3, 'supervisor'),
(4, 'coordinator'),
(5, 'student');

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `StudentNumber` int(11) NOT NULL,
  `FirstName` varchar(255) DEFAULT NULL,
  `Surname` varchar(255) DEFAULT NULL,
  `Gender` varchar(255) DEFAULT NULL,
  `courseTypeId` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`StudentNumber`, `FirstName`, `Surname`, `Gender`, `courseTypeId`) VALUES
(200608444, 'Andrew', 'Muteka', 'male', 'Software Development');

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
  `UserLoginId` int(11) NOT NULL,
  `Username` varchar(255) DEFAULT NULL,
  `Password` varchar(72) CHARACTER SET utf8 NOT NULL COMMENT 'salted SHA256'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `UserID` int(11) NOT NULL,
  `Name` varchar(150) NOT NULL,
  `LastName` varchar(50) NOT NULL COMMENT 'aka loginname',
  `EMail` varchar(150) NOT NULL,
  `UserTypeId` varchar(11) NOT NULL DEFAULT '0' COMMENT 'binary system, not really documented yet',
  `UserLoginId` varchar(11) NOT NULL COMMENT 'two chars used as user-identifier for document IDs'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`UserID`, `Name`, `LastName`, `EMail`, `UserTypeId`, `UserLoginId`) VALUES
(1, 'admin', 'admin', 'doriva17@gmail.com', '255', 'AD'),
(2, 'Andrew', 'andrew', 'andrew@tumbare.com', '255', 'AN'),
(4, 'test1', 'test1', 'tewset1', '11', 'q'),
(5, 'test2', 'test2', 'test2', '11', 'qq'),
(6, 'Nic', 'Nic', 'Nic', '11', 'Nic'),
(7, 'John', 'Jon', 'ewrwer', '11', 'jo'),
(8, 'fdsafdsa', 'fsafsd', 'fasfd', 'fsafds', 'asdfdsads'),
(10, 'Joseph Muhepa', 'Mafo', 'mafo@nust.com', 'level 1', '1');

-- --------------------------------------------------------

--
-- Table structure for table `usertype`
--

CREATE TABLE `usertype` (
  `UserTypeId` int(11) NOT NULL,
  `TypeName` varchar(255) DEFAULT NULL,
  `UserDescription` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cluster`
--
ALTER TABLE `cluster`
  ADD PRIMARY KEY (`ClusterId`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`CID`),
  ADD KEY `fk_location` (`LocationId`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`CountryCode`),
  ADD UNIQUE KEY `Name` (`Name`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`CourseId`,`CourseDescription`);

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
-- Indexes for table `lecturer`
--
ALTER TABLE `lecturer`
  ADD PRIMARY KEY (`LecturerId`),
  ADD UNIQUE KEY `LecturerId` (`LecturerId`);

--
-- Indexes for table `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`LocationId`);

--
-- Indexes for table `papers`
--
ALTER TABLE `papers`
  ADD PRIMARY KEY (`PaperId`);

--
-- Indexes for table `paperstatus`
--
ALTER TABLE `paperstatus`
  ADD PRIMARY KEY (`PaperStatusID`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`RoleID`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`StudentNumber`),
  ADD UNIQUE KEY `studentNumber` (`StudentNumber`);

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
  ADD PRIMARY KEY (`UserLoginId`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserID`),
  ADD UNIQUE KEY `Name` (`Name`),
  ADD UNIQUE KEY `EMail` (`EMail`),
  ADD UNIQUE KEY `UIdent` (`UserLoginId`),
  ADD UNIQUE KEY `Nickname` (`LastName`),
  ADD UNIQUE KEY `Login` (`LastName`),
  ADD KEY `fk_userType` (`UserTypeId`);

--
-- Indexes for table `usertype`
--
ALTER TABLE `usertype`
  ADD PRIMARY KEY (`UserTypeId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cluster`
--
ALTER TABLE `cluster`
  MODIFY `ClusterId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `CID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `papers`
--
ALTER TABLE `papers`
  MODIFY `PaperId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `paperstatus`
--
ALTER TABLE `paperstatus`
  MODIFY `PaperStatusID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `RoleID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `TagID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `userloginaccount`
--
ALTER TABLE `userloginaccount`
  MODIFY `UserLoginId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `usertype`
--
ALTER TABLE `usertype`
  MODIFY `UserTypeId` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;