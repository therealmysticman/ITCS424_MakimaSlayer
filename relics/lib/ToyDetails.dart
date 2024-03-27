import 'package:flutter/material.dart';
import 'package:relics/Checkout.dart';

class ToyDetails extends StatelessWidget {
  final Map<String, dynamic> toyData;

  ToyDetails({required this.toyData});

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = -1;
    return Scaffold(
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
              SizedBox(
                  height: 20), // Adding some space between text and buttons
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
        currentIndex: _selectedIndex == -1 ? 0 : _selectedIndex,
        selectedItemColor: _selectedIndex == -1
            ? Color.fromARGB(255, 94, 61, 123)
            : Colors.amber[800],
        unselectedItemColor: Color.fromARGB(255, 94, 61, 123),
        onTap: (index) {
          // Handle navigation
          switch (index) {
            case 0:
              // Navigate to home
              break;
            case 1:
           Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CheckoutPage(selectedItemsIds: [toyData['ID']]),
           ));
               
              break;
          }
        },
      ),
    );
  }
}
