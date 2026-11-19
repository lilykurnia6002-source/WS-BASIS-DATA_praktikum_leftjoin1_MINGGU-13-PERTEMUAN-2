-- ==========================================
-- KUMPULAN SEMUA QUERY TUGAS ACARA 1
-- ==========================================
USE praktikum_leftjoin1;

-- TUGAS 1: Laporan Semua Produk & Total Pendapatan
SELECT 
    pr.id_produk,
    pr.nama_produk,
    pr.kategori,
    COALESCE(SUM(dp.jumlah), 0) AS total_terjual,
    COALESCE(SUM(dp.jumlah * dp.harga_satuan), 0) AS total_pendapatan
FROM produk pr
LEFT JOIN detail_pesanan dp ON pr.id_produk = dp.id_produk
GROUP BY pr.id_produk, pr.nama_produk, pr.kategori
ORDER BY total_pendapatan DESC;

-- TUGAS 2: Semua Pelanggan + Jumlah Pesanan 'pending'
SELECT 
    p.id_pelanggan,
    p.nama,
    COUNT(ps.id_pesanan) AS jumlah_pending
FROM pelanggan p
LEFT JOIN pesanan ps 
    ON p.id_pelanggan = ps.id_pelanggan 
    AND ps.status = 'pending'
GROUP BY p.id_pelanggan, p.nama
ORDER BY jumlah_pending DESC, p.id_pelanggan ASC;

-- TUGAS 3: Pelanggan yang Belum Pernah Pesan (Anti-Join)
SELECT 
    p.id_pelanggan,
    p.nama,
    p.kota,
    p.tanggal_daftar
FROM pelanggan p
LEFT JOIN pesanan ps ON p.id_pelanggan = ps.id_pelanggan
WHERE ps.id_pesanan IS NULL;

-- TUGAS 4: Laporan Per Kategori Produk
SELECT 
    pr.kategori,
    COUNT(DISTINCT pr.id_produk) AS jumlah_produk,
    COALESCE(SUM(dp.jumlah), 0) AS total_item_terjual,
    COALESCE(SUM(dp.jumlah * dp.harga_satuan), 0) AS total_pendapatan
FROM produk pr
LEFT JOIN detail_pesanan dp ON pr.id_produk = dp.id_produk
GROUP BY pr.kategori
ORDER BY total_pendapatan DESC;

-- TUGAS 5: Perbaikan Filter ON untuk Status 'selesai'
SELECT p.nama, ps.status
FROM pelanggan p
LEFT JOIN pesanan ps 
    ON p.id_pelanggan = ps.id_pelanggan 
    AND ps.status = 'selesai';

-- TUGAS 6: Rekap Pelanggan (Total Pesanan & Produk Unik)
SELECT 
    p.id_pelanggan,
    p.nama,
    COUNT(DISTINCT ps.id_pesanan) AS total_pesanan,
    COUNT(DISTINCT dp.id_produk) AS total_produk_unik_dibeli
FROM pelanggan p
LEFT JOIN pesanan ps ON p.id_pelanggan = ps.id_pelanggan
LEFT JOIN detail_pesanan dp ON ps.id_pesanan = dp.id_pesanan
GROUP BY p.id_pelanggan, p.nama
ORDER BY p.id_pelanggan;