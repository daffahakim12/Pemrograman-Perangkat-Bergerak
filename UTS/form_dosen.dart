import 'package:flutter/material.dart';

class FormDosenPage extends StatefulWidget {
  const FormDosenPage({super.key});

  @override
  State<FormDosenPage> createState() => _FormDosenPageState();
}

class _FormDosenPageState extends State<FormDosenPage> {
  final _formKey = GlobalKey<FormState>();
  final cNidn = TextEditingController();
  final cNama = TextEditingController();
  final cEmail = TextEditingController();
  final cNoTlp = TextEditingController();
  String? homeBase;

  @override
  void dispose() {
    cNidn.dispose();
    cNama.dispose();
    cEmail.dispose();
    cNoTlp.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate() || homeBase == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Periksa kembali isian Anda.')),
      );
      return;
    }
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Ringkasan Data Dosen'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('NIDN: ${cNidn.text.trim()}'),
            Text('Nama: ${cNama.text.trim()}'),
            Text('Home Base: $homeBase'),
            Text('Email: ${cEmail.text.trim()}'),
            Text('No Tlp: ${cNoTlp.text.trim()}'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Tutup')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Dosen')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: cNidn,
                decoration: const InputDecoration(
                  labelText: 'NIDN',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.badge),
                ),
                keyboardType: TextInputType.number,
                validator: (v) => (v == null || v.trim().isEmpty) ? 'NIDN wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: cNama,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Nama wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Home Base',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.home),
                ),
                value: homeBase,
                items: [
                  'Teknik Informatika',
                  'Sistem Informasi',
                ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (val) => setState(() => homeBase = val),
                validator: (v) => (v == null || v.isEmpty) ? 'Home Base wajib dipilih' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: cEmail,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Email wajib diisi';
                  final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v.trim());
                  return ok ? null : 'Format email tidak valid';
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: cNoTlp,
                decoration: const InputDecoration(
                  labelText: 'No Tlp',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                validator: (v) => (v == null || v.trim().isEmpty) ? 'No Tlp wajib diisi' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Simpan'),
                onPressed: _simpan,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
