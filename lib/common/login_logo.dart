import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginLogo extends StatelessWidget {
  const LoginLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15.h),
      child: Row(
        children: [
          Image.asset("assets/images/face.png", height: 30, width: 30),
          SizedBox(width: 2.h),
          Image.asset("assets/images/google.png", height: 30, width: 30),
          SizedBox(width: 2.h),
          Image.asset("assets/images/apple.png", height: 30, width: 30),
        ],
      ),
    );
  }
}
