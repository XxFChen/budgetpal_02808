import 'package:budgetpal/model/transaction.dart';
import 'package:equatable/equatable.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];

  map(List Function(dynamic state) param0) {}
}

class TransactionLoading extends TransactionState {}

class TransactionsLoaded extends TransactionState {
  final List<Transaction> transactions;

  const TransactionsLoaded([this.transactions = const []]);

  @override
  List<Object> get props => [transactions];
}

class TransactionError extends TransactionState {}
