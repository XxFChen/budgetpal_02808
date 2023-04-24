import 'package:flutter/material.dart';

import 'main_page.dart'; // 导入MainWithCategoryPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BudgetPal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainWithCategoryPage(), // 使用MainWithCategoryPage作为主页
    );
  }
}
