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

### Sprint Goal
- Agar pengguna dapat melihat dan mencari menu
- Agar pengguna dapat memesan makanan
- Agar pengguna dapat masuk ke dalam aplikasi

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

(EDIT 08/06/2023: Lupa dimasukkan di Trello, dan tidak sengaja sudah dikerjakan oleh Davin padahal dijadwalkan untuk sprint selanjutnya)
5. Sebagai pelanggan, saya ingin mencari makanan dengan mudah, agar bisa menemukan makanan yang kusuka. [3/5]

TOTAL: 22

# Sprint 3 (09/06/2023 s/d 15/06/2023)

### Sprint Goal
- Agar pengguna dapat diinformasikan atas status pesanan mereka
- Agar pengguna dapat melihat dan mengubah data diri mereka
- Agar pengguna dapat melihat riwayat pemesanan mereka

### Sprint Backlog
*Note: [STORY POINT/PRIORITY]*

1. Sebagai pelanggan, saya ingin tahu apakah pesanan saya sudah siap atau belum, agar bisa diambil [5/4]
- Tampilan halaman menunggu ketika loading
- Tampilan halaman menunggu ketika sudah selesai
- Komunikasi realtime dengan server melalui socket.io untuk menerima status pesanan
- Request ke backend untuk mengambil pesanan sekarang

2. Sebagai pelanggan, saya ingin lihat transaksi dan pesanan saya sebelumnya. [3/6]
- Komponen untuk riwayat transaksi/pesanan
- Tampilan halaman riwayat pemesanan
- Infinite scrolling untuk halaman riwayat pemesanan
- Request ke backend untuk mengambil riwayat pemesanan

3. Sebagai pelanggan, saya ingin mengubah dan melihat data diri sendiri seperti email, nama, no. telp, dan password. [3/7]
- Tampilan halaman akun
- Request ke backend untuk mengambil informasi akun
- Fitur menghapus akun
- Fitur mengedit informasi akun
- Request ke backend untuk menghapus/mengedit informasi akun

TOTAL: 11

# Sprint 4 (16/06/2023 s/d 22/06/2023)

### Sprint Goal
- Untuk memakai widget-widget yang dipelajari di pelajaran PAMFE namun tidak dipakai di projek
(EDIT 28/06/2023)
- Agar Vincent dapat berkontribusi dalam bentuk yang dapat diukur
- Melakukan demonstrasi cara penggunaan aplikasi

### Sprint Planning
1. Sebagai dosen mata kuliah PAMFE, saya ingin siswa saya memakai widget yang dipelajari di mata kuliah PAMFE [11/1]
- Minggu 5: Chips, Checkbox
- Minggu 6: Switch, Dropdown
- Minggu 9: Tabs Bar
- Minggu 10: Banner
- Minggu 11: Menus
- Minggu 13: Slider
- Minggu 14: Date/Time Picker
- Minggu 15: ImagePicker, WebView


2. (EDIT 28/06/2023) Sebagai dosen mata kuliah PAMFE, saya ingin siswa saya memakai widget yang dipelajari di mata kuliah PAMFE [3/1]
- Implementasi CircleAvatar
- Implementasi LinearProgressIndicator

3. (EDIT 28/06/2023) Sebagai investor, saya ingin melihat demonstrasi produk agar tahu garisbesar kualitas dan cara menggunakannnya [3/2]
- Rekam video demo program web
- Rekam video demo program mobile

TOTAL: 11 + 6 = 17