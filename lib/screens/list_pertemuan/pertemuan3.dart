import 'package:flutter/material.dart';

class Pertemuan3 extends StatelessWidget {
  const Pertemuan3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white, // Tambahkan warna icon
          onPressed: () => _navigateHome(context),
        ),
        title: const Text(
          'Pertemuan 3',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        foregroundColor: Colors.white,
        backgroundColor:  const Color(0xFF00C29B),
        centerTitle: true, // Tambahkan ini untuk posisi judul di tengah
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.account_circle,
              size: 100,
              color: Colors.blueAccent,
            ),
            const SizedBox(height: 16),
            const Text(
              'Hai, Raffi Maulana',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              onPressed: () => _showGreeting(context),
              child: const Text('CLICK ME'),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateHome(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  void _showGreeting(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Hi aku raffi :)!'),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(20),
      ),
    );
  }
}