import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Home.dart';
import 'SignUp.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _usernameEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signIn() async {
    final String usernameEmail = _usernameEmailController.text.trim();
    final String password = _passwordController.text.trim();

    try {
      final QuerySnapshot emailQuerySnapshot = await FirebaseFirestore.instance
          .collection('UserData')
          .where('Email', isEqualTo: usernameEmail)
          .where('Password', isEqualTo: password)
          .get();

      final QuerySnapshot usernameQuerySnapshot = await FirebaseFirestore.instance
          .collection('UserData')
          .where('Username', isEqualTo: usernameEmail)
          .where('Password', isEqualTo: password)
          .get();

      if (emailQuerySnapshot.docs.isNotEmpty) {
        // Email found, navigate to dashboard with email
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home(usernameEmail: usernameEmail)),
        );
        print('Sign in successful');
      } else if (usernameQuerySnapshot.docs.isNotEmpty) {
        // Username found, navigate to dashboard with username
        final userData = usernameQuerySnapshot.docs.first.data();
        final String userEmail = (userData as Map<String, dynamic>)['Email'];
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home(usernameEmail: userEmail)),
        );
        print('Sign in successful');
      } else {
        // No matching user found, display error message
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Invalid username/email or password. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print('Error signing in: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/relicslogo.png', // Replace with your image path
                height: 150, // Adjust height as needed
                fit: BoxFit.contain, // Adjust the fit as needed
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _usernameEmailController,
                decoration: InputDecoration(
                  labelText: 'Username/Email',
                  prefixIcon: Icon(Icons.person), // Add icon here
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock), // Add icon here
                ),
                obscureText: true,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _signIn,
                child: Text('Sign In'),
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? "),
                  TextButton(
                    onPressed: () {
                      // Navigate to sign up page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    child: Text('Sign Up here!'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
