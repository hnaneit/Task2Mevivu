import 'package:flutter/material.dart';
import 'package:shop/main.dart';
import 'package:shop/model/userModel.dart';
import 'package:shop/network/network.dart';
import 'package:shop/page/discover/discover.dart';
import 'package:shop/page/getStorage.dart';
import 'package:shop/page/homePage/homePage.dart';
import 'package:shop/page/myOrder/myOrder.dart';
import 'package:shop/page/profile/profilePage.dart';
import 'package:get/get.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final StorageService storageService = StorageService();
  final counter = Get.put(TrangThai());

  bool isDarkMode = false;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    DiscoverPage(),
    MyOrderPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: NetworkRequest.fetchUserData(storageService.readData('token')),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          User user = snapshot.data!;
          storageService.saveData('user', user);
          return Obx(
            () => Scaffold(
              drawer: _buildDrawer(),
              body: Center(
                child: _widgetOptions.elementAt(counter.count.value),
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_bag),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: '',
                  ),
                ],
                currentIndex: counter.count.value,
                selectedItemColor: Colors.black,
                onTap: (index) => counter.reset(index),
              ),
            ),
          );
        } else {
          return const Center(child: Text('No user data found'));
        }
      },
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
                      backgroundImage: NetworkImage(
                          storageService.readData('user').image ?? ""),
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
