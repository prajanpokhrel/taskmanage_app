import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20),
          Text("Login here"),
          Text("Welcome comeback you have\n been missed!"),
        ],
      ),
    );
  }
}
