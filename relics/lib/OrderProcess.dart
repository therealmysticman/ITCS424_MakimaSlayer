import 'package:flutter/material.dart';

import 'Home.dart';

class OrderProcessedPage extends StatelessWidget {
  final String userEmail;
  OrderProcessedPage({required this.userEmail});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: 100,
              color: Color.fromARGB(255, 144, 6, 203),
            ),
            SizedBox(height: 20),
            Text(
              "Your order has been processed",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate back to homepage
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home(usernameEmail: userEmail,)),
              );
              },
              child: Text("Back to Homepage"),
            ),
          ],
        ),
      ),
    );
  }
}