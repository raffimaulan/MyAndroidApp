import 'package:apk_tugas/screens/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  String _name = '';
  String _desc = '';
  String? _photoUrl;
  bool _isLoading = true;

  Future<void> _loadUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        final doc = await _firestore.collection('users').doc(user.uid).get();
        if (doc.exists) {
          final data = doc.data();
          setState(() {
            _name = data?['name'] ?? '';
            _desc = data?['desc'] ?? '';
            _photoUrl = data?['photoUrl'];
            _isLoading = false;
          });
        } else {
          Fluttertoast.showToast(msg: "Data pengguna tidak ditemukan", backgroundColor: Colors.orange);
          setState(() => _isLoading = false);
        }
      } catch (e) {
        Fluttertoast.showToast(
          msg: "Gagal memuat data: ${e.toString()}",
          backgroundColor: Colors.red,
        );
        setState(() => _isLoading = false);
      }
    } else {
      Fluttertoast.showToast(msg: "User belum login", backgroundColor: Colors.red);
      setState(() => _isLoading = false);
    }
  }

  Future<void> _logout(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Konfirmasi Keluar"),
        content: const Text("Yakin ingin keluar dari akun?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Batal")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Ya")),
        ],
      ),
    );

    if (confirm == true) {
      await _auth.signOut();
      Fluttertoast.showToast(msg: "Berhasil logout", backgroundColor: Colors.redAccent);
      Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 180,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/FotoSampul.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -50,
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: (_photoUrl != null && _photoUrl!.isNotEmpty)
                                ? NetworkImage(_photoUrl!)
                                : const AssetImage("assets/profile.jpg") as ImageProvider,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text("Nama"),
                    subtitle: Text(_name),
                  ),
                  ListTile(
                    leading: const Icon(Icons.description),
                    title: const Text("Deskripsi"),
                    subtitle: Text(_desc),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => const EditProfileScreen()))
                          .then((_) => _loadUserData()); // refresh setelah kembali
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text("Edit Profil"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('Tentang Aplikasi'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text('Keluar', style: TextStyle(color: Colors.red)),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () => _logout(context),
                  ),
                ],
              ),
            ),
    );
  }
}
