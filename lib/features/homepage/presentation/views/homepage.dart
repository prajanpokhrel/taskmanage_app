import 'package:flutter/material.dart';
import 'package:taskmanagement_app/common/bottom.dart';
import 'package:taskmanagement_app/common/date_selector.dart';
import 'package:taskmanagement_app/common/task_card.dart';

import 'package:taskmanagement_app/constant/colors.dart';
import 'package:taskmanagement_app/features/addtasks/presentation/view/add_task.dart';
import 'package:taskmanagement_app/utils/bottombar/bottombar.dart';

import 'package:taskmanagement_app/utils/utils.dart';

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
            Expanded(
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      TaskCard(
                        color: Colors.red,
                        headerText: 'hello',
                        descriptionText: 'hello i am comming',
                        scheduledDate: '2025-5-25',
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: strengthenColor(
                            const Color.fromRGBO(246, 222, 194, 1),
                            0.69,
                          ),
                          shape: BoxShape.circle,
                          image: DecorationImage(image: NetworkImage("")),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          "2025-5-25",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNewTask()),
          );
        },
        child: const Icon(color: AppconstColor.Kwhite, Icons.add),
        backgroundColor: AppconstColor.PrimaryColor,
        shape: const CircleBorder(), //
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // BottomAppBar with a notch
      bottomNavigationBar: AnimatedBottomBar(),
    );
  }
}
