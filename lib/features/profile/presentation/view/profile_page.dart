import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:taskmanagement_app/common/button.dart';
import 'package:taskmanagement_app/common/textform/textform_field.dart';
import 'package:taskmanagement_app/features/homepage/presentation/views/homepage.dart';
import 'package:taskmanagement_app/utils/utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final nameController = TextEditingController();

  File? file;
  @override
  void dispose() {
    nameController.dispose();

    super.dispose();
  }

  // upload images and name in database
  Future<void> uploadProfileInDb() async {
    try {
      String? imageUrl;
      if (file != null) {
        final uploadData = await uploadToCloudinary(file!);
        imageUrl = uploadData!['secure_url'];
      }

      // ignore: unused_local_variable
      final data = await FirebaseFirestore.instance
          .collection("profile")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
            'img': imageUrl,
            "name": nameController.text.trim(),
            'isProfileComplete': true,
          });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile added successfully!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to add Profile")));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homepage()),
      );
    }
  }

  // uploading files in cloud
  Future<Map<String, String>?> uploadToCloudinary(File file) async {
    final cloudName = 'dszsek2ru';
    final uploadPreset = 'task_flow';

    final mimeType = lookupMimeType(file.path)?.split('/');
    final uri = Uri.parse(
      'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
    );

    final request =
        http.MultipartRequest('POST', uri)
          ..fields['upload_preset'] = uploadPreset
          ..fields['folder'] = 'taskflow_folder'
          ..files.add(
            await http.MultipartFile.fromPath(
              'file',
              file.path,
              contentType: MediaType(mimeType![0], mimeType[1]),
            ),
          );

    final response = await request.send();

    if (response.statusCode == 200) {
      final res = await http.Response.fromStream(response);
      final data = jsonDecode(res.body);
      return {'secure_url': data['secure_url'], 'public_id': data['public_id']};
    } else {
      print('Cloudinary upload failed: ${response.statusCode}');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 141, 188, 226),
        title: Center(child: Text("Complete your Profile")),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            GestureDetector(
              onTap: () async {
                final image = await selectImage();
                setState(() {
                  file = image;
                });
              },

              child: DottedBorder(
                borderType: BorderType.Circle,
                dashPattern: const [6, 3],
                strokeCap: StrokeCap.round,
                color: Colors.lightBlue,
                padding: const EdgeInsets.all(4),
                child: ClipOval(
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey.shade200,
                    child:
                        file != null
                            ? Image.file(
                              file!,
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            )
                            : const Center(
                              child: Icon(Icons.camera_alt_outlined, size: 40),
                            ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Textformfields(
                hinttext: 'Name',
                controller: nameController,
              ),
            ),

            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(19.0),
              child: GestureDetector(
                onTap: () async {
                  await uploadProfileInDb();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.green,
                      content: Text("Profile is completed"),
                    ),
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const Homepage()),
                  );
                },
                child: CommonButton(buttonName: 'Save'.tr()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
