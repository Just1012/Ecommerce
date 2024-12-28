import 'package:flutter/foundation.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  double get totalPrice => _cartItems.fold(
        0.0,
        (sum, item) => sum + (item['quantity'] * item['price']),
      );

  void addItem(String name, int quantity, double price) {
    final existingItemIndex =
        _cartItems.indexWhere((item) => item['name'] == name);
    if (existingItemIndex >= 0) {
      _cartItems[existingItemIndex]['quantity'] += quantity;
    } else {
      _cartItems.add({
        'name': name,
        'quantity': quantity,
        'price': price,
      });
    }
    notifyListeners();
  }

  void removeItem(String name) {
    _cartItems.removeWhere((item) => item['name'] == name);
    notifyListeners();
  }

  void incrementQuantity(String name) {
    final index = _cartItems.indexWhere((item) => item['name'] == name);
    if (index >= 0) {
      _cartItems[index]['quantity'] += 1;
      notifyListeners();
    }
  }

  void decrementQuantity(String name) {
    final index = _cartItems.indexWhere((item) => item['name'] == name);
    if (index >= 0) {
      if (_cartItems[index]['quantity'] > 1) {
        _cartItems[index]['quantity'] -= 1;
      } else {
        _cartItems.removeAt(index);
      }
      notifyListeners();
    }
  }
}
