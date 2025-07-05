import 'package:flutter/material.dart';

class Pertemuan6 extends StatefulWidget {
  const Pertemuan6({super.key});

  @override
  Pertemuan6State createState() => Pertemuan6State();
}

class Pertemuan6State extends State<Pertemuan6> {
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
  bool _selectAll = false;

  @override
  void initState() {
    super.initState();
    checkedList = List<bool>.filled(listViewInfos.length, false);
  }

  void _toggleCheckbox(int index, bool? value) {
    setState(() {
      checkedList[index] = value ?? false;
      _updateSelectAllState();
    });
  }

  void _toggleSelectAll(bool? value) {
    setState(() {
      _selectAll = value ?? false;
      checkedList = List<bool>.filled(listViewInfos.length, _selectAll);
    });
  }

  void _updateSelectAllState() {
    setState(() {
      _selectAll = checkedList.every((isChecked) => isChecked);
    });
  }

  void _deleteSelected() {
    setState(() {
      for (int i = checkedList.length - 1; i >= 0; i--) {
        if (checkedList[i]) {
          listViewInfos.removeAt(i);
          checkedList.removeAt(i);
        }
      }
      _selectAll = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pertemuan 6', style: TextStyle(color: Colors.white)),
        backgroundColor:  const Color(0xFF00C29B),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: checkedList.any((isChecked) => isChecked) ? _deleteSelected : null,
            tooltip: 'Hapus yang dipilih',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _toggleSelectAll(!_selectAll);
          });
        },
        backgroundColor:  const Color(0xFF00C29B),
        child: Icon(_selectAll ? Icons.check_box : Icons.check_box_outline_blank),
      ),
      body: Column(
        children: [
          if (checkedList.any((isChecked) => isChecked))
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.blue[50],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${checkedList.where((isChecked) => isChecked).length} item dipilih',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: _deleteSelected,
                    child: const Text('HAPUS', 
                      style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ),
          Expanded(
            child: ListView.separated(
              itemCount: listViewInfos.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final info = listViewInfos[index];
                return Dismissible(
                  key: Key(info['title']!),
                  background: Container(color: Colors.red[100]),
                  secondaryBackground: Container(color: Colors.green[100]),
                  onDismissed: (direction) {
                    setState(() {
                      listViewInfos.removeAt(index);
                      checkedList.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${info['title']} dihapus'),
                        action: SnackBarAction(
                          label: 'Batal',
                          onPressed: () {
                            setState(() {
                              listViewInfos.insert(index, info);
                              checkedList.insert(index, false);
                            });
                          },
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Checkbox(
                      value: checkedList[index],
                      onChanged: (value) => _toggleCheckbox(index, value),
                      activeColor: const Color.fromARGB(255, 20, 92, 218),
                    ),
                    title: Text(
                      info['title']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(info['description']!),
                    trailing: CircleAvatar(child: Text('${index + 1}')),
                    onTap: () {
                      // Tambahkan aksi ketika item di-tap
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}