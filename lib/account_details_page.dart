import 'package:flutter/material.dart';
import 'package:budgetpal/model/account.dart';
import 'package:budgetpal/bloc/account_bloc.dart';

class AccountDetailsPage extends StatefulWidget {
  final Account account;
  final AccountBloc accountBloc;

  const AccountDetailsPage({Key? key, required this.account, required this.accountBloc})
      : super(key: key);

  @override
  _AccountDetailsPageState createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.account.name),
      ),
      body: Container(
        child: Center(
          child: Text('Account details for ${widget.account.name}'),
        ),
      ),
    );
  }
}
