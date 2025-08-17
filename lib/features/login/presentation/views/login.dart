import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:taskmanagement_app/common/button.dart';
import 'package:taskmanagement_app/common/login_logo.dart';
import 'package:taskmanagement_app/common/pasword_form_field.dart';
import 'package:taskmanagement_app/common/text_form.dart';
import 'package:taskmanagement_app/constant/colors.dart';
import 'package:taskmanagement_app/core/firebase_auth/auth_service.dart';
import 'package:taskmanagement_app/features/authpage/presentation/view/auth_page.dart';

import 'package:taskmanagement_app/features/signup/presentation/view/signup_Screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: AppconstColor.PrimaryColor),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  // for status bar
  Widget build(BuildContext context) {
    print('🔁 LoginScreen built');
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: AppconstColor.PrimaryColor),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Center(
                child: Text(
                  "Login here".tr(),
                  style: TextStyle(
                    color: AppconstColor.PrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                "Welcome back you have".tr(),

                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                "been missed !".tr(),

                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 4.h),
              TextForm(
                controller: emailController,
                hintText: 'Email'.tr(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required".tr();
                  }
                  return null;
                },
              ),
              SizedBox(height: 4.h),
              PasswordField(
                controller: passwordController,
                hintText: 'Password'.tr(),

                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return "Password is required  ".tr();
                //   }
                //   return null;
                // },
              ),
              SizedBox(height: 2.h),
              Container(
                margin: EdgeInsets.only(left: 24.h),
                child: Text(
                  "Forgot your Password?".tr(),
                  style: TextStyle(
                    color: AppconstColor.PrimaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              GestureDetector(
                onTap: () async {
                  var isValidate = _formKey.currentState!.validate();

                  final authService = Provider.of<AuthService>(
                    context,
                    listen: false,
                  );

                  final email = emailController.text.trim();
                  final password = passwordController.text.trim();
                  try {
                    final userCredential = await authService
                        .loginwithEmailandPassword(
                          email: email,
                          password: password,
                        );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.green,
                        content: Text("You are logged in"),
                      ),
                    );

                    if (userCredential != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const AuthGate()),
                      );
                    }
                  } catch (e) {
                    print("error");
                  }
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
                    text: 'Don\'t have an account?'.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: 'Sign Up'.tr(),
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "Or Continue with".tr(),
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
      ),
    );
  }
}
