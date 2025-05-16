import 'package:flutter/material.dart';

class Pertemuan8 extends StatefulWidget {
  const Pertemuan8({Key? key}) : super(key: key);

  @override
  State<Pertemuan8> createState() => _Pertemuan8State();
}

class _Pertemuan8State extends State<Pertemuan8> {
  final List<String> pertemuanList = ['Flutter', 'Kotlin', 'Java', 'Php', 'Html'];
  String? selectedDropdown;
  String? autoCompleteSelected;
  TextEditingController autoCompleteController = TextEditingController();

  void _navigateToDetail(String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PertemuanDetailPage(title: title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pertemuan 8'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Cari atau pilih topik:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Spinner / Dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Pilih Pertemuan (Dropdown)',
                border: OutlineInputBorder(),
              ),
              value: selectedDropdown,
              items: pertemuanList.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedDropdown = value;
                  autoCompleteController.clear();
                });
              },
            ),

            const SizedBox(height: 16),

            // Autocomplete
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<String>.empty();
                }
                return pertemuanList.where((String option) {
                  return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                });
              },
              onSelected: (String selection) {
                setState(() {
                  autoCompleteSelected = selection;
                  selectedDropdown = null;
                  autoCompleteController.text = selection;
                });
              },
              fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                autoCompleteController = controller;
                return TextFormField(
                  controller: controller,
                  focusNode: focusNode,
                  decoration: const InputDecoration(
                    labelText: 'Cari Pertemuan (Autocomplete)',
                    border: OutlineInputBorder(),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            ElevatedButton.icon(
              onPressed: () {
                final selected = autoCompleteSelected ?? selectedDropdown;
                if (selected != null) {
                  _navigateToDetail(selected);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Pilih atau ketik pertemuan terlebih dahulu.')),
                  );
                }
              },
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Buka Halaman'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PertemuanDetailPage extends StatelessWidget {
  final String title;

  const PertemuanDetailPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCEFEA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF00C29B),
        leading: const BackButton(),
        title: Text(title.toUpperCase(), style: const TextStyle(color: Colors.black)),
        elevation: 0,
      ),
      body: Center(
        child: Text('Ini adalah halaman $title'),
      ),
    );
  }
}
