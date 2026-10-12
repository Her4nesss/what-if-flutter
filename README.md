# What If?

Aplikasi mobile dan web berbasis Flutter untuk menjelajahi pertanyaan hipotetis. Satu pertanyaan, misalnya "bagaimana kalau manusia tidak perlu tidur?", diurai menjadi jawaban singkat, enam sisi dampak, dan lini masa yang bisa diklik, bukan satu paragraf panjang.

Dibuat sebagai tugas mata kuliah Pemrograman Berbasis Platfrom

## Demo

- Web (GitHub Pages): https://her4nesss.github.io/what-if-flutter/
- Web (Firebase): [isi link kalau sudah ada]
- APK Android: [isi link release kalau sudah ada]

Akun disimpan di browser atau perangkat masing-masing, jadi saat pertama membuka demo, buat akun dulu lewat Create Account.

## Fitur

**Akun**
- Sign Up dan Login, data tersimpan lokal lewat `shared_preferences`
- Onboarding tiga slide yang diperkenalkan oleh maskot Kiro

**Menjelajah**
- Home dengan kolom pencarian, strip topik yang bisa digeser, dan Featured Questions
- Halaman "See all" untuk semua topik dan semua pertanyaan, serta filter per kategori
- Halaman About (di tampilan web)

**Detail pertanyaan**
- Jawaban singkat dan komentar dari Kiro
- Lini masa interaktif
- Enam dimensi dampak: Biology, Society, Economy, Technology, Environment, Unexpected Consequences
- Take It Further: lanjut ke pertanyaan yang berkaitan
- Bookmark

**Profil**
- Foto profil yang bisa diganti
- Jumlah pertanyaan yang sudah dijelajahi, topik yang paling sering dibuka, riwayat, dan daftar pertanyaan tersimpan
- Logout

**Tampilan**
- HP dan jendela sempit: bottom navigation
- Layar lebar (900 px ke atas): halaman awal dua panel, navbar atas, dan Home dengan hero

## Struktur Kode

```
lib/
  data/       dataset pertanyaan dan state bersama (foto profil)
  models/     class Question
  screens/    halaman-halaman aplikasi
  theme/      warna dan transisi halaman
  widgets/    komponen yang dipakai ulang
```

Class `Question` di `models/` adalah blueprint setiap pertanyaan. Field-nya privat dan diakses lewat getter. Status `isExplored` dan `isSaved` diubah lewat setter, dan method `matchesKeyword()` dipakai fitur pencarian. Daftar ditampilkan dengan `ListView.builder` dan `GridView.builder`, dan objek `Question` dikirim antar halaman lewat constructor widget.

## Teknologi

- Flutter dan Dart
- `shared_preferences` untuk penyimpanan lokal
- `google_fonts` untuk tipografi
- `image_picker` untuk foto profil

## Menjalankan

Butuh Flutter SDK. Font Google diunduh saat aplikasi pertama dijalankan, jadi perlu koneksi internet.

```bash
git clone https://github.com/Her4nesss/what-if-flutter.git
cd what-if-flutter
flutter pub get
flutter run              # emulator atau HP
flutter run -d chrome    # web
```

Build web untuk GitHub Pages:

```bash
flutter build web --release --base-href "/what-if-flutter/"
```

## Batasan

- Konten pertanyaan ditulis manual (curated), bukan dihasilkan AI secara real-time. Pencarian hanya mencari di dalam dataset yang ada.
- Progres eksplorasi, daftar tersimpan, dan foto profil hanya tersimpan selama aplikasi terbuka.
- Password disimpan sebagai teks biasa, sebuah simplifikasi untuk skala tugas kuliah.
- Akun tersimpan lokal, jadi akun di satu browser atau perangkat tidak terbawa ke yang lain.

## Penulis

Mutiara Nur Hidayah, 25051204412, Teknik Informatika, Universitas Negeri Surabaya