import 'package:flutter/material.dart';
import 'package:budgetpal/model/account.dart';
import 'package:budgetpal/bloc/account_bloc.dart';

class AddAccountPage extends StatefulWidget {
  final AccountBloc accountBloc;

  const AddAccountPage({Key? key, required this.accountBloc}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddAccountPageState createState() => _AddAccountPageState();
}

class _AddAccountPageState extends State<AddAccountPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _accountName = '';
  String _initialBalance = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      double initialBalance = double.tryParse(_initialBalance) ?? 0.0;
      final newAccount = Account(name: _accountName, balance: initialBalance, id: '', type: '', category: '', color: '');

      widget.accountBloc.addAccount(newAccount);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Account Name',
                  hintText: 'Enter account name',
                  prefixIcon: Icon(Icons.account_balance),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an account name';
                  }
                  return null;
                },
                onSaved: (value) => _accountName = value!,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Initial Balance',
                  hintText: 'Enter initial balance',
                  prefixIcon: Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an initial balance';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) => _initialBalance = value!,
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Add Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}