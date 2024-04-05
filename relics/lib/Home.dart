import 'package:flutter/material.dart';
import 'package:relics/CartIcon.dart';
import 'package:relics/CouponList.dart';
import 'package:relics/Dashboard.dart';

import 'Categories.dart';
import 'Search.dart'; // Import the Search screen
import 'Toylist.dart';

class Home extends StatelessWidget {
  final String usernameEmail;
  Home({required this.usernameEmail});

  @override
  Widget build(BuildContext context) {
    // Define your cartItems list
    return Scaffold(
      appBar: AppBar(
        title: Text('Relic+'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Search(usernameEmail: usernameEmail,), // Navigate to Search screen
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.grey, // Border color
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Search',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Search(usernameEmail: usernameEmail,), // Navigate to Search screen
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        actions: [
          CartIcon(userEmail: usernameEmail,), // Include the CartIcon widget here
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/imagebg.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3),
                BlendMode
                    .dstATop), // Adjust opacity here (0.5 means 50% opacity)
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [ Image.asset(
              'assets/relicslogo.png', // Replace with your image path
              height: 150, // Adjust height as needed
              fit: BoxFit.contain, // Adjust the fit as needed
            ),
              Text(
                'Welcome to Relic+!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Explore various toy range from old to latest.',
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
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
        currentIndex: 0, // Set index of Categories page
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
                MaterialPageRoute(builder: (context) => Home(usernameEmail: usernameEmail,)),
              );
              break;
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
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Dashboard(userEmail: usernameEmail)),
              );

              break;
          }
        },
      ),
    );
  }
}
