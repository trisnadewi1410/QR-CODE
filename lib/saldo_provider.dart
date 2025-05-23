import 'package:flutter/material.dart';

class SaldoProvider extends ChangeNotifier {
  double _saldo = 1000000.0; // Saldo awal
  final List<Map<String, dynamic>> _mutasi = []; // List untuk menyimpan histori transaksi

  double get saldo => _saldo;
  List<Map<String, dynamic>> get mutasi => _mutasi; // Getter untuk mutasi

  void tambahSaldo(double jumlah, String jenis) {
    _saldo += jumlah;
    _addMutasi(jumlah, jenis, 'Masuk');
    notifyListeners();
  }

  void kurangiSaldo(double jumlah, String jenis) {
    if (jumlah <= _saldo) {
      _saldo -= jumlah;
      _addMutasi(jumlah, jenis, 'Keluar');
      notifyListeners();
    }
  }

  void _addMutasi(double jumlah, String jenis, String tipe) {
    _mutasi.add({
      'jumlah': jumlah,
      'jenis': jenis,
      'tipe': tipe,
      'tanggal': DateTime.now().toString(),
    });
  }
}