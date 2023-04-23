import 'package:flutter/material.dart';
import 'package:budgetpal/model/account.dart';
import 'package:budgetpal/bloc/account_bloc.dart';

class EditAccountPage extends StatefulWidget {
  final Account account;
  final AccountBloc accountBloc;

  const EditAccountPage({Key? key, required this.account, required this.accountBloc})
      : super(key: key);

  @override
  _EditAccountPageState createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  late TextEditingController _nameController;
  late TextEditingController _colorController;
  late TextEditingController _categoryController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.account.name);
    _colorController = TextEditingController(text: widget.account.color);
    _categoryController = TextEditingController(text: widget.account.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _colorController,
              decoration: const InputDecoration(labelText: 'Color'),
            ),
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            ElevatedButton(
              onPressed: () {
                final updatedAccount = Account(
                  id: widget.account.id,
                  name: _nameController.text,
                  balance: widget.account.balance,
                  color: _colorController.text,
                  category: _categoryController.text, type: '',
                );
                widget.accountBloc.updateAccount(updatedAccount);
                Navigator.pop(context);
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _colorController.dispose();
    _categoryController.dispose();
    super.dispose();
  }
}
