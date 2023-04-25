class Category {
  final String id;
  final String name;
  final String icon;

  Category({required this.id, required this.name, required this.icon});

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        icon = json['icon'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'icon': icon,
      };
}
