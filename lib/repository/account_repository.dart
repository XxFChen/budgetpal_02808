import 'package:budgetpal/database/database_provider.dart';
import 'package:budgetpal/model/account.dart';

class AccountRepository {
  final List<Account> _accounts = [];

  AccountRepository(DatabaseProvider databaseProvider);

  List<Account> getAllAccounts() => _accounts;

  void addAccount(Account account) {
    _accounts.add(account);
  }

  void updateAccount(Account updatedAccount) {
    int index = _accounts.indexWhere((account) => account.id == updatedAccount.id);
    _accounts[index] = updatedAccount;
  }

  void deleteAccount(String id) {
    _accounts.removeWhere((account) => account.id == id);
  }
}
