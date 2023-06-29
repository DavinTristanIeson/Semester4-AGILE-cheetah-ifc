# Kompilasi
Disarankan anda compile ke Windows jika ingin mengetes aplikasi secara keseluruhan, karena jika dijalankan di alat terpisah maka tidak akan bisa berhubung dengan server, karena server di-host di localhost (kecuali jika anda utak atik dengan alamatnya).

### Tidak bisa
- Android di alat terpisah karena masalah diatas
- Web karena projek membutuhkan akses ke file system (library path_provider).

Jika anda compile ke Windows, mohon cari pengaturan Developer Mode dan di-toggle ke on karena projek ini menggunakan beberapa plugin yang membutuhkan symlink support.

# Cara menjalankan aplikasi
Disarankan untuk meng-upgrade ke versi Flutter terbaru sebelum menjalankan aplikasi.
Akan disediakan folder yang berisi server kami, jika anda memiliki node.js dan npm (atau alat sejenis) silahkan menggunakan perintah berikut:

```npm install```

```npm run dev```

Jika semua library sudah terinstalasi maka seharusnya server akan berjalan pada localhost:3000. Anda juga dapat mengakses dashboard admin di localhost:3000/admin/login dengan password `adminpass`; ini dibutuhkan untuk beberapa interaksi dalam aplikasi.

Kemudian, untuk menjalankan aplikasi mobil silahkan menggunakan perintah berikut di folder yang berisi pubspec.yaml.

```flutter run```

# Interaksi Dasar

Sebagai pengguna (yang memegang aplikasi mobile), anda dapat membuat pesanan, melihat pesanan anda dulu, dan mengedit informasi diri. Ketika memesan makanan, pengguna akan dibawa ke halaman tunggu.

Di bagian dashboard admin, akan muncul pesanan-pesanan yang sedang menunggu dimasak. Anda dapat memberi info kepada pengguna bahwa pesanan mereka sedang dimasak, atau membatalkan pesanan mereka.

# Widget-Widget Lain

Untuk memenuhi nilai tugas Pengembangan Aplikasi Mobil Front-End, kami menaruh semua widget-widget yang tidak digunakan dalam aplikasi ke dalam halaman *Easter Egg*, yang bisa diakses dengan menekan icon di halaman login, atau kata "The Savory Spoon" di AppBar.
