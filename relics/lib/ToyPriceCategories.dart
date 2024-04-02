import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ToyDetails.dart';

class ToyPriceCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toy Price Categories'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Below 1,000 Baht'),
            onTap: () {
              _showToysByPriceRange(context, 'Below 1000 Baht', 0, 1000);
            },
          ),
          ListTile(
            title: Text('1,000-1,999 Baht'),
            onTap: () {
              _showToysByPriceRange(context, '1000-1999 Baht', 1000, 2000);
            },
          ),
          ListTile(
            title: Text('Above 2,000 Baht'),
            onTap: () {
              _showToysByPriceRange(context, 'Above 2000 Baht', 2000, double.infinity);
            },
          ),
        ],
      ),
    );
  }

  void _showToysByPriceRange(BuildContext context, String priceCategory, double minPrice, double maxPrice) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ToysByPriceScreen(priceCategory: priceCategory, minPrice: minPrice, maxPrice: maxPrice),
      ),
    );
  }
}

class ToysByPriceScreen extends StatelessWidget {
  final String priceCategory;
  final double minPrice;
  final double maxPrice;

  const ToysByPriceScreen({required this.priceCategory, required this.minPrice, required this.maxPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toys $priceCategory'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('ToyData')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final List<Map<String, dynamic>> toysInRange = snapshot.data!.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .where((toy) {
                final String priceString = toy['Price'];
                final double price = double.tryParse(priceString.replaceAll(' Baht', '')) ?? 0.0;
                return price >= minPrice && price < maxPrice;
              })
              .toList();

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Two items per row
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: toysInRange.length,
            itemBuilder: (BuildContext context, int index) {
              Map<String, dynamic> data = toysInRange[index];
              return GestureDetector(
                onTap: () {
                  // Navigate to ToyDetails screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ToyDetails(toyData: data, selectedItemsIds: [], selectedCouponData: {}),
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
