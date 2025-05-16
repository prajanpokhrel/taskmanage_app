import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:taskmanagement_app/constant/colors.dart';

class TextForm extends StatefulWidget {
  final Widget? prefixIcon;
  final String hintText;
  final Widget? suffixIcon;
  const TextForm({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    required this.hintText,
  });

  @override
  State<TextForm> createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 2.h, right: 2.h),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,

          filled: true,
          fillColor: const Color.fromARGB(255, 216, 216, 228),
          contentPadding: EdgeInsets.all(20),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppconstColor.PrimaryColor),
            borderRadius: BorderRadius.circular(8),
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(fontSize: 14, color: AppconstColor.Kblack),
        ),
      ),
    );
  }
}
