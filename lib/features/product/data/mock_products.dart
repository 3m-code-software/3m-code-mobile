import 'dart:math';

import 'package:huungry/features/product/data/product_model.dart';
import 'package:huungry/features/product/data/category_model.dart';

class MockProductData {
  static List<Category> generateCategories(int count) {
    return List.generate(count, (i) {
      return Category(
        id: 'cat_${i + 1}',
        name: 'الفئة ${i + 1}',
        icon: '',
        productCount: 0,
      );
    });
  }

  static List<Product> generateProducts(int count, {int categoryCount = 10}) {
    final rnd = Random(42);
    final categories = generateCategories(categoryCount);

    return List.generate(count, (i) {
      final cat = categories[i % categoryCount];
      final basePrice = 10 + (i % 20) * 2; // varying prices
      final price = (basePrice + rnd.nextDouble() * 10).toDouble();
      final images = List.generate(
        3,
        (j) => 'https://picsum.photos/seed/${i + j}/600/400',
      );

      return Product(
        id: 'prod_${i + 1}',
        name: 'منتج ${i + 1} - ${cat.name}',
        description:
            'وصف توضيحي لمنتج ${i + 1}. هذا نص تجريبي لاختبار واجهة التفاصيل والفلاتر.',
        image: images.first,
        images: images,
        price: double.parse(price.toStringAsFixed(2)),
        rating: (3 + rnd.nextDouble() * 2),
        reviewCount: rnd.nextInt(200),
        category: cat.name,
        isAvailable: true,
        tags: ['تجريبي', 'شائع'],
      );
    });
  }
}
