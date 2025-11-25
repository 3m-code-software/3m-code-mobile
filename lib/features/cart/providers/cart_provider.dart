import 'package:flutter/foundation.dart';
import 'package:huungry/features/product/data/product_model.dart';

class CartItemData {
  final Product product;
  int quantity;

  CartItemData({required this.product, required this.quantity});

  double get subtotal => product.price * quantity;

  CartItemData copyWith({Product? product, int? quantity}) {
    return CartItemData(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}

class CartProvider extends ChangeNotifier {
  final List<CartItemData> _items = [];

  List<CartItemData> get items => _items;

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice => _items.fold(0.0, (sum, item) => sum + item.subtotal);

  bool get isEmpty => _items.isEmpty;

  // Add product to cart or increase quantity if already exists
  void addToCart(Product product, {int quantity = 1}) {
    final existingIndex = _items.indexWhere(
      (item) => item.product.id == product.id,
    );
    if (existingIndex >= 0) {
      _items[existingIndex].quantity += quantity;
    } else {
      _items.add(CartItemData(product: product, quantity: quantity));
    }
    notifyListeners();
  }

  // Remove item from cart
  void removeFromCart(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  // Update quantity of a cart item
  void updateQuantity(String productId, int newQuantity) {
    if (newQuantity <= 0) {
      removeFromCart(productId);
      return;
    }
    final itemIndex = _items.indexWhere((item) => item.product.id == productId);
    if (itemIndex >= 0) {
      _items[itemIndex].quantity = newQuantity;
      notifyListeners();
    }
  }

  // Increment quantity
  void incrementQuantity(String productId) {
    final itemIndex = _items.indexWhere((item) => item.product.id == productId);
    if (itemIndex >= 0) {
      _items[itemIndex].quantity++;
      notifyListeners();
    }
  }

  // Decrement quantity
  void decrementQuantity(String productId) {
    final itemIndex = _items.indexWhere((item) => item.product.id == productId);
    if (itemIndex >= 0 && _items[itemIndex].quantity > 1) {
      _items[itemIndex].quantity--;
      notifyListeners();
    } else if (itemIndex >= 0) {
      removeFromCart(productId);
    }
  }

  // Clear all items from cart
  void clear() {
    _items.clear();
    notifyListeners();
  }
}
