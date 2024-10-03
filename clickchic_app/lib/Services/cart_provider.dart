import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  // Add item to cart or increase quantity if it already exists
  void addItem(Map<String, dynamic> newItem) {
    final index =
        _cartItems.indexWhere((item) => item['title'] == newItem['title']);

    if (index == -1) {
      _cartItems.add(newItem);
    } else {
      _cartItems[index]['quantity'] += newItem['quantity'];
    }
    notifyListeners();
  }

  // Remove item from cart
  void removeItem(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  // Increment item quantity
  void incrementQuantity(int index) {
    _cartItems[index]['quantity'] += 1;
    notifyListeners();
  }

  // Decrement item quantity
  void decrementQuantity(int index) {
    if (_cartItems[index]['quantity'] > 1) {
      _cartItems[index]['quantity'] -= 1;
      notifyListeners();
    }
  }

  // Clear cart
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  // Calculate total price
  int get totalPrice {
    return _cartItems.fold(
        0,
        (sum, item) =>
            sum + (item['price'] as int) * (item['quantity'] as int));
  }

  // Calculate total items
  int get totalItems {
    return _cartItems.fold(0, (sum, item) => sum + (item['quantity'] as int));
  }
}
