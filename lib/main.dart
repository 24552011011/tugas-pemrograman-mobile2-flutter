import 'package:flutter/material.dart';

void main() {
  runApp(const CyberCafeApp());
}

class CyberCafeApp extends StatelessWidget {
  const CyberCafeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cyber Café & Gaming Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        primaryColor: const Color(0xFF38BDF8),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF38BDF8),
          secondary: Color(0xFF818CF8),
          surface: Color(0xFF1E293B),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E293B),
          elevation: 0,
          centerTitle: true,
        ),
      ),
      home: const MainPage(),
    );
  }
}

class MenuItem {
  final String name;
  final String category;
  final int price;
  final String imagePath;
  final IconData fallbackIcon;
  bool isFavorite;

  MenuItem({
    required this.name,
    required this.category,
    required this.price,
    required this.imagePath,
    required this.fallbackIcon,
    this.isFavorite = false,
  });
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // State untuk BottomNavigationBar
  int _bottomNavIndex = 0;

  // State untuk SegmentedButton Filter Kategori
  Set<String> _selectedCategory = {'Semua'};

  // State untuk Switch Mode Member
  bool _isVipMember = false;

  // Daftar Menu menggunakan gambar lokal dari folder pictures/
  final List<MenuItem> _menuItems = [
    MenuItem(
      name: 'Espresso Overclock',
      category: 'Minuman',
      price: 18000,
      imagePath: 'pictures/kopi.jpg',
      fallbackIcon: Icons.coffee,
    ),
    MenuItem(
      name: 'Matcha Firewall Latte',
      category: 'Minuman',
      price: 22000,
      imagePath: 'pictures/matcha.jpg',
      fallbackIcon: Icons.local_cafe,
    ),
    MenuItem(
      name: 'VIP Gaming PC (1 Jam)',
      category: 'Gaming',
      price: 15000,
      imagePath: 'pictures/pc.jpg',
      fallbackIcon: Icons.computer,
    ),
    MenuItem(
      name: 'Mechanical Keyboard Rental',
      category: 'Gaming',
      price: 10000,
      imagePath: 'pictures/keyboard.jpg',
      fallbackIcon: Icons.keyboard,
    ),
    MenuItem(
      name: 'Cyber Noodle Spesial',
      category: 'Makanan',
      price: 20000,
      imagePath: 'pictures/mie.jpg',
      fallbackIcon: Icons.ramen_dining,
    ),
  ];

  int _totalItems = 0;
  int _totalPrice = 0;

  // Fungsi menampilkan SnackBar
  void _showMsg(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF0284C7),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _addToCart(MenuItem item) {
    setState(() {
      _totalItems++;
      _totalPrice += item.price;
    });
    _showMsg('${item.name} ditambahkan ke keranjang!');
  }

  void _resetCart() {
    setState(() {
      _totalItems = 0;
      _totalPrice = 0;
    });
    _showMsg('Keranjang pesanan dikosongkan.');
  }

  // Helper Widget untuk memanggil Image.asset dari folder pictures/
  Widget _buildLocalImage(String path, IconData fallback, {double width = 60, double height = 60}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(
        path,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: width,
            height: height,
            color: const Color(0xFF0F172A),
            child: Icon(fallback, color: const Color(0xFF38BDF8), size: width * 0.4),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String activeFilter = _selectedCategory.first;
    final List<MenuItem> filteredList = activeFilter == 'Semua'
        ? _menuItems
        : _menuItems.where((item) => item.category == activeFilter).toList();

    return Scaffold(
      // 1. APPBAR
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.terminal, color: Color(0xFF38BDF8)),
            SizedBox(width: 8),
            Text(
              'CYBER CAFÉ HUB',
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
            tooltip: 'Reset Keranjang',
            onPressed: _resetCart,
          ),
        ],
      ),

      // 2. DRAWER
      drawer: Drawer(
        backgroundColor: const Color(0xFF0F172A),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0284C7), Color(0xFF4F46E5)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.person, size: 32, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Menu Navigasi Cyber Café',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'NIM: 24552011011 • UTB',
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 12),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Color(0xFF38BDF8)),
              title: const Text('Home / Katalog'),
              onTap: () {
                setState(() => _bottomNavIndex = 0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Color(0xFF818CF8)),
              title: const Text('Profile & Demo Widget'),
              onTap: () {
                setState(() => _bottomNavIndex = 1);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      // 3. FLOATING ACTION BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF38BDF8),
        foregroundColor: const Color(0xFF0F172A),
        tooltip: 'Quick Checkout',
        onPressed: () {
          _showMsg('Total Keranjang Saat Ini: $_totalItems Item (Rp $_totalPrice)');
        },
        child: const Icon(Icons.shopping_cart_checkout),
      ),

      // 4. BOTTOM NAVIGATION BAR
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        backgroundColor: const Color(0xFF1E293B),
        selectedItemColor: const Color(0xFF38BDF8),
        unselectedItemColor: Colors.white54,
        onTap: (index) {
          setState(() => _bottomNavIndex = index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile & Widget'),
        ],
      ),

      // 5. BODY (Berganti sesuai tab BottomNavigationBar)
      body: _bottomNavIndex == 0 ? _buildHomeContent(filteredList) : _buildProfileAndWidgetDemo(),
    );
  }

  // HALAMAN 1: HOME & KATALOG (Container, Row, Column, Image.asset, Card, ListTile)
  Widget _buildHomeContent(List<MenuItem> filteredList) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Banner Featured (Now Playing / Featured Promo Style)
        const Text(
          'Featured Cyber Arena',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF38BDF8)),
        ),
        const SizedBox(height: 10),
        Container(
          height: 170,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF38BDF8), width: 1.5),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              _buildLocalImage('pictures/banner.jpg', Icons.sports_esports_rounded, width: double.infinity, height: 170),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [Colors.black.withValues(alpha: 0.85), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'RTX 4090 VIP Battle Arena',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 18),
                        SizedBox(width: 4),
                        Text('4.9 • High Refresh Rate 240Hz + Kopi Dingin', style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Trending Horizontal Cards
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Trending Hari Ini',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text('Geser ->', style: TextStyle(fontSize: 12, color: Color(0xFF38BDF8))),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 135,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _menuItems.length,
            itemBuilder: (context, index) {
              final item = _menuItems[index];
              return Container(
                width: 120,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF334155)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLocalImage(item.imagePath, item.fallbackIcon, width: 80, height: 70),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        item.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      'Rp ${item.price}',
                      style: const TextStyle(fontSize: 11, color: Color(0xFF38BDF8)),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),

        // SegmentedButton untuk Filter Kategori
        const Text(
          'Filter Kategori Menu',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white70),
        ),
        const SizedBox(height: 8),
        SegmentedButton<String>(
          segments: const [
            ButtonSegment(value: 'Semua', label: Text('Semua')),
            ButtonSegment(value: 'Minuman', label: Text('Minuman')),
            ButtonSegment(value: 'Gaming', label: Text('Gaming')),
            ButtonSegment(value: 'Makanan', label: Text('Makanan')),
          ],
          selected: _selectedCategory,
          onSelectionChanged: (Set<String> newSelection) {
            setState(() {
              _selectedCategory = newSelection;
            });
            _showMsg('Filter kategori: ${newSelection.first}');
          },
        ),
        const SizedBox(height: 16),

        // Daftar Card & ListTile Menu
        ...filteredList.map((item) {
          return Card(
            color: const Color(0xFF1E293B),
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Color(0xFF334155)),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: _buildLocalImage(item.imagePath, item.fallbackIcon, width: 56, height: 56),
              title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${item.category} • Rp ${item.price}', style: const TextStyle(color: Colors.white60)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // IconButton Favorit
                  IconButton(
                    icon: Icon(
                      item.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.pinkAccent,
                    ),
                    onPressed: () {
                      setState(() => item.isFavorite = !item.isFavorite);
                      _showMsg(item.isFavorite ? 'Disukai!' : 'Batal disukai');
                    },
                  ),
                  // ElevatedButton Pesan
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF38BDF8),
                      foregroundColor: const Color(0xFF0F172A),
                    ),
                    onPressed: () => _addToCart(item),
                    child: const Text('Pesan', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          );
        }),

        // Ringkasan Total Pesanan di Bawah
        Container(
          margin: const EdgeInsets.only(top: 8, bottom: 60),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF4F46E5)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total Item: $_totalItems', style: const TextStyle(color: Colors.white70)),
                  Text(
                    'Rp $_totalPrice',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF38BDF8)),
                  ),
                ],
              ),
              FilledButton.icon(
                onPressed: _totalItems == 0
                    ? null
                    : () => _showMsg('Pesanan Rp $_totalPrice berhasil diproses!'),
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Bayar Sekarang'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // HALAMAN 2: PROFILE & DEMO SEMUA BUTTON
  Widget _buildProfileAndWidgetDemo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container dengan BoxDecoration
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF0284C7), Color(0xFF4F46E5)]),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                children: [
                  Icon(Icons.person_pin, size: 50, color: Colors.white),
                  SizedBox(height: 8),
                  Text(
                    'Mochammad Daffa Khairi Dhiaulhaq',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text('NIM: 24552011011 • Teknik Informatika UTB', style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Switch Widget
            Card(
              color: const Color(0xFF1E293B),
              child: SwitchListTile(
                title: const Text('Status Member VIP Cyber Café'),
                subtitle: Text(_isVipMember ? 'Aktif (Diskon Member)' : 'Reguler'),
                value: _isVipMember,
                activeThumbColor: const Color(0xFF38BDF8),
                onChanged: (val) {
                  setState(() => _isVipMember = val);
                  _showMsg('Status VIP: ${val ? "Aktif" : "Nonaktif"}');
                },
              ),
            ),
            const SizedBox(height: 20),

            // Demo Semua Jenis Button
            const Text(
              'Demo Variasi Button',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF38BDF8)),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: [
                TextButton(
                  onPressed: () => _showMsg('TextButton pressed'),
                  child: const Text('TextButton'),
                ),
                ElevatedButton(
                  onPressed: () => _showMsg('ElevatedButton pressed'),
                  child: const Text('ElevatedButton'),
                ),
                FilledButton(
                  onPressed: () => _showMsg('FilledButton pressed'),
                  child: const Text('FilledButton'),
                ),
                OutlinedButton(
                  onPressed: () => _showMsg('OutlinedButton pressed'),
                  child: const Text('OutlinedButton'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}