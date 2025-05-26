import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskmanagement_app/constant/colors.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  DateTime selectedDate = DateTime.now();
  Color _selectedColor = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppconstColor.Kwhite,
        backgroundColor: AppconstColor.PrimaryColor,
        title: Text(
          "Add New Task",
          style: TextStyle(color: AppconstColor.Kwhite),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              final selDate = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 90)),
              );
              if (selDate != null) {
                setState(() {
                  selectedDate = selDate;
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                DateFormat('MM-d-y').format(selectedDate),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
