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
import 'package:taskmanagement_app/constant/colors.dart';

import 'package:taskmanagement_app/features/homepage/presentation/views/homepage.dart';
import 'package:taskmanagement_app/utils/utils.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final nameController = TextEditingController();
  File? file;
  String? existingImageUrl;

  @override
  void initState() {
    super.initState();
    fetchExistingProfile();
  }

  Future<void> fetchExistingProfile() async {
    final doc =
        await FirebaseFirestore.instance
            .collection('profile')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();

    if (doc.exists) {
      final data = doc.data()!;
      nameController.text = data['name'] ?? '';
      setState(() {
        existingImageUrl = data['img'];
      });
    }
  }

  Future<void> updateProfileInDb() async {
    try {
      String? imageUrl = existingImageUrl;

      if (file != null) {
        final uploadData = await uploadToCloudinary(file!);
        imageUrl = uploadData?['secure_url'];
      }
      // instead of set here update
      await FirebaseFirestore.instance
          .collection("profile")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'img': imageUrl, "name": nameController.text.trim()});

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile updated successfully!")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homepage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to update profile")));
    }
  }

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
        foregroundColor: AppconstColor.Kwhite,
        backgroundColor: AppconstColor.PrimaryColor,
        title: const Center(child: Text("Edit Profile")),
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
                            ? Image.file(file!, fit: BoxFit.cover)
                            : existingImageUrl != null
                            ? Image.network(
                              existingImageUrl!,
                              fit: BoxFit.cover,
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
                  await updateProfileInDb();
                },
                child: CommonButton(buttonName: 'Update'.tr()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
