# Sprint 1 (26/05/2023 s/d 01/06/2023)

### Sprint Goal:
- Agar admin dapat mengelola menu
- Agar anggota tanpa akun dapat melihat menu
- Memperbaiki kode lama

### Sprint Backlog
*Note: [FRONTEND/BACKEND/PRIORITY]*

1. Sebagai admin, saya ingin memiliki fitur add,edit,delete makanan dalam menu [5/5/1]
- Halaman di /admin untuk modifikasi menu
- Ambil data menu dari backend untuk ditampilkan
- Dapat mengirim request untuk tambah/hapus menu ke backend
- Dapat membuka modal untuk edit menu
- Rute untuk menambahkan makanan baru ke menu dan simpan ke db
- Rute menghapus menu

2. Sebagai admin, saya ingin bisa mengubah harga, deskripsi, gambar dan jumlah minimal pembelian makanan untuk konsumer. [3/1/1]
- Dapat mengirim request untuk mengedit menu
- Tampilan modal pengeditan
- Rute untuk memperbarui data makanan dalam menu

3. Sebagai admin, saya ingin bisa berkomunikasi dengan konsumer dan mengubah order dari konsumer jika makanan yg dipesan tidak bisa di masak/penuhi. [5/2/2]
- Opsi untuk cancel order
- Dapat mengirim request cancel order ke backend
- Tampilan di halaman menunggu untuk menunjukkan alasan order di-cancel
- Rute untuk mengubah status pesanan menjadi "tidak dapat diproses".
- Fitur memberitahu pembeli tentang perubahan status pesanan.

4. Sebagai guest, saya ingin bisa mengakses menu untuk lihat lihat terlebih dahulu sebelum membuat akun/memesan. [3/-/3]
- Tampilan halaman menu
- Navbar untuk ke halaman login
- Ambil data menu dari backend untuk ditampilkan

5. Sebagai guest, saya ingin bisa memfiltrasi menu agar mempermudah pencarian. [1/-/4]
- Popup filter dan search bar
- Ambil data menu berdasarkan filter dan search

(EDIT: 28/05/2023)
6. Sebagai pengguna, saya ingin memodifikasi informasi akun saya [2/2/5]
- Tampilan form pengeditan akun
- Rute untuk edit akun

TOTAL: 25 + 4 = 29

# Sprint 2 (02/06/2023 s/d 08/06/2023)

### Sprint Backlog
*Note: [STORY POINT/PRIORITY]*

1. Sebagai pelanggan, saya ingin daftar ke website agar bisa pesan makanan tanpa harus menunggu di restoran [3/1]
- Tampilan form login/daftar
- Send request ke backend untuk login/daftar
- Cek apakah pengguna sudah login atau tidak, kalau tidak redirect ke halaman login, kalau sudah ke halaman menu

2. Sebagai pelanggan, saya ingin memesan makanan dengan cepat dan mudah, karena saya lapar [8/2]
- Tampilan halaman pemesanan
- Komponen untuk item menu
- Infinite scrolling untuk memuat item menu baru
- Bisa view dalam bentuk grid/list
- Tampilan AppBar yang berbeda untuk halaman pemesanan

3. Sebagai pelanggan, saya ingin tahu berapa harga dari makanan yang kupesan [5/3]
- Bottom modal untuk buka list pesanan di halaman pemesanan
- Metode untuk membuka bottom modal
- Bisa send request untuk buat pesanan baru
- Bisa menghapus/mengedit item di list pesanan

4. Sebagai pelanggan, saya ingin kasih pesan tambahan untuk bagaimana makanan saya disiapkan; contoh: teh jangan terlalu banyak pakai es, nasi goreng jangan pakai bawang. [3/3]
- Modal untuk edit informasi pesanan seperti kuantitas dan pesan tambahan

TOTAL: 19
