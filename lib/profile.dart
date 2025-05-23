import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login.dart';
import 'nasabah_provider.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final nasabahProvider = context.watch<NasabahProvider>();
    final saldo = nasabahProvider.saldo;
    final formattedSaldo = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 2,
    ).format(saldo);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue[900],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar
            const CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                'https://raw.githubusercontent.com/trisnadewi1410/Trisna-PersonalWebsite/main/img/foto1.jpg',
              ),
            ),
            const SizedBox(height: 20),
            // Nama Nasabah
            Text(
              nasabahProvider.nama,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            const SizedBox(height: 10),
            // Status Keanggotaan
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Anggota Aktif',
                style: TextStyle(
                  color: Colors.green[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Informasi Saldo
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              child: ListTile(
                leading:
                    Icon(Icons.account_balance_wallet, color: Colors.blue[800]),
                title: const Text('Saldo Saat Ini'),
                subtitle: Text(formattedSaldo),
              ),
            ),
            const SizedBox(height: 10),
            // Informasi Nomor Anggota
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.badge, color: Colors.blue[800]),
                title: const Text('Nomor Anggota'),
                subtitle: const Text('KOP-2024-001'),
              ),
            ),
            const SizedBox(height: 10),
            // Informasi Nomor Handphone
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.phone, color: Colors.blue[800]),
                title: const Text('No. Handphone'),
                subtitle: const Text('081234567890'),
              ),
            ),
            const SizedBox(height: 10),
            // Informasi Email
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.email, color: Colors.blue[800]),
                title: const Text('Email'),
                subtitle: const Text('ayu.trisna.dewi@student.undiksha.ac.id'),
              ),
            ),
            const SizedBox(height: 10),
            // Informasi Tanggal Bergabung
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.calendar_today, color: Colors.blue[800]),
                title: const Text('Tanggal Bergabung'),
                subtitle: const Text('1 Januari 2024'),
              ),
            ),
            const SizedBox(height: 10),
            // Informasi Versi Aplikasi
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.info, color: Colors.blue[800]),
                title: const Text('Versi Aplikasi'),
                subtitle: const Text('1.0.0'),
              ),
            ),
            const SizedBox(height: 30),
            // Tombol Logout
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text(
                'LOGOUT',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
