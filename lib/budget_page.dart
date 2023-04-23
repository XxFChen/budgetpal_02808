import 'package:flutter/material.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BudgetPageState createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  double _budget = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Budget: \$${_budget.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Set Budget',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _budget = double.tryParse(value) ?? 0;
                });
              },
            ),
            // Add budget progress and budget overspending alert widgets here.
          ],
        ),
      ),
    );
  }
}
