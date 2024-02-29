import 'package:flutter/material.dart';

class ToyTypeCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: Text('Plastic Kits'),
            onTap: () {
              // Handle tap event
            },
          ),
          ListTile(
            title: Text('Soft Vinyl'),
            onTap: () {
              // Handle tap event
            },
          ),
          ListTile(
            title: Text('Action Figure'),
            onTap: () {
              // Handle tap event
            },
          ),
          ListTile(
            title: Text('Statue'),
            onTap: () {
              // Handle tap event
            },
          ),
          ListTile(
            title: Text('Others'),
            onTap: () {
              // Handle tap event
            },
          ),
        ],
      ),
    );
  }
}
