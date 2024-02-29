import 'package:flutter/material.dart';

class ToyManufacturer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: Text('Bandai'),
            onTap: () {
              // Handle tap event
            },
          ),
          ListTile(
            title: Text('Banpresto'),
            onTap: () {
              // Handle tap event
            },
          ),
          ListTile(
            title: Text('Tamashii Nations'),
            onTap: () {
              // Handle tap event
            },
          ),
          ListTile(
            title: Text('Hasbro'),
            onTap: () {
              // Handle tap event
            },
          ),
          ListTile(
            title: Text('Sideshows collectibles'),
            onTap: () {
              // Handle tap event
            },
          ),
        ],
      ),
    );
  }
}
