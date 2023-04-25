import 'package:budgetpal/model/currency.dart';

class Account {
  final String id;
  final String name;
  final String type;
  final double balance;
  final String category;
  final String color;
  final Currency currency;

  Account({
    required this.id,
    required this.name,
    required this.type,
    required this.balance,
    required this.category,
    required this.color,
    required this.currency,
  });

  String get getColor => color;
  String get getCategory => category;
}
