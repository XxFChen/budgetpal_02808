import 'package:budgetpal/model/transaction.dart';
import 'package:equatable/equatable.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionLoading extends TransactionState {}

class TransactionsLoaded extends TransactionState {
  final List<Transaction> transactions;

  const TransactionsLoaded(this.transactions);

  @override
  List<Object> get props => [transactions];
}

class TransactionError extends TransactionState {}
