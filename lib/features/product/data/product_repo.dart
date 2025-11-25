import 'package:huungry/core/network/api_service.dart';
import 'package:huungry/features/product/data/product_model.dart';
import 'package:huungry/features/product/data/category_model.dart';
import 'package:huungry/features/product/data/mock_products.dart';

class ProductRepository {
  final ApiService _apiService;

  ProductRepository(this._apiService);

  // جلب جميع المنتجات
  Future<List<Product>> getProducts({
    String? category,
    double? minPrice,
    double? maxPrice,
    String? searchQuery,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.get(
        '/products',
        queryParameters: {
          if (category != null && category != 'All') 'category': category,
          if (minPrice != null) 'minPrice': minPrice,
          if (maxPrice != null) 'maxPrice': maxPrice,
          if (searchQuery != null && searchQuery.isNotEmpty)
            'search': searchQuery,
          'page': page,
          'limit': limit,
        },
      );

      if (response['data'] == null) {
        // Fallback to mock products for local testing
        return MockProductData.generateProducts(50, categoryCount: 10);
      }

      final List<dynamic> productsList = response['data'] as List<dynamic>;
      if (productsList.isEmpty) {
        return MockProductData.generateProducts(50, categoryCount: 10);
      }

      return productsList
          .map((p) => Product.fromJson(p as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  // جلب المنتج حسب ID
  Future<Product> getProductById(String productId) async {
    try {
      final response = await _apiService.get('/products/$productId');

      if (response['data'] == null) {
        throw Exception('Product not found');
      }

      return Product.fromJson(response['data'] as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to load product: $e');
    }
  }

  // جلب جميع الفئات
  Future<List<Category>> getCategories() async {
    try {
      final response = await _apiService.get('/categories');
      if (response['data'] == null) {
        return MockProductData.generateCategories(10);
      }

      final List<dynamic> categoriesList = response['data'] as List<dynamic>;
      if (categoriesList.isEmpty) {
        return MockProductData.generateCategories(10);
      }

      return categoriesList
          .map((c) => Category.fromJson(c as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  // جلب المنتجات حسب الفئة
  Future<List<Product>> getProductsByCategory(
    String category, {
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.get(
        '/products',
        queryParameters: {'category': category, 'page': page, 'limit': limit},
      );

      if (response['data'] == null) return [];

      final List<dynamic> productsList = response['data'] as List<dynamic>;
      return productsList
          .map((p) => Product.fromJson(p as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load category products: $e');
    }
  }

  // البحث عن المنتجات
  Future<List<Product>> searchProducts(
    String query, {
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.get(
        '/products/search',
        queryParameters: {'q': query, 'page': page, 'limit': limit},
      );

      if (response['data'] == null) return [];

      final List<dynamic> productsList = response['data'] as List<dynamic>;
      return productsList
          .map((p) => Product.fromJson(p as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to search products: $e');
    }
  }

  // جلب المنتجات الأكثر تقييماً
  Future<List<Product>> getTopRatedProducts({int limit = 10}) async {
    try {
      final response = await _apiService.get(
        '/products/top-rated',
        queryParameters: {'limit': limit},
      );

      if (response['data'] == null) return [];

      final List<dynamic> productsList = response['data'] as List<dynamic>;
      return productsList
          .map((p) => Product.fromJson(p as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load top rated products: $e');
    }
  }

  // جلب المنتجات الجديدة
  Future<List<Product>> getNewProducts({int limit = 10}) async {
    try {
      final response = await _apiService.get(
        '/products/new',
        queryParameters: {'limit': limit},
      );

      if (response['data'] == null) return [];

      final List<dynamic> productsList = response['data'] as List<dynamic>;
      return productsList
          .map((p) => Product.fromJson(p as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load new products: $e');
    }
  }

  // جلب المنتجات حسب نطاق السعر
  Future<List<Product>> getProductsByPriceRange(
    double minPrice,
    double maxPrice, {
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.get(
        '/products',
        queryParameters: {
          'minPrice': minPrice,
          'maxPrice': maxPrice,
          'page': page,
          'limit': limit,
        },
      );

      if (response['data'] == null) return [];

      final List<dynamic> productsList = response['data'] as List<dynamic>;
      return productsList
          .map((p) => Product.fromJson(p as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load products by price: $e');
    }
  }
}
