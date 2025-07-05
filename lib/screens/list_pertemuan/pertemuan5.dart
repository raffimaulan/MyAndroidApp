import 'package:flutter/material.dart';

class Pertemuan5 extends StatefulWidget {
  const Pertemuan5({super.key});

  @override
  Pertemuan5State createState() => Pertemuan5State();
}

class Pertemuan5State extends State<Pertemuan5> {
  final List<Map<String, String>> listViewInfos = [
    {
      'title': 'ListView.builder',
      'description': 'Digunakan untuk daftar dengan jumlah item yang banyak atau tidak tetap',
    },
    {
      'title': 'ListView.separated',
      'description': 'Digunakan jika ingin menambahkan pemisah antar item',
    },
    {
      'title': 'ListView.custom',
      'description': 'Digunakan untuk membuat list dengan lebih banyak control menggunakan SliverChildDelegate',
    },
    {
      'title': 'ListView',
      'description': 'Digunakan jika daftar memiliki jumlah item tetap yang kecil',
    },
  ];

  List<bool> checkedList = [];

  @override
  void initState() {
    super.initState();
    checkedList = List<bool>.filled(listViewInfos.length, false);
  }

  void _onCheckboxChanged(int index, bool? value) {
    setState(() {
      checkedList[index] = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pertemuan 5', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF00C29B),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.separated(
        itemCount: listViewInfos.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final info = listViewInfos[index];
          return Dismissible(
            key: Key(info['title']!),
            background: Container(color: Colors.red),
            onDismissed: (direction) {
              setState(() {
                listViewInfos.removeAt(index);
                checkedList.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${info['title']} dihapus')),
              );
            },
            child: CheckboxListTile(
              title: Text(
                info['title']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(info['description']!),
              secondary: CircleAvatar(child: Text('${index + 1}')),
              value: checkedList[index],
              onChanged: (value) => _onCheckboxChanged(index, value),
              activeColor: const Color.fromARGB(255, 20, 92, 218),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final selectedItems = listViewInfos.asMap().entries.where((entry) => checkedList[entry.key]).toList();
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Item Terpilih'),
              content: SingleChildScrollView(
                child: Column(
                  children: selectedItems.map((entry) => 
                    ListTile(
                      leading: CircleAvatar(child: Text('${entry.key + 1}')),
                      title: Text(entry.value['title']!),
                    )
                  ).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Tutup'),
                ),
              ],
            ),
          );
        },
        backgroundColor:  const Color(0xFF00C29B),
        child: const Icon(Icons.list),
      ),
    );
  }
}