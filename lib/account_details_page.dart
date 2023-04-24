import 'package:flutter/material.dart';
import 'package:budgetpal/model/account.dart';
import 'package:budgetpal/bloc/account_bloc.dart';
import 'package:budgetpal/model/transaction.dart';
import 'package:budgetpal/transaction_list_item.dart';
import 'package:budgetpal/bloc/transaction_bloc.dart';
import 'package:budgetpal/repository/transaction_repository.dart';
import 'package:budgetpal/database/database_provider.dart';

import 'bloc/transaction_event.dart';

class AccountDetailsPage extends StatefulWidget {
  final Account account;
  final AccountBloc accountBloc;

  const AccountDetailsPage({Key? key, required this.account, required this.accountBloc})
      : super(key: key);

  @override
  _AccountDetailsPageState createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  late final DatabaseProvider _databaseProvider;
  late final TransactionBloc _transactionBloc;

  @override
  void initState() {
    super.initState();
    _databaseProvider = DatabaseProvider();
    _transactionBloc = TransactionBloc(TransactionRepository(_databaseProvider));
    _transactionBloc.add(FetchTransactions(widget.account.id as String, accountId: ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.account.name),
      ),
      body: Column(
        children: [
          Container(
            child: Center(
              child: Text('Account details for ${widget.account.name}'),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Transaction>>(
              stream: _transactionBloc.transactionsStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final transactions = snapshot.data!;
                  return ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = transactions[index];
                      return TransactionListItem(transaction: transaction);
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _transactionBloc.close();
    super.dispose();
  }
}
