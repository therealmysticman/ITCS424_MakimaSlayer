import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:relics/Home.dart';
import 'Categories.dart';
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
                    MaterialPageRoute(builder: (context) => ToyDetails(toyData: data)),
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
                            alignment: FractionalOffset.topCenter,// Cover the whole area
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
        currentIndex: 2, // Set index of Categories page
        selectedItemColor: Color.fromARGB(255, 108, 2, 126), // Selected item color
        unselectedItemColor: Color.fromARGB(255, 95, 76, 113), // Unselected item color
        iconSize: 24, // Adjust icon size
        onTap: (index) {
          // Handle navigation
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
              break;
              case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Categories()),
              );
              break;
            case 2: // For Toy Lists
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ToyList()), // Navigate to ToyList
              );
              break;
            // Add navigation for other items if needed
          }
        },
      ),
    );
  }
}
