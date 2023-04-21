
import 'package:budgetpal/model/account.dart';

abstract class AccountState {}

class AccountLoading extends AccountState {}

class AccountsLoaded extends AccountState {
  final List<Account> accounts;

  AccountsLoaded(this.accounts);
}

class AccountError extends AccountState {}
