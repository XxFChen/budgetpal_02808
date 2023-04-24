import 'package:flutter/material.dart';

class Transaction {
  final String id;
  final String accountId;
  final String categoryId;
  final String description;
  final double amount;
  final DateTime date;
  final bool isExpense;

  Transaction({
    required this.id,
    required this.accountId,
    required this.categoryId,
    required this.description,
    required this.amount,
    required this.date,
    required this.isExpense,
  });

  Transaction copyWith({
    String? id,
    String? accountId,
    String? categoryId,
    String? description,
    double? amount,
    DateTime? date,
    bool? isExpense,
  }) {
    return Transaction(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      categoryId: categoryId ?? this.categoryId,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      isExpense: isExpense ?? this.isExpense,
    );
  }
}
