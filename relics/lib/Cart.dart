import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:relics/Checkout.dart';
import 'package:relics/CartProvider.dart'; // Import the CartProvider
import 'package:relics/CouponProvider.dart'; // Import the CouponProvider

class CartPage extends StatelessWidget {
  final String userEmail; // Add userEmail as a parameter

  CartPage({required this.userEmail}); // Constructor
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final selectedCouponData = Provider.of<CouponProvider>(context).selectedCouponData;
    
    // Calculate total price in Thai Baht (THB)
    double totalPriceTHB = 0.0;
    for (var item in cartProvider.cartItems) {
      totalPriceTHB +=
          double.parse(item['Price'].replaceAll(RegExp(r'[^\d.]'), '')) *
              item['quantity'];
    }

    // Get the selected item IDs from the cart items
    List<String> selectedItemsIds = cartProvider.cartItems.map((item) => item['ID'].toString()).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: cartProvider.cartItems.isEmpty
          ? Center(
              child: Text('Your cart is empty.'),
            )
          : ListView.builder(
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                final item = cartProvider.cartItems[index];
                final price = item['Price'].replaceAll(RegExp(r'[\n\r]'), '');
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 16.0),
                          leading: Container(
                            width: 100,
                            height: 100,
                            child: Image.network(
                              item['Image'],
                              fit: BoxFit.cover,
                              alignment: FractionalOffset.topCenter,
                            ),
                          ),
                          title: Text(
                            item['Title'],
                            style: TextStyle(fontSize: 11),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            price,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                cartProvider.removeFromCart(item);
                              },
                            ),
                            Text(
                              '${item['quantity']}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                cartProvider.addToCart(item);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: ฿${totalPriceTHB.toStringAsFixed(2)}', // Display total price in THB
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigate to checkout page with selected item IDs and coupon data
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckoutPage(
                        selectedItemsIds: selectedItemsIds,
                        totalPriceTHB: totalPriceTHB,
                        selectedCouponData: selectedCouponData,
                        usernameEmail: userEmail,
                      ),
                    ),
                  );
                },
                child: Text('Checkout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
