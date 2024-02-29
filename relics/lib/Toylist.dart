import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'ToyDetails.dart'; // Import the ToyDetails screen

class ToyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toy List'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('ToyData').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 3,
                  child: ListTile(
                    leading: Image.network(data['Image']),
                    title: Text(data['Title']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Release Year: ${data['Release Year']}'),
                        Text('Price: ${data['Price']}'),
                      ],
                    ),
                    onTap: () {
                      // Navigate to ToyDetails screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ToyDetails(toyData: data)),
                      );
                    },
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
