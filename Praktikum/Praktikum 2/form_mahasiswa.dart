import 'package:flutter/material.dart';

// 1. Menambahkan void main untuk menjalankan aplikasi
void main() => runApp(const MyApp());

// 2. Membuat kelas MyApp untuk root aplikasi
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Mahasiswa - Bagian 1',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const FormMahasiswaPage(),
    );
  }
}

// 3. Mengubah FormMahasiswaPage menjadi StatefulWidget
class FormMahasiswaPage extends StatefulWidget {
  const FormMahasiswaPage({super.key});

  @override
  State<FormMahasiswaPage> createState() => _FormMahasiswaPageState();
}

class _FormMahasiswaPageState extends State<FormMahasiswaPage> {
  // --- Form key & step
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0; // hanya 1 step (index 0)

  // --- Controller & field (BAGIAN 1)
  final cNama = TextEditingController();
  final cNpm = TextEditingController();
  final cEmail = TextEditingController();
  final cAlamat = TextEditingController();
  final cNoHp = TextEditingController();
  DateTime? tglLahir;
  TimeOfDay? jamBimbingan;

  String? jenisKelamin; // 'Laki-laki' atau 'Perempuan'

  String get tglLahirLabel =>
      tglLahir == null ? 'Pilih tanggal' : '${tglLahir!.day}/${tglLahir!.month}/${tglLahir!.year}';
  String get jamLabel =>
      jamBimbingan == null ? 'Pilih jam' : jamBimbingan!.format(context);

  @override
  void dispose() {
    cNama.dispose();
    cNpm.dispose();
    cEmail.dispose();
    cAlamat.dispose();
    cNoHp.dispose();
    super.dispose();
  }

  // 6. Fungsi untuk memilih tanggal lahir
  Future<void> _pickDate() async {
    final now = DateTime.now();
    final res = await showDatePicker(
      context: context,
      firstDate: DateTime(1970),
      lastDate: DateTime(now.year + 1),
      initialDate: DateTime(now.year - 18, now.month, now.day),
    );
    if (res != null) setState(() => tglLahir = res);
  }

  // 6. Fungsi untuk memilih waktu bimbingan
  Future<void> _pickTime() async {
    final res = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
    );
    if (res != null) setState(() => jamBimbingan = res);
  }

  // 7. Fungsi untuk menyimpan data dan menampilkan dialog
  void _simpan() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Periksa kembali isian Anda.')),
      );
      return;
    }
    if (tglLahir == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tanggal lahir belum dipilih')),
      );
      return;
    }
    if (jamBimbingan == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Jam bimbingan belum dipilih')),
      );
      return;
    }
    if (jenisKelamin == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Jenis kelamin belum dipilih')),
      );
      return;
    }

    final data = {
      'Nama': cNama.text.trim(),
      'NPM': cNpm.text.trim(),
      'Email': cEmail.text.trim(),
      'Jenis Kelamin': jenisKelamin,
      'No Hp': cNoHp.text.trim(),
      'Alamat': cAlamat.text.trim(),
      'Tanggal Lahir': tglLahirLabel,
      'Jam Bimbingan': jamLabel,
    };

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Ringkasan Data (Bagian 1)'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: data.entries
                .map((e) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text('${e.key}: ${e.value}'),
                    ))
                .toList(),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Tutup')),
        ],
      ),
    );
  }

  // 8. Widget untuk menampilkan judul section
  Widget _sectionTitle(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8, top: 8),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      );

  @override
  Widget build(BuildContext context) {
    final steps = <Step>[
      Step(
        title: const Text('Identitas'),
        isActive: true,
        state: StepState.indexed,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Data Pribadi'),
            TextFormField(
              controller: cNama,
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
                hintText: 'cth: Aulia Rahman',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Nama wajib diisi' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: cNpm,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'NPM',
                hintText: 'cth: 221234567',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.badge),
              ),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'NPM wajib diisi' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: cEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'cth: nama@kampus.ac.id',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Email wajib diisi';
                final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v.trim());
                return ok ? null : 'Format email tidak valid';
              },
            ),
            const SizedBox(height: 10),
            // Jenis Kelamin
            _sectionTitle('Jenis Kelamin'),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Laki-laki'),
                    value: 'Laki-laki',
                    groupValue: jenisKelamin,
                    onChanged: (val) => setState(() => jenisKelamin = val),
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Perempuan'),
                    value: 'Perempuan',
                    groupValue: jenisKelamin,
                    onChanged: (val) => setState(() => jenisKelamin = val),
                  ),
                ),
              ],
            ),
            // No HP
            _sectionTitle('No HP'),
            TextFormField(
              controller: cNoHp,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'No HP',
                hintText: 'cth: 081234567890',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'No HP wajib diisi';
                final ok = RegExp(r'^0[0-9]{9,13}$').hasMatch(v.trim());
                return ok ? null : 'Format No HP tidak valid';
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: cAlamat,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Alamat',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.home),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.cake_outlined),
                    label: Text(tglLahirLabel),
                    onPressed: _pickDate,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.schedule),
                    label: Text(jamLabel),
                    onPressed: _pickTime,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Form Mahasiswa — Bagian 1')),
      body: Form(
        key: _formKey,
        child: Stepper(
          type: StepperType.vertical,
          currentStep: _currentStep, // selalu 0
          steps: steps,
          onStepContinue: _simpan,   // tombol lanjut = Simpan untuk 1 step
          onStepCancel: null,        // tidak perlu tombol kembali
          controlsBuilder: (context, details) {
            return Row(
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.check),
                  label: const Text('Simpan'),
                  onPressed: details.onStepContinue,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}