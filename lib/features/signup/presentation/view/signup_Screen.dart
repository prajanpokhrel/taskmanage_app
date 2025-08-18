import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:taskmanagement_app/features/login/presentation/views/login.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //for status bar
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: AppconstColor.PrimaryColor),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Center(
                child: Text(
                  "Create An Account".tr(),
                  style: TextStyle(
                    color: AppconstColor.PrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                "Create an account so you can".tr(),

                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                "manage your tasks.".tr(),

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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password is required";
                  } else if (value.length < 6) {
                    return "password should have  at least 6 characters";
                  }
                  return null;
                },
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
                  if (!formKey.currentState!.validate()) {
                    return; // Stop if validation fails
                  }
                  final email = emailController.text.trim();
                  final password = passwordController.text.trim();
                  final authService = Provider.of<AuthService>(
                    context,
                    listen: false,
                  );
                  try {
                    final userCredential = await authService
                        .createUserwithEmailandPassword(
                          email: email,
                          password: password,
                        );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.green,
                        content: Text("Account Created Successfully 😊"),
                      ),
                    );
                    if (userCredential != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    }
                  } on FirebaseAuthException catch (e) {
                    String errorMessage;

                    switch (e.code) {
                      case 'invalid-email':
                        errorMessage = "invalid-email".tr();
                        break;
                      case 'email-already-in-use':
                        errorMessage = "This email-already-in-use".tr();
                        break;
                      case 'weak-password':
                        errorMessage =
                            "Password is weak or less than 6 character".tr();
                        break;

                      case 'too-many-requests':
                        errorMessage =
                            "Too many failed attempts. Try again later".tr();
                        break;
                      case 'network-request-failed':
                        errorMessage =
                            "Network error. Check your connection".tr();
                        break;
                      default:
                        errorMessage = "Sigin failed. Please try again".tr();
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.red,
                        content: Text(errorMessage),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.red,
                        content: Text("An unexpected error occurred".tr()),
                      ),
                    );
                  }
                },
                child: CommonButton(buttonName: "Sign Up".tr()),
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
                    text: "Already have an account?".tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: 'Login'.tr(),
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
