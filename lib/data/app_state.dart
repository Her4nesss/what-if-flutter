import 'dart:typed_data';
import 'package:flutter/foundation.dart';

// Foto profil dipakai di halaman Profile dan di navbar atas,
// jadi disimpan di satu tempat. Masih per-sesi (hilang saat app ditutup).
final ValueNotifier<Uint8List?> avatarNotifier =
    ValueNotifier<Uint8List?>(null);