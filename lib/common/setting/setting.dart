import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:switcher_button/switcher_button.dart';
import 'package:taskmanagement_app/constant/colors.dart';
import 'package:taskmanagement_app/core/provider/darkmode_provider/dark_mode_provider.dart';
import 'package:taskmanagement_app/core/provider/notification/notification_provider.dart';
import 'package:taskmanagement_app/notifications/notification.dart';

class SettingDetails extends StatefulWidget {
  final Color? switchColor;
  const SettingDetails({super.key, this.switchColor});

  @override
  State<SettingDetails> createState() => _SettingDetailsState();
}

class _SettingDetailsState extends State<SettingDetails> {
  bool isNotificationOn = false;
  @override
  Widget build(BuildContext context) {
    final isNepali = context.locale.languageCode == 'ne';
    return Container(
      decoration: BoxDecoration(
        color:
            Theme.of(context).brightness == Brightness.light
                ? AppconstColor.Kwhite
                : Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      height: 25.h,
      width: 41.h,
      child: Column(
        children: [
          //darkmode
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<ThemeProvider>(
              builder: (BuildContext context, themeProvider, Widget? child) {
                return Row(
                  children: [
                    Icon(Icons.dark_mode),
                    SizedBox(width: 2.h),
                    Text(
                      "Dark mode".tr(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Off".tr(),
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SwitcherButton(
                        onColor: AppconstColor.Kgrey,
                        offColor: AppconstColor.PrimaryColor,
                        size: 40,
                        value: themeProvider.thememode == ThemeMode.dark,
                        onChange: (value) {
                          themeProvider.toggleTheme(value);
                        },
                      ),
                    ),
                    Text(
                      "On".tr(),
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                );
              },
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
                  "Notification".tr(),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Spacer(),
                Text("Off".tr(), style: TextStyle(fontWeight: FontWeight.w400)),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SwitcherButton(
                    onColor: AppconstColor.Kgrey,
                    offColor: AppconstColor.PrimaryColor,
                    size: 40,
                    value: isNotificationOn,
                    onChange: (value) {
                      setState(() {
                        isNotificationOn = value;
                      });
                      // instant notification code
                      if (value) {
                        // Send instant notification only when switched ON
                        // NotifiServices().showNotification(
                        //   title: "Log out",
                        //   body: "You are logged out",
                        // );

                        // schedule notification code
                        NotifiServices().scheduleNotifications(
                          title: "Just start",
                          body: "progress beats perfection. 🕒💪",
                          hour: 1,
                          min: 8,
                        );

                        Provider.of<NotificationProvider>(
                          context,
                          listen: false,
                        ).markAsNew();
                      }
                    },
                  ),
                ),
                Text("On".tr(), style: TextStyle(fontWeight: FontWeight.w500)),
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
                  "Select Language".tr(),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Spacer(),
                Text("EN", style: TextStyle(fontWeight: FontWeight.w400)),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SwitcherButton(
                    onColor: AppconstColor.Kgrey,
                    offColor: AppconstColor.PrimaryColor,
                    size: 40,
                    value: isNepali,
                    onChange: (value) {
                      final newLocale =
                          value ? Locale('ne', 'NP') : Locale('en', 'US');
                      EasyLocalization.of(context)?.setLocale(newLocale);
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
