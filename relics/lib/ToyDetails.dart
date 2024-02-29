import 'package:flutter/material.dart';

class ToyDetails extends StatelessWidget {
  final Map<String, dynamic> toyData;

  ToyDetails({required this.toyData});

  @override
  Widget build(BuildContext context) {
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
                'Title: ${toyData['Title']}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Manufacturer: ${toyData['Manufacturer']}'),
              Text('Price: ${toyData['Price']}'),
              Text('Release Year: ${toyData['Release Year']}'),
              Text('Type: ${toyData['Type']}'),
              SizedBox(height: 20), // Adding some space between text and buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Add to cart functionality
                      },
                      child: Text('Add to Cart'),
                    ),
                  ),
                  SizedBox(width: 20), // Adding space between buttons
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Buy now functionality
                      },
                      child: Text('Buy Now'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
