import 'package:flutter/material.dart';

class Pertemuan2 extends StatelessWidget {
  const Pertemuan2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pertemuan 2',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor:  const Color(0xFF00C29B),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tombol Toast
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              onPressed: () => _showToast(context),
              child: const Text('TOAST'),
            ),
            const SizedBox(height: 16),
            // Tombol AlertDialog
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              onPressed: () => _showAlertDialog(context),
              child: const Text('ALERT DIALOG'),
            ),
          ],
        ),
      ),
    );
  }

  void _showToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ini Toast'),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(20),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(
          'AlertDialog',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text('Ini contoh AlertDialog.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('TUTUP'),
          ),
        ],
      ),
    );
  }
}