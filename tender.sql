-- phpMyAdmin SQL Dump
-- version 4.9.4
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Янв 09 2020 г., 14:33
-- Версия сервера: 10.4.11-MariaDB-1:10.4.11+maria~eoan-log
-- Версия PHP: 7.2.26-1+ubuntu19.10.1+deb.sury.org+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `tender2`
--

-- --------------------------------------------------------

--
-- Структура таблицы `arhiv_prot`
--

CREATE TABLE `arhiv_prot` (
  `id` int(11) NOT NULL,
  `arhiv` varchar(1024) NOT NULL,
  `region` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `auction_end_applications`
--

CREATE TABLE `auction_end_applications` (
  `id` int(11) NOT NULL,
  `id_auction_end_protocol` int(11) NOT NULL,
  `journal_number` varchar(255) NOT NULL,
  `app_rating` int(11) NOT NULL,
  `admission` varchar(1024) NOT NULL,
  `id_participiant` int(11) NOT NULL,
  `result_zk` varchar(255) NOT NULL,
  `price` decimal(30,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `auction_end_protocol`
--

CREATE TABLE `auction_end_protocol` (
  `id` int(11) NOT NULL,
  `id_protocol` varchar(50) NOT NULL,
  `protocol_date` datetime NOT NULL,
  `purchase_number` varchar(255) NOT NULL,
  `url` varchar(1024) NOT NULL,
  `print_form` varchar(1024) NOT NULL,
  `xml` varchar(2000) NOT NULL,
  `type_protocol` varchar(128) NOT NULL,
  `cancel` tinyint(1) NOT NULL,
  `abandoned_reason_name` varchar(2000) NOT NULL,
  `lot_number` int(11) NOT NULL,
  `refusal_fact` varchar(4000) NOT NULL,
  `purchase_date` datetime NOT NULL,
  `purchase_name` varchar(2000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `auction_participant`
--

CREATE TABLE `auction_participant` (
  `id` int(11) NOT NULL,
  `inn` varchar(255) NOT NULL,
  `kpp` varchar(255) NOT NULL,
  `organization_name` varchar(2000) NOT NULL,
  `participant_type` varchar(20) NOT NULL,
  `country_full_name` varchar(200) NOT NULL,
  `post_address` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `region`
--

CREATE TABLE `region` (
  `id` int(11) NOT NULL,
  `okrug_id` int(11) NOT NULL,
  `name` text NOT NULL,
  `path` varchar(255) NOT NULL,
  `conf` varchar(11) NOT NULL,
  `path223` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `region`
--

INSERT INTO `region` (`id`, `okrug_id`, `name`, `path`, `conf`, `path223`) VALUES
(1, 2, 'Белгородская область', 'Belgorodskaja_obl', '31', 'Belgorodskaya_obl'),
(2, 2, 'Брянская область', 'Brjanskaja_obl', '32', 'Brianskaya_obl'),
(3, 2, 'Владимирская область', 'Vladimirskaja_obl', '33', 'Vladimirskaya_obl'),
(4, 2, 'Воронежская область', 'Voronezhskaja_obl', '36', 'Voronezhskaya_obl'),
(5, 2, 'Ивановская область', 'Ivanovskaja_obl', '37', 'Ivanowskaya_obl'),
(6, 2, 'Калужская область', 'Kaluzhskaja_obl', '40', 'Kaluzhskaya_obl'),
(7, 2, 'Костромская область', 'Kostromskaja_obl', '44', 'Kostromskaya_obl'),
(8, 2, 'Курская область', 'Kurskaja_obl', '46', 'Kurskaya_obl'),
(9, 2, 'Липецкая область', 'Lipeckaja_obl', '48', 'Lipetckaya_obl'),
(10, 2, 'Москва', 'Moskva', '77', 'Moskva'),
(11, 2, 'Московская область', 'Moskovskaja_obl', '50', 'Moskovskaya_obl'),
(12, 2, 'Орловская область', 'Orlovskaja_obl', '57', 'Orlovskaya_obl'),
(13, 2, 'Рязанская область', 'Rjazanskaja_obl', '62', 'Ryazanskaya_obl'),
(14, 2, 'Смоленская область', 'Smolenskaja_obl', '67', 'Smolenskaya_obl'),
(15, 2, 'Тамбовская область', 'Tambovskaja_obl', '68', 'Tambovskaya_obl'),
(16, 2, 'Тверская область', 'Tverskaja_obl', '69', 'Tverskaya_obl'),
(17, 2, 'Тульская область', 'Tulskaja_obl', '71', 'Tulskaya_obl'),
(18, 2, 'Ярославская область', 'Jaroslavskaja_obl', '76', 'Jaroslavskaya_obl'),
(19, 4, 'Архангельская область', 'Arkhangelskaja_obl', '29', 'Arhangelskaya_obl'),
(20, 4, 'Вологодская область', 'Vologodskaja_obl', '35', 'Vologodskaya_obl'),
(21, 4, 'Калининградская область', 'Kaliningradskaja_obl', '39', 'Kaliningradskaya_obl'),
(22, 4, 'Республика Карелия', 'Karelija_Resp', '10', 'Kareliya_Resp'),
(23, 4, 'Республика Коми', 'Komi_Resp', '11', 'Komi_Resp'),
(24, 4, 'Ленинградская область', 'Leningradskaja_obl', '47', 'Leningradskaya_obl'),
(25, 4, 'Мурманская область', 'Murmanskaja_obl', '51', 'Murmanskaya_obl'),
(26, 4, 'Ненецкий автономный округ', 'Neneckij_AO', '83', 'Nenetckii_AO'),
(27, 4, 'Новгородская область', 'Novgorodskaja_obl', '53', 'Novgorodskaya_obl'),
(28, 4, 'Псковская область', 'Pskovskaja_obl', '60', 'Pskovskaya_obl'),
(29, 4, 'Санкт-Петербург', 'Sankt-Peterburg', '78', 'Sankt-Peterburg'),
(30, 7, 'Республика Адыгея', 'Adygeja_Resp', '01', 'Adygeya_Resp'),
(31, 7, 'Астраханская область', 'Astrakhanskaja_obl', '30', 'Astrahanskaya_obl'),
(32, 7, 'Волгоградская область', 'Volgogradskaja_obl', '34', 'Volgogradskaya_obl'),
(33, 7, 'Республика Калмыкия', 'Kalmykija_Resp', '08', 'Kalmykiya_Resp'),
(34, 7, 'Краснодарский край', 'Krasnodarskij_kraj', '23', 'Krasnodarskii_krai'),
(35, 7, 'Ростовская область', 'Rostovskaja_obl', '61', 'Rostovskaya_obl'),
(36, 9, 'Республика Дагестан', 'Dagestan_Resp', '05', 'Dagestan_Resp'),
(37, 9, 'Республика Ингушетия', 'Ingushetija_Resp', '06', 'Ingushetiya_Resp'),
(38, 9, 'Кабардино-Балкарская Республика', 'Kabardino-Balkarskaja_Resp', '07', 'Kabardino-Balkarskaya_Resp'),
(39, 9, 'Карачаево-Черкесская Республика', 'Karachaevo-Cherkesskaja_Resp', '09', 'Karachaevo-Cherkesskaya_Resp'),
(40, 9, 'Республика Северная Осетия — Алания', 'Severnaja_Osetija-Alanija_Resp', '15', 'Severnaia_Osetiya_Alaniia_Resp'),
(41, 9, 'Ставропольский край', 'Stavropolskij_kraj', '26', 'Stavropolskii_krai'),
(42, 9, 'Чеченская Республика', 'Chechenskaja_Resp', '20', 'Chechenskaya_Resp'),
(43, 3, 'Республика Башкортостан', 'Bashkortostan_Resp', '02', 'Bashkortostan_Resp'),
(44, 3, 'Кировская область', 'Kirovskaja_obl', '43', 'Kirowskaya_obl'),
(45, 3, 'Республика Марий Эл', 'Marij_El_Resp', '12', 'Marii_El_Resp'),
(46, 3, 'Республика Мордовия', 'Mordovija_Resp', '13', 'Mordoviya_Resp'),
(47, 3, 'Нижегородская область', 'Nizhegorodskaja_obl', '52', 'Nizhegorodskaya_obl'),
(48, 3, 'Оренбургская область', 'Orenburgskaja_obl', '56', 'Orenburgskaya_obl'),
(49, 3, 'Пензенская область', 'Penzenskaja_obl', '58', 'Penzenskaya_obl'),
(50, 3, 'Пермский край', 'Permskij_kraj', '59', 'Permskii_krai'),
(51, 3, 'Самарская область', 'Samarskaja_obl', '63', 'Samarskaya_obl'),
(52, 3, 'Саратовская область', 'Saratovskaja_obl', '64', 'Saratovskaya_obl'),
(53, 3, 'Республика Татарстан', 'Tatarstan_Resp', '16', 'Tatarstan_Resp'),
(54, 3, 'Удмуртская Республика', 'Udmurtskaja_Resp', '18', 'Udmurtskaya_Resp'),
(55, 3, 'Ульяновская область', 'Uljanovskaja_obl', '73', 'Ulianovskaya_obl'),
(56, 3, 'Чувашская Республика', 'Chuvashskaja_Resp', '21', 'Chuvashskaya_Respublika'),
(57, 6, 'Курганская область', 'Kurganskaja_obl', '45', 'Kurganskaya_obl'),
(58, 6, 'Свердловская область', 'Sverdlovskaja_obl', '66', 'Sverdlovskaya_obl'),
(59, 6, 'Тюменская область', 'Tjumenskaja_obl', '72', 'Tiumenskaya_obl'),
(60, 6, 'Ханты-Мансийский автономный округ — Югра', 'Khanty-Mansijskij_AO-Jugra_AO', '86', 'Hanty-Mansiiskii_AO_Iugra_AO'),
(61, 6, 'Челябинская область', 'Cheljabinskaja_obl', '74', 'Cheliabinskaya_obl'),
(62, 6, 'Ямало-Ненецкий автономный округ', 'Jamalo-Neneckij_AO', '89', 'Jamalo-Nenetckii_AO'),
(63, 5, 'Республика Алтай', 'Altaj_Resp', '04', 'Altay_Resp'),
(64, 5, 'Алтайский край', 'Altajskij_kraj', '22', 'Altayskii__krai'),
(65, 1, 'Республика Бурятия', 'Burjatija_Resp', '03', 'Buryatiya_Resp'),
(66, 1, 'Забайкальский край', 'Zabajkalskij_kraj', '75', 'Zabaikalskii_krai'),
(67, 5, 'Иркутская область', 'Irkutskaja_obl', '38', 'Irkutskaya_obl'),
(68, 5, 'Кемеровская область', 'Kemerovskaja_obl', '42', 'Kemerowskaya_obl'),
(69, 5, 'Красноярский край', 'Krasnojarskij_kraj', '24', 'Krasnoyarskii_krai'),
(70, 5, 'Новосибирская область', 'Novosibirskaja_obl', '54', 'Novosibirskaya_obl'),
(71, 5, 'Омская область', 'Omskaja_obl', '55', 'Omskaya_obl'),
(72, 5, 'Томская область', 'Tomskaja_obl', '70', 'Tomskaya_obl'),
(73, 5, 'Республика Тыва', 'Tyva_Resp', '17', 'Tyva_Resp'),
(74, 5, 'Республика Хакасия', 'Khakasija_Resp', '19', 'Hakasiia_Resp'),
(75, 1, 'Амурская область', 'Amurskaja_obl', '28', 'Amurskaya_obl'),
(76, 1, 'Еврейская автономная область', 'Evrejskaja_Aobl', '79', 'Evreiskaya_Aobl'),
(77, 1, 'Камчатский край', 'Kamchatskij_kraj', '41', 'Kamchatskii_krai'),
(78, 1, 'Магаданская область', 'Magadanskaja_obl', '49', 'Magadanskaya_obl'),
(79, 1, 'Приморский край', 'Primorskij_kraj', '25', 'Primorskii_krai'),
(80, 1, 'Республика Саха (Якутия)', 'Sakha_Jakutija_Resp', '14', 'Saha_Jakutiya_Resp'),
(81, 1, 'Сахалинская область', 'Sakhalinskaja_obl', '65', 'Sahalinskaya_obl'),
(82, 1, 'Хабаровский край', 'Khabarovskij_kraj', '27', 'Habarovskii_krai'),
(83, 1, 'Чукотский автономный округ', 'Chukotskij_AO', '87', 'Chukotskii_AO'),
(84, 8, 'Республика Крым', 'Krim_Resp', '91', 'Krym_Resp'),
(85, 8, 'Город федерального значения Севастополь', 'Sevastopol_g', '92', 'Sevastopol'),
(86, 10, 'Город федерального значения Байконур', 'Bajkonur_g', '-', 'Baikonur_g'),
(88, 0, 'Неопределено', 'fcs_undefined', '-', 'undefined'),
(89, 5, 'Усть-Ордынский Бурятский округ', 'Irkutskaya_obl_Ust-Ordynskii_Buriatskii_okrug', '38', 'Irkutskaya_obl_Ust-Ordynskii_Buriatskii_okrug'),
(90, 1, 'Агинский Бурятский округ', 'Zabaikalskii_krai_Aginskii_Buriatskii_okrug', '75', 'Zabaikalskii_krai_Aginskii_Buriatskii_okrug');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `arhiv_prot`
--
ALTER TABLE `arhiv_prot`
  ADD PRIMARY KEY (`id`),
  ADD KEY `arhiv` (`arhiv`(255)),
  ADD KEY `region` (`region`),
  ADD KEY `arhiv_2` (`arhiv`(255),`region`);

--
-- Индексы таблицы `auction_end_applications`
--
ALTER TABLE `auction_end_applications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `journal_number` (`journal_number`),
  ADD KEY `id_participiant` (`id_participiant`),
  ADD KEY `id_auction_end_protocol` (`id_auction_end_protocol`);

--
-- Индексы таблицы `auction_end_protocol`
--
ALTER TABLE `auction_end_protocol`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchase_number` (`purchase_number`),
  ADD KEY `id_protocol` (`id_protocol`),
  ADD KEY `cancel` (`cancel`),
  ADD KEY `lot_number` (`lot_number`);

--
-- Индексы таблицы `auction_participant`
--
ALTER TABLE `auction_participant`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inn` (`inn`),
  ADD KEY `kpp` (`kpp`),
  ADD KEY `inn_2` (`inn`,`kpp`);

--
-- Индексы таблицы `region`
--
ALTER TABLE `region`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `arhiv_prot`
--
ALTER TABLE `arhiv_prot`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `auction_end_applications`
--
ALTER TABLE `auction_end_applications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `auction_end_protocol`
--
ALTER TABLE `auction_end_protocol`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `auction_participant`
--
ALTER TABLE `auction_participant`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `region`
--
ALTER TABLE `region`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;