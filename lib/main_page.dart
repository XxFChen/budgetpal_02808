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
import 'package:budgetpal/add_transaction_page.dart';
import 'package:budgetpal/budget_page.dart';
import 'package:budgetpal/database/database_provider.dart';
import 'package:budgetpal/category_management_page.dart';
import 'package:budgetpal/category_page.dart';

class MainPage extends StatefulWidget {
  final AccountBloc accountBloc;
  final TransactionBloc transactionBloc;

  const MainPage({Key? key, required this.accountBloc, required this.transactionBloc}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class MainWithCategoryPage extends StatefulWidget {
  const MainWithCategoryPage({Key? key}) : super(key: key);

  @override
  _MainWithCategoryPageState createState() => _MainWithCategoryPageState();
}

class _MainWithCategoryPageState extends State<MainWithCategoryPage> {
  int _selectedIndex = 0;
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _screens = [
      MainPage(accountBloc: _accountBloc, transactionBloc: _transactionBloc),
      CategoryPage(),
    ];

    return Scaffold(
      body: _screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Accounts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  @override
  void dispose() {
    _accountBloc.dispose();
    super.dispose();
  }
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  late final DatabaseProvider _databaseProvider;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _databaseProvider = DatabaseProvider();
    widget.accountBloc.fetchAccounts();

    _pages = [
      accountPage(),
      CategoryManagementPage(),
    ];
  }

  Widget accountPage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts'),
        actions: [
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
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                  (context) => TransactionListPage(transactionBloc: widget.transactionBloc, account: null),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Account>>(
        stream: widget.accountBloc.accountsStream,
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
                        builder: (context) => AccountDetailsPage(account: account, accountBloc: widget.accountBloc),
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
                              builder: (context) => EditAccountPage(account: account, accountBloc: widget.accountBloc),
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          widget.accountBloc.deleteAccount(account.id as String);
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BudgetPal')),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Accounts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    widget.accountBloc.dispose();
    super.dispose();
  }
}
