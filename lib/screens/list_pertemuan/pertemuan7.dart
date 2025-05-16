import 'package:flutter/material.dart';

class Pertemuan7 extends StatefulWidget {
  @override
  _Pertemuan7State createState() => _Pertemuan7State();
}

class _Pertemuan7State extends State<Pertemuan7> {
  String? _selectedGender;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  bool _termsAccepted = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Data Terkirim'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nama: ${_nameController.text}'),
              Text('Jenis Kelamin: ${_selectedGender ?? 'Tidak diisi'}'),
              Text('Syarat dan Ketentuan: ${_termsAccepted ? 'Diterima' : 'Tidak diterima'}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00C29B),
        title: const Text('Pertemuan 7', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Input Nama
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harap masukkan nama';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Radio Button Group
              const Text(
                'Pilih Jenis Kelamin:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ...['Pria', 'Wanita', 'Lainnya'].map((gender) {
                return ListTile(
                  title: Text(gender),
                  leading: Radio<String>(
                    value: gender.toLowerCase(),
                    groupValue: _selectedGender,
                    onChanged: (String? value) {
                      setState(() => _selectedGender = value);
                    },
                    activeColor: const Color.fromARGB(255, 20, 92, 218),
                  ),
                );
              }).toList(),

              // Checkbox Terms
              Row(
                children: [
                  Checkbox(
                    value: _termsAccepted,
                    onChanged: (value) {
                      setState(() => _termsAccepted = value ?? false);
                    },
                    activeColor: const Color.fromARGB(255, 20, 92, 218),
                  ),
                  const Expanded(
                    child: Text('Saya menyetujui syarat dan ketentuan yang berlaku'),
                  ),
                ],
              ),
              if (!_termsAccepted && _formKey.currentState?.validate() == true)
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Harap terima syarat dan ketentuan',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),

              const SizedBox(height: 20),

              // Display Selection
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Data yang Dipilih:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text('Nama: ${_nameController.text.isNotEmpty ? _nameController.text : 'Belum diisi'}'),
                      Text('Jenis Kelamin: ${_selectedGender ?? 'Belum dipilih'}'),
                      Text('Persetujuan: ${_termsAccepted ? 'Diterima' : 'Belum diterima'}'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00C29B),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'SUBMIT',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}