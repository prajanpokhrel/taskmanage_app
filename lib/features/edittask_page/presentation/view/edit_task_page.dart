import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:taskmanagement_app/common/button.dart';
import 'package:taskmanagement_app/common/textform/textform_field.dart';
import 'package:taskmanagement_app/constant/colors.dart';
import 'package:taskmanagement_app/features/homepage/presentation/views/homepage.dart';
import 'package:taskmanagement_app/utils/utils.dart';

class EditTaskPage extends StatefulWidget {
  final String taskId;
  final String title;
  final String description;
  final Timestamp date;
  final String color;
  final String imageUrl;
  const EditTaskPage({
    super.key,
    required this.taskId,
    required this.title,
    required this.description,
    required this.date,
    required this.color,
    required this.imageUrl,
  });

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  late Color _selectedColor;

  File? file;

  @override
  void initState() {
    super.initState();
    // Pre-fill the fields with the existing data
    titleController.text = widget.title;
    descriptionController.text = widget.description;
    selectedDate = widget.date.toDate().toLocal();
    _selectedColor = hexToColor(widget.color);
  }

  //uploadaing files in cloud
  Future<String> uploadImageToCloudinary(File imageFile) async {
    const cloudName = 'dszsek2ru';
    const uploadPreset = 'task_flow';

    final url = Uri.parse(
      'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
    );

    final request =
        http.MultipartRequest('POST', url)
          ..fields['upload_preset'] = uploadPreset
          ..fields['folder'] = 'taskflow_folder'
          ..files.add(
            await http.MultipartFile.fromPath('file', imageFile.path),
          );

    final response = await request.send();

    if (response.statusCode == 200) {
      final resStream = await http.Response.fromStream(response);
      final responseData = json.decode(resStream.body);
      return responseData['secure_url'];
    } else {
      throw Exception('Failed to upload image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppconstColor.Kwhite,
        backgroundColor: AppconstColor.PrimaryColor,
        title: Text(
          "Edit Your Task".tr(),
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
                            ? Image.file(file!, fit: BoxFit.cover)
                            : widget.imageUrl.isNotEmpty
                            ? Image.network(widget.imageUrl, fit: BoxFit.cover)
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
                  try {
                    String imageUrlToUse = widget.imageUrl;

                    // Upload image if user selected a new one
                    if (file != null) {
                      imageUrlToUse = await uploadImageToCloudinary(file!);
                    }
                    await FirebaseFirestore.instance
                        .collection('tasks')
                        .doc(widget.taskId)
                        .update({
                          'title': titleController.text,
                          'description': descriptionController.text,
                          'color':
                              '#${_selectedColor.value.toRadixString(16).padLeft(8, '0')}',

                          'date': Timestamp.fromDate(selectedDate),
                          'imageUrl': imageUrlToUse,
                        });

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => Homepage()),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.blue,
                        content: Text("Task updated"),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.red,
                        content: Text("Task  updated failed"),
                      ),
                    );
                  }
                },
                child: CommonButton(buttonName: 'Save Changes'.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
