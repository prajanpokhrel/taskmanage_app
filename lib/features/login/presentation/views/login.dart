import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:taskmanagement_app/common/pasword_form_field.dart';
import 'package:taskmanagement_app/common/text_form.dart';
import 'package:taskmanagement_app/constant/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20.h),
          Center(
            child: Text(
              "Login here",
              style: TextStyle(
                color: AppconstColor.PrimaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            "Welcome comeback you have",

            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            "been missed!",

            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 4.h),
          TextForm(hintText: 'Email'),
          SizedBox(height: 4.h),
          PasswordField(hintText: 'Password'),
        ],
      ),
    );
  }
}
