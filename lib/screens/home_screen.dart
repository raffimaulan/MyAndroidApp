import 'package:flutter/material.dart';
import 'list_view_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Selamat Datang',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              _buatMenuKartu(context),
            ],
          ),
        ),
      ),
    );
  }

  // Method untuk membuat kartu menu
  Widget _buatMenuKartu(BuildContext context) {
    return Column(
      children: [
        MenuCard(
          icon: Icons.list,
          label: 'List Data',
          onTap: () => _navigasiKe(context, const ListViewScreen()),
        ),
        const SizedBox(height: 16),
        MenuCard(
          icon: Icons.add,
          label: 'Buat Data',
          onTap: () {
            
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Fitur Buat Data belum tersedia')),
            );
          },
        ),
        const SizedBox(height: 16),
        MenuCard(
          icon: Icons.info_outline,
          label: 'Tentang',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Fitur Tentang belum tersedia')),
            );
          },
        ),
      ],
    );
  }

  // Method helper untuk navigasi
  void _navigasiKe(BuildContext context, Widget halaman) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => halaman));
  }
}

class MenuCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const MenuCard({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFF00C29B), size: 24),
              const SizedBox(width: 16),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
