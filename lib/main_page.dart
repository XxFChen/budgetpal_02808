import 'package:flutter/material.dart';
import 'package:budgetpal/model/account.dart';
import 'package:budgetpal/bloc/account_bloc.dart';
import 'package:budgetpal/repository/account_repository.dart';
import 'package:budgetpal/add_account_page.dart';
import 'package:budgetpal/account_details_page.dart';
import 'package:budgetpal/edit_account_page.dart';
import 'package:budgetpal/bloc/transaction_bloc.dart';
import 'package:budgetpal/repository/transaction_repository.dart';
import 'package:budgetpal/transaction_list_page.dart';
import 'package:budgetpal/add_transaction_page.dart'; // Make sure this import is added
import 'package:budgetpal/budget_page.dart';
import 'package:budgetpal/database/database_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final DatabaseProvider _databaseProvider;
  late final AccountBloc _accountBloc;
  late final TransactionBloc _transactionBloc;

  @override
  void initState() {
    super.initState();
    _databaseProvider = DatabaseProvider();
    _accountBloc = AccountBloc(AccountRepository(_databaseProvider));
    _transactionBloc = TransactionBloc(TransactionRepository(_databaseProvider));
    _accountBloc.fetchAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts'),
        actions: [
          // Add transaction button
          IconButton(
            icon: const Icon(Icons.add_box),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTransactionPage(),
                ),
              );
            },
          ),
          // Other existing buttons
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TransactionListPage(transactionBloc: _transactionBloc, account: null,),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Account>>(
        stream: _accountBloc.accountsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final accounts = snapshot.data!;
            return ListView.builder(
              itemCount: accounts.length,
              itemBuilder: (context, index) {
                final account = accounts[index];
                return ListTile(
                  title: Text(account.name),
                  subtitle: Text('Balance: \$${account.balance}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AccountDetailsPage(account: account, accountBloc: _accountBloc),
                      ),
                    );
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditAccountPage(account: account, accountBloc: _accountBloc),
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          _accountBloc.deleteAccount(account.id as String);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
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
              builder: (context) => const BudgetPage(),
           ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _accountBloc.dispose();
    super.dispose();
  }
}