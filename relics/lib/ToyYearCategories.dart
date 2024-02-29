import 'package:flutter/material.dart';

class ToyYearCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: Text('1970-1999'),
            onTap: () {
              // Handle tap event
            },
          ),
          ListTile(
            title: Text('2000-2010'),
            onTap: () {
              // Handle tap event
            },
          ),
          ListTile(
            title: Text('2010-2018'),
            onTap: () {
              // Handle tap event
            },
          ),
          ListTile(
            title: Text('2019-present'),
            onTap: () {
              // Handle tap event
            },
          ),
        ],
      ),
    );
  }
}
