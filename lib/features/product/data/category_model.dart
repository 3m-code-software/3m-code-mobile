class Category implements Comparable<Category> {
  final String id;
  final String name;
  final String icon;
  final int productCount;

  const Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.productCount,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
      productCount: json['productCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'icon': icon, 'productCount': productCount};
  }

  @override
  int compareTo(Category other) => name.compareTo(other.name);
}
