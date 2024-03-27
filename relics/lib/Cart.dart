import 'package:flutter/material.dart';

class CartIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.shopping_cart),
      onPressed: () {
        // Handle cart icon tap
        // You can navigate to your cart page or show a modal, etc.
      },
    );
  }
}