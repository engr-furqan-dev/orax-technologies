import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/post_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Threads Posts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PostListPage(),
    );
  }
}
