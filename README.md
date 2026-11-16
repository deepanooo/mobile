# My Portfolio Mobile

Aplikasi portofolio pribadi berbasis Flutter. Aplikasi menyediakan halaman utama, formulir tambah proyek, dan formulir edukasi dengan validasi serta dialog ringkasan.

## Menjalankan aplikasi

Pastikan Flutter SDK telah terpasang, lalu jalankan perintah berikut dari direktori utama:

```sh
flutter pub get
flutter run
```

Untuk memeriksa kualitas kode:

```sh
flutter analyze
```

## Tugas 8

1. `Navigator.push()` menambahkan halaman baru ke atas tumpukan sehingga tombol kembali dapat membuka halaman sebelumnya. `Navigator.pushReplacement()` mengganti halaman aktif, sedangkan `Navigator.pop()` menutup halaman aktif. Kartu Tambah Edukasi menggunakan `Navigator.push()`. Opsi Home pada drawer menggunakan `pushReplacement()` untuk membuka halaman utama.
2. `Scaffold` menyediakan kerangka halaman, `AppBar` menampilkan judul dan aksi di bagian atas, dan `Drawer` memberi navigasi yang konsisten. Halaman utama dan formulir edukasi menggunakan drawer yang sama. Warna indigo dipakai pada kartu Tambah Proyek, AppBar formulir, dan tombol Simpan agar selaras dengan tema portofolio.
3. Formulir menggunakan `ListView` dengan padding agar isian dapat digulir saat layar sempit atau papan ketik terbuka. `Padding`, `SizedBox`, dan `Row` mengatur jarak serta mengelompokkan tahun mulai dan selesai tanpa membuat kolom terlalu lebar.
4. `GlobalKey<FormState>` menghubungkan tombol Simpan dengan seluruh form. Setiap validator memeriksa inputnya, dan `validate()` menjalankan pemeriksaan sebelum dialog ditampilkan. Contohnya, tahun selesai yang lebih awal daripada tahun mulai ditolak. Keyboard angka membantu memasukkan tahun, tetapi tetap perlu validator karena pengguna masih dapat memasukkan nilai kosong, di luar rentang, atau urutan yang keliru.

## Penggunaan AI

OpenAI Codex membantu membaca instruksi tugas, menyusun formulir edukasi, navigasi dari kartu dan drawer, validasi, serta draf dokumentasi dan refleksi ini. Saya meninjau dan menyesuaikan kode terhadap struktur proyek yang sudah ada. AI dapat melewatkan perilaku runtime atau perbedaan versi Flutter; karena itu hasil perlu diperiksa dengan `flutter analyze` dan diuji di emulator atau browser sebelum dikumpulkan. Log prompting tidak disertakan dalam repositori ini.
