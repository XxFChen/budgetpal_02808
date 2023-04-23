import 'dart:async';
import 'package:budgetpal/bloc/transaction_event.dart';
import 'package:budgetpal/bloc/transaction_state.dart';
import 'package:budgetpal/model/transaction.dart';
import 'package:budgetpal/repository/transaction_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository _transactionRepository;

  TransactionBloc(this._transactionRepository) : super(TransactionLoading());

  get transactionsStream => null;

  @override
  Stream<TransactionState> mapEventToState(TransactionEvent event) async* {
    if (event is FetchTransactions) {
      yield* _mapFetchTransactionsToState();
    } else if (event is AddTransaction) {
      yield* _mapAddTransactionToState(event.transaction);
    } else if (event is UpdateTransaction) {
      yield* _mapUpdateTransactionToState(event.transaction);
    } else if (event is DeleteTransaction) {
      yield* _mapDeleteTransactionToState(event.id);
    }
  }

  Stream<TransactionState> _mapFetchTransactionsToState() async* {
    try {
      final transactions = await _transactionRepository.getAllTransactions();
      yield TransactionsLoaded(transactions);
    } catch (_) {
      yield TransactionError();
    }
  }

  Stream<TransactionState> _mapAddTransactionToState(Transaction transaction) async* {
    try {
      await _transactionRepository.addTransaction(transaction);
      final transactions = await _transactionRepository.getAllTransactions();
      yield TransactionsLoaded(transactions);
    } catch (_) {
      yield TransactionError();
    }
  }

  Stream<TransactionState> _mapUpdateTransactionToState(Transaction transaction) async* {
    try {
      await _transactionRepository.updateTransaction(transaction);
      final transactions = await _transactionRepository.getAllTransactions();
      yield TransactionsLoaded(transactions);
    } catch (_) {
      yield TransactionError();
    }
  }

  Stream<TransactionState> _mapDeleteTransactionToState(String id) async* {
    try {
      await _transactionRepository.deleteTransaction(id);
      final transactions = await _transactionRepository.getAllTransactions();
      yield TransactionsLoaded(transactions);
    } catch (_) {
      yield TransactionError();
    }
  }

  void fetchTransactions() {}

  void dispose() {}
}
