import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:huungry/features/product/data/product_model.dart';
import 'package:huungry/features/product/data/product_repo.dart';
import 'package:huungry/core/network/api_service.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRepository _repository = ProductRepository(ApiService());

  List<Product> _products = [];
  List<Product> get products => _products;

  List<String> _categories = ['All'];
  List<String> get categories => _categories;

  String _selectedCategory = 'All';
  String get selectedCategory => _selectedCategory;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  double? _minPrice;
  double? get minPrice => _minPrice;

  double? _maxPrice;
  double? get maxPrice => _maxPrice;

  Timer? _searchDebounce;

  // paging
  int _page = 1;
  final int _limit = 20;

  Future<void> loadCategories() async {
    try {
      final cats = await _repository.getCategories();
      final names = cats.map((c) => c.name).toList();
      _categories = ['All', ...names];
      notifyListeners();
    } catch (e) {
      if (kDebugMode) print('loadCategories error: $e');
    }
  }

  Future<void> loadProducts({bool reset = false}) async {
    if (reset) {
      _page = 1;
      _products = [];
    }

    _isLoading = true;
    notifyListeners();

    try {
      final list = await _repository.getProducts(
        category: _selectedCategory == 'All' ? null : _selectedCategory,
        searchQuery: _searchQuery.isEmpty ? null : _searchQuery,
        minPrice: _minPrice,
        maxPrice: _maxPrice,
        page: _page,
        limit: _limit,
      );

      if (reset) {
        _products = list;
      } else {
        _products.addAll(list);
      }

      _page++;
    } catch (e) {
      if (kDebugMode) print('loadProducts error: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  void setCategory(String cat) {
    _selectedCategory = cat;
    notifyListeners();
    loadProducts(reset: true);
  }

  void setSearchQuery(String q) {
    _searchQuery = q;
    notifyListeners();
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 600), () {
      loadProducts(reset: true);
    });
  }

  void refresh() => loadProducts(reset: true);

  void setPriceRange(double? min, double? max) {
    _minPrice = min;
    _maxPrice = max;
    notifyListeners();
    loadProducts(reset: true);
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    super.dispose();
  }
}
