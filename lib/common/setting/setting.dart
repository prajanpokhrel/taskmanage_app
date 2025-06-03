import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:switcher_button/switcher_button.dart';
import 'package:taskmanagement_app/constant/colors.dart';

class SettingDetails extends StatelessWidget {
  final Color? switchColor;
  const SettingDetails({super.key, this.switchColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppconstColor.Kwhite,
        borderRadius: BorderRadius.circular(12),
      ),
      height: 25.h,
      width: 41.h,
      child: Column(
        children: [
          //darkmode
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.dark_mode),
                SizedBox(width: 2.h),
                Text(
                  "Dark mode",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Spacer(),
                Text("Off", style: TextStyle(fontWeight: FontWeight.w400)),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SwitcherButton(
                    onColor: Colors.black,
                    offColor: AppconstColor.PrimaryColor,
                    size: 40,
                    value: true,
                    onChange: (value) {
                      "";
                    },
                  ),
                ),
                Text("On", style: TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          // notification
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.notifications),
                SizedBox(width: 2.h),
                Text(
                  "Notification",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Spacer(),
                Text("Off", style: TextStyle(fontWeight: FontWeight.w400)),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SwitcherButton(
                    onColor: Colors.grey,
                    offColor: AppconstColor.PrimaryColor,
                    size: 40,
                    value: true,
                    onChange: (value) {
                      "";
                    },
                  ),
                ),
                Text("On", style: TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          //Language
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.language_rounded),
                SizedBox(width: 2.h),
                Text(
                  "Select Language",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Spacer(),
                Text("EN", style: TextStyle(fontWeight: FontWeight.w400)),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SwitcherButton(
                    onColor: Colors.grey,
                    offColor: AppconstColor.PrimaryColor,
                    size: 40,
                    value: true,
                    onChange: (value) {
                      "";
                    },
                  ),
                ),
                Text("NP", style: TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
