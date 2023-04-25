class Currency {
  final String id;
  final String name;
  final String symbol;

  Currency({required this.id, required this.name, required this.symbol});
}

final List<Currency> currencies = [
  Currency(id: 'USD', name: 'US Dollar', symbol: '\$'),
  Currency(id: 'EUR', name: 'Euro', symbol: '€'),
  Currency(id: 'CNY', name: 'China Yuan', symbol: '¥'),
  Currency(id: 'DKK', name: 'Danish Krones', symbol: 'kr'),
  Currency(id: 'JPY', name: 'Japanese Yen', symbol: '¥'),
];
