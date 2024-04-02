import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ToyDetails.dart';

class ToyTypeCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toy Type Categories'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Plastic Kits'),
            onTap: () {
              _showToysByType(context, 'Plastic Kits');
            },
          ),
          ListTile(
            title: Text('Soft Vinyl'),
            onTap: () {
              _showToysByType(context, 'Soft Vinyl');
            },
          ),
          ListTile(
            title: Text('Action Figure'),
            onTap: () {
              _showToysByType(context, 'Action Figure');
            },
          ),
          ListTile(
            title: Text('Statue'),
            onTap: () {
              _showToysByType(context, 'Statue');
            },
          ),
          ListTile(
            title: Text('Others'),
            onTap: () {
              _showToysByType(context, 'Others');
            },
          ),
        ],
      ),
    );
  }

  void _showToysByType(BuildContext context, String type) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ToysByTypeScreen(type: type),
      ),
    );
  }
}

class ToysByTypeScreen extends StatelessWidget {
  final String type;

  const ToysByTypeScreen({required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toys by $type'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('ToyData')
            .where('Type', isEqualTo: type)
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
