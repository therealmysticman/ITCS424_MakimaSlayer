import 'package:flutter/material.dart';
import 'package:relics/Cart.dart'; // Import your cart page widget

class CartIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.shopping_cart),
      onPressed: () {
        // Navigate to the cart page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CartPage()),
        );
      },
    );
  }
}
