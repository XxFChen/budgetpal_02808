class Transaction {
  final int? id;
  final int accountId;
  final String category;
  final String note;
  final double amount;
  final DateTime date;
  final String type;

  Transaction({
    this.id,
    required this.accountId,
    required this.category,
    required this.note,
    required this.amount,
    required this.date,
    required this.type, required String description,
  });

  String? get description => null;
}
