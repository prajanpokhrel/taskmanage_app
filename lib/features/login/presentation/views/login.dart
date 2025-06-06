import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:taskmanagement_app/common/button.dart';
import 'package:taskmanagement_app/common/login_logo.dart';
import 'package:taskmanagement_app/common/pasword_form_field.dart';
import 'package:taskmanagement_app/common/text_form.dart';
import 'package:taskmanagement_app/constant/colors.dart';
import 'package:taskmanagement_app/features/homepage/presentation/views/homepage.dart';
import 'package:taskmanagement_app/features/signup/presentation/view/signup_Screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              "Welcome back you have",

              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Text(
              "been missed !",

              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 4.h),
            TextForm(hintText: 'Email'.tr()),
            SizedBox(height: 4.h),
            PasswordField(hintText: 'Password'.tr()),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Homepage()),
                );
              },
              child: CommonButton(buttonName: "Login".tr()),
            ),
            SizedBox(height: 3.h),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen()),
                );
              },
              child: RichText(
                text: TextSpan(
                  text: 'Don\'t have an account? ',
                  style: Theme.of(context).textTheme.titleMedium,
                  children: [
                    TextSpan(
                      text: 'Sign Up'.tr(),
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
