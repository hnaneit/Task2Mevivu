import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shop/main.dart';
import 'package:shop/page/getStorage.dart';
import 'package:shop/page/homePage/Category/beauty.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final StorageService storageService = StorageService();

  int _selectedCategory = 0;
  bool isDarkMode = false;

  final List<Map<String, dynamic>> categories = [
    {'name': 'Beauty', 'icon': LineIcons.glasses},
    {'name': 'Women', 'icon': Icons.female},
    {'name': 'Men', 'icon': Icons.male},
    {'name': 'Accessories', 'icon': LineIcons.glasses},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Gemstore',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_outlined,
                    color: Colors.black),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 100,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  categories.length,
                  (index) => _buildCategoryItem(index),
                ),
              ),
            ),
            Container(
              child: _buildCategoryContent(_selectedCategory),
            ),
          ],
        ),
      ),
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(storageService.readData('user').image),
                      radius: 30,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(storageService.readData('user').username,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18)),
                        SizedBox(
                          width: 200,
                          child: Text(
                            storageService.readData('user').email,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          _buildDrawerItems(),
        ],
      ),
    );
  }

  Widget _buildDrawerItems() {
    final counter = Get.put(TrangThai());
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Homepage'),
          onTap: () => {
            counter.reset(0),
            Navigator.pop(context),
          },
        ),
        ListTile(
          leading: const Icon(Icons.search),
          title: const Text('Discover'),
          onTap: () => {
            counter.reset(1),
            Navigator.pop(context),
          },
        ),
        ListTile(
          leading: const Icon(Icons.shopping_bag),
          title: const Text('My Order'),
          onTap: () => {
            counter.reset(2),
            Navigator.pop(context),
          },
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('My profile'),
          onTap: () => {
            counter.reset(3),
            Navigator.pop(context),
          },
        ),
        const Divider(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text('OTHER',
              style:
                  TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Setting'),
          onTap: () => Navigator.pop(context),
        ),
        ListTile(
          leading: const Icon(Icons.mail),
          title: const Text('Support'),
          onTap: () => Navigator.pop(context),
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('About us'),
          onTap: () => Navigator.pop(context),
        ),
        SwitchListTile(
          secondary: isDarkMode
              ? const Icon(Icons.dark_mode)
              : const Icon(Icons.light_mode),
          title: isDarkMode ? const Text('Dark') : const Text('Light'),
          value: isDarkMode,
          onChanged: (value) {
            setState(() {
              isDarkMode = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildCategoryItem(int index) {
    bool isSelected = index == _selectedCategory;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedCategory = index;
        });
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.brown : Colors.white,
                  width: 2.0,
                ),
              ),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: isSelected ? Colors.brown : Colors.grey[300],
                child: Icon(
                  categories[index]['icon'],
                  size: 40,
                  color: isSelected ? Colors.white : Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              categories[index]['name'],
              style: TextStyle(
                color: isSelected ? Colors.brown : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryContent(int categoryIndex) {
    switch (categoryIndex) {
      case 0:
        return const Beauty();
      case 1:
        return const Center(child: Text('Women\'s Products'));
      case 2:
        return const Center(child: Text('Men\'s Products'));
      case 3:
        return const Center(child: Text('Accessories'));
      default:
        return const Center(child: Text('Select a category'));
    }
  }
}
