import 'package:flutter/material.dart';
import 'package:taskmanagement_app/constant/colors.dart';

class Textformfields extends StatelessWidget {
  final String hinttext;
  final int? maxLine;
  final TextEditingController? controller;
  const Textformfields({
    super.key,
    required this.hinttext,
    this.maxLine,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(27),

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300, width: 3),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            // color: Pallete.gradient2,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(10),
        ),

        hintText: hinttext,
        hintStyle: TextStyle(fontSize: 16, color: AppconstColor.Kblack),
      ),
      maxLines: maxLine,
    );
  }
}
