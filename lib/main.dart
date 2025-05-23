import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';
import 'menuUtama.dart';
import 'cekSaldo.dart';
import 'transfer_page.dart';
import 'deposito.dart';
import 'pembayaran.dart';
import 'peminjaman.dart';
import 'profile.dart';
import 'mutasi.dart';
import 'setting.dart';
import 'qrcode.dart';
import 'nasabah_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('is_logged_in') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NasabahProvider()),
      ],
      child: MyApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const MenuUtama() : const LoginPage(),
      routes: {
        '/login': (_) => const LoginPage(),
        '/cek_saldo': (_) => const CekSaldoPage(),
        '/transfer': (_) => const TransferPage(),
        '/deposito': (_) => const DepositoPage(),
        '/pembayaran': (_) => const PaymentPage(),
        '/pinjaman': (_) => const PeminjamanPage(),
        '/mutasi': (_) => MutationPage(),
        '/setting': (_) => const SettingPage(),
        '/profile': (_) => const ProfilePage(),
        '/qrcode': (_) => const QRCodePage(),
      },
    );
  }
}
