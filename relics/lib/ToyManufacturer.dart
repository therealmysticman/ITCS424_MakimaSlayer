import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'ToyDetails.dart';

class ToyManufacturer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toy Manufacturer Categories'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Bandai'),
            onTap: () {
              _showToysByManufacturer(context, 'Bandai');
            },
          ),
          ListTile(
            title: Text('Banpresto'),
            onTap: () {
              _showToysByManufacturer(context, 'Banpresto');
            },
          ),
          ListTile(
            title: Text('Tamashii Nations'),
            onTap: () {
              _showToysByManufacturer(context, 'Tamashii Nations');
            },
          ),
          ListTile(
            title: Text('Hasbro'),
            onTap: () {
              _showToysByManufacturer(context, 'Hasbro');
            },
          ),
          ListTile(
            title: Text('Sideshow Collectibles'),
            onTap: () {
              _showToysByManufacturer(context, 'Sideshow Collectibles');
            },
          ),
        ],
      ),
    );
  }

  void _showToysByManufacturer(BuildContext context, String manufacturer) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ToysByManufacturerScreen(manufacturer: manufacturer),
      ),
    );
  }
}

class ToysByManufacturerScreen extends StatelessWidget {
  final String manufacturer;

  const ToysByManufacturerScreen({required this.manufacturer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toys by $manufacturer'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('ToyData')
            .where('Manufacturer', isEqualTo: manufacturer)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Two items per row
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              Map<String, dynamic> data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
              return GestureDetector(
                onTap: () {
                  // Navigate to ToyDetails screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ToyDetails(toyData: data, selectedItemsIds: [], selectedCouponData: {}), // Pass empty data for selected items and coupon,
                    ),
                  );
                },
                child: Card(
                  elevation: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Image.network(
                          data['Image'],
                          fit: BoxFit.cover,
                          alignment: FractionalOffset.topCenter,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['Title'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Text('Release Year: ${data['Release Year']}'),
                            Text('Price: ${data['Price']}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
