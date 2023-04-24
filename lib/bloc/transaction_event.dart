import 'package:budgetpal/model/transaction.dart';
import 'package:equatable/equatable.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class FetchTransactions extends TransactionEvent {
  final String accountId;

  FetchTransactions(String id, {required this.accountId});

  @override
  List<Object> get props => [accountId];
}

class AddTransaction extends TransactionEvent {
  final Transaction transaction;

  AddTransaction({required this.transaction});

  @override
  List<Object> get props => [transaction];
}

class UpdateTransaction extends TransactionEvent {
  final Transaction transaction;

  UpdateTransaction({required this.transaction});

  @override
  List<Object> get props => [transaction];
}




class DeleteTransaction extends TransactionEvent {
  final String id;

  DeleteTransaction({required this.id});

  @override
  List<Object> get props => [id];
}
