import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:taskmanagement_app/common/button.dart';
import 'package:taskmanagement_app/common/textform/textform_field.dart';
import 'package:taskmanagement_app/constant/colors.dart';
import 'package:taskmanagement_app/core/firebase_auth/auth_service.dart';
import 'package:taskmanagement_app/utils/utils.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  Color _selectedColor = Colors.transparent;
  File? file;
  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppconstColor.Kwhite,
        backgroundColor: AppconstColor.PrimaryColor,
        title: Text(
          "Add New Task".tr(),
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
              padding: EdgeInsets.only(right: 2.h),
              child: Text(
                DateFormat('MM-d-y').format(selectedDate),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  final image = await selectImage();
                  setState(() {
                    file = image;
                  });
                },
                child: DottedBorder(
                  color:
                      Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : AppconstColor.Kwhite,
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(10),
                  dashPattern: const [10, 4],
                  strokeCap: StrokeCap.round,
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:
                        file != null
                            ? Image.file(file!)
                            : const Center(
                              child: Icon(Icons.camera_alt_outlined, size: 40),
                            ),
                  ),
                ),
              ),
              SizedBox(height: 3.h),
              Textformfields(
                controller: titleController,
                hinttext: 'Title'.tr(),
              ),
              SizedBox(height: 3.h),
              Textformfields(
                controller: descriptionController,
                hinttext: 'Descriptions'.tr(),
                maxLine: 3,
              ),
              ColorPicker(
                pickersEnabled: const {ColorPickerType.wheel: true},

                onColorChanged: (Color color) {
                  setState(() {
                    _selectedColor = color;
                  });
                },
                heading: Text('Select color'.tr()),
                subheading: Text('Select a different shade'.tr()),
              ),
              SizedBox(height: 5),
              GestureDetector(
                onTap: () async {
                  final authService = Provider.of<AuthService>(
                    context,
                    listen: false,
                  );
                  await authService.uploadinDb(
                    context,
                    title: titleController.text.trim(),
                    description: descriptionController.text.trim(),
                    date: selectedDate,
                    color: rgbToHex(_selectedColor),

                    file: file,
                  );
                },
                child: CommonButton(buttonName: 'Submit'.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
