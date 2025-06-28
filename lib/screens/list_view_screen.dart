import 'package:flutter/material.dart';
import '../screens/list_pertemuan/pertemuan1.dart';
import '../screens/list_pertemuan/pertemuan2.dart';
import '../screens/list_pertemuan/pertemuan3.dart';
import '../screens/list_pertemuan/pertemuan4.dart';
import '../screens/list_pertemuan/pertemuan5.dart';
import '../screens/list_pertemuan/pertemuan6.dart';
import '../screens/list_pertemuan/pertemuan7.dart';
import '../screens/list_pertemuan/pertemuan8.dart';
import '../screens/list_pertemuan/pertemuan9.dart';
import '../screens/list_pertemuan/pertemuan13.dart';
import '../screens/list_pertemuan/pertemuan14.dart';



class ListViewScreen extends StatefulWidget {
  const ListViewScreen({super.key});

  @override
  _ListViewScreenState createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  List<String> _items = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchItems();
  }

  Future<void> _fetchItems() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _items = [
        'Pertemuan 1',
        'Pertemuan 2',
        'Pertemuan 3',
        'Pertemuan 4',
        'Pertemuan 5',
        'Pertemuan 6',
        'Pertemuan 7',
        'Pertemuan 8',
        'Pertemuan 9',
        'Pertemuan 13',
        'Pertemuan 14',


      ];
      _isLoading = false;
    });
  }

  Widget? _getTargetPage(String item) {
    switch (item) {
      case 'Pertemuan 1':
        return Pertemuan1();
      case 'Pertemuan 2':
        return Pertemuan2();
      case 'Pertemuan 3':
        return Pertemuan3();
      case 'Pertemuan 4':
        return Pertemuan4();
      case 'Pertemuan 5':
        return Pertemuan5();
      case 'Pertemuan 6':
        return Pertemuan6();
      case 'Pertemuan 7':
        return Pertemuan7();
      case 'Pertemuan 8':
        return Pertemuan8();
      case 'Pertemuan 9':
        return pertemuan9();
      case 'Pertemuan 13':
        return Pertemuan13();
      case 'Pertemuan 14':
        return Pertemuan14();
      default:
        print('Navigasi untuk item "$item" tidak didefinisikan.');
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Daftar Pertemuan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: theme.textTheme.titleLarge?.color,
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _items.isEmpty
                    ? Center(child: Text('Tidak ada data pertemuan.'))
                    : ListView.builder(
                        itemCount: _items.length,
                        itemBuilder: (context, index) {
                          final item = _items[index];
                          return ListTile(
                            leading: Icon(Icons.assignment, color: theme.iconTheme.color),
                            title: Text(item),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: theme.iconTheme.color?.withOpacity(0.7),
                            ),
                            onTap: () {
                              final targetPage = _getTargetPage(item);
                              if (targetPage != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => targetPage),
                                );
                              }
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
