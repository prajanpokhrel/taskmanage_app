import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:taskmanagement_app/core/provider/darkmode_provider/dark_mode_provider.dart';
import 'package:taskmanagement_app/features/login/presentation/views/login.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final darkTheme = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.black,
      primaryColor: Colors.tealAccent,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white70),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStatePropertyAll(Colors.tealAccent),
        trackColor: MaterialStatePropertyAll(Colors.grey),
      ),
    );
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          title: 'TaskFlow',
          locale: context.locale,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          theme: ThemeData.light(),
          darkTheme: darkTheme,
          themeMode: context.watch<ThemeProvider>().thememode,
          home: const LoginScreen(),
        );
      },
    );
  }
}
