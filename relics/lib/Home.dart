import 'package:flutter/material.dart';

import 'ToyManufacturer.dart';
import 'ToyTypeCategories.dart';
import 'ToyYearCategories.dart';
import 'Toylist.dart';
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Relics'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            SizedBox(height: 20), // Spacer between buttons
            // Toy Types Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ToyTypeCategories()),
                );
              },
              child: Text('Toy Types'),
            ),
            SizedBox(height: 20), // Spacer between buttons
            // Toy Release Year Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ToyYearCategories()),
                );
              },
              child: Text('Toy Release Year'),
            ),
            SizedBox(height: 20), // Spacer between buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ToyManufacturer()),
                );
              },
              child: Text('Toy Manufacturer'),
            ),
            SizedBox(height: 20), // Spacer between buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ToyList()),
                );
              },
              child: Text('All Toys'),
            ),
          ],
        ),
      ),
    );
  }
}
