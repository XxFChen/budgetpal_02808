import '../model/account.dart';

abstract class AccountEvent {}

class FetchAccounts extends AccountEvent {}

class AddAccount extends AccountEvent {
  final Account account;

  AddAccount(this.account);
}

class UpdateAccount extends AccountEvent {
  final Account account;

  UpdateAccount(this.account);
}

class DeleteAccount extends AccountEvent {
  final String id;

  DeleteAccount(this.id);
}
