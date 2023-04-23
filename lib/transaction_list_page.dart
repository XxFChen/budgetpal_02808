import 'package:flutter/material.dart';
import 'package:budgetpal/model/transaction.dart';
import 'package:budgetpal/bloc/transaction_bloc.dart';
import 'package:budgetpal/repository/transaction_repository.dart';
import 'package:budgetpal/add_transaction_page.dart';

class TransactionListPage extends StatefulWidget {
  final TransactionBloc transactionBloc;

  const TransactionListPage({Key? key, required this.transactionBloc, required account}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TransactionListPageState createState() => _TransactionListPageState();
}

class _TransactionListPageState extends State<TransactionListPage> {
  @override
  void initState() {
    super.initState();
    widget.transactionBloc.fetchTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      body: StreamBuilder<List<Transaction>>(
        stream: widget.transactionBloc.transactionsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final transactions = snapshot.data!;
            return ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return ListTile(
                  title: Text(transaction.description ?? ''),
                  subtitle: Text('Amount: \$${transaction.amount}'),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTransactionPage(transactionBloc: widget.transactionBloc),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    widget.transactionBloc.dispose();
    super.dispose();
  }
  
  // ignore: non_constant_identifier_names
  AddTransactionPage({required TransactionBloc transactionBloc}) {}
}
