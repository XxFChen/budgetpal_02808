import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({Key? key}) : super(key: key);

  @override
  _AddTransactionPageState createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _transactionNameController = TextEditingController();
  final TextEditingController _transactionAmountController = TextEditingController();
  String _transactionCategory = 'Food';
  bool _isExpense = true;

  List<String> _transactionCategories = [
    'Food',
    'Transportation',
    'Shopping',
    'Health',
    'Entertainment',
    'Utilities',
    'Housing',
    'Insurance',
    'Education',
    'Others',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Transaction'),
      ),
      body: _buildForm(context),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(16),
        children: [
          TextFormField(
            controller: _transactionNameController,
            decoration: InputDecoration(
              labelText: 'Transaction Name',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter transaction name';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          InputDecorator(
            decoration: InputDecoration(
              labelText: 'Transaction Category',
            ),
            child: DropdownButton<String>(
              value: _transactionCategory,
              items: _transactionCategories.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _transactionCategory = newValue!;
                });
              },
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _transactionAmountController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: 'Transaction Amount',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter transaction amount';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Expense'),
              CupertinoSwitch(
                value: _isExpense,
                onChanged: (bool value) {
                  setState(() {
                    _isExpense = value;
                  });
                },
              ),
              Text('Income'),
            ],
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Add the transaction
              }
            },
            child: Text('Add Transaction'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _transactionNameController.dispose();
    _transactionAmountController.dispose();
    super.dispose();
  }
}
