import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:switcher_button/switcher_button.dart';
import 'package:taskmanagement_app/constant/colors.dart';
import 'package:taskmanagement_app/core/firebase_auth/auth_service.dart';
import 'package:taskmanagement_app/features/login/presentation/views/login.dart';

class SupportSetting extends StatefulWidget {
  const SupportSetting({super.key});

  @override
  State<SupportSetting> createState() => _SupportSettingState();
}

class _SupportSettingState extends State<SupportSetting> {
  final authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            Theme.of(context).brightness == Brightness.light
                ? AppconstColor.Kwhite
                : Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      height: 12.h,
      width: 41.h,
      child: Column(
        children: [
          //darkmode
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Icon(Icons.help),
                SizedBox(width: 2.h),
                Text(
                  "Help".tr(),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                authService.signOut(context);
              },
              child: Row(
                children: [
                  Icon(Icons.logout_rounded),
                  SizedBox(width: 2.h),
                  Text(
                    "Logout".tr(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
