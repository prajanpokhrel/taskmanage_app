import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:taskmanagement_app/constant/colors.dart';

class CommonButton extends StatelessWidget {
  final String buttonName;
  const CommonButton({super.key, required this.buttonName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44.h,
      height: 14.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppconstColor.PrimaryColor,
      ),

      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Text(
            buttonName,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppconstColor.Kwhite,
            ),
          ),
        ),
      ),
    );
  }
}
