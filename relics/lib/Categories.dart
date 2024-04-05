import 'package:flutter/material.dart';
import 'package:relics/ToyPriceCategories.dart';

import 'CartIcon.dart';
import 'CouponList.dart';
import 'Dashboard.dart';
import 'Home.dart';
import 'ToyList.dart'; // Import the ToyList screen
import 'ToyManufacturer.dart';
import 'ToyTypeCategories.dart';
import 'ToyYearCategories.dart';

class Categories extends StatelessWidget {
  final String usernameEmail;
  Categories({required this.usernameEmail});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        actions: [
          CartIcon(userEmail: usernameEmail,), // Include the CartIcon widget here
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/imagebg.jpg"), // Replace "imagebg.jpeg" with your actual image file
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop), // Adjust opacity here (0.5 means 50% opacity)
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20), // Spacer between buttons
              // Toy Types Button
              Container(
                width: 200, // Set the width of the button
                height: 50, // Set the height of the button
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 132, 83, 222), // Set the background color of the button
                  borderRadius: BorderRadius.circular(12), // Set rounded corners
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ToyTypeCategories(userEmail: usernameEmail,)),
                    );
                  },
                  child: Text(
                    'Toy Types',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20), // Spacer between buttons
              // Toy Release Year Button
              Container(
                width: 200, // Set the width of the button
                height: 50, // Set the height of the button
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 132, 83, 222), // Set the background color of the button
                  borderRadius: BorderRadius.circular(12), // Set rounded corners
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ToyYearCategories(userEmail: usernameEmail,)),
                    );
                  },
                  child: Text(
                    'Toy Release Year',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20), // Spacer between buttons
              // Toy Manufacturer Button
              Container(
                width: 200, // Set the width of the button
                height: 50, // Set the height of the button
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 132, 83, 222), // Set the background color of the button
                  borderRadius: BorderRadius.circular(12), // Set rounded corners
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ToyManufacturer(userEmail: usernameEmail,)),
                    );
                  },
                  child: Text(
                    'Toy Manufacturer',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20), // Spacer between buttons
              // Toy List Button
              Container(
                width: 200, // Set the width of the button
                height: 50, // Set the height of the button
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 132, 83, 222), // Set the background color of the button
                  borderRadius: BorderRadius.circular(12), // Set rounded corners
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ToyPriceCategories(userEmail: usernameEmail,)),
                    );
                  },
                  child: Text(
                    'Toys Price',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
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
        currentIndex: 1, // Set index of Categories page
        selectedItemColor: Color.fromARGB(255, 108, 2, 126), // Selected item color
        unselectedItemColor: Color.fromARGB(255, 95, 76, 113), // Unselected item color
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
            case 2: // For Toy Lists
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ToyList(usernameEmail: usernameEmail,)), // Navigate to ToyList
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
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => Dashboard(userEmail: usernameEmail,))
            );
              break;
          }
        },
      ),
    );
  }
}
