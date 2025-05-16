import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Pertemuan4 extends StatefulWidget {
  @override
  State<Pertemuan4> createState() => _Pertemuan4State();
}

class _Pertemuan4State extends State<Pertemuan4>{
  int _counter = 0;
  final double _avatarRadius = 95.0;
  final Color _primaryColor = const Color.fromARGB(255, 115, 208, 236);
  final Color _secondaryColor = const Color.fromARGB(255, 158, 1, 1);

  void _incrementCounter() {
    setState(() => _counter++);
    _showToast(
      message: "Power Tuan Muda meningkat! $_counter",
      backgroundColor: _secondaryColor,
    );
  }

  void _resetCounter() {
    setState(() => _counter = 0);
    _showToast(
      message: "Power Tuan Muda telah direset!",
      backgroundColor: _primaryColor,
    );
  }

  void _showToast({
    required String message,
    required Color backgroundColor,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  void _showConfirmationDialog({required bool isReset}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Konfirmasi"),
        content: Text(isReset
            ? "Apakah Anda yakin ingin mereset power ke 0?"
            : "Apakah Anda yakin ingin menaikkan power?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              isReset ? _resetCounter() : _incrementCounter();
            },
            child: Text(isReset ? "Reset" : "Ya"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth * 0.6;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pertemuan 4'),
        backgroundColor:  const Color(0xFF00C29B),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(26),
        child: Column(
          children: [
            // Profile Section
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  height: 274,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: AssetImage('assets/profile.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 80,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00C29B),
                          blurRadius: 10,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: _avatarRadius,
                      backgroundImage:
                          const AssetImage('assets/profile2.jpeg'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            // Content Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Raffi Maulana',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                            'saya adalah sang prabu',                   
                       textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                const SizedBox(height: 20),
                // Power Counter
                Text(
                  'Power Level: $_counter',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                // Buttons
                _buildActionButton(
                  width: buttonWidth,
                  text: 'Tambah kekuatan',
                  color: _primaryColor,
                  onPressed: () => _showConfirmationDialog(isReset: false),
                ),
                const SizedBox(height: 20),
                _buildActionButton(
                  width: buttonWidth,
                  text: 'Reset kekuatan',
                  color: _secondaryColor,
                  onPressed: () => _showConfirmationDialog(isReset: true),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

 Widget _buildActionButton({
  required double width,
  required String text,
  required Color color,
  required VoidCallback onPressed,
}) {
  return SizedBox(
    width: width,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:  const Color(0xFF00C29B),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 15), // Fixed
        shadowColor: color.withOpacity(0.6),
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(text),
    ),
  );
}
}