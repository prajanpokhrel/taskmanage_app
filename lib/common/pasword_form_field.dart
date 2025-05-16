import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:taskmanagement_app/constant/colors.dart';

class PasswordField extends StatefulWidget {
  final Widget? prefixIcon;
  final String hintText;

  const PasswordField({super.key, this.prefixIcon, required this.hintText});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  @override
  Widget build(BuildContext context) {
    bool _obscureText = true;
    return Padding(
      padding: EdgeInsets.only(left: 2.h, right: 2.h),
      child: TextFormField(
        obscureText: _obscureText,
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          suffixIcon: IconButton(
            color: AppconstColor.Kgrey,
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            icon: Icon(
              _obscureText
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
            ),
          ),

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
    ;
  }
}
