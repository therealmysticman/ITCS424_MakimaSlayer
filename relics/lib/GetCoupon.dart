import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting
import 'CouponList.dart';
import 'CouponProvider.dart';

class GetCoupon extends StatelessWidget {
    final String redeemCouponId;

  GetCoupon({required this.redeemCouponId});
  
  @override
  Widget build(BuildContext context) {
    final selectedCouponData =
        Provider.of<CouponProvider>(context).selectedCouponData;

    // Extracting coupon IDs from the selectedCouponData map
    List<String> selectedCouponIds = selectedCouponData.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Selected Coupons'),
      ),
      body: selectedCouponData.isNotEmpty
          ? ListView.builder(
              itemCount: selectedCouponIds.length,
              itemBuilder: (context, index) {
                final couponId = selectedCouponIds[index];
                final couponData = selectedCouponData[couponId];
                final title = couponData['Title'] ?? 'Unknown Title';
                final discount =
                    couponData['DiscountCost'] ?? 'Unknown Discount';
                final endDate = (couponData['EndDate'])
                    .toDate(); // Convert Timestamp to DateTime
                final endDateFormatted =
                    DateFormat.yMMMd().format(endDate); // Format the end date
                return ListTile(
                  leading: Image.asset(
                    'assets/pricetag.png', // Assuming this is your asset image
                    width: 100,
                    height: 100,
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Title: $title',
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Discount: $discount',
                        style: TextStyle(fontSize: 10),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'End Date: $endDateFormatted', // Display formatted end date
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      final redeemCouponId = couponId; // Use couponId here
                      final redeemedCouponTitle = title; // Use coupon title here
                      Navigator.pop(context, {'id': redeemCouponId, 'title': redeemedCouponTitle});
                      print('$redeemCouponId,$redeemedCouponTitle');
                    },
                    child: Text('Redeem'),
                  ),
                );
              },
            )
          : Center(
              child: Text('No coupons selected yet'),
            ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CouponList(), // Navigate to CouponList
            ),
          );
        },
        child: Text('Back to Coupon List'),
      ),
    );
  }
}
