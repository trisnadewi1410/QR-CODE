import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _notifikasiAktif = true;
  String _selectedTheme = 'Biru';
  String _selectedLanguage = 'Indonesia';
  Color _primaryColor = Colors.blue[900]!;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notifikasiAktif = prefs.getBool('notifikasi') ?? true;
      _selectedTheme = prefs.getString('theme') ?? 'Biru';
      _selectedLanguage = prefs.getString('language') ?? 'Indonesia';
      _updateThemeColor(_selectedTheme);
    });
  }

  void _updateThemeColor(String theme) {
    switch (theme) {
      case 'Biru':
        _primaryColor = Colors.blue[900]!;
        break;
      case 'Hijau':
        _primaryColor = Colors.green[900]!;
        break;
      case 'Merah':
        _primaryColor = Colors.red[900]!;
        break;
    }
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifikasi', _notifikasiAktif);
    await prefs.setString('theme', _selectedTheme);
    await prefs.setString('language', _selectedLanguage);

    // Terapkan perubahan tema
    _updateThemeColor(_selectedTheme);

    // Tampilkan snackbar
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_selectedLanguage == 'Indonesia'
              ? 'Pengaturan berhasil disimpan'
              : 'Settings saved successfully'),
          backgroundColor: _primaryColor,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _showThemeDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          _selectedLanguage == 'Indonesia' ? 'Pilih Tema' : 'Choose Theme',
          style: TextStyle(color: _primaryColor),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Biru'),
              onTap: () {
                setState(() {
                  _selectedTheme = 'Biru';
                  _updateThemeColor('Biru');
                });
                Navigator.pop(context);
              },
              trailing: _selectedTheme == 'Biru'
                  ? Icon(Icons.check, color: _primaryColor)
                  : null,
            ),
            ListTile(
              title: const Text('Hijau'),
              onTap: () {
                setState(() {
                  _selectedTheme = 'Hijau';
                  _updateThemeColor('Hijau');
                });
                Navigator.pop(context);
              },
              trailing: _selectedTheme == 'Hijau'
                  ? Icon(Icons.check, color: _primaryColor)
                  : null,
            ),
            ListTile(
              title: const Text('Merah'),
              onTap: () {
                setState(() {
                  _selectedTheme = 'Merah';
                  _updateThemeColor('Merah');
                });
                Navigator.pop(context);
              },
              trailing: _selectedTheme == 'Merah'
                  ? Icon(Icons.check, color: _primaryColor)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          _selectedLanguage == 'Indonesia' ? 'Pilih Bahasa' : 'Choose Language',
          style: TextStyle(color: _primaryColor),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Indonesia'),
              onTap: () {
                setState(() => _selectedLanguage = 'Indonesia');
                Navigator.pop(context);
              },
              trailing: _selectedLanguage == 'Indonesia'
                  ? Icon(Icons.check, color: _primaryColor)
                  : null,
            ),
            ListTile(
              title: const Text('English'),
              onTap: () {
                setState(() => _selectedLanguage = 'English');
                Navigator.pop(context);
              },
              trailing: _selectedLanguage == 'English'
                  ? Icon(Icons.check, color: _primaryColor)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          _selectedLanguage == 'Indonesia' ? 'Tentang Aplikasi' : 'About App',
          style: TextStyle(color: _primaryColor),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Koperasi Undiksha Mobile',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: _primaryColor),
            ),
            const SizedBox(height: 8),
            const Text('Versi: 1.0.0'),
            const SizedBox(height: 8),
            const Text('© 2024 Koperasi Undiksha'),
            const SizedBox(height: 8),
            Text(
              _selectedLanguage == 'Indonesia'
                  ? 'Aplikasi mobile banking untuk anggota Koperasi Undiksha. '
                      'Dengan aplikasi ini, Anda dapat melakukan berbagai transaksi '
                      'keuangan dengan mudah dan aman.'
                  : 'Mobile banking application for Undiksha Cooperative members. '
                      'With this app, you can perform various financial '
                      'transactions easily and securely.',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              _selectedLanguage == 'Indonesia' ? 'Tutup' : 'Close',
              style: TextStyle(color: _primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _primaryColor,
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.settings,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              _selectedLanguage == 'Indonesia' ? 'Pengaturan' : 'Settings',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: Colors.white,
              ),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: _primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.tune,
                    color: _primaryColor,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    _selectedLanguage == 'Indonesia'
                        ? 'Pengaturan Umum'
                        : 'General Settings',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              child: SwitchListTile(
                value: _notifikasiAktif,
                onChanged: (value) {
                  setState(() => _notifikasiAktif = value);
                },
                title: Text(_selectedLanguage == 'Indonesia'
                    ? 'Notifikasi'
                    : 'Notifications'),
                subtitle: Text(_selectedLanguage == 'Indonesia'
                    ? 'Aktifkan atau nonaktifkan notifikasi'
                    : 'Enable or disable notifications'),
                activeColor: _primaryColor,
              ),
            ),
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.color_lens, color: _primaryColor),
                title: Text(_selectedLanguage == 'Indonesia'
                    ? 'Tema Aplikasi'
                    : 'App Theme'),
                subtitle: Text(_selectedLanguage == 'Indonesia'
                    ? 'Tema saat ini: $_selectedTheme'
                    : 'Current theme: $_selectedTheme'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: _showThemeDialog,
              ),
            ),
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.language, color: _primaryColor),
                title: Text(
                    _selectedLanguage == 'Indonesia' ? 'Bahasa' : 'Language'),
                subtitle: Text(_selectedLanguage == 'Indonesia'
                    ? 'Bahasa saat ini: $_selectedLanguage'
                    : 'Current language: $_selectedLanguage'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: _showLanguageDialog,
              ),
            ),
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.info, color: _primaryColor),
                title: Text(_selectedLanguage == 'Indonesia'
                    ? 'Tentang Aplikasi'
                    : 'About App'),
                subtitle: Text(_selectedLanguage == 'Indonesia'
                    ? 'Informasi tentang aplikasi'
                    : 'Information about the app'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: _showAboutDialog,
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                onPressed: _saveSettings,
                icon: const Icon(Icons.save, color: Colors.white),
                label: Text(
                  _selectedLanguage == 'Indonesia'
                      ? 'Simpan Pengaturan'
                      : 'Save Settings',
                  style: const TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
