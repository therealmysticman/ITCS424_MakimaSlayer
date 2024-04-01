import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:relics/Checkout.dart';
import 'package:relics/Provider.dart'; // Import the CartProvider

class ToyDetails extends StatelessWidget {
  final Map<String, dynamic> toyData;

  ToyDetails({required this.toyData});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, _) => Scaffold(
        appBar: AppBar(
          title: Text('Toy Details'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(toyData['Image']),
                SizedBox(height: 20),
                Text(
                  '${toyData['Title']}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text('Manufacturer: ${toyData['Manufacturer']}'),
                Text('Price: ${toyData['Price']}'),
                Text('Release Year: ${toyData['Release Year']}'),
                Text('Type: ${toyData['Type']}'),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Add to Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: 'Make a Purchase',
            ),
          ],
          selectedItemColor:
              Color.fromARGB(255, 110, 66, 131), // Set the selected item color to purple
          unselectedItemColor:
              Color.fromARGB(255, 110, 66, 131), // Set the unselected item color to purple
          onTap: (index) async {
            if (index == 0) {
              // Add to cart
              cartProvider.addToCart(toyData);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Item added to cart')),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CheckoutPage(selectedItemsIds: [
                    toyData['ID']
                  ]), // Assuming selectedItemsIds expects a List<String>
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
