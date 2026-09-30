import 'package:flutter/material.dart';
import 'food_item.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'detail_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;
  final List<FoodItem> _items = FoodItem.sampleData;

  Future<void> _openDetail(FoodItem item) async {
    final result = await Navigator.push<int>(
      context,
      MaterialPageRoute(builder: (_) => DetailPage(item: item)),
    );
    if (result != null) {
      setState(() => item.quantity = result); // beranda ikut update
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(items: _items, onTapItem: _openDetail),
      const ProfilePage(),
    ];
    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.restaurant_menu), label: 'Menu'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}