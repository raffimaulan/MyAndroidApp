import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  String? _photoUrl;
  File? _imageFile;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        final data = doc.data();
        _nameController.text = data?['name'] ?? '';
        _descController.text = data?['desc'] ?? '';
        _photoUrl = data?['photoUrl'];
      }
    }
    setState(() => _isLoading = false);
  }

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 60);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  Future<String?> _uploadImage(File image) async {
    try {
      final user = _auth.currentUser;
      final ref = FirebaseStorage.instance.ref().child('profile_pictures/${user!.uid}.jpg');
      await ref.putFile(image);
      return await ref.getDownloadURL();
    } catch (e) {
      Fluttertoast.showToast(msg: "Gagal upload gambar", backgroundColor: Colors.red);
      return null;
    }
  }

  Future<void> _deleteProfilePhoto() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Hapus Foto Profil"),
        content: const Text("Yakin ingin menghapus foto profil?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Batal")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Hapus")),
        ],
      ),
    );

    if (confirm != true) return;

    final user = _auth.currentUser;
    if (user == null) return;

    try {
      final ref = FirebaseStorage.instance.ref().child('profile_pictures/${user.uid}.jpg');
      await ref.delete();
    } catch (_) {
      // Tidak perlu menampilkan error jika file tidak ditemukan
    }

    await _firestore.collection('users').doc(user.uid).update({'photoUrl': ''});

    setState(() {
      _photoUrl = null;
      _imageFile = null;
    });

    Fluttertoast.showToast(msg: "Foto profil dihapus", backgroundColor: Colors.orange);
  }

  Future<void> _saveProfile() async {
    final user = _auth.currentUser;
    if (user == null) return;

    if (_nameController.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: "Nama tidak boleh kosong", backgroundColor: Colors.red);
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Konfirmasi"),
        content: const Text("Simpan perubahan profil?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Batal")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Simpan")),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() => _isLoading = true);

    String? photoUrl = _photoUrl;

    if (_imageFile != null) {
      final uploaded = await _uploadImage(_imageFile!);
      if (uploaded != null) photoUrl = uploaded;
    }

    await _firestore.collection('users').doc(user.uid).update({
      'name': _nameController.text.trim(),
      'desc': _descController.text.trim(),
      'photoUrl': photoUrl ?? '',
    });

    Fluttertoast.showToast(msg: "Profil berhasil disimpan", backgroundColor: Colors.green);

    setState(() => _isLoading = false);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = _imageFile != null
        ? FileImage(_imageFile!)
        : (_photoUrl != null && _photoUrl!.isNotEmpty
            ? NetworkImage(_photoUrl!)
            : const AssetImage("assets/profile.jpg")) as ImageProvider;

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profil"), backgroundColor: Colors.teal),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: imageProvider,
                        ),
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 18,
                          child: Icon(Icons.edit, size: 20, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton.icon(
                    onPressed: _photoUrl != null || _imageFile != null ? _deleteProfilePhoto : null,
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    label: const Text("Hapus Foto Profil", style: TextStyle(color: Colors.red)),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: "Nama"),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _descController,
                    decoration: const InputDecoration(labelText: "Deskripsi"),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _saveProfile,
                    icon: const Icon(Icons.save),
                    label: const Text("Simpan"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      minimumSize: const Size(double.infinity, 45),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
