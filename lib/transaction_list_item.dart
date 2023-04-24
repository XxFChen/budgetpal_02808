import 'package:budgetpal/model/transaction.dart';
import 'package:flutter/material.dart';

class TransactionListItem extends StatelessWidget {
  final Transaction transaction;

  const TransactionListItem({Key? key, required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(transaction.description),
      subtitle: Text(transaction.date.toString()),
      trailing: Text('\$${transaction.amount}'),
    );
  }
}
