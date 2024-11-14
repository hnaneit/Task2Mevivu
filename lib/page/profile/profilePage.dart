import 'package:flutter/material.dart';
import 'package:shop/page/getStorage.dart';
import 'package:shop/page/signUp_login/login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final StorageService storageService = StorageService();

  bool isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          _buildProfileHeader(),
          const SizedBox(height: 50),
          _buildMenuOptions(context),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage:
                NetworkImage(storageService.readData('user').image),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                storageService.readData('user').username,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                storageService.readData('user').email,
              )
            ],
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildMenuOptions(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {'icon': Icons.location_on, 'text': 'Address'},
      {'icon': Icons.payment, 'text': 'Payment method'},
      {'icon': Icons.local_offer, 'text': 'Voucher'},
      {'icon': Icons.favorite, 'text': 'My Wishlist'},
      {'icon': Icons.star, 'text': 'Rate this app'},
      {'icon': Icons.logout, 'text': 'Log out'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children:
              menuItems.map((item) => _buildMenuItem(item, context)).toList(),
        ),
      ),
    );
  }

  Widget _buildMenuItem(Map<String, dynamic> item, BuildContext context) {
    return ListTile(
      leading: Icon(item['icon']),
      title: Text(item['text']),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        if (item['text'] == 'Log out') {
          _logout(context);
        }
      },
    );
  }

  void _logout(BuildContext context) {
    storageService.removeData('user');
    storageService.removeData('token');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }
}
