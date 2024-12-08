-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 18, 2024 at 12:57 PM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `simkos`
--

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `id_booking` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_kamar` int(11) NOT NULL,
  `tanggal_masuk` date NOT NULL,
  `hitungan_sewa` int(11) NOT NULL,
  `durasi_sewa` int(11) NOT NULL,
  `tanggal_keluar` date NOT NULL,
  `jumlah_kamar` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`id_booking`, `id_user`, `id_kamar`, `tanggal_masuk`, `hitungan_sewa`, `durasi_sewa`, `tanggal_keluar`, `jumlah_kamar`) VALUES
(1, 34, 3, '2024-04-30', 3, 2, '2024-06-30', 1),
(2, 34, 4, '2024-05-19', 3, 2, '2024-07-19', 1),
(8, 34, 1, '2024-05-17', 3, 1, '2024-06-17', 1),
(9, 34, 1, '2024-05-14', 3, 1, '2024-06-14', 1),
(10, 34, 1, '2024-05-22', 3, 1, '2024-06-22', 1),
(11, 34, 1, '2024-05-22', 3, 2, '2024-07-22', 1),
(12, 34, 1, '2024-05-22', 3, 2, '2024-07-22', 1),
(18, 34, 1, '2024-05-09', 3, 2, '2024-07-09', 1),
(19, 34, 1, '2024-05-15', 3, 2, '2024-07-15', 1),
(20, 34, 1, '2024-05-19', 3, 1, '2024-06-19', 1),
(21, 34, 2, '2024-06-18', 3, 1, '2024-07-18', 1);

--
-- Triggers `booking`
--
DELIMITER $$
CREATE TRIGGER `update_kamar` AFTER INSERT ON `booking` FOR EACH ROW BEGIN
	UPDATE kamar SET jumlah_kamar=jumlah_kamar-NEW.jumlah_kamar
    WHERE id_kamar=NEW.id_kamar;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `kamar`
--

CREATE TABLE `kamar` (
  `id_kamar` int(11) NOT NULL,
  `id_kost` int(11) NOT NULL,
  `jumlah_kamar` int(11) NOT NULL,
  `panjang_kamar` int(11) NOT NULL,
  `lebar_kamar` int(11) NOT NULL,
  `tipe_kamar` varchar(255) NOT NULL,
  `biaya_fasilitas` int(11) NOT NULL,
  `fasilitas_kamar` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `kamar`
--

INSERT INTO `kamar` (`id_kamar`, `id_kost`, `jumlah_kamar`, `panjang_kamar`, `lebar_kamar`, `tipe_kamar`, `biaya_fasilitas`, `fasilitas_kamar`) VALUES
(1, 4, 4, 4, 4, 'kamar mandi dalam', 100000, 'Tempat Tidur, TV, Kulkas'),
(2, 4, 1, 3, 3, 'kamar mandi luar', 50000, 'Tempat Tidur, Lemari, Kipas Angin'),
(3, 4, 3, 5, 3, 'kamar mandi luar', 231, 'Lemari, TV'),
(4, 10, 3, 4, 4, 'kamar mandi dalam', 10000, 'TV');

--
-- Triggers `kamar`
--
DELIMITER $$
CREATE TRIGGER `after_update` AFTER UPDATE ON `kamar` FOR EACH ROW BEGIN
	UPDATE kost SET jumlah_kamar=jumlah_kamar-1
	WHERE id_kost=NEW.id_kost;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `hapus_kamar` AFTER DELETE ON `kamar` FOR EACH ROW UPDATE kost SET kost.jumlah_kamar = kost.jumlah_kamar-old.jumlah_kamar
WHERE kost.id_kost=old.id_kost
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `total_kamar` AFTER INSERT ON `kamar` FOR EACH ROW BEGIN
	UPDATE kost SET jumlah_kamar=jumlah_kamar+NEW.jumlah_kamar
	WHERE id_kost=NEW.id_kost;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `kost`
--

CREATE TABLE `kost` (
  `id_kost` int(11) NOT NULL,
  `nama_kost` varchar(255) NOT NULL,
  `tipe_kost` varchar(255) NOT NULL,
  `jenis_kost` varchar(255) NOT NULL,
  `jumlah_kamar` int(11) NOT NULL,
  `tanggal_tagih` date NOT NULL,
  `nama_pemilik` text NOT NULL,
  `nama_bank` text NOT NULL,
  `no_rekening` int(11) NOT NULL,
  `foto_bangunan_utama` varchar(255) NOT NULL,
  `foto_kamar` varchar(255) NOT NULL,
  `foto_kamar_mandi` varchar(255) NOT NULL,
  `foto_interior` varchar(255) NOT NULL,
  `provinsi` varchar(25) NOT NULL,
  `kota` varchar(25) NOT NULL,
  `kecamatan` varchar(25) NOT NULL,
  `kelurahan` varchar(25) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `harga_sewa` int(11) NOT NULL,
  `kontak` varchar(255) NOT NULL,
  `deskripsi` text NOT NULL,
  `id_pemilik` int(11) NOT NULL,
  `fasilitas_kost` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `kost`
--

INSERT INTO `kost` (`id_kost`, `nama_kost`, `tipe_kost`, `jenis_kost`, `jumlah_kamar`, `tanggal_tagih`, `nama_pemilik`, `nama_bank`, `no_rekening`, `foto_bangunan_utama`, `foto_kamar`, `foto_kamar_mandi`, `foto_interior`, `provinsi`, `kota`, `kecamatan`, `kelurahan`, `alamat`, `harga_sewa`, `kontak`, `deskripsi`, `id_pemilik`, `fasilitas_kost`) VALUES
(4, 'Kost Eross I', 'Tahun', 'Putra', 0, '2020-03-13', 'Rafi', 'Mandiri', 812345678, 'kamar.jpg', 'bg.jpg', 'kamarmandi.jpg', 'interior.jpg', 'Jawa tengah', 'Semarang', 'Semarang Utara', 'Bulu lor', 'Jl. erowati selatan no.1', 600000, '+6281361735597', 'Kost Putra, memiliki fasilitas terbaik , Dekat kampus UDINUS', 32, 'WIFI/Internet, Ruang Makan, Dapur'),
(7, 'Kost Eross II', 'Bulan', 'Putra', 20, '2020-03-21', 'Rafi', 'Mandiri', 3262622, 'kamar2.jpg', 'ErossII.png', 'kamarmandidlm.jpg', '', 'Jawa tengah', 'Semarang', 'Semarang Utara', 'Bulu lor', 'Jl. Erowati Raya', 700000, '081361735597', 'tempat kos anak UDINUS', 32, 'WIFI/Internet'),
(8, 'Kost Eross III', 'Bulan', 'Putra', 0, '2020-03-27', 'Rafi', 'BCA', 2147483647, 'kamar2.jpg', 'ErossIII.png', 'kamarmandi.jpg', '', 'Jawa tengah', 'Semarang', 'Semarang Utara', 'Bulu lor', 'Jl. Surtikanti Tengah I no.5', 600000, '081361735597', 'Kost Putri nyaman mantap minimalis', 32, 'WIFI/Internet, Laundry'),
(9, 'Kost Eross IV', 'Bulan', 'Putri', 10, '2024-05-19', 'Rafi', 'Mandiri', 923334124, 'kamar2.jpg', 'ErossIV.png', 'kamarmandidlm.jpg', '', 'Jawa tengah', 'Semarang', 'Semarang Utara', 'Bulu lor', 'Jl. Banowati raya', 1500000, '081361735597', 'Kost gaya classic terbaik', 32, 'Parkir Mobil, WIFI/Internet, Security, Ruang Tamu, Dapur'),
(10, 'Kost Eross V', 'Bulan', 'Campuran', 3, '2024-05-01', 'Rafi', 'BCA', 281137390, 'kamar2.jpg', 'ErossV.png', 'kamarmandidlm.jpg', '', 'Jawa tengah', 'Semarang', 'Semarang Utara', 'Bulu lor', 'Jl. Surtikanti Tengah II no.12', 1000000, '+6281361735597', 'Eksklusif', 32, 'WIFI/Internet, Ruang Tamu, Dapur');

-- --------------------------------------------------------

--
-- Table structure for table `rating`
--

CREATE TABLE `rating` (
  `id_rating` int(11) NOT NULL,
  `Id_kost` int(11) NOT NULL,
  `Id_user` int(11) NOT NULL,
  `score` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `roles_user`
--

CREATE TABLE `roles_user` (
  `id_roles` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `roles_user`
--

INSERT INTO `roles_user` (`id_roles`, `nama`) VALUES
(1, 'penghuni kost'),
(2, 'pemilik kost'),
(3, 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `tagihan`
--

CREATE TABLE `tagihan` (
  `no_tagihan` int(11) NOT NULL,
  `no_booking` int(11) NOT NULL,
  `total_tagihan` int(11) NOT NULL,
  `stats` int(11) NOT NULL,
  `tanggal_tagihan` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `bukti_bayar` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tagihan`
--

INSERT INTO `tagihan` (`no_tagihan`, `no_booking`, `total_tagihan`, `stats`, `tanggal_tagihan`, `bukti_bayar`) VALUES
(1, 1, 750462, 1, '2024-05-19 18:17:17', '2.PNG'),
(2, 2, 20020000, 1, '2024-05-19 13:11:51', '2.2.PNG'),
(3, 8, 150000, 1, '2024-05-21 06:26:04', 'jersey3.png'),
(4, 9, 150000, 1, '2024-05-21 06:26:36', 'jersey2.png'),
(5, 10, 150000, 1, '2024-05-21 06:26:44', 'jersey4.png'),
(6, 11, 300000, 1, '2024-05-21 06:26:28', 'Screenshot 2024-03-31 185031.png'),
(7, 12, 300000, 1, '2024-05-21 13:39:31', 'LOGO UPN.jpg'),
(8, 18, 300000, 1, '2024-05-21 13:39:37', 'LOGO UPN.jpg'),
(9, 19, 300000, 1, '2024-06-17 17:30:22', 'LOGO UPN.jpg'),
(10, 20, 150000, 1, '2024-06-18 06:54:00', 'b-s.PNG'),
(11, 21, 100000, 1, '2024-06-18 10:34:05', 'Dashboard Customer.png');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `nama_lengkap` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `no_hp` varchar(255) NOT NULL,
  `pekerjaan` varchar(255) NOT NULL,
  `jenis_kelamin` varchar(25) NOT NULL,
  `foto_ktp` varchar(255) NOT NULL,
  `foto_profil` text NOT NULL,
  `roles` int(11) NOT NULL,
  `id_kost_saya` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `nama_lengkap`, `email`, `username`, `password`, `no_hp`, `pekerjaan`, `jenis_kelamin`, `foto_ktp`, `foto_profil`, `roles`, `id_kost_saya`) VALUES
(22, 'Pak Deta', 'deta@mail.com', 'deta', 'deta', '082147483647', 'deta owner', ' laki-laki', '', 'pexels-photo-2340978.jpeg', 2, 0),
(25, 'Muhammad Iqbal', 'muhiqsimui@gmail.com', 'user', 'user', '082133771248', 'Mahasiswa', '         laki-laki', 'Capture.PNG', 'ada.PNG', 1, 0),
(26, 'deta2', 'deta2@mail.com', 'deta2', 'deta2', '2222222', 'Programmer', '  laki-laki', 'ele.jpg', 'pexels-photo-3779677.jpeg', 2, 0),
(30, 'admin', '', 'admin', 'admin', '0', '', '', '', '', 3, 0),
(31, 'Jhon Dee', 'deta3@mail.com', 'deta3', 'deta3', '0433211452', 'Programmer', '  laki-laki', 'www.drawesome.uy-vac46s66tb.png', 'pexels-photo-220453.jpeg', 2, 0),
(32, 'Rachmanda Rafi', 'rafirasyid94@gmail.com', 'rafi', '12345678', '6287732787325', 'penjudi', '   laki-laki', '2.2.PNG', 'jersey3.png', 2, 0),
(33, 'Rachmanda Rafi', 'rafirasyid94@gmail.com', 'rafi', '12345678', '6287732787325', 'penjudi', '   laki-laki', '', 'jersey3.png', 2, 0),
(34, 'Micel', 'jijo@gmail.com', 'mike', '123', '081212746847234', 'model', '    laki-laki', 'iqbaal.jpg', 'jersey3.png', 1, 0),
(35, 'Rachmanda Rafi', 'rafirasyid94@gmail.com', 'rafi', '123', '6287732787325', 'penjudi', '   laki-laki', '', 'jersey3.png', 2, 0);

-- --------------------------------------------------------

--
-- Table structure for table `wishlist`
--

CREATE TABLE `wishlist` (
  `id_wishlist` int(11) NOT NULL,
  `id_kost` int(11) NOT NULL,
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `wishlist`
--

INSERT INTO `wishlist` (`id_wishlist`, `id_kost`, `id_user`) VALUES
(1, 10, 34),
(2, 4, 34);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`id_booking`),
  ADD KEY `id_user` (`id_user`,`id_kamar`),
  ADD KEY `id_kamar` (`id_kamar`);

--
-- Indexes for table `kamar`
--
ALTER TABLE `kamar`
  ADD PRIMARY KEY (`id_kamar`),
  ADD KEY `id_kost` (`id_kost`);

--
-- Indexes for table `kost`
--
ALTER TABLE `kost`
  ADD PRIMARY KEY (`id_kost`),
  ADD KEY `id_pemilik` (`id_pemilik`);

--
-- Indexes for table `rating`
--
ALTER TABLE `rating`
  ADD PRIMARY KEY (`id_rating`),
  ADD KEY `Id_kost` (`Id_kost`),
  ADD KEY `Id_user` (`Id_user`);

--
-- Indexes for table `roles_user`
--
ALTER TABLE `roles_user`
  ADD PRIMARY KEY (`id_roles`);

--
-- Indexes for table `tagihan`
--
ALTER TABLE `tagihan`
  ADD PRIMARY KEY (`no_tagihan`),
  ADD KEY `no_booking` (`no_booking`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_kost_saya` (`id_kost_saya`),
  ADD KEY `roles` (`roles`);

--
-- Indexes for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD PRIMARY KEY (`id_wishlist`),
  ADD KEY `id_kost` (`id_kost`),
  ADD KEY `id_user` (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `id_booking` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `kamar`
--
ALTER TABLE `kamar`
  MODIFY `id_kamar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `kost`
--
ALTER TABLE `kost`
  MODIFY `id_kost` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `rating`
--
ALTER TABLE `rating`
  MODIFY `id_rating` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles_user`
--
ALTER TABLE `roles_user`
  MODIFY `id_roles` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tagihan`
--
ALTER TABLE `tagihan`
  MODIFY `no_tagihan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `wishlist`
--
ALTER TABLE `wishlist`
  MODIFY `id_wishlist` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `booking_ibfk_3` FOREIGN KEY (`id_kamar`) REFERENCES `kamar` (`id_kamar`);

--
-- Constraints for table `kamar`
--
ALTER TABLE `kamar`
  ADD CONSTRAINT `kamar_ibfk_1` FOREIGN KEY (`id_kost`) REFERENCES `kost` (`id_kost`);

--
-- Constraints for table `kost`
--
ALTER TABLE `kost`
  ADD CONSTRAINT `kost_ibfk_1` FOREIGN KEY (`id_pemilik`) REFERENCES `user` (`id`);

--
-- Constraints for table `rating`
--
ALTER TABLE `rating`
  ADD CONSTRAINT `rating_ibfk_1` FOREIGN KEY (`Id_kost`) REFERENCES `kost` (`id_kost`),
  ADD CONSTRAINT `rating_ibfk_2` FOREIGN KEY (`Id_user`) REFERENCES `user` (`id`);

--
-- Constraints for table `tagihan`
--
ALTER TABLE `tagihan`
  ADD CONSTRAINT `tagihan_ibfk_1` FOREIGN KEY (`no_booking`) REFERENCES `booking` (`id_booking`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`roles`) REFERENCES `roles_user` (`id_roles`);

--
-- Constraints for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD CONSTRAINT `wishlist_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `wishlist_ibfk_2` FOREIGN KEY (`id_kost`) REFERENCES `kost` (`id_kost`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
