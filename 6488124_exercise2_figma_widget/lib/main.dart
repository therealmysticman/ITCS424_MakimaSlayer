import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Product {
  final String imageUrl;
  final String description;
  final String name;
  final String price;
  final String discount;
  Product(
      {required this.imageUrl,
      required this.description,
      required this.name,
      required this.price,
      required this.discount});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ProductDetailsScreen(),
      ),
    );
  }
}

class ProductDetailsScreen extends StatelessWidget {
  final Product product = Product(
    imageUrl:
        'https://th-live-01.slatic.net/p/bfb83e11c5a351cac178c084044803d1.jpg',
    name: 'Shin Ultraman Figure, Takara Tomy',
    price: '800.00 Baht',
    description: 'Status: Available',
    discount: "Discount coupon",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details',
            style: TextStyle(color: Colors.white)),
        backgroundColor:
            Colors.purple, // Set the background color of the app barr
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(
                context); // Navigate back when the back arrow is pressed
          },
        ),
      ),
      body: Container(
        color: Colors.white, // Set the background color of the body
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              product.imageUrl,
              height: 200,
              width: 200,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 24),
            Text(
              product.name,
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 22),
            Text(
              product.price,
              style: TextStyle(fontSize: 22),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.info,
                  color: Colors.black,
                ),
                SizedBox(width: 8),
                Text(
                  product.description,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
               
                SizedBox(width: 8),
                Text(
                  product.discount,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  textAlign: TextAlign.left,
                ),
                 Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                ),
              ],
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle cart button press
                    print('Added to Cart');
                  },
                  child: Text('Add to Cart'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    // Handle purchase button press
                    print('Purchase');
                  },
                  child: Text('Purchase'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
