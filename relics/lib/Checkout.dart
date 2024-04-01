import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  final List<String> selectedItemsIds;

  CheckoutPage({required this.selectedItemsIds});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: FutureBuilder<List<DocumentSnapshot>>(
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
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var item = snapshot.data![index];
              return ListTile(
                title: Text(item['Title']),
                subtitle: Text(item['Manufacturer']),
                trailing: Text(item['Price']),
              );
            },
          );
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
