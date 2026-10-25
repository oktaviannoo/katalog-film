# Katalog Film

Aplikasi mobile Flutter yang menampilkan daftar film dari TMDB (The Movie Database) API, lengkap dengan poster, tanggal rilis, rating, dan sinopsis.

Dibuat untuk Ujian Tengah Semester (UTS) mata kuliah Pemrograman Mobile.

## Fitur Utama

- Menampilkan daftar film top rated dari TMDB API
- Poster, judul, tanggal rilis, dan rating pada setiap film
- Halaman detail film (poster, rating, tanggal rilis, sinopsis)
- Penanganan tiga kondisi data dengan FutureBuilder: loading, success, dan error
- Tombol "Coba Lagi" saat error dan tarik ke bawah untuk memuat ulang

## Teknologi dan Package

- Flutter dan Dart
- http (permintaan HTTP ke API)
- TMDB API (sumber data)

## Struktur Folder

    lib/
    ├── main.dart
    ├── models/film_model.dart
    ├── services/api_service.dart
    └── pages/
        ├── home_page.dart
        └── detail_page.dart

## Langkah Menjalankan Aplikasi

1. Pastikan Flutter SDK sudah terpasang.
2. Clone repositori ini, lalu masuk ke foldernya.
3. Jalankan `flutter pub get`.
4. Daftar di themoviedb.org, lalu ambil API Key (v3 auth) di Settings > API.
5. Buka `lib/services/api_service.dart` dan isi API key pada baris:

   `static const String apiKey = 'ISI_API_KEY_ANDA';`

6. Jalankan dengan `flutter run`. Disarankan memakai emulator/HP Android atau Windows desktop, karena mode web dapat memblokir gambar poster (CORS).

## Atribusi

Aplikasi ini menggunakan data dari TMDB API, tetapi tidak didukung atau disertifikasi oleh TMDB.

## Pembuat

- Nama: Nur Zidan Ramadhani Oktaviano Putra
- NIM: 240605110025
- Kelas: Mobile Programming C