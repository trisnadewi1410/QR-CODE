import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'nasabah_provider.dart';
import 'package:intl/intl.dart';

class MutationPage extends StatelessWidget {
  const MutationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nasabahProvider = Provider.of<NasabahProvider>(context);
    final mutasi = nasabahProvider.mutasi;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mutasi',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue[900],
      ),
      body: mutasi.isEmpty
          ? const Center(
              child: Text(
                'Belum ada histori transaksi.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: mutasi.length,
              itemBuilder: (context, index) {
                final item = mutasi[index];
                final jenisTransaksi = item['jenis'];
                final tipe = item['tipe'];
                final tanggal = item['tanggal'];
                final jumlah = item['jumlah'] is double
                    ? item['jumlah']
                    : double.tryParse(item['jumlah'].toString()) ?? 0.0;

                // Format tanggal
                final formattedTanggal = DateFormat('dd-MM-yyyy HH:mm:ss')
                    .format(DateTime.parse(tanggal));

                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(
                      '$jenisTransaksi ($tipe)',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Tanggal: $formattedTanggal'),
                    trailing: Text(
                      '${tipe == 'Masuk' ? '+' : '-'} Rp ${jumlah.toStringAsFixed(0)}',
                      style: TextStyle(
                        color: tipe == 'Masuk' ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
