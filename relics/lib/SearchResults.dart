import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'ToyDetails.dart';

class SearchResults extends StatelessWidget {
  final String searchQuery;
  final String userEmail;
  SearchResults({required this.searchQuery, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('ToyData').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        // Filter the documents in memory
        final List<DocumentSnapshot> filteredDocs =
            snapshot.data!.docs.where((doc) {
          final data = doc.data() as Map<String, dynamic>;
          // Convert both search query and title to lowercase for case-insensitive comparison
          final title = data['Title'].toString().toLowerCase();
          final query = searchQuery.toLowerCase();
          // Check for partial matches in title
          return title.contains(query);
        }).toList();

        return GridView.builder(
           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Two items per row
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
           ),
          itemCount: filteredDocs.length,
          itemBuilder: (BuildContext context, int index) {
            Map<String, dynamic> data =
                filteredDocs[index].data() as Map<String, dynamic>;
            return GestureDetector(
              onTap: () {
                // Navigate to ToyDetails screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ToyDetails(toyData: data, selectedItemsIds: [], selectedCouponData: {}, userEmail: userEmail,),
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
                            10.0), // Same border radius as above
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Image.network(
                              data['Image'],
                              fit: BoxFit.cover,
                              alignment: FractionalOffset
                                  .topCenter, // Cover the whole area
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
                  )
            );
          },
        );
      },
    );
  }
}
