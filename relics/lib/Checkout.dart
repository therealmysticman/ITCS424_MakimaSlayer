import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:relics/Home.dart';

class CheckoutPage extends StatelessWidget {
  final List<String> selectedItemsIds;
  final double totalPriceTHB;

  CheckoutPage({required this.selectedItemsIds, required this.totalPriceTHB});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: ListView(
        children: [
          FutureBuilder<List<DocumentSnapshot>>(
            future: _fetchSelectedItems(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Text('No items selected'),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var item = snapshot.data![index];
                  final price = item['Price'].replaceAll(RegExp(r'[\n\r]'), '');
                  return ListTile(
                    leading: Container(
                      width: 100,
                      height: 100,
                      child: Image.network(
                        item['Image'],
                        fit: BoxFit.cover,
                        alignment: FractionalOffset.topCenter,
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['Title'],
                          style: TextStyle(fontSize: 16),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          price,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          ListTile(
            title: Text('Select Address'),
            onTap: () {
              // Implement onTap functionality for selecting coupon
            },
          ),
          ListTile(
            title: Text('Select Coupon'),
            onTap: () {
              // Implement onTap functionality for selecting coupon
            },
          ),
          ListTile(
            title: Text('Select Payment method'),
            onTap: () {
              // Implement onTap functionality for selecting address
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: SizedBox.shrink(), // Empty widget to remove the icon
            label: 'Total: ฿${totalPriceTHB.toStringAsFixed(2)}',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Make an Order',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            // No action needed since it's displaying the total price
          } else if (index == 1) {
             Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(),
                    ),
                  );
          }
        },
      ),
    );
  }

  Future<List<DocumentSnapshot>> _fetchSelectedItems() async {
    final selectedItems = await FirebaseFirestore.instance
        .collection('ToyData')
        .where('ID', whereIn: selectedItemsIds)
        .get();
    return selectedItems.docs;
  }
}
