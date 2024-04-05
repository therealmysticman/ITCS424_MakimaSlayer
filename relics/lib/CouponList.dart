import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:relics/CouponProvider.dart';

import 'Categories.dart';
import 'Dashboard.dart';
import 'Home.dart';
import 'Toylist.dart';

class CouponList extends StatelessWidget {
  final String usernameEmail;
  CouponList({required this.usernameEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coupons'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('CouponData').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No coupons available'),
            );
          }

          final couponProvider = Provider.of<CouponProvider>(context);

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              var coupon = snapshot.data!.docs[index];
              var discountPercentage = coupon['DiscountCost'].toDouble();
              var formattedDiscount =
                  '${discountPercentage.toStringAsFixed(0)}%';
              var endDate = (coupon['EndDate'] as Timestamp).toDate();
              var formattedEndDate = DateFormat.yMMMd().format(endDate);

              bool isSelected = couponProvider.isSelected(coupon.id);

              return ListTile(
                leading: Container(
                  width: 50,
                  height: 60,
                  child: Image.asset(
                    'assets/pricetag.png',
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(coupon['Title']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Discount: $formattedDiscount'),
                    Text('End Date: $formattedEndDate'),
                  ],
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    final isSelected = couponProvider.isSelected(coupon.id);
                    if (!isSelected) {
                      couponProvider.selectCoupon(
                          coupon.id, coupon.data() as Map<String, dynamic>);
                      // Navigate to GetCoupon page
                    } else {
                      couponProvider.deselectCoupon(coupon.id);
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      isSelected ? Colors.grey : Color.fromARGB(255, 141, 39, 108),
                    ),
                  ),
                  child: Text(isSelected ? 'Selected' : 'Select',
                  style: TextStyle(color: isSelected? const Color.fromARGB(255, 60, 60, 60) : Color.fromARGB(255, 255, 163, 221) ),),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Toy Lists', // New item for Toy Lists
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: 'Coupon',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
        ],
        currentIndex: 3, // Set index of Categories page
        selectedItemColor:
            Color.fromARGB(255, 108, 2, 126), // Selected item color
        unselectedItemColor:
            Color.fromARGB(255, 95, 76, 113), // Unselected item color
        iconSize: 24, // Adjust icon size
        onTap: (index) {
          // Handle navigation
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home(usernameEmail: '',)),
              );
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Categories(usernameEmail: usernameEmail,)),
              );
              break;
            case 2: // For Toy Lists
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ToyList(usernameEmail: usernameEmail,)), // Navigate to ToyList
              );
              break;
            // Add navigation for other items if needed
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CouponList(usernameEmail: usernameEmail,)), // Navigate to ToyList
              );
              break;
            case 4:
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Dashboard(
                            userEmail: usernameEmail,
                          )));
              break;
          }
        },
      ),
    );
  }
}
