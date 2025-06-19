import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:taskmanagement_app/common/bottom.dart';
import 'package:taskmanagement_app/common/date_selector.dart';
import 'package:taskmanagement_app/common/skeleton/page_skeleton.dart';
import 'package:taskmanagement_app/common/task_card.dart';

import 'package:taskmanagement_app/constant/colors.dart';
import 'package:taskmanagement_app/core/provider/notification/notification_provider.dart';
import 'package:taskmanagement_app/features/addtasks/presentation/view/add_task.dart';

import 'package:taskmanagement_app/features/edittask_page/presentation/view/edit_task_page.dart';
import 'package:taskmanagement_app/features/search/presentation/view/task_search.dart';

import 'package:taskmanagement_app/utils/utils.dart';
import 'package:loader_skeleton/loader_skeleton.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool hasNewNotification = true; // Set to true when new notification arrives

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        backgroundColor: AppconstColor.PrimaryColor,
        title: StreamBuilder(
          stream:
              FirebaseFirestore.instance
                  .collection('profile')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.hasData && snapshot.data!.exists) {
              final data = snapshot.data!.data() as Map<String, dynamic>;
              final String? name = data['name'];
              final String? photo = data['img'];
              final user = FirebaseAuth.instance.currentUser;
              final email = user?.email ?? "No Email";
              return ListTile(
                leading: CircleAvatar(
                  maxRadius: 22,
                  backgroundImage: photo != null ? NetworkImage(photo) : null,
                  child: photo == null ? const Icon(Icons.person) : null,
                ),
                title: Text(
                  name != null ? "Welcome, $name" : "Welcome, User",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,

                  style: TextStyle(
                    color: AppconstColor.Kwhite,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                subtitle: Text(
                  email,
                  style: TextStyle(
                    color: AppconstColor.Kwhite,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
            }
            return const ListTile(
              leading: CircleAvatar(child: Icon(Icons.person)),
              title: Text("User"),
            );
          },
        ),
        actions: [
          IconButton(
            color: AppconstColor.Kwhite,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TaskSearchScreen()),
              );
            },
            icon: Icon(Icons.search),
          ),
          SizedBox(
            child: Consumer<NotificationProvider>(
              builder: (context, notifier, child) {
                return Stack(
                  children: [
                    IconButton(
                      color: AppconstColor.Kwhite,
                      icon: const Icon(Icons.notifications),
                      onPressed: () {
                        Provider.of<NotificationProvider>(
                          context,
                          listen: false,
                        ).clearNotification();
                      },
                    ),
                    if (notifier.hasNewNotification)
                      Positioned(
                        right: 6,
                        top: 6,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                );
              },
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
                  return PageSkeleton();
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
                        onDismissed: (direction) async {
                          if (direction == DismissDirection.endToStart) {
                            //deleting form cloudniar
                            // final doc = snapshot.data!.docs[index];
                            // final publicId =
                            //     doc.data().containsKey('imagePublicId')
                            //         ? doc['imagePublicId']
                            //         : null;

                            // deleting from firebase
                            await FirebaseFirestore.instance
                                .collection('tasks')
                                .doc(snapshot.data!.docs[index].id)
                                .delete();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.red,
                                content: Text("Task  deleted"),
                              ),
                            );

                            //updating task
                          } else if (direction == DismissDirection.startToEnd) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => EditTaskPage(
                                      taskId: snapshot.data!.docs[index].id,
                                      title:
                                          snapshot.data!.docs[index]['title'],
                                      description:
                                          snapshot
                                              .data!
                                              .docs[index]['description'],
                                      date: snapshot.data!.docs[index]['date'],
                                      color:
                                          snapshot.data!.docs[index]['color'],
                                      imageUrl:
                                          snapshot
                                              .data!
                                              .docs[index]['imageUrl'],
                                    ),
                              ),
                            );
                          }
                        },

                        background: Container(
                          color: Colors.blue,
                          alignment: Alignment.centerRight,
                          child: const Padding(
                            padding: EdgeInsets.only(right: 20.0),
                            child: Icon(Icons.edit, color: Colors.white),
                          ),
                        ),
                        secondaryBackground: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          child: const Padding(
                            padding: EdgeInsets.only(right: 20.0),
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                        ),

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
