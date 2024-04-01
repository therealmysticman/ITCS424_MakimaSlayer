import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _cartItems = [];
  List<String> _selectedItemIds = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;
  List<String> get selectedItemIds => _selectedItemIds;

  void addToCart(Map<String, dynamic> item) {
    int existingIndex = _cartItems.indexWhere((cartItem) => cartItem['ID'] == item['ID']);

    if (existingIndex != -1) {
      _cartItems[existingIndex]['quantity'] += 1;
    } else {
      Map<String, dynamic> newItem = Map<String, dynamic>.from(item);
      newItem['quantity'] = 1;
      _cartItems.add(newItem);
    }

    notifyListeners();
  }

  void removeFromCart(Map<String, dynamic> item) {
    int index = _cartItems.indexWhere((cartItem) => cartItem['ID'] == item['ID']);

    if (index != -1) {
      if (_cartItems[index]['quantity'] > 1) {
        _cartItems[index]['quantity'] -= 1;
      } else {
        _cartItems.removeAt(index);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  void setSelectedItemIds(List<String> ids) {
    _selectedItemIds = ids;
    notifyListeners();
  }
}
