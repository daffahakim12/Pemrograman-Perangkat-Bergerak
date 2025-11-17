import 'package:flutter/material.dart';

class PengaturanPage extends StatelessWidget {
  const PengaturanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan')),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.settings, size: 48),
                const SizedBox(height: 16),
                const Text(
                  'Pengaturan Aplikasi',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Atur preferensi aplikasi Anda di sini.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DetailPengaturanPage(),
                      ),
                    );
                  },
                  child: const Text('Detail Pengaturan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DetailPengaturanPage extends StatelessWidget {
  const DetailPengaturanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Pengaturan')),
      body: const Center(
        child: Text('Ini adalah halaman detail pengaturan.'),
      ),
    );
  }
}
