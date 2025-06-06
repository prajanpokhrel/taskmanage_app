import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:taskmanagement_app/app/app.dart';
import 'package:taskmanagement_app/core/provider/darkmode_provider/dark_mode_provider.dart';
import 'package:taskmanagement_app/firebase_options.dart';
import 'package:taskmanagement_app/notifications/notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //init notifi
  final notifiService = NotifiServices();
  await notifiService.initNotifi();

  final prefs = await SharedPreferences.getInstance();
  final isDark = prefs.getBool('isDark') ?? false;
  final initialTheme = isDark ? ThemeMode.dark : ThemeMode.light;

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(initialTheme),
      child: EasyLocalization(
        supportedLocales: [Locale('en', 'US'), Locale('ne', 'NP')],
        path: 'assets/translations',
        fallbackLocale: Locale('en', 'US'),

        child: const MyApp(),
      ),
    ),
  );
}
