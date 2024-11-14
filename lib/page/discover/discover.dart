import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/main.dart';
import 'package:shop/page/getStorage.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final StorageService storageService = StorageService();
  bool isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Discover",
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
      body: const SingleChildScrollView(
        child: Center(
          child: Text("Discover"),
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
            setState(
              () {
                isDarkMode = value;
              },
            );
          },
        ),
      ],
    );
  }
}
