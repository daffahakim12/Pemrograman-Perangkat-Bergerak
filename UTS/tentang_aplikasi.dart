import 'package:flutter/material.dart';

class TentangAplikasiPage extends StatelessWidget {
  const TentangAplikasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tentang Aplikasi')),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.info, size: 48),
                const SizedBox(height: 16),
                const Text(
                  'Demo Form Mahasiswa',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Versi 1.0.0',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Aplikasi ini dibuat untuk demo form mahasiswa.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DetailTentangAplikasiPage(),
                      ),
                    );
                  },
                  child: const Text('Detail Tentang Aplikasi'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DetailTentangAplikasiPage extends StatelessWidget {
  const DetailTentangAplikasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Tentang Aplikasi')),
      body: const Center(
        child: Text('Ini adalah halaman detail tentang aplikasi.'),
      ),
    );
  }
}
