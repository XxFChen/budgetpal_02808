class Account {
  final String id;
  final String name;
  final String type;
  final double balance;

  Account({
    required this.id,
    required this.name,
    required this.type,
    required this.balance, required String category, required String color,
  });

  get color => null;

  get category => null;
}
