import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:taskmanagement_app/features/homepage/presentation/views/homepage.dart';
import 'package:taskmanagement_app/features/login/presentation/views/login.dart';
import 'package:taskmanagement_app/features/profile/presentation/view/profile_page.dart';

class AuthService extends ChangeNotifier {
  //login in with google

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) throw Exception('Google Sign-In aborted');

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);
      String uid = userCredential.user!.uid;

      // Check Firestore for existing profile
      final docRef = FirebaseFirestore.instance.collection('profile').doc(uid);
      final docSnapshot = await docRef.get();

      if (!docSnapshot.exists) {
        // Create a new profile document with default values
        await docRef.set({
          'name': userCredential.user?.displayName ?? '',
          'email': userCredential.user?.email ?? '',
          'isProfileComplete': false,
          // Add any additional default fields here
        });
      }

      // Now check again (or just navigate to ProfilePage directly to complete it)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ProfilePage()),
      );
    } catch (e) {
      print('Google Sign-In error: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Google Sign-In Failed')));
    }
  }

  // Creating user with email and password
  Future<UserCredential?> createUserwithEmailandPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }

  // Login with email and password

  Future<UserCredential> loginwithEmailandPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }

  //signout

  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 1),
        backgroundColor: Colors.red,
        content: Text("You are logged out"),
      ),
    );
    await Future.delayed(Duration(milliseconds: 500));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  // uploading  in database
  Future<void> uploadinDb(
    BuildContext context, {
    required String title,
    required String description,
    required DateTime date,
    required String color,
    String? creators,

    File? file,
  }) async {
    try {
      String? imageUrl;
      String? publicId;

      if (file != null) {
        final uploadData = await uploadToCloudinary(file!);
        imageUrl = uploadData?['secure_url'];
        publicId = uploadData?['public_id'];
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Task added successfully!")));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const Homepage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to add task")));
    }
  }

  //uploadaing files in cloud
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
}
