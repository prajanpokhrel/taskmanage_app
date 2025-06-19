import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:taskmanagement_app/common/setting/setting.dart';
import 'package:taskmanagement_app/common/setting/support.dart';
import 'package:taskmanagement_app/common/skeleton/page_skeleton.dart';
import 'package:taskmanagement_app/constant/colors.dart';
import 'package:taskmanagement_app/features/profile/presentation/view/edit_profile/edit_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context).brightness == Brightness.light
              ? Color.fromARGB(255, 238, 235, 235)
              : Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        backgroundColor:
            Theme.of(context).brightness == Brightness.light
                ? Color.fromARGB(255, 238, 235, 235)
                : Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Padding(
          padding: EdgeInsets.only(left: 8.h),
          child: Text(
            "Profile".tr(),
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance
                      .collection('profile')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return PageSkeleton();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (snapshot.hasData && snapshot.data!.exists) {
                  final data = snapshot.data!.data() as Map<String, dynamic>;
                  final String? name = data['name'];
                  final String? photo = data['img'];

                  return Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            CircleAvatar(
                              maxRadius: 50,
                              backgroundImage:
                                  photo != null ? NetworkImage(photo) : null,
                              child:
                                  photo == null
                                      ? const Icon(Icons.person)
                                      : null,
                            ),
                            SizedBox(width: 1.h),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditProfilePage(),
                                  ),
                                );
                              },
                              child: Icon(
                                color: AppconstColor.PrimaryColor,
                                Icons.edit,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          name != null ? name : "Welcome, User",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return ListTile(
                  leading: CircleAvatar(child: Icon(Icons.person)),
                  title: Text("User"),
                );
              },
            ),
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.only(left: 3.h),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Settings".tr(),
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
                "Supports".tr(),
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
