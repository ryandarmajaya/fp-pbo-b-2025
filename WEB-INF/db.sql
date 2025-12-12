-- ==========================================
-- Database: q2_webpro_2025
-- ==========================================

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP DATABASE IF EXISTS `q2_webpro_2025`;
CREATE DATABASE `q2_webpro_2025` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `q2_webpro_2025`;

-- ==========================================
-- 1. MASTER DATA TABLES
-- ==========================================

-- Table: role
CREATE TABLE `role` (
  `kode` int(10) unsigned NOT NULL,
  `nama` varchar(100) NOT NULL,
  PRIMARY KEY (`kode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `role` VALUES 
(1,'Administrator'),
(2,'Dosen'),
(3,'Tenaga Kependidikan'),
(4,'Mahasiswa');

-- Table: jenis_kelamin
CREATE TABLE `jenis_kelamin` (
  `kode` int(10) unsigned NOT NULL,
  `nama` varchar(100) NOT NULL,
  PRIMARY KEY (`kode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `jenis_kelamin` VALUES (1,'Laki - Laki'),(2,'Perempuan');

-- Table: jenjang
CREATE TABLE `jenjang` (
  `kode` int(10) unsigned NOT NULL,
  `nama` varchar(100) NOT NULL,
  PRIMARY KEY (`kode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `jenjang` VALUES (1,'S1'),(2,'S2'),(3,'S3'),(4,'D3'),(5,'D4');

-- ==========================================
-- 2. DEPENDENT TABLES (Level 1)
-- ==========================================

-- Table: prodi
CREATE TABLE `prodi` (
  `kode` int(10) unsigned NOT NULL,
  `nama` varchar(100) NOT NULL,
  `kode_jenjang` int(10) unsigned NOT NULL,
  PRIMARY KEY (`kode`),
  KEY `prodi_jenjang_FK` (`kode_jenjang`),
  CONSTRAINT `prodi_jenjang_FK` FOREIGN KEY (`kode_jenjang`) REFERENCES `jenjang` (`kode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `prodi` VALUES 
(1,'Sistem Informasi',1),
(2,'Teknik Informatika',1),
(3,'Manajemen',1),
(4,'Akuntansi',1),
(5,'Teknik Elektro',1),
(6,'Teknik Kimia',1),
(7,'Teknik Industri',1),
(8,'Teknik Mesin',1),
(9,'Teknik Sipil',1),
(10,'Manajemen Bisnis',2),
(11,'Teknik Komputer',4),
(12,'Sistem Informasi Bisnis',4),
(13,'Teknik Telekomunikasi',4);

-- Table: user
-- FIXED: Explicitly set charset to utf8mb4 to match 'mahasiswa' table later
CREATE TABLE `user` (
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `kode_role` int(10) unsigned NOT NULL,
  PRIMARY KEY (`username`),
  KEY `user_role_FK` (`kode_role`),
  CONSTRAINT `user_role_FK` FOREIGN KEY (`kode_role`) REFERENCES `role` (`kode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Passwords (MD5):
-- admin / admin -> 21232f297a57a5a743894a0e4a801fc3
-- dosen / dosen -> ce28eed1511f631af6b2a7bb0a85d636
-- tendik / tendik -> b8f8d5eba982ebdb42956582a429524f
-- mhs / 123456  -> e10adc3949ba59abbe56e057f20f883e

INSERT INTO `user` VALUES 
-- Admin & Staff
('admin','21232f297a57a5a743894a0e4a801fc3',1),
('budi_tendik', 'b8f8d5eba982ebdb42956582a429524f',3),
-- Dosen
('dosen_ti', 'ce28eed1511f631af6b2a7bb0a85d636',2),
('dosen_si', 'ce28eed1511f631af6b2a7bb0a85d636',2),
-- Mahasiswa (mhs01 - mhs15)
('mhs01', 'e10adc3949ba59abbe56e057f20f883e', 4),
('mhs02', 'e10adc3949ba59abbe56e057f20f883e', 4),
('mhs03', 'e10adc3949ba59abbe56e057f20f883e', 4),
('mhs04', 'e10adc3949ba59abbe56e057f20f883e', 4),
('mhs05', 'e10adc3949ba59abbe56e057f20f883e', 4),
('mhs06', 'e10adc3949ba59abbe56e057f20f883e', 4),
('mhs07', 'e10adc3949ba59abbe56e057f20f883e', 4),
('mhs08', 'e10adc3949ba59abbe56e057f20f883e', 4),
('mhs09', 'e10adc3949ba59abbe56e057f20f883e', 4),
('mhs10', 'e10adc3949ba59abbe56e057f20f883e', 4),
('mhs11', 'e10adc3949ba59abbe56e057f20f883e', 4),
('mhs12', 'e10adc3949ba59abbe56e057f20f883e', 4),
('mhs13', 'e10adc3949ba59abbe56e057f20f883e', 4),
('mhs14', 'e10adc3949ba59abbe56e057f20f883e', 4),
('mhs15', 'e10adc3949ba59abbe56e057f20f883e', 4);

-- ==========================================
-- 3. MAIN DATA TABLES (Level 2)
-- ==========================================

-- Table: mahasiswa
CREATE TABLE `mahasiswa` (
  `nim` varchar(20) NOT NULL,
  `nama` varchar(200) NOT NULL,
  `kode_jenis_kelamin` int(10) unsigned NOT NULL,
  `kode_prodi` int(10) unsigned NOT NULL,
  `username` varchar(100) NOT NULL,
  PRIMARY KEY (`nim`),
  KEY `mahasiswa_prodi_FK` (`kode_prodi`),
  KEY `mahasiswa_user_FK` (`username`),
  KEY `mahasiswa_jenis_kelamin_FK` (`kode_jenis_kelamin`),
  CONSTRAINT `mahasiswa_jenis_kelamin_FK` FOREIGN KEY (`kode_jenis_kelamin`) REFERENCES `jenis_kelamin` (`kode`),
  CONSTRAINT `mahasiswa_prodi_FK` FOREIGN KEY (`kode_prodi`) REFERENCES `prodi` (`kode`),
  CONSTRAINT `mahasiswa_user_FK` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `mahasiswa` VALUES 
('2025001', 'Andi Pratama', 1, 1, 'mhs01'),        -- Laki, TI
('2025002', 'Siti Aminah', 2, 2, 'mhs02'),         -- Perempuan, SI
('2025003', 'Rizky Ramadhan', 1, 1, 'mhs03'),      -- Laki, TI
('2025004', 'Dewi Kartika', 2, 4, 'mhs04'),        -- Perempuan, Akuntansi
('2025005', 'Bayu Saputra', 1, 5, 'mhs05'),        -- Laki, Elektro
('2025006', 'Nurul Hidayah', 2, 3, 'mhs06'),       -- Perempuan, Manajemen
('2025007', 'Fajar Nugraha', 1, 9, 'mhs07'),       -- Laki, Sipil
('2025008', 'Lestari Putri', 2, 6, 'mhs08'),       -- Perempuan, Kimia
('2025009', 'Eko Prasetyo', 1, 8, 'mhs09'),        -- Laki, Mesin
('2025010', 'Maya Sari', 2, 11, 'mhs10'),          -- Perempuan, Tek Komputer (D3)
('2025011', 'Hendra Wijaya', 1, 2, 'mhs11'),       -- Laki, SI
('2025012', 'Diana Puspita', 2, 7, 'mhs12'),       -- Perempuan, Industri
('2025013', 'Gilang Ramadhan', 1, 12, 'mhs13'),    -- Laki, SIB (D4)
('2025014', 'Rina Wati', 2, 1, 'mhs14'),           -- Perempuan, TI
('2025015', 'Agus Setiawan', 1, 10, 'mhs15');      -- Laki, Magister Manajemen (S2)

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;