import 'package:budgetpal/database/database_provider.dart';
import 'package:budgetpal/model/transaction.dart';

class TransactionRepository {
  final List<Transaction> _transactions = [];

  TransactionRepository(DatabaseProvider databaseProvider);

  Future<List<Transaction>> getAllTransactions(String accountId) async {
    return _transactions.where((transaction) => transaction.accountId == accountId).toList();
  }

  Future<void> addTransaction(Transaction transaction) async {
    _transactions.add(transaction);
  }

  Future<void> updateTransaction(Transaction transaction) async {
    final index = _transactions.indexWhere((t) => t.id == transaction.id);
    if (index != -1) {
      _transactions[index] = transaction;
    }
  }

  Future<void> deleteTransaction(String id) async {
    _transactions.removeWhere((transaction) => transaction.id == id);
  }
}
