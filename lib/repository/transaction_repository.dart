import 'package:budgetpal/database/database_provider.dart';
import 'package:budgetpal/model/transaction.dart';

class TransactionRepository {
  TransactionRepository(DatabaseProvider databaseProvider);

  addTransaction(Transaction transaction) {}

  getAllTransactions() {}

  updateTransaction(Transaction transaction) {}

  deleteTransaction(String id) {}
  // Implement CRUD methods for Transaction data
}
