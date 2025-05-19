import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:taskmanagement_app/common/button.dart';
import 'package:taskmanagement_app/common/login_logo.dart';
import 'package:taskmanagement_app/common/pasword_form_field.dart';
import 'package:taskmanagement_app/common/text_form.dart';
import 'package:taskmanagement_app/constant/colors.dart';
import 'package:taskmanagement_app/features/login/presentation/views/login.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    //for status bar
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: AppconstColor.PrimaryColor),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Center(
              child: Text(
                "Create An Account",
                style: TextStyle(
                  color: AppconstColor.PrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              "Create an account so you can ",

              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Text(
              "manage your tasks.",

              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 4.h),
            TextForm(hintText: 'Email'),
            SizedBox(height: 4.h),
            PasswordField(hintText: 'Password'),
            SizedBox(height: 2.h),
            Container(
              margin: EdgeInsets.only(left: 24.h),
              child: Text(
                "Forgot your Password ?",
                style: TextStyle(
                  color: AppconstColor.PrimaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 4.h),
            GestureDetector(
              onTap: () {
                print("pressed");
              },
              child: CommonButton(buttonName: "Sign Up"),
            ),
            SizedBox(height: 3.h),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: RichText(
                text: TextSpan(
                  text: 'Already  have an account? ',
                  style: Theme.of(context).textTheme.titleMedium,
                  children: [
                    TextSpan(
                      text: 'Login',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Or Continue with ",
              style: TextStyle(
                color: AppconstColor.PrimaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4.h),
            LoginLogo(),
          ],
        ),
      ),
    );
  }
}
