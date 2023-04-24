import 'dart:async';
import 'package:budgetpal/bloc/transaction_event.dart';
import 'package:budgetpal/bloc/transaction_state.dart';
import 'package:budgetpal/model/transaction.dart';
import 'package:budgetpal/repository/transaction_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository _transactionRepository;

  TransactionBloc(this._transactionRepository) : super(TransactionLoading());

  @override
  Stream<TransactionState> mapEventToState(TransactionEvent event) async* {
    if (event is FetchTransactions) {
      yield* _mapFetchTransactionsToState(event.accountId);
    } else if (event is AddTransaction) {
      yield* _mapAddTransactionToState(event.transaction);
    } else if (event is UpdateTransaction) {
      yield* _mapUpdateTransactionToState(event.transaction);
    } else if (event is DeleteTransaction) {
      yield* _mapDeleteTransactionToState(event.id);
    }
  }

  Stream<TransactionState> _mapFetchTransactionsToState(String accountId) async* {
    try {
      final transactions = await _transactionRepository.getAllTransactions(accountId);
      yield TransactionsLoaded(transactions);
    } catch (_) {
      yield TransactionError();
    }
  }

  Stream<TransactionState> _mapAddTransactionToState(Transaction transaction) async* {
    try {
      _transactionRepository.addTransaction(transaction);
      final transactions = await _transactionRepository.getAllTransactions(transaction.accountId);
      yield TransactionsLoaded(transactions);
    } catch (_) {
      yield TransactionError();
    }
  }

  Stream<TransactionState> _mapUpdateTransactionToState(Transaction transaction) async* {
    try {
      _transactionRepository.updateTransaction(transaction);
      final transactions = await _transactionRepository.getAllTransactions(transaction.accountId);
      yield TransactionsLoaded(transactions);
    } catch (_) {
      yield TransactionError();
    }
  }

  Stream<TransactionState> _mapDeleteTransactionToState(String id) async* {
    try {
      _transactionRepository.deleteTransaction(id);
      final transactions = await _transactionRepository.getAllTransactions(''); // TODO: Provide the correct accountId
      yield TransactionsLoaded(transactions);
    } catch (_) {
      yield TransactionError();
    }
  }
  

  // Add this getter
  Stream<List<Transaction>> get transactionsStream => state.map((state) {
    if (state is TransactionsLoaded) {
      return state.transactions;
    } else {
      return [];
    }
  });

  // Add this method
  void dispose() {
    close();
  }

  void fetchTransactions() {}
}
