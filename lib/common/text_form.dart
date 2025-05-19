import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:taskmanagement_app/constant/colors.dart';

class TextForm extends StatefulWidget {
  final Widget? prefixIcon;
  final String hintText;

  const TextForm({super.key, this.prefixIcon, required this.hintText});

  @override
  State<TextForm> createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 2.h, right: 2.h),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          prefixIcon: widget.prefixIcon,

          filled: true,
          fillColor: const Color.fromARGB(255, 216, 216, 228),

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
