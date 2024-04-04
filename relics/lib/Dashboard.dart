import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Categories.dart';
import 'CouponList.dart';
import 'Home.dart';
import 'SignIn.dart';
import 'Toylist.dart';

class Dashboard extends StatefulWidget {
  final String userEmail;

  Dashboard({required this.userEmail});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String username = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      print('Fetching user data for email: ${widget.userEmail}');
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('UserData')
          .where('Email', isEqualTo: widget.userEmail)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userData = querySnapshot.docs.first.data();

        setState(() {
          username = (userData as Map<String, dynamic>)['Username'];
          email = (userData as Map<String, dynamic>)['Email'];
        });

        print('User data fetched successfully: $userData');
      } else {
        print('No user data found for email: ${widget.userEmail}');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

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
                    child: Image.asset('assets/profile.png')),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$username',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$email', // Display username and email here
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SignInPage()), // Assuming SignInPage is your login page
              );
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
        currentIndex: 4, // Set index of Categories page
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
                MaterialPageRoute(
                    builder: (context) => Home(
                          usernameEmail: email,
                        )),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Categories(
                          usernameEmail: email,
                        )),
              );
              break;
            case 2: // For Toy Lists
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ToyList(
                          usernameEmail: email,
                        )), // Navigate to ToyList
              );
              break;
            // Add navigation for other items if needed
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CouponList(
                          usernameEmail: email,
                        )), // Navigate to ToyList
              );
              break;
            case 4:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Dashboard(userEmail: email)),
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
