import 'package:flutter/material.dart';

import 'Categories.dart';
import 'Home.dart';
import 'Toylist.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Implement functionality to edit profile
            },
          ),
          IconButton(
            icon: Icon(Icons.visibility),
            onPressed: () {
              // Implement functionality to view point
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                CircleAvatar(
                  // Display user profile image
                  radius: 30,
                  backgroundImage: NetworkImage('https://example.com/user_profile_image.jpg'),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Username',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'user@example.com',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NavBarItem(icon: Icons.payment, label: 'Wait for Payment'),
                NavBarItem(icon: Icons.delivery_dining, label: 'Delivery'),
                NavBarItem(icon: Icons.check_circle, label: 'Success'),
                NavBarItem(icon: Icons.rate_review, label: 'Review'),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Implement settings functionality
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About Us'),
            onTap: () {
              // Implement about us functionality
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              // Implement logout functionality
            },
          ),
        ],
        
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
                MaterialPageRoute(builder: (context) => Home()),
              );
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Categories()),
              );
              break;
            case 2: // For Toy Lists
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ToyList()), // Navigate to ToyList
              );
              break;
            // Add navigation for other items if needed
            case 3:
              break;
            case 4:
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => Dashboard())
            );
              break;
          }
        },
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;

  NavBarItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 30),
        SizedBox(height: 5),
        Text(label),
      ],
    );
  }
}
