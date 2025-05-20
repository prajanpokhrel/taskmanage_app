import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:taskmanagement_app/constant/colors.dart';
import 'package:taskmanagement_app/utils/progress_bar.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

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
      body: Column(
        children: [TaskProgressBar(totalTasks: 10, completedTasks: 2)],
      ),
    );
  }
}
