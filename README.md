# Dokumentasi Penggunaan Project Klasifikasi Gambar

## Cara Memakai Project Ini

Ikuti langkah-langkah berikut untuk menggunakan project ini:

### 1. Buat Project Flutter Baru

Buka terminal atau editor Anda dan buat project Flutter baru dengan perintah berikut:
```bash
flutter create nama_project_anda
```

### 2. Salin Folder `asset` & `lib` ke Project Anda

Copy seluruh folder `asset` dan `lib` dari project ini ke dalam folder project Anda yang baru.

### 3. Sesuaikan File Model di dalam Folder `asset`

Edit file model di dalam folder `asset` sesuai dengan kebutuhan model Anda.

### 4. Tambahkan Dependency di `pubspec.yaml`

Salin library berikut dari file `pubspec.yaml` project ini ke file `pubspec.yaml` di project Anda:
```yaml
image_picker: ^0.8.4+9
tflite_v2: ^1.0.0
flutter_spinkit: ^5.1.0
get: ^4.6.6
```
Setelah itu, jalankan perintah berikut untuk menginstall dependency:
```bash
flutter pub get
```

### 5. Sesuaikan Path File Model dan Labels di Controller

Buka file controller dan ubah path untuk file model dan labels sesuai dengan lokasi file Anda. Contohnya:
```dart
model: "asset/model9079.tflite", // Path ke file model ML
labels: "asset/labels.txt",      // Path ke file labels
```

### 6. Jalankan Project Seperti Biasa

Setelah semua langkah di atas selesai, Anda dapat menjalankan project seperti biasa menggunakan perintah berikut:
```bash
flutter run
```

---

## Catatan Tambahan
- Pastikan file `model` dan `labels` sudah sesuai dengan kebutuhan aplikasi Anda.
- Jika ada error saat proses instalasi atau runtime, cek kembali langkah-langkah di atas dan pastikan tidak ada yang terlewat.

Happy coding! 🚀

