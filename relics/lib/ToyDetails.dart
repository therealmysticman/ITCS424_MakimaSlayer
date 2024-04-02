import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:relics/Checkout.dart';
import 'package:relics/CartProvider.dart';
import 'package:relics/CouponProvider.dart'; // Import the CartProvider

class ToyDetails extends StatelessWidget {
  final Map<String, dynamic> toyData;
  final List<String> selectedItemsIds;
  final Map<String, dynamic> selectedCouponData;

  ToyDetails({
    required this.toyData,
    required this.selectedItemsIds,
    required this.selectedCouponData,
  });

  @override
Widget build(BuildContext context) {
  final selectedCouponData = Provider.of<CouponProvider>(context).selectedCouponData;

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
        selectedItemColor: Color.fromARGB(255, 110, 66, 131),
        unselectedItemColor: Color.fromARGB(255, 110, 66, 131),
        onTap: (index) async {
          if (index == 0) {
            // Add to cart
            cartProvider.addToCart(toyData);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Item added to cart')),
            );
          } else if (index == 1) {
            // Calculate total price
            double totalPriceTHB = double.parse(toyData['Price'].replaceAll(RegExp(r'[^\d.]'), ''));
            
            // Add the current toy to the selected items list
            List<String> updatedSelectedItemsIds = List.from(selectedItemsIds);
            updatedSelectedItemsIds.add(toyData['ID']);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CheckoutPage(selectedItemsIds: updatedSelectedItemsIds, totalPriceTHB: totalPriceTHB, selectedCouponData: selectedCouponData),
              ),
            );
          }
        },
      ),
    ),
  );
}

}
