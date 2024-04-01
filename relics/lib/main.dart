import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:relics/Home.dart'; // Import the Home widget
import 'package:relics/Provider.dart'; // Import the CartProvider

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toy App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(), // Set Home as the initial page
    );
  }
}
