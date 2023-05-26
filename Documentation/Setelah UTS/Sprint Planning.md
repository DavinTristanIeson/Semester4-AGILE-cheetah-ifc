# Sprint 1 (26/05/2023 s/d 02/06/2023)

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
