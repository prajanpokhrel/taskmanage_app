import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:taskmanagement_app/core/firebase_auth/auth_service.dart';
import 'package:taskmanagement_app/features/homepage/presentation/views/homepage.dart';

class LoginLogo extends StatefulWidget {
  const LoginLogo({super.key});

  @override
  State<LoginLogo> createState() => _LoginLogoState();
}

class _LoginLogoState extends State<LoginLogo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15.h),
      child: Row(
        children: [
          GestureDetector(
            child: Image.asset("assets/images/face.png", height: 30, width: 30),
          ),
          SizedBox(width: 6.h),
          GestureDetector(
            onTap: () async {
              final authService = Provider.of<AuthService>(
                context,
                listen: false,
              );
              try {
                await authService.signInWithGoogle();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Homepage()),
                );
              } catch (e) {
                print("Google Sign-In Error: $e");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Sign in failed: ${e.toString()}')),
                );
              }
            },
            child: Image.asset(
              "assets/images/google.png",
              height: 30,
              width: 30,
            ),
          ),
        ],
      ),
    );
  }
}
