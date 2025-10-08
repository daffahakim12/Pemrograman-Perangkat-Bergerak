import 'package:flutter/material.dart';

class FormMatakuliahPage extends StatefulWidget {
  const FormMatakuliahPage({super.key});

  @override
  State<FormMatakuliahPage> createState() => _FormMatakuliahPageState();
}

class _FormMatakuliahPageState extends State<FormMatakuliahPage> {
  final _formKey = GlobalKey<FormState>();
  final cKode = TextEditingController();
  final cNama = TextEditingController();
  final cSks = TextEditingController();

  @override
  void dispose() {
    cKode.dispose();
    cNama.dispose();
    cSks.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Periksa kembali isian Anda.')),
      );
      return;
    }
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Ringkasan Data Matakuliah'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kode Matkul: ${cKode.text.trim()}'),
            Text('Nama Matkul: ${cNama.text.trim()}'),
            Text('SKS: ${cSks.text.trim()}'),
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
      appBar: AppBar(title: const Text('Form Matakuliah')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: cKode,
                decoration: const InputDecoration(
                  labelText: 'Kode Matkul',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.code),
                ),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Kode Matkul wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: cNama,
                decoration: const InputDecoration(
                  labelText: 'Nama Matkul',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.book),
                ),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Nama Matkul wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: cSks,
                decoration: const InputDecoration(
                  labelText: 'SKS',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.numbers),
                ),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'SKS wajib diisi';
                  final n = int.tryParse(v.trim());
                  if (n == null || n < 1 || n > 6) return 'SKS harus 1-6';
                  return null;
                },
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
