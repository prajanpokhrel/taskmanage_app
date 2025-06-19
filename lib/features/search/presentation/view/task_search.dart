import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:taskmanagement_app/common/textform/textform_field.dart';
import 'package:taskmanagement_app/constant/colors.dart';
import 'package:taskmanagement_app/core/provider/search_provider/search_provider.dart';
import 'package:taskmanagement_app/features/edittask_page/presentation/view/edit_task_page.dart';
import 'package:taskmanagement_app/features/homepage/presentation/views/homepage.dart';

class TaskSearchScreen extends StatefulWidget {
  @override
  _TaskSearchScreenState createState() => _TaskSearchScreenState();
}

class _TaskSearchScreenState extends State<TaskSearchScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TaskProvider>(context, listen: false).fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppconstColor.Kwhite,
        backgroundColor: AppconstColor.PrimaryColor,
        title: Text('Search Tasks'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(2.h),

            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(27),

                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 3),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    // color: Pallete.gradient2,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Search task...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                taskProvider.searchTasks(value);
              },
            ),
          ),
          Expanded(
            child:
                taskProvider.filteredTasks.isEmpty
                    ? Center(child: Text('No tasks found.'))
                    : ListView.builder(
                      itemCount: taskProvider.filteredTasks.length,
                      itemBuilder: (context, index) {
                        final task = taskProvider.filteredTasks[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => EditTaskPage(
                                      taskId: task.id,
                                      title: task.title,
                                      description: task.description,
                                      date: task.date,
                                      color: task.color,
                                      imageUrl: task.imageUrl,
                                    ),
                              ),
                            );
                          },
                          child: ListTile(
                            title: Text(task.title),
                            subtitle: Text(task.description),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
