# Go Camp

Aplikasi *Go Camp* ini adalah aplikasi sederhana yang memberikan tampilan visual untuk menjelajahi pilihan camping dan perlengkapan yang dapat disewa. Aplikasi ini fokus pada antarmuka pengguna tanpa fungsionalitas pemrograman.

## Tampilan Aplikasi Go Camp
![image](https://github.com/user-attachments/assets/be9bef84-94be-4463-991c-2fea850fec14)


## Persona User dan Pain Point

**Persona User:**
- Pengguna yang baru pertama kali berkemah dan membutuhkan panduan.
- Pengguna yang mencari kemudahan dalam memilih perlengkapan camping yang sesuai.
- Pengguna yang ingin mengeksplorasi tempat camping dan perlengkapan dengan rating dan review.

**Pain Point:**
- Pengguna kesulitan mencari tempat camping atau perlengkapan yang tepat tanpa informasi yang jelas.
- Pengguna baru sering bingung dengan berbagai pilihan dan membutuhkan bantuan dalam proses pemesanan.
- Sulit untuk memantau status pesanan atau melakukan pembelian dalam satu platform.

## Fitur

### 1. Halaman Depan
Menampilkan pilihan tempat camping dan perlengkapan dengan menu navigasi yang mudah diakses.

### 2. Detail Item
Informasi lengkap tentang perlengkapan atau tempat camping, termasuk harga, fasilitas, dan gambar.

### 3. Review dan Rating
Review dan rating dari penyewa sebelumnya untuk membantu pengguna memilih item yang tepat.

### 4. Chat dengan Admin
Fitur chat untuk membantu pengguna yang baru pertama kali berkemah dengan pertanyaan atau panduan.

### 5. Daftar Wishlist
Pengguna dapat menyimpan item yang diminati ke dalam wishlist untuk referensi di masa depan.

### 6. Keranjang dan Checkout
Memudahkan pengguna untuk memilih item dan melanjutkan ke proses checkout.

### 7. Paket Hemat, Promosi
Menampilkan paket promosi dan hemat untuk pengguna yang mencari penawaran khusus.

### 8. Daftar Transaksi
Mengelola status transaksi dan pengembalian item yang disewa.

## Struktur Direktori
**lib**  
|--**models**  -> Berisi model data aplikasi, seperti item perlengkapan camping, transaksi, dan wishlist.  
|--**screens** -> Berisi halaman-halaman aplikasi, seperti halaman depan, detail item, dan wishlist.  
|--**theme**   -> Mengatur tema dan gaya visual aplikasi, termasuk warna, font, dan gaya UI.  
|__**widgets** -> Berisi widget reusable seperti tombol, card, dan rating untuk digunakan di berbagai layar.  
**main.dart**  -> titik masuk aplikasi yang menginisialisasi tema serta tampilan awal aplikasi.

