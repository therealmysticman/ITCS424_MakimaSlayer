import 'package:flutter/material.dart';
import 'package:relics/Cart.dart'; // Import your cart page widget

class CartIcon extends StatelessWidget {
  final String userEmail; // Add userEmail as a parameter

  CartIcon({required this.userEmail}); // Constructor

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.shopping_cart),
      onPressed: () {
        // Navigate to the cart page with userEmail
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CartPage(userEmail: userEmail)),
        );
      },
    );
  }
}
