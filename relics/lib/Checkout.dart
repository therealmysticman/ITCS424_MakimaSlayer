import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:relics/CouponProvider.dart';
import 'package:relics/Home.dart';
import 'package:relics/GetCoupon.dart';

class CheckoutPage extends StatelessWidget {
  final List<String> selectedItemsIds;
  final double totalPriceTHB;
  final Map<String, dynamic> selectedCouponData;

  CheckoutPage({
    required this.selectedItemsIds,
    required this.totalPriceTHB,
    required this.selectedCouponData,
  });

  @override
  Widget build(BuildContext context) {
     String selectedCouponTitle = 'Select Coupon'; 
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Consumer<CouponProvider>(
        builder: (context, couponProvider, _) {
          final selectedCouponData = couponProvider.selectedCouponData;

          print('Selected Coupon Data in CheckoutPage: $selectedCouponData');
          return ListView(
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
                      final price =
                          item['Price'].replaceAll(RegExp(r'[\n\r]'), '');
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
                  // Implement onTap functionality for selecting address
                },
              ),
ListTile(
  title: Text(selectedCouponTitle), // Use the selectedCouponTitle variable
  onTap: () async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GetCoupon(redeemCouponId: ''), // Pass an initial value for redeemCouponId
      ),
    );
    if (result != null) {
      final redeemCouponId = result['id'];
      final redeemedCouponTitle = result['title'];
      couponProvider.redeemCoupon(redeemCouponId); // Redeem the selected coupon
      selectedCouponTitle = redeemedCouponTitle; // Update the selectedCouponTitle
      // Use the context to rebuild the UI
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Coupon redeemed: $redeemedCouponTitle'),
      ));
    }
  },
),
              ListTile(
                title: Text('Select Payment method'),
                onTap: () {
                  // Implement onTap functionality for selecting payment method
                },
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: SizedBox.shrink(),
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
