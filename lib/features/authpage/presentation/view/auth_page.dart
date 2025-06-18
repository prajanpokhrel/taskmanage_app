import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:taskmanagement_app/features/homepage/presentation/views/homepage.dart';
import 'package:taskmanagement_app/features/login/presentation/views/login.dart';
import 'package:taskmanagement_app/features/profile/presentation/view/profile_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = snapshot.data;

        if (user == null) return const LoginScreen();

        // Wait for profile to load before making decision
        return StreamBuilder<DocumentSnapshot>(
          stream:
              FirebaseFirestore.instance
                  .collection('profile')
                  .doc(user.uid)
                  .snapshots(),
          builder: (context, profileSnapshot) {
            if (profileSnapshot.connectionState == ConnectionState.waiting ||
                !profileSnapshot.hasData) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (profileSnapshot.data!.exists) {
              final data =
                  profileSnapshot.data!.data() as Map<String, dynamic>?;

              final isComplete = data?['isProfileComplete'] == true;

              return isComplete ? const Homepage() : const ProfilePage();
            } else {
              // Still loading or no document found
              return const ProfilePage();
            }
          },
        );
      },
    );
  }
}
