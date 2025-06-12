import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:taskmanagement_app/common/bottom.dart';
import 'package:taskmanagement_app/common/date_selector.dart';
import 'package:taskmanagement_app/common/task_card.dart';

import 'package:taskmanagement_app/constant/colors.dart';
import 'package:taskmanagement_app/features/addtasks/presentation/view/add_task.dart';

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
            "Welcome".tr(),
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
          Padding(
            padding: EdgeInsets.only(right: 1.h),
            child: IconButton(
              color: AppconstColor.Kwhite,
              onPressed: () {},
              icon: Icon(Icons.notifications),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            // TaskProgressBar(totalTasks: 10, completedTasks: 2),
            DateSelector(),
            // getting data from database
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance
                      .collection('tasks')
                      .where(
                        'creator',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid,
                      )
                      .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (!snapshot.hasData) {
                  return Text("No Data Found");
                }
                // if there is data
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: ValueKey(
                          snapshot.data!.docs[index].id,
                        ), // it makes unique show it don't any error,
                        child: Row(
                          children: [
                            Expanded(
                              child: TaskCard(
                                color: hexToColor(
                                  snapshot.data!.docs[index].data()['color'],
                                ),
                                headerText:
                                    snapshot.data!.docs[index].data()['title'],
                                descriptionText:
                                    snapshot.data!.docs[index]
                                        .data()['description'],
                                scheduledDate: DateFormat('yMMMd').format(
                                  (snapshot.data!.docs[index].data()['date']
                                          as Timestamp)
                                      .toDate(),
                                ),
                              ),
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
                                image:
                                    snapshot.data!.docs[index]
                                                .data()['imageUrl'] ==
                                            null
                                        ? null
                                        : DecorationImage(
                                          image: NetworkImage(
                                            snapshot.data!.docs[index]
                                                .data()['imageUrl'],
                                          ),
                                        ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                DateFormat('h:mm a').format(
                                  (snapshot.data!.docs[index].data()['date']
                                          as Timestamp)
                                      .toDate()
                                      .toLocal(),
                                ),
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
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
