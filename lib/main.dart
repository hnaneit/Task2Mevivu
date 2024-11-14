import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';

import 'package:shop/page/welcome/welcome.dart';

void main() async {
  await GetStorage.init();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainApp(),
  ));
}

class TrangThai extends GetxController {
  RxInt count = 0.obs;

  void reset(int a) {
    count.value = a;
  }
}

class MainApp extends StatelessWidget {
  final box = GetStorage();
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}
