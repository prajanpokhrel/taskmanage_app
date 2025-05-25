import 'package:flutter/material.dart';
import 'package:taskmanagement_app/common/date_selector.dart';

import 'package:taskmanagement_app/constant/colors.dart';
import 'package:taskmanagement_app/utils/progress_bar.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        backgroundColor: AppconstColor.PrimaryColor,
        title: ListTile(
          leading: CircleAvatar(),
          title: Text(
            "Welcome prajan,",
            style: TextStyle(
              color: AppconstColor.Kwhite,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            "May 10",
            style: TextStyle(
              color: AppconstColor.Kwhite,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        actions: [
          IconButton(
            color: AppconstColor.Kwhite,
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            color: AppconstColor.Kwhite,
            onPressed: () {},
            icon: Icon(Icons.notifications),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            // TaskProgressBar(totalTasks: 10, completedTasks: 2),
            DateSelector(),
          ],
        ),
      ),
    );
  }
}
