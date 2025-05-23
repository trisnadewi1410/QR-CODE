import 'package:flutter/foundation.dart';

class NasabahProvider extends ChangeNotifier {
  String nama = 'Ni Komang Ayu Trisna Dewi';
  double saldo = 5000000;
  final List<Map<String, dynamic>> _mutasi = [];

  List<Map<String, dynamic>> get mutasi => _mutasi;

  void updateSaldo(double baru) {
    saldo = baru;
    notifyListeners();
  }

  void tambahMutasi(String jenis, String tipe, double jumlah) {
    _mutasi.add({
      'jenis': jenis,
      'tipe': tipe,
      'jumlah': jumlah,
      'tanggal': DateTime.now().toString(),
    });
    notifyListeners();
  }
}
