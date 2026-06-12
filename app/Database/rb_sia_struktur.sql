-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 12, 2026 at 10:37 AM
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
-- Database: `rb_sia`
--

-- --------------------------------------------------------

--
-- Table structure for table `absensi`
--

CREATE TABLE `absensi` (
  `id` int UNSIGNED NOT NULL,
  `id_karyawan` int UNSIGNED NOT NULL,
  `tanggal` date NOT NULL,
  `tipe` enum('Hadir','Izin','Sakit') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Hadir',
  `jam_masuk` time DEFAULT NULL,
  `jam_keluar` time DEFAULT NULL,
  `foto_masuk` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `foto_keluar` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `surat_izin` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `lokasi_masuk` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `lokasi_keluar` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `jam_kerja_normal` decimal(5,2) NOT NULL DEFAULT '8.00',
  `total_jam_kerja` decimal(5,2) DEFAULT NULL,
  `jam_lembur` decimal(5,2) NOT NULL DEFAULT '0.00',
  `keterangan` text COLLATE utf8mb4_general_ci,
  `dibuat_pada` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `accounts_payable`
--

CREATE TABLE `accounts_payable` (
  `id` int UNSIGNED NOT NULL,
  `id_pemasok` int UNSIGNED NOT NULL,
  `nomor_invoice` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tanggal` date NOT NULL,
  `jatuh_tempo` date NOT NULL,
  `jumlah` decimal(15,2) NOT NULL,
  `sisa` decimal(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `accounts_receivable`
--

CREATE TABLE `accounts_receivable` (
  `id` int UNSIGNED NOT NULL,
  `sumber` enum('manual','roastery','katering') COLLATE utf8mb4_general_ci DEFAULT 'manual',
  `sumber_id` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'id_invoice dari penjualan_roastery jika sumber=roastery',
  `nama_pihak_ext` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Nama pelanggan roastery (jika tidak ada di tabel customers)',
  `id_pelanggan` int UNSIGNED DEFAULT NULL,
  `nomor_invoice` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tanggal` date NOT NULL,
  `jatuh_tempo` date NOT NULL,
  `jumlah` decimal(15,2) NOT NULL,
  `sisa` decimal(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `asset_categories`
--

CREATE TABLE `asset_categories` (
  `id` int UNSIGNED NOT NULL,
  `nama` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `keterangan` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `coa`
--

CREATE TABLE `coa` (
  `kode_akun` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `nama_akun` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `kategori` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `saldo_normal` enum('debit','kredit') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'debit'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int UNSIGNED NOT NULL,
  `nama` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `kontak_person` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `telepon` varchar(15) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` int UNSIGNED NOT NULL,
  `nama_departemen` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `keterangan` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `depreciation_entries`
--

CREATE TABLE `depreciation_entries` (
  `id` int UNSIGNED NOT NULL,
  `id_aset` int UNSIGNED NOT NULL,
  `tahun_periode` year NOT NULL,
  `bulan_periode` tinyint UNSIGNED NOT NULL,
  `jumlah_penyusutan` decimal(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `detail_invoice`
--

CREATE TABLE `detail_invoice` (
  `id_detail_invoice` varchar(15) COLLATE utf8mb4_general_ci NOT NULL,
  `id_invoice` varchar(15) COLLATE utf8mb4_general_ci NOT NULL,
  `id_produk` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `nama_produk` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'snapshot nama saat invoice terbit',
  `quantity` int UNSIGNED NOT NULL DEFAULT '1',
  `harga_satuan` decimal(12,2) NOT NULL,
  `standard_cost` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT 'snapshot standard_cost saat invoice',
  `subtotal` decimal(14,2) NOT NULL DEFAULT '0.00',
  `hpp_subtotal` decimal(14,2) NOT NULL DEFAULT '0.00' COMMENT '= quantity × standard_cost'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `detail_order`
--

CREATE TABLE `detail_order` (
  `id_detail` int UNSIGNED NOT NULL,
  `id_pesanan` varchar(15) COLLATE utf8mb4_general_ci NOT NULL,
  `id_menu` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `nama_menu` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'snapshot nama saat order',
  `kategori` enum('drink','Food') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'drink' COMMENT 'snapshot: penentu akun GL (4-1100 vs 4-1200)',
  `qty_menu` int UNSIGNED NOT NULL DEFAULT '1',
  `harga_saat_pesan` decimal(12,2) NOT NULL COMMENT 'snapshot harga_jual saat order',
  `standard_cost` decimal(12,2) NOT NULL COMMENT 'snapshot standard_cost — basis hitung HPP GL',
  `subtotal` decimal(14,2) NOT NULL DEFAULT '0.00',
  `hpp_subtotal` decimal(14,2) NOT NULL DEFAULT '0.00' COMMENT '= qty × standard_cost, diisi otomatis'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` int UNSIGNED NOT NULL,
  `id_pengguna` int UNSIGNED DEFAULT NULL,
  `nama_lengkap` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `nik` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `alamat` text COLLATE utf8mb4_general_ci,
  `no_telp` varchar(15) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `id_departemen` int UNSIGNED DEFAULT NULL,
  `id_jabatan` int UNSIGNED DEFAULT NULL,
  `tgl_masuk` date DEFAULT NULL,
  `status` enum('Tetap','Kontrak') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Tetap'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `fixed_assets`
--

CREATE TABLE `fixed_assets` (
  `id` int UNSIGNED NOT NULL,
  `kode_aset` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `nama_aset` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `id_kategori` int UNSIGNED NOT NULL,
  `tanggal_perolehan` date NOT NULL,
  `harga_perolehan` decimal(15,2) NOT NULL,
  `umur_ekonomis` int NOT NULL,
  `nilai_residu` decimal(15,2) NOT NULL DEFAULT '0.00',
  `metode_penyusutan` enum('straight-line') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'straight-line',
  `kode_akun_aset` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `kode_akun_akumulasi_penyusutan` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `kode_akun_beban_penyusutan` varchar(10) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `general_ledger`
--

CREATE TABLE `general_ledger` (
  `id` int UNSIGNED NOT NULL,
  `kode_akun` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `tahun_periode` year NOT NULL,
  `bulan_periode` tinyint UNSIGNED NOT NULL,
  `saldo_awal` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total_debit` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total_kredit` decimal(15,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gl_entries`
--

CREATE TABLE `gl_entries` (
  `id` bigint UNSIGNED NOT NULL,
  `sumber_tipe` enum('PEMBAYARAN_CAFE','INVOICE_ROASTERY_TERBIT','INVOICE_ROASTERY_LUNAS') COLLATE utf8mb4_general_ci NOT NULL,
  `sumber_id` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'id_pembayaran atau id_invoice',
  `tanggal` date NOT NULL,
  `kode_akun` varchar(10) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'FK ke coa.kode_akun',
  `nama_akun` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'snapshot nama akun',
  `debit` decimal(14,2) NOT NULL DEFAULT '0.00',
  `kredit` decimal(14,2) NOT NULL DEFAULT '0.00',
  `keterangan` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `good_receipts`
--

CREATE TABLE `good_receipts` (
  `id` int UNSIGNED NOT NULL,
  `id_po` int UNSIGNED NOT NULL,
  `tanggal_terima` date NOT NULL,
  `keterangan` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `good_receipt_items`
--

CREATE TABLE `good_receipt_items` (
  `id` int UNSIGNED NOT NULL,
  `id_penerimaan` int UNSIGNED NOT NULL,
  `id_po_item` int UNSIGNED NOT NULL,
  `jumlah_diterima` int UNSIGNED NOT NULL,
  `keterangan` text COLLATE utf8mb4_general_ci,
  `tanggal_terima_item` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `jenis_layanan`
--

CREATE TABLE `jenis_layanan` (
  `id_jenis` int UNSIGNED NOT NULL,
  `nama_layanan` varchar(50) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `journals`
--

CREATE TABLE `journals` (
  `id` int UNSIGNED NOT NULL,
  `nomor_jurnal` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `tanggal_jurnal` date NOT NULL,
  `keterangan` text COLLATE utf8mb4_general_ci,
  `referensi` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tipe` enum('regular','adjustment') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'regular',
  `status` enum('draft','posted') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'posted'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `journal_adjustments`
--

CREATE TABLE `journal_adjustments` (
  `id` int UNSIGNED NOT NULL,
  `nomor_jurnal` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `tanggal_jurnal` date NOT NULL,
  `keterangan` text COLLATE utf8mb4_general_ci,
  `referensi` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tipe` enum('regular','adjustment') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'adjustment',
  `status` enum('draft','posted') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'posted'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `journal_adjustment_details`
--

CREATE TABLE `journal_adjustment_details` (
  `id` int UNSIGNED NOT NULL,
  `id_jurnal` int UNSIGNED NOT NULL,
  `kode_akun` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `debit` decimal(15,2) NOT NULL DEFAULT '0.00',
  `kredit` decimal(15,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `journal_details`
--

CREATE TABLE `journal_details` (
  `id` int UNSIGNED NOT NULL,
  `id_jurnal` int UNSIGNED NOT NULL,
  `kode_akun` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `debit` decimal(15,2) NOT NULL DEFAULT '0.00',
  `kredit` decimal(15,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `meja`
--

CREATE TABLE `meja` (
  `id_meja` int UNSIGNED NOT NULL,
  `nomor_meja` int UNSIGNED NOT NULL,
  `status_meja` enum('Tersedia','Terisi','Reservasi') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Tersedia'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `menu_cafe`
--

CREATE TABLE `menu_cafe` (
  `id_menu` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `kode_menu` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `nama_menu` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `kategori` enum('drink','Food') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'drink',
  `harga_jual` decimal(12,2) NOT NULL,
  `standard_cost` decimal(12,2) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `menu_roastery`
--

CREATE TABLE `menu_roastery` (
  `id_produk` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `kode_produk` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `nama_produk` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `harga_jual` decimal(12,2) NOT NULL,
  `standard_cost` decimal(12,2) NOT NULL COMMENT 'basis HPP roastery → 5-1300',
  `is_active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` bigint UNSIGNED NOT NULL,
  `version` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `class` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `group` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `namespace` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `time` int NOT NULL,
  `batch` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `owner_signatures`
--

CREATE TABLE `owner_signatures` (
  `id` int UNSIGNED NOT NULL,
  `nama_owner` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `tanda_tangan` longtext COLLATE utf8mb4_general_ci,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `payment_history`
--

CREATE TABLE `payment_history` (
  `id` int UNSIGNED NOT NULL,
  `id_utang` int UNSIGNED NOT NULL,
  `tanggal_bayar` date NOT NULL,
  `jumlah_bayar` decimal(15,2) NOT NULL,
  `metode_bayar` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `payroll`
--

CREATE TABLE `payroll` (
  `id` int UNSIGNED NOT NULL,
  `id_karyawan` int UNSIGNED NOT NULL,
  `bulan_periode` tinyint NOT NULL,
  `tahun_periode` year NOT NULL,
  `gaji_pokok` decimal(15,2) NOT NULL,
  `tunjangan` decimal(15,2) NOT NULL DEFAULT '0.00',
  `potongan` decimal(15,2) NOT NULL DEFAULT '0.00',
  `jam_lembur` int NOT NULL DEFAULT '0',
  `tarif_lembur` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total_lembur` decimal(15,2) NOT NULL DEFAULT '0.00',
  `gaji_bersih` decimal(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `pelanggan_roastery`
--

CREATE TABLE `pelanggan_roastery` (
  `id_pelanggan` int UNSIGNED NOT NULL,
  `nama_pelanggan` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `no_wa` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `pembayaran`
--

CREATE TABLE `pembayaran` (
  `id_pembayaran` varchar(15) COLLATE utf8mb4_general_ci NOT NULL,
  `id_pesanan` varchar(15) COLLATE utf8mb4_general_ci NOT NULL,
  `waktu_bayar` datetime NOT NULL,
  `metode_bayar` enum('Tunai','QRIS','Transfer','Debit','Kredit') COLLATE utf8mb4_general_ci NOT NULL,
  `akun_kas` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'FK ke kode_akun COA: 1-1100 atau 1-1200',
  `jumlah_bayar` decimal(14,2) NOT NULL,
  `kembalian` decimal(14,2) NOT NULL DEFAULT '0.00',
  `status_bayar` enum('Lunas','Pending','Batal') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Pending',
  `gl_posted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 = sudah diposting ke GL buku besar'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `penjualan_roastery`
--

CREATE TABLE `penjualan_roastery` (
  `id_invoice` varchar(15) COLLATE utf8mb4_general_ci NOT NULL,
  `id_pelanggan` int UNSIGNED NOT NULL,
  `tanggal_terbit` date NOT NULL,
  `tanggal_jatuh_tempo` date DEFAULT NULL,
  `total_invoice` decimal(14,2) NOT NULL DEFAULT '0.00',
  `total_hpp` decimal(14,2) NOT NULL DEFAULT '0.00' COMMENT 'SUM(detail_invoice.hpp_subtotal)',
  `status_invoice` enum('Draft','Terbit','Lunas','Batal') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Draft',
  `akun_piutang` varchar(10) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '1-1300' COMMENT 'default: Piutang Usaha',
  `akun_pendapatan` varchar(10) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '4-1300' COMMENT 'default: Pendapatan Roastery',
  `gl_terbit_posted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 = Piutang & Pendapatan sudah di-GL',
  `gl_lunas_posted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 = Kas masuk & Piutang cleared sudah di-GL'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `pesanan`
--

CREATE TABLE `pesanan` (
  `id_pesanan` varchar(15) COLLATE utf8mb4_general_ci NOT NULL,
  `id_meja` int UNSIGNED DEFAULT NULL,
  `jenis_layanan` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `tanggal_order` date NOT NULL,
  `total_harga` decimal(14,2) NOT NULL DEFAULT '0.00',
  `status_pesanan` enum('Pending','Diproses','Selesai','Batal') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Pending',
  `gl_posted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 = sudah diposting ke GL buku besar'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `positions`
--

CREATE TABLE `positions` (
  `id` int UNSIGNED NOT NULL,
  `nama_jabatan` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `keterangan` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `purchase_orders`
--

CREATE TABLE `purchase_orders` (
  `id` int UNSIGNED NOT NULL,
  `nomor_po` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `id_pr` int UNSIGNED DEFAULT NULL,
  `id_pemasok` int UNSIGNED DEFAULT NULL,
  `tanggal_po` date NOT NULL,
  `status` enum('open','closed') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'open',
  `total` decimal(15,2) NOT NULL,
  `catatan` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `purchase_order_items`
--

CREATE TABLE `purchase_order_items` (
  `id` int UNSIGNED NOT NULL,
  `id_po` int UNSIGNED NOT NULL,
  `nama_aset` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `spesifikasi` text COLLATE utf8mb4_general_ci,
  `jumlah` int NOT NULL DEFAULT '1',
  `harga_satuan` decimal(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `purchase_requests`
--

CREATE TABLE `purchase_requests` (
  `id` int UNSIGNED NOT NULL,
  `nomor_pr` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `tanggal_pr` date NOT NULL,
  `id_departemen` int UNSIGNED DEFAULT NULL,
  `pemohon` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` enum('draft','submitted','approved','rejected') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'draft',
  `jenis` enum('aset_tetap','persediaan') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'persediaan',
  `tanda_tangan` longtext COLLATE utf8mb4_general_ci,
  `catatan_tolak` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tanggal_approval` date DEFAULT NULL,
  `nama_penyetuju` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `id_owner_signature` int UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `purchase_request_items`
--

CREATE TABLE `purchase_request_items` (
  `id` int UNSIGNED NOT NULL,
  `id_pr` int UNSIGNED NOT NULL,
  `nama_aset` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `spesifikasi` text COLLATE utf8mb4_general_ci,
  `jumlah` int NOT NULL DEFAULT '1',
  `estimasi_harga_satuan` decimal(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `receipt_history`
--

CREATE TABLE `receipt_history` (
  `id` int UNSIGNED NOT NULL,
  `id_piutang` int UNSIGNED NOT NULL,
  `tanggal_terima` date NOT NULL,
  `jumlah_diterima` decimal(15,2) NOT NULL,
  `metode_terima` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `salary_standards`
--

CREATE TABLE `salary_standards` (
  `id` int UNSIGNED NOT NULL,
  `id_jabatan` int UNSIGNED NOT NULL,
  `id_karyawan` int UNSIGNED DEFAULT NULL,
  `gaji_pokok` decimal(15,2) NOT NULL,
  `tunjangan_tetap` decimal(15,2) NOT NULL DEFAULT '0.00',
  `tanggal_berlaku` date NOT NULL,
  `tanggal_berakhir` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` int UNSIGNED NOT NULL,
  `nama` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `kontak_person` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `alamat` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


-- --------------------------------------------------------

--
-- Table structure for table `trial_balance`
--

CREATE TABLE `trial_balance` (
  `id` int UNSIGNED NOT NULL,
  `tahun_periode` year NOT NULL,
  `bulan_periode` tinyint UNSIGNED NOT NULL,
  `kode_akun` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `debit` decimal(15,2) NOT NULL DEFAULT '0.00',
  `kredit` decimal(15,2) NOT NULL DEFAULT '0.00',
  `tipe` enum('before','after') COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int UNSIGNED NOT NULL,
  `nama_pengguna` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `kata_sandi_hash` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `nama_lengkap` varchar(100) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
--


--
-- Indexes for dumped tables
--

--
-- Indexes for table `absensi`
--
ALTER TABLE `absensi`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_karyawan_tanggal` (`id_karyawan`,`tanggal`);

--
-- Indexes for table `accounts_payable`
--
ALTER TABLE `accounts_payable`
  ADD PRIMARY KEY (`id`),
  ADD KEY `accounts_payable_id_pemasok_foreign` (`id_pemasok`);

--
-- Indexes for table `accounts_receivable`
--
ALTER TABLE `accounts_receivable`
  ADD PRIMARY KEY (`id`),
  ADD KEY `accounts_receivable_id_pelanggan_foreign` (`id_pelanggan`);

--
-- Indexes for table `asset_categories`
--
ALTER TABLE `asset_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `coa`
--
ALTER TABLE `coa`
  ADD PRIMARY KEY (`kode_akun`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `depreciation_entries`
--
ALTER TABLE `depreciation_entries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `depreciation_entries_id_aset_foreign` (`id_aset`);

--
-- Indexes for table `detail_invoice`
--
ALTER TABLE `detail_invoice`
  ADD PRIMARY KEY (`id_detail_invoice`),
  ADD KEY `detail_invoice_id_invoice_foreign` (`id_invoice`);

--
-- Indexes for table `detail_order`
--
ALTER TABLE `detail_order`
  ADD PRIMARY KEY (`id_detail`),
  ADD KEY `detail_order_id_pesanan_foreign` (`id_pesanan`),
  ADD KEY `detail_order_id_menu_foreign` (`id_menu`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employees_id_pengguna_foreign` (`id_pengguna`),
  ADD KEY `employees_id_departemen_foreign` (`id_departemen`),
  ADD KEY `employees_id_jabatan_foreign` (`id_jabatan`);

--
-- Indexes for table `fixed_assets`
--
ALTER TABLE `fixed_assets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `kode_aset` (`kode_aset`),
  ADD KEY `fixed_assets_id_kategori_foreign` (`id_kategori`),
  ADD KEY `fixed_assets_kode_akun_aset_foreign` (`kode_akun_aset`),
  ADD KEY `fixed_assets_kode_akun_akumulasi_penyusutan_foreign` (`kode_akun_akumulasi_penyusutan`),
  ADD KEY `fixed_assets_kode_akun_beban_penyusutan_foreign` (`kode_akun_beban_penyusutan`);

--
-- Indexes for table `general_ledger`
--
ALTER TABLE `general_ledger`
  ADD PRIMARY KEY (`id`),
  ADD KEY `general_ledger_kode_akun_foreign` (`kode_akun`);

--
-- Indexes for table `gl_entries`
--
ALTER TABLE `gl_entries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sumber_tipe_sumber_id` (`sumber_tipe`,`sumber_id`),
  ADD KEY `tanggal` (`tanggal`),
  ADD KEY `kode_akun` (`kode_akun`);

--
-- Indexes for table `good_receipts`
--
ALTER TABLE `good_receipts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `good_receipts_id_po_foreign` (`id_po`);

--
-- Indexes for table `good_receipt_items`
--
ALTER TABLE `good_receipt_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `good_receipt_items_id_penerimaan_foreign` (`id_penerimaan`),
  ADD KEY `good_receipt_items_id_po_item_foreign` (`id_po_item`);

--
-- Indexes for table `jenis_layanan`
--
ALTER TABLE `jenis_layanan`
  ADD PRIMARY KEY (`id_jenis`);

--
-- Indexes for table `journals`
--
ALTER TABLE `journals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_tgl_status` (`tanggal_jurnal`,`status`);

--
-- Indexes for table `journal_adjustments`
--
ALTER TABLE `journal_adjustments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_tgl_status` (`tanggal_jurnal`,`status`);

--
-- Indexes for table `journal_adjustment_details`
--
ALTER TABLE `journal_adjustment_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `journal_adjustment_details_id_jurnal_foreign` (`id_jurnal`),
  ADD KEY `journal_adjustment_details_kode_akun_foreign` (`kode_akun`);

--
-- Indexes for table `journal_details`
--
ALTER TABLE `journal_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `journal_details_kode_akun_foreign` (`kode_akun`),
  ADD KEY `idx_id_jurnal` (`id_jurnal`);

--
-- Indexes for table `meja`
--
ALTER TABLE `meja`
  ADD PRIMARY KEY (`id_meja`);

--
-- Indexes for table `menu_cafe`
--
ALTER TABLE `menu_cafe`
  ADD PRIMARY KEY (`id_menu`),
  ADD UNIQUE KEY `kode_menu` (`kode_menu`);

--
-- Indexes for table `menu_roastery`
--
ALTER TABLE `menu_roastery`
  ADD PRIMARY KEY (`id_produk`),
  ADD UNIQUE KEY `kode_produk` (`kode_produk`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `owner_signatures`
--
ALTER TABLE `owner_signatures`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_history`
--
ALTER TABLE `payment_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payment_history_id_utang_foreign` (`id_utang`);

--
-- Indexes for table `payroll`
--
ALTER TABLE `payroll`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payroll_id_karyawan_foreign` (`id_karyawan`);

--
-- Indexes for table `pelanggan_roastery`
--
ALTER TABLE `pelanggan_roastery`
  ADD PRIMARY KEY (`id_pelanggan`);

--
-- Indexes for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`id_pembayaran`),
  ADD KEY `pembayaran_id_pesanan_foreign` (`id_pesanan`);

--
-- Indexes for table `penjualan_roastery`
--
ALTER TABLE `penjualan_roastery`
  ADD PRIMARY KEY (`id_invoice`),
  ADD KEY `penjualan_roastery_id_pelanggan_foreign` (`id_pelanggan`);

--
-- Indexes for table `pesanan`
--
ALTER TABLE `pesanan`
  ADD PRIMARY KEY (`id_pesanan`),
  ADD KEY `pesanan_id_meja_foreign` (`id_meja`);

--
-- Indexes for table `positions`
--
ALTER TABLE `positions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchase_orders_id_pr_foreign` (`id_pr`),
  ADD KEY `purchase_orders_id_pemasok_foreign` (`id_pemasok`);

--
-- Indexes for table `purchase_order_items`
--
ALTER TABLE `purchase_order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchase_order_items_id_po_foreign` (`id_po`);

--
-- Indexes for table `purchase_requests`
--
ALTER TABLE `purchase_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchase_requests_id_departemen_foreign` (`id_departemen`);

--
-- Indexes for table `purchase_request_items`
--
ALTER TABLE `purchase_request_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchase_request_items_id_pr_foreign` (`id_pr`);

--
-- Indexes for table `receipt_history`
--
ALTER TABLE `receipt_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `receipt_history_id_piutang_foreign` (`id_piutang`);

--
-- Indexes for table `salary_standards`
--
ALTER TABLE `salary_standards`
  ADD PRIMARY KEY (`id`),
  ADD KEY `salary_standards_id_jabatan_foreign` (`id_jabatan`),
  ADD KEY `salary_standards_id_karyawan_foreign` (`id_karyawan`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trial_balance`
--
ALTER TABLE `trial_balance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `trial_balance_kode_akun_foreign` (`kode_akun`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nama_pengguna` (`nama_pengguna`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `absensi`
--
ALTER TABLE `absensi`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `accounts_payable`
--
ALTER TABLE `accounts_payable`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `accounts_receivable`
--
ALTER TABLE `accounts_receivable`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=208;

--
-- AUTO_INCREMENT for table `asset_categories`
--
ALTER TABLE `asset_categories`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `depreciation_entries`
--
ALTER TABLE `depreciation_entries`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=557;

--
-- AUTO_INCREMENT for table `detail_order`
--
ALTER TABLE `detail_order`
  MODIFY `id_detail` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8523;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `fixed_assets`
--
ALTER TABLE `fixed_assets`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `general_ledger`
--
ALTER TABLE `general_ledger`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gl_entries`
--
ALTER TABLE `gl_entries`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1565;

--
-- AUTO_INCREMENT for table `good_receipts`
--
ALTER TABLE `good_receipts`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `good_receipt_items`
--
ALTER TABLE `good_receipt_items`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `jenis_layanan`
--
ALTER TABLE `jenis_layanan`
  MODIFY `id_jenis` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `journals`
--
ALTER TABLE `journals`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `journal_adjustments`
--
ALTER TABLE `journal_adjustments`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `journal_adjustment_details`
--
ALTER TABLE `journal_adjustment_details`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `journal_details`
--
ALTER TABLE `journal_details`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- AUTO_INCREMENT for table `meja`
--
ALTER TABLE `meja`
  MODIFY `id_meja` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `owner_signatures`
--
ALTER TABLE `owner_signatures`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `payment_history`
--
ALTER TABLE `payment_history`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `payroll`
--
ALTER TABLE `payroll`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `pelanggan_roastery`
--
ALTER TABLE `pelanggan_roastery`
  MODIFY `id_pelanggan` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `positions`
--
ALTER TABLE `positions`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `purchase_order_items`
--
ALTER TABLE `purchase_order_items`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `purchase_requests`
--
ALTER TABLE `purchase_requests`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `purchase_request_items`
--
ALTER TABLE `purchase_request_items`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `receipt_history`
--
ALTER TABLE `receipt_history`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=125;

--
-- AUTO_INCREMENT for table `salary_standards`
--
ALTER TABLE `salary_standards`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `trial_balance`
--
ALTER TABLE `trial_balance`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `absensi`
--
ALTER TABLE `absensi`
  ADD CONSTRAINT `absensi_id_karyawan_foreign` FOREIGN KEY (`id_karyawan`) REFERENCES `employees` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `accounts_payable`
--
ALTER TABLE `accounts_payable`
  ADD CONSTRAINT `accounts_payable_id_pemasok_foreign` FOREIGN KEY (`id_pemasok`) REFERENCES `suppliers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `accounts_receivable`
--
ALTER TABLE `accounts_receivable`
  ADD CONSTRAINT `accounts_receivable_id_pelanggan_foreign` FOREIGN KEY (`id_pelanggan`) REFERENCES `customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `depreciation_entries`
--
ALTER TABLE `depreciation_entries`
  ADD CONSTRAINT `depreciation_entries_id_aset_foreign` FOREIGN KEY (`id_aset`) REFERENCES `fixed_assets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `detail_invoice`
--
ALTER TABLE `detail_invoice`
  ADD CONSTRAINT `detail_invoice_id_invoice_foreign` FOREIGN KEY (`id_invoice`) REFERENCES `penjualan_roastery` (`id_invoice`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `detail_order`
--
ALTER TABLE `detail_order`
  ADD CONSTRAINT `detail_order_id_menu_foreign` FOREIGN KEY (`id_menu`) REFERENCES `menu_cafe` (`id_menu`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `detail_order_id_pesanan_foreign` FOREIGN KEY (`id_pesanan`) REFERENCES `pesanan` (`id_pesanan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employees_id_departemen_foreign` FOREIGN KEY (`id_departemen`) REFERENCES `departments` (`id`) ON DELETE CASCADE ON UPDATE SET NULL,
  ADD CONSTRAINT `employees_id_jabatan_foreign` FOREIGN KEY (`id_jabatan`) REFERENCES `positions` (`id`) ON DELETE CASCADE ON UPDATE SET NULL,
  ADD CONSTRAINT `employees_id_pengguna_foreign` FOREIGN KEY (`id_pengguna`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE SET NULL;

--
-- Constraints for table `fixed_assets`
--
ALTER TABLE `fixed_assets`
  ADD CONSTRAINT `fixed_assets_id_kategori_foreign` FOREIGN KEY (`id_kategori`) REFERENCES `asset_categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fixed_assets_kode_akun_akumulasi_penyusutan_foreign` FOREIGN KEY (`kode_akun_akumulasi_penyusutan`) REFERENCES `coa` (`kode_akun`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fixed_assets_kode_akun_aset_foreign` FOREIGN KEY (`kode_akun_aset`) REFERENCES `coa` (`kode_akun`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fixed_assets_kode_akun_beban_penyusutan_foreign` FOREIGN KEY (`kode_akun_beban_penyusutan`) REFERENCES `coa` (`kode_akun`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `general_ledger`
--
ALTER TABLE `general_ledger`
  ADD CONSTRAINT `general_ledger_kode_akun_foreign` FOREIGN KEY (`kode_akun`) REFERENCES `coa` (`kode_akun`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `good_receipts`
--
ALTER TABLE `good_receipts`
  ADD CONSTRAINT `good_receipts_id_po_foreign` FOREIGN KEY (`id_po`) REFERENCES `purchase_orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `good_receipt_items`
--
ALTER TABLE `good_receipt_items`
  ADD CONSTRAINT `good_receipt_items_id_penerimaan_foreign` FOREIGN KEY (`id_penerimaan`) REFERENCES `good_receipts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `good_receipt_items_id_po_item_foreign` FOREIGN KEY (`id_po_item`) REFERENCES `purchase_order_items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `journal_adjustment_details`
--
ALTER TABLE `journal_adjustment_details`
  ADD CONSTRAINT `journal_adjustment_details_id_jurnal_foreign` FOREIGN KEY (`id_jurnal`) REFERENCES `journal_adjustments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `journal_adjustment_details_kode_akun_foreign` FOREIGN KEY (`kode_akun`) REFERENCES `coa` (`kode_akun`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `journal_details`
--
ALTER TABLE `journal_details`
  ADD CONSTRAINT `journal_details_id_jurnal_foreign` FOREIGN KEY (`id_jurnal`) REFERENCES `journals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `journal_details_kode_akun_foreign` FOREIGN KEY (`kode_akun`) REFERENCES `coa` (`kode_akun`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `payment_history`
--
ALTER TABLE `payment_history`
  ADD CONSTRAINT `payment_history_id_utang_foreign` FOREIGN KEY (`id_utang`) REFERENCES `accounts_payable` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `payroll`
--
ALTER TABLE `payroll`
  ADD CONSTRAINT `payroll_id_karyawan_foreign` FOREIGN KEY (`id_karyawan`) REFERENCES `employees` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD CONSTRAINT `pembayaran_id_pesanan_foreign` FOREIGN KEY (`id_pesanan`) REFERENCES `pesanan` (`id_pesanan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `penjualan_roastery`
--
ALTER TABLE `penjualan_roastery`
  ADD CONSTRAINT `penjualan_roastery_id_pelanggan_foreign` FOREIGN KEY (`id_pelanggan`) REFERENCES `pelanggan_roastery` (`id_pelanggan`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `pesanan`
--
ALTER TABLE `pesanan`
  ADD CONSTRAINT `pesanan_id_meja_foreign` FOREIGN KEY (`id_meja`) REFERENCES `meja` (`id_meja`) ON DELETE CASCADE ON UPDATE SET NULL;

--
-- Constraints for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  ADD CONSTRAINT `purchase_orders_id_pemasok_foreign` FOREIGN KEY (`id_pemasok`) REFERENCES `suppliers` (`id`) ON DELETE CASCADE ON UPDATE SET NULL,
  ADD CONSTRAINT `purchase_orders_id_pr_foreign` FOREIGN KEY (`id_pr`) REFERENCES `purchase_requests` (`id`) ON DELETE CASCADE ON UPDATE SET NULL;

--
-- Constraints for table `purchase_order_items`
--
ALTER TABLE `purchase_order_items`
  ADD CONSTRAINT `purchase_order_items_id_po_foreign` FOREIGN KEY (`id_po`) REFERENCES `purchase_orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `purchase_requests`
--
ALTER TABLE `purchase_requests`
  ADD CONSTRAINT `purchase_requests_id_departemen_foreign` FOREIGN KEY (`id_departemen`) REFERENCES `departments` (`id`) ON DELETE CASCADE ON UPDATE SET NULL;

--
-- Constraints for table `purchase_request_items`
--
ALTER TABLE `purchase_request_items`
  ADD CONSTRAINT `purchase_request_items_id_pr_foreign` FOREIGN KEY (`id_pr`) REFERENCES `purchase_requests` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `receipt_history`
--
ALTER TABLE `receipt_history`
  ADD CONSTRAINT `receipt_history_id_piutang_foreign` FOREIGN KEY (`id_piutang`) REFERENCES `accounts_receivable` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `salary_standards`
--
ALTER TABLE `salary_standards`
  ADD CONSTRAINT `salary_standards_id_jabatan_foreign` FOREIGN KEY (`id_jabatan`) REFERENCES `positions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `salary_standards_id_karyawan_foreign` FOREIGN KEY (`id_karyawan`) REFERENCES `employees` (`id`) ON DELETE CASCADE ON UPDATE SET NULL;

--
-- Constraints for table `trial_balance`
--
ALTER TABLE `trial_balance`
  ADD CONSTRAINT `trial_balance_kode_akun_foreign` FOREIGN KEY (`kode_akun`) REFERENCES `coa` (`kode_akun`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
