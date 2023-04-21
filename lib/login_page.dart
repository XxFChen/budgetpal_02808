import 'package:flutter/material.dart';
import 'main_page.dart'; // 导入 main_page.dart

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key); // 添加 key 参数

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  void _onLoginPressed(BuildContext context) {
    final username = _usernameController.text;
    final password = _passwordController.text;

    // 在这里添加验证用户名和密码的逻辑
    if (_validateUsername(username) == null && _validatePassword(password) == null) {
      // 验证通过，导航到 MainPage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    } else {
      // 显示错误信息
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid username or password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                hintText: 'Enter your username',
                prefixIcon: const Icon(Icons.person),
                errorText: _validateUsername(_usernameController.text),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon: const Icon(Icons.lock),
                errorText: _validatePassword(_passwordController.text),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () => _onLoginPressed(context),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
