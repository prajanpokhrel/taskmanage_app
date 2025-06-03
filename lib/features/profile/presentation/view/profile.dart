import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:switcher_button/switcher_button.dart';
import 'package:taskmanagement_app/common/setting/setting.dart';
import 'package:taskmanagement_app/common/setting/support.dart';
import 'package:taskmanagement_app/constant/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 235, 235),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 238, 235, 235),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Padding(
          padding: EdgeInsets.only(left: 8.h),
          child: Text("Profile", style: TextStyle(fontWeight: FontWeight.w500)),
        ),
      ),
      body: Column(
        children: [
          Container(
            child: Center(
              child: Column(
                children: [
                  CircleAvatar(
                    maxRadius: 50,
                    backgroundImage: AssetImage("assets/images/google.png"),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    "Prajan Pokhrel",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.only(left: 3.h),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Settings",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ),
          ),
          SizedBox(height: 1.h),

          SettingDetails(),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.only(left: 3.h),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Supports",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ),
          ),
          SizedBox(height: 1.h),

          SupportSetting(),
        ],
      ),
    );
  }
}
