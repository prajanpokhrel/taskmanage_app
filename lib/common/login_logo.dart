import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:taskmanagement_app/core/firebase_auth/auth_service.dart';

class LoginLogo extends StatefulWidget {
  const LoginLogo({super.key});

  @override
  State<LoginLogo> createState() => _LoginLogoState();
}

class _LoginLogoState extends State<LoginLogo> {
  final auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15.h),
      child: Row(
        children: [
          GestureDetector(
            child: Image.asset("assets/images/face.png", height: 30, width: 30),
          ),
          SizedBox(width: 2.h),
          GestureDetector(
            onTap: () async {
              try {
                await auth.signInWithGoogle();
                // Navigate to home screen
              } catch (e) {
                print("Google Sign-In Error: $e");
              }
            },
            child: Image.asset(
              "assets/images/google.png",
              height: 30,
              width: 30,
            ),
          ),
          SizedBox(width: 2.h),
          Image.asset("assets/images/apple.png", height: 30, width: 30),
        ],
      ),
    );
  }
}
