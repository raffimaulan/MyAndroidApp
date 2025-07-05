import 'package:flutter/material.dart';

class Pertemuan10 extends StatelessWidget {
  const Pertemuan10({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pertemuan 10 - Pengenalan TabLayout'),
        backgroundColor:const Color(0xFF00C29B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Text(
              '📌 Apa itu TabLayout?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              'TabLayout adalah sebuah widget atau elemen antarmuka (UI) dalam Android yang digunakan untuk menampilkan tab secara horizontal. '
              'Diperkenalkan melalui Support Design Library, TabLayout memungkinkan developer untuk menampilkan beberapa layar dalam satu layar utama, '
              'di mana pengguna dapat dengan cepat bergeser antar tab.',
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16),
            Text(
              '🔧 Implementasi dan Penggunaan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '1. **Menambahkan Dependency**\n'
              '   Tambahkan dalam `build.gradle`:\n'
              "   `implementation 'com.android.support:design:26.1.0'`\n\n"
              '2. **Menambahkan ke Layout XML**\n'
              '   Contoh:\n'
              '   ```xml\n'
              '   <android.support.design.widget.TabLayout\n'
              '       android:id="@+id/tabLayout" />\n\n'
              '   <android.support.v4.view.ViewPager\n'
              '       android:id="@+id/viewPager" />\n'
              '   ```\n\n'
              '3. **Membuat dan Menambah Tab (Java)**\n'
              '   ```java\n'
              '   TabLayout tabLayout = findViewById(R.id.tabLayout);\n'
              '   tabLayout.addTab(tabLayout.newTab().setText("Home"));\n'
              '   tabLayout.addTab(tabLayout.newTab().setText("Sport"));\n'
              '   tabLayout.addTab(tabLayout.newTab().setText("Movie"));\n'
              '   ```',
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16),
            Text(
              '📱 Integrasi dengan ViewPager dan Fragment',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '• ViewPager digunakan untuk mengatur transisi geser antar fragment.\n'
              '• Setiap tab menampilkan Fragment-nya masing-masing (contoh: HomeFragment.java).\n'
              '• FragmentPagerAdapter bertugas menghubungkan ViewPager dengan fragment berdasarkan posisi tab.',
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16),
            Text(
              '🔄 Sinkronisasi Tab dan Swipe',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Agar TabLayout dan ViewPager saling tersinkron:\n'
              '• Gunakan `viewPager.addOnPageChangeListener(...)` untuk memperbarui Tab saat swipe.\n'
              '• Gunakan `tabLayout.addOnTabSelectedListener(...)` untuk mengubah konten ViewPager saat tab ditekan.',
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
