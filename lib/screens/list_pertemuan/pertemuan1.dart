import 'package:flutter/material.dart';

class Pertemuan1 extends StatelessWidget {
  const Pertemuan1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pertemuan 1',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF00C29B),
        foregroundColor: Colors.white,
        centerTitle: true,  // Tambahkan ini untuk membuat judul di tengah
        elevation: 4,  // Tambahkan shadow di bawah AppBar
      ),
      body: Center(
        child: Text(
          'Hello',
          style: TextStyle(
            fontSize: 24,
            color: Theme.of(context).primaryColor,  // Warna mengikuti tema
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}