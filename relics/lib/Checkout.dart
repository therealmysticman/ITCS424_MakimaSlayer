import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:relics/CouponProvider.dart';
import 'package:relics/GetCoupon.dart';
import 'package:relics/OrderProcess.dart';

import 'AddressSelect.dart';
import 'CardList.dart';

class CheckoutPage extends StatefulWidget {
  final List<String> selectedItemsIds;
  final double totalPriceTHB;
  final Map<String, dynamic> selectedCouponData;
  final String usernameEmail;

  CheckoutPage({
    required this.selectedItemsIds,
    required this.totalPriceTHB,
    required this.selectedCouponData,
    required this.usernameEmail,
  });

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String totalLabel = ''; // Declare totalLabel as a class variable
  String selectedCardImage =
      'assets/default_image.jpg'; // Provide the default image path here
  @override
  void initState() {
    super.initState();
    totalLabel =
        'Total: ฿${widget.totalPriceTHB.toStringAsFixed(2)}'; // Initialize in initState
  }

  String selectedAddressTitle = '';
  String selectedPaymentMethod = ''; // Add this line
  double discountedPrice = 0.0;
  void _updateSelectedAddress(String addressTitle) {
    setState(() {
      selectedAddressTitle = addressTitle;
    });
  }

  void calculateDiscountedTotalPrice(double discountPercentage) {
    final double totalPriceTHB = widget.totalPriceTHB;
    final double discountAmount = (totalPriceTHB * discountPercentage) / 100;
    discountedPrice = totalPriceTHB - discountAmount;
    setState(() {
      totalLabel = 'Total: ฿${discountedPrice.toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
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
                title: Text(
                  selectedAddressTitle.isEmpty
                      ? 'Select Address'
                      : '$selectedAddressTitle',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ), // Display selected address if available
                onTap: () async {
                  final selectedAddress = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddressSelectionPage(
                        onAddressSelected: _updateSelectedAddress,
                      ),
                    ),
                  );
                  if (selectedAddress != null) {
                    // Handle the selected address if needed
                  }
                },
              ),
              ListTile(
                title: Consumer<CouponProvider>(
                  builder: (context, couponProvider, _) {
                    return Text(couponProvider.selectedCouponTitle);
                  },
                ),
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GetCoupon(
                          redeemCouponId:
                              '', usernameEmail: '',), // Pass an initial value for redeemCouponId
                    ),
                  );
                  if (result != null) {
                    final redeemCouponId = result['id'];
                    final redeemedCouponTitle = result['title'];
                    final discountPercentage = result['discountPercentage']
                        .toDouble(); // Convert to double
                    couponProvider.redeemCoupon(
                        redeemCouponId); // Redeem the selected coupon
                    couponProvider.updateSelectedCouponTitle(
                        redeemedCouponTitle); // Update the selectedCouponTitle using CouponProvider
                    // Calculate the discounted price based on the redeemed coupon's discount percentage
                    calculateDiscountedTotalPrice(discountPercentage);
                    // Use the context to rebuild the UI
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Coupon redeemed: $redeemedCouponTitle'),
                    ));
                  }
                },
              ),
              ListTile(
                leading: SizedBox(
                  width: 40, // Adjust width as needed
                  height: 40, // Adjust height as needed
                  child: Image.asset(
                    selectedCardImage, // Provide default image path
                  ),
                ),
                title: Text(
                  selectedPaymentMethod.isEmpty
                      ? 'Select Payment method'
                      : selectedPaymentMethod,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () async {
                  // Navigate to the CardList screen and wait for result
                  final selectedCard = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CardList(),
                    ),
                  );

                  // If selectedCard is not null, update the selected payment method
                  if (selectedCard != null) {
                    final selectedCardNum = selectedCard['CardNum'] as String?;
                    
                    final newSelectedCardImage =
                        selectedCard['CardImage'] as String?;

                    setState(() {
                      selectedCardImage = newSelectedCardImage ??
                          selectedCardImage; // Update with new value if available
                      selectedPaymentMethod = selectedCardNum != null
                          ? ' $selectedCardNum' // Concatenate with a space
                          : 'Select Payment method';
                    });
                  }
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
            label: totalLabel,
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
                builder: (context) => OrderProcessedPage(userEmail: widget.usernameEmail),
              ),
            );
          }
        },
      ),
    );
  }

  Future<List<DocumentSnapshot>> _fetchSelectedItems() async {
    final List<String> selectedItemsIds = widget.selectedItemsIds;
    final selectedItems = await FirebaseFirestore.instance
        .collection('ToyData')
        .where('ID', whereIn: selectedItemsIds)
        .get();
    return selectedItems.docs;
  }
}
