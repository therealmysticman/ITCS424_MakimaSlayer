import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:relics/CouponProvider.dart';
import 'package:relics/CartProvider.dart';
import 'package:relics/SignIn.dart'; // Import the CartProvider

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => CouponProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Relics+',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignInPage(), // Set Home as the initial page
    );
  }
}
