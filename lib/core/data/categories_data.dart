class Category {
  final String id;
  final String nameEn;
  final String nameAr;
  final String icon; // Material Icons name
  final List<String> subcategories;

  const Category({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.icon,
    required this.subcategories,
  });
}

class CategoryService {
  static const List<Category> mainCategories = [
    Category(
      id: 'electronics',
      nameEn: 'Electronics',
      nameAr: 'إلكترونيات',
      icon: 'devices',
      subcategories: [
        'Smartphones & Tablets',
        'Laptops & Computers',
        'Audio & Headphones',
        'Cameras & Photography',
        'Smart Home Devices',
        'Gaming Consoles',
        'Wearables & Smartwatches',
        'Accessories',
      ],
    ),
    Category(
      id: 'fashion',
      nameEn: 'Fashion',
      nameAr: 'موضة',
      icon: 'checkroom',
      subcategories: [
        'Men\'s Clothing',
        'Women\'s Clothing',
        'Kids\' Clothing',
        'Shoes & Sneakers',
        'Bags & Backpacks',
        'Watches & Jewelry',
        'Sunglasses',
        'Winter Wear',
      ],
    ),
    Category(
      id: 'home',
      nameEn: 'Home & Kitchen',
      nameAr: 'منزل ومطبخ',
      icon: 'home',
      subcategories: [
        'Furniture',
        'Home Decor',
        'Kitchen Appliances',
        'Cookware & Utensils',
        'Bedding & Bath',
        'Storage & Organization',
        'Lighting',
        'Garden & Outdoor',
      ],
    ),
    Category(
      id: 'sports',
      nameEn: 'Sports & Outdoors',
      nameAr: 'رياضة',
      icon: 'sports_basketball',
      subcategories: [
        'Fitness Equipment',
        'Sports Clothing',
        'Cycling',
        'Camping & Hiking',
        'Water Sports',
        'Team Sports',
        'Yoga & Pilates',
        'Sports Nutrition',
      ],
    ),
    Category(
      id: 'beauty',
      nameEn: 'Beauty & Health',
      nameAr: 'جمال وصحة',
      icon: 'spa',
      subcategories: [
        'Skincare',
        'Makeup & Cosmetics',
        'Hair Care',
        'Fragrances',
        'Personal Care',
        'Health Supplements',
        'Medical Devices',
        'Grooming Tools',
      ],
    ),
    Category(
      id: 'books',
      nameEn: 'Books & Media',
      nameAr: 'كتب ووسائط',
      icon: 'book',
      subcategories: [
        'Fiction Books',
        'Non-Fiction Books',
        'Educational Books',
        'Comics & Manga',
        'Music & Vinyl',
        'Movies & TV Shows',
        'Video Games',
        'Stationery',
      ],
    ),
    Category(
      id: 'toys',
      nameEn: 'Toys & Kids',
      nameAr: 'ألعاب وأطفال',
      icon: 'toys',
      subcategories: [
        'Educational Toys',
        'Action Figures',
        'Dolls & Playsets',
        'Building Blocks',
        'Board Games',
        'Baby Products',
        'Kids Electronics',
        'Outdoor Play',
      ],
    ),
    Category(
      id: 'automotive',
      nameEn: 'Automotive',
      nameAr: 'سيارات',
      icon: 'directions_car',
      subcategories: [
        'Car Accessories',
        'Car Electronics',
        'Car Care & Cleaning',
        'Tires & Wheels',
        'Engine Parts',
        'Interior Accessories',
        'Exterior Accessories',
        'Tools & Equipment',
      ],
    ),
  ];
}
