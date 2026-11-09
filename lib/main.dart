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
      // Mengatur Tema Gelap (Cyberpunk / Dark Tech Theme)
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
      home: const MenuScreen(),
    );
  }
}

class MenuItem {
  final String name;
  final String category;
  final int price;
  final IconData icon;

  MenuItem({
    required this.name,
    required this.category,
    required this.price,
    required this.icon,
  });
}

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final List<MenuItem> _menuItems = [
    MenuItem(name: 'Espresso Overclock', category: 'Coffee', price: 18000, icon: Icons.coffee),
    MenuItem(name: 'Matcha Firewall Latte', category: 'Non-Coffee', price: 22000, icon: Icons.local_cafe),
    MenuItem(name: 'VIP Gaming PC (1 Jam)', category: 'Billing', price: 15000, icon: Icons.computer),
    MenuItem(name: 'Mechanical Keyboard Rental', category: 'Gear', price: 10000, icon: Icons.keyboard),
    MenuItem(name: 'Cyber Noodle Spesial', category: 'Food', price: 20000, icon: Icons.ramen_dining),
    MenuItem(name: 'Full-Stack French Fries', category: 'Snack', price: 15000, icon: Icons.fastfood),
  ];

  int _totalItems = 0;
  int _totalPrice = 0;

  void _addToCart(MenuItem item) {
    setState(() {
      _totalItems++;
      _totalPrice += item.price;
    });
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.name} ditambahkan ke pesanan!'),
        backgroundColor: const Color(0xFF38BDF8),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _resetCart() {
    setState(() {
      _totalItems = 0;
      _totalPrice = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          if (_totalItems > 0)
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.redAccent),
              tooltip: 'Reset Pesanan',
              onPressed: _resetCart,
            ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Header
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0284C7), Color(0xFF4F46E5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selamat Datang, Developer!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 6),
                Text(
                  'Pilih amunisi kopi dan paket billing PC untuk menemani sesi ngoding & gaming hari ini.',
                  style: TextStyle(fontSize: 13, color: Colors.white70),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Daftar Menu & Layanan',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF38BDF8)),
            ),
          ),
          const SizedBox(height: 10),
          // Grid Daftar Menu
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _menuItems.length,
              itemBuilder: (context, index) {
                final item = _menuItems[index];
                return Card(
                  color: const Color(0xFF1E293B),
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Color(0xFF334155), width: 1),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundColor: const Color(0xFF0F172A),
                      child: Icon(item.icon, color: const Color(0xFF38BDF8)),
                    ),
                    title: Text(
                      item.name,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    subtitle: Text(
                      '${item.category} • Rp ${item.price}',
                      style: const TextStyle(color: Colors.white60, fontSize: 13),
                    ),
                    trailing: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF38BDF8),
                        foregroundColor: const Color(0xFF0F172A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => _addToCart(item),
                      icon: const Icon(Icons.add_shopping_cart, size: 16),
                      label: const Text('Pesan', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // Bottom Bar Ringkasan Pesanan
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color(0xFF1E293B),
          border: Border(top: BorderSide(color: Color(0xFF334155), width: 1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Item: $_totalItems',
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
                Text(
                  'Rp $_totalPrice',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF38BDF8),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4F46E5),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: _totalItems == 0
                  ? null
                  : () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: const Color(0xFF1E293B),
                          title: const Text('Pesanan Berhasil!'),
                          content: Text(
                            'Total pembayaran sebesar Rp $_totalPrice untuk $_totalItems item telah dicatat ke sistem.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _resetCart();
                              },
                              child: const Text('Selesai'),
                            ),
                          ],
                        ),
                      );
                    },
              child: const Text('Checkout', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}