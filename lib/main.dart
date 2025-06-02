import 'package:firebase_core_dart/firebase_core_dart.dart';
import 'package:flutter/material.dart';
import 'package:taskmanagement_app/app/app.dart';
import 'package:taskmanagement_app/firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}
