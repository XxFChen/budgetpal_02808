import 'package:flutter/material.dart';

class CategoryManagementPage extends StatefulWidget {
  @override
  _CategoryManagementPageState createState() => _CategoryManagementPageState();
}

class _CategoryManagementPageState extends State<CategoryManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Management'),
      ),
      body: Center(
        child: Text('Here you can manage categories.'),
      ),
    );
  }
}
