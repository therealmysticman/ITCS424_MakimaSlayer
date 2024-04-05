import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'ToyDetails.dart';

class ToyYearCategories extends StatelessWidget {
  final String userEmail;

  ToyYearCategories({required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toy Year Categories'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('1970-1999'),
            onTap: () {
              _showToysByYearRange(context, 1970, 1999);
            },
          ),
          ListTile(
            title: Text('2000-2010'),
            onTap: () {
              _showToysByYearRange(context, 2000, 2010);
            },
          ),
          ListTile(
            title: Text('2011-2018'),
            onTap: () {
              _showToysByYearRange(context, 2011, 2018);
            },
          ),
          ListTile(
            title: Text('2019-present'),
            onTap: () {
              _showToysByYearRange(context, 2019, DateTime.now().year);
            },
          ),
        ],
      ),
    );
  }

  void _showToysByYearRange(BuildContext context, int startYear, int endYear) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ToysByYearRangeScreen(startYear: startYear, endYear: endYear, userEmail: userEmail),
      ),
    );
  }
}

class ToysByYearRangeScreen extends StatelessWidget {
  final int startYear;
  final int endYear;
  final String userEmail;

  const ToysByYearRangeScreen({required this.startYear, required this.endYear, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toys from $startYear to $endYear'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('ToyData')
            .where('Release Year', isGreaterThanOrEqualTo: startYear)
            .where('Release Year', isLessThanOrEqualTo: endYear)
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
                      builder: (context) => ToyDetails(toyData: data, selectedItemsIds: [], selectedCouponData: {}, userEmail: userEmail),
                    ),
                  );
                },
                child: Card(
                  elevation: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromARGB(255, 253, 248, 253), // Start color
                          Color.fromARGB(255, 227, 216, 239), // End color
                        ],
                      ),
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ), // Same border radius as above
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Image.network(
                            data['Image'],
                            fit: BoxFit.cover,
                            alignment: FractionalOffset.topCenter, // Cover the whole area
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
                ),
              );
            },
          );
        },
      ),
    );
  }
}
